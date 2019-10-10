defmodule NetworkedLeds do
  use Application

  require Logger

  @impl true
  def start(_type, _args) do
    Logger.debug("Starting application")
    NetworkedLeds.Supervisor.start_link(name: NetworkedLeds.Supervisor)
  end
end
