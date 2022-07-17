defmodule DertGGWeb.CORSRouter do
  use Corsica.Router,
    origins: "chrome-extension://ockadlekmaibojkgilmijlmpliafdhga"

  resource("/api/*", allow_headers: ["Authorization", "Content-Type"])
end
