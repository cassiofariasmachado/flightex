defmodule FlightexTest do
  use ExUnit.Case

  import Flightex.Factory

  alias Flightex.Bookings.Agent, as: BookingAgent

  doctest Flightex do
    setup %{} do
      Flightex.start_agents()

      booking_id = "1e81ab8a-e775-4b26-be80-5537fe156067"
      booking = build(:booking, id: booking_id)

      BookingAgent.save(booking)

      :ok
    end
  end
end
