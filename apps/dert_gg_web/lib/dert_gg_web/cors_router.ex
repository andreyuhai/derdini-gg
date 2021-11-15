defmodule DertGGWeb.CORSRouter do
  use Corsica.Router,
    origins: "*"


  resource "/api/*", allow_headers: ["Authorization"]
end
