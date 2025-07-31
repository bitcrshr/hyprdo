defmodule Hyprdo.Repo do
  use Ecto.Repo,
    otp_app: :hyprdo,
    adapter: Ecto.Adapters.SQLite3
end
