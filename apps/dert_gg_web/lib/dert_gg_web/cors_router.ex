defmodule DertGGWeb.CORSRouter do
  use Corsica.Router,
    origins: "*"


  resource "/auth", allow_headers: ["Authorization"]
end
