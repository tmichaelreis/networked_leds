defmodule NetworkedLeds.Supervisor do
  use Supervisor

  require Logger

  def start_link(opts) do
    Logger.debug("Starting supervisor")
    Supervisor.start_link(__MODULE__, :ok, opts)
  end

  @impl true
  def init(:ok) do
    children = [
      {NetworkedLeds.LightController, name: NetworkedLeds.LightController}
    ]

    Supervisor.init(children, strategy: :one_for_one)
  end
end
