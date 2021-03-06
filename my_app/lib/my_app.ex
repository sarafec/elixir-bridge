defmodule MyApp do
  @moduledoc """
  Documentation for MyApp
  """
  use Application

  def start(_type, _args) do
    children = [
      {MyApp.Router, []},
      {MyApp.ApiHandler, []}
    ]

    opts = [strategy: :one_for_one, name: MyApp.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
