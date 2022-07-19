FROM elixir:1.13.4-alpine AS build

RUN apk add --no-cache build-base npm git python3

# prepare build dir
WORKDIR /app

# install hex + rebar
RUN mix local.hex --force && \
    mix local.rebar --force

# set build ENV
ENV MIX_ENV="prod"

# install mix dependencies
COPY mix.exs mix.lock ./
COPY apps/dert_gg/mix.exs apps/dert_gg/mix.exs
COPY apps/dert_gg_web/mix.exs apps/dert_gg_web/mix.exs

RUN mix deps.get --only $MIX_ENV
RUN mkdir config

# copy compile-time config files before we compile dependencies
# to ensure any relevant config change will trigger the dependencies
# to be re-compiled.
COPY config/config.exs config/${MIX_ENV}.exs config/
RUN mix deps.compile

COPY apps/dert_gg/priv apps/dert_gg/priv
COPY apps/dert_gg_web/priv apps/dert_gg_web/priv

COPY apps/dert_gg/lib apps/dert_gg/lib
COPY apps/dert_gg_web/lib apps/dert_gg_web/lib

COPY apps/dert_gg_web/assets apps/dert_gg_web/assets

# Deploy & Digest assets
RUN npm --prefix ./apps/dert_gg_web/assets ci --progress=false --no-audit --loglevel=error && \
    npm run --prefix ./apps/dert_gg_web/assets deploy
RUN mix phx.digest

# Compile the release
RUN mix compile

# Changes to config/runtime.exs don't require recompiling the code
COPY config/runtime.exs config/

COPY rel rel

RUN mix release

FROM alpine:3 AS app

RUN apk add --no-cache openssl ncurses-libs libgcc libstdc++

WORKDIR /app

RUN chown nobody:nobody /app

USER nobody:nobody

COPY --from=build --chown=nobody:nobody /app/_build/prod/rel/dert_gg_web ./

ENV HOME=/app

ENV ECTO_IPV6 true
ENV ERL_AFLAGS "-proto_dist inet6_tcp"

CMD ["bin/server"]
