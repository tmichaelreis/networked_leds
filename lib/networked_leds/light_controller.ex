defmodule NetworkedLeds.LightController do
  use GenServer
  require Logger

  alias Circuits.GPIO

  @input_pin Application.get_env(:networked_leds, :input_pin, 17)
  @output_pin Application.get_env(:networked_leds, :ouput_pin, 18)

  def start_link(opts) do
    GenServer.start_link(__MODULE__, :ok, opts)
  end

  @impl true
  def init(:ok) do
    Logger.info("Starting pin #{@input_pin} as input")
    {:ok, input_gpio} = GPIO.open(@input_pin, :input)

    Logger.info("Starting pin #{@output_pin} as output")
    {:ok, output_gpio} = GPIO.open(@output_pin, :output)

    spawn(fn -> listen_forever(input_gpio, output_gpio) end)
    {:ok, nil}
  end

  defp listen_forever(input, output) do
    GPIO.set_interrupts(input, :both)
    listen_loop(output)
  end

  defp listen_loop(output) do
    receive do
      {:circuits_gpio, _p, _timestamp, 1} ->
        GPIO.write(output, 1)

      {:circuits_gpio, _p, _timestamp, 0} ->
        GPIO.write(output, 0)
    end

    listen_loop(output)
  end
end
