defmodule Flightex.Bookings.Get do
  alias Flightex.Bookings.Agent, as: BookingAgent

  def call(booking_id) do
    with {:ok, booking} <- BookingAgent.get(booking_id) do
      {:ok, booking}
    else
      error -> error
    end
  end
end
