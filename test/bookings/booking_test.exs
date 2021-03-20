defmodule Flightex.Bookings.BookingTest do
  use ExUnit.Case

  alias Flightex.Bookings.Booking

  describe "build/4" do
    test "when all params are valid, returns the booking" do
      response =
        Booking.build(
          ~N[2020-09-01 12:00:00],
          "São Leopoldo",
          "Porto Alegre",
          "61c29ff8-bb7b-43eb-a1ab-b81588bed49a"
        )

      assert {
               :ok,
               %Booking{
                 cidade_destino: "Porto Alegre",
                 cidade_origem: "São Leopoldo",
                 data_completa: ~N[2020-09-01 12:00:00],
                 id_usuario: "61c29ff8-bb7b-43eb-a1ab-b81588bed49a"
               }
             } = response
    end

    test "when date is an valid string, returns the booking" do
      response =
        Booking.build(
          "2020-09-01 12:00:00",
          "São Leopoldo",
          "Porto Alegre",
          "61c29ff8-bb7b-43eb-a1ab-b81588bed49a"
        )

      assert {
               :ok,
               %Booking{
                 cidade_destino: "Porto Alegre",
                 cidade_origem: "São Leopoldo",
                 data_completa: ~N[2020-09-01 12:00:00],
                 id_usuario: "61c29ff8-bb7b-43eb-a1ab-b81588bed49a"
               }
             } = response
    end

    test "when there are params invalid, returns an error" do
      response =
        Booking.build(
          "2020-09-01 12:00:00",
          :cidade,
          "Porto Alegre",
          "61c29ff8-bb7b-43eb-a1ab-b81588bed49a"
        )

      expected_response = {:error, "Invalid parameters"}

      assert expected_response == response
    end

    test "when cannot convert string to date, returns an error" do
      response =
        Booking.build(
          "2020-09-01",
          "São Leopoldo",
          "Porto Alegre",
          "61c29ff8-bb7b-43eb-a1ab-b81588bed49a"
        )

      expected_response = {:error, "Invalid date, cannot convert string to date"}

      assert expected_response == response
    end

    test "when date is invalid, returns an error" do
      response =
        Booking.build(
          :date,
          "São Leopoldo",
          "Porto Alegre",
          "61c29ff8-bb7b-43eb-a1ab-b81588bed49a"
        )

      expected_response = {:error, "Invalid date"}

      assert expected_response == response
    end
  end
end
