defmodule NetworkedLeds.Indicator do
  alias Nerves.Leds
  require Logger

  def get_leds() do
    led_list = Application.get_env(:networked_leds, :led_list)
    Logger.debug("list of leds to blink is #{inspect(led_list)}")
    {:ok, led_list}
  end

  def blink_led_n_times(led, times) do
    spawn(fn -> blink_until_done(led, times) end)
  end

  def blink_until_done(_led, 0) do
  end

  def blink_until_done(led, times) do
    blink_led(led)
    blink_until_done(led, times - 1)
  end

  def blink_led(led) do
    Leds.set([{led, true}])
    :timer.sleep(100)
    Leds.set([{led, false}])
    :timer.sleep(100)
  end
end
