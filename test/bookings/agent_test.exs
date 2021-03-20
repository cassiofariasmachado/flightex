defmodule Flightex.Bookings.AgentTest do
  use ExUnit.Case

  import Flightex.Factory

  alias Flightex.Bookings.Agent, as: BookingAgent
  alias Flightex.Bookings.Booking

  describe "save/1" do
    setup %{} do
      BookingAgent.start_link(%{})

      :ok
    end

    test "saves the booking" do
      booking = build(:booking)

      assert :ok == BookingAgent.save(booking)
    end
  end

  describe "get/1" do
    setup %{} do
      BookingAgent.start_link(%{})
      :ok
    end

    test "when the booking is found, returns the booking" do
      booking_id = "1e81ab8a-e775-4b26-be80-5537fe156067"
      booking = build(:booking, id: booking_id)

      BookingAgent.save(booking)

      response = BookingAgent.get(booking_id)

      expected_response = {:ok, booking}

      assert expected_response == response
    end

    test "when the booking is not found, returns an error" do
      response = BookingAgent.get("00000000000")

      expected_response = {:error, "Flight Booking not found"}

      assert expected_response == response
    end
  end

  describe "get_all/1" do
    setup %{} do
      BookingAgent.start_link(%{})
      :ok
    end

    test "when there are no bookings, returns empty" do
      response = BookingAgent.get_all()

      assert %{} == response
    end

    test "when there are bookings, returns the bookings" do
      booking_one_id = "1e81ab8a-e775-4b26-be80-5537fe156067"
      booking_one = build(:booking, id: booking_one_id)

      booking_two_id = "7f1ce228-c2c1-4151-b90a-09c379e635de"
      booking_two = build(:booking, id: booking_two_id)

      BookingAgent.save(booking_one)
      BookingAgent.save(booking_two)

      response = BookingAgent.get_all()

      expected_response = %{
        "1e81ab8a-e775-4b26-be80-5537fe156067" => %Booking{
          cidade_destino: "Porto Alegre",
          cidade_origem: "São Leopoldo",
          data_completa: ~N[2020-09-01 12:00:00],
          id: "1e81ab8a-e775-4b26-be80-5537fe156067",
          id_usuario: "70831e44-5820-4b4c-aae1-87b079a2882f"
        },
        "7f1ce228-c2c1-4151-b90a-09c379e635de" => %Booking{
          cidade_destino: "Porto Alegre",
          cidade_origem: "São Leopoldo",
          data_completa: ~N[2020-09-01 12:00:00],
          id: "7f1ce228-c2c1-4151-b90a-09c379e635de",
          id_usuario: "70831e44-5820-4b4c-aae1-87b079a2882f"
        }
      }

      assert expected_response == response
    end
  end
end
