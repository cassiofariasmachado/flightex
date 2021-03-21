defmodule Flightex.Bookings.Report do
  alias Flightex.Bookings.Agent, as: BookingAgent
  alias Flightex.Bookings.Booking

  def call(from_date, to_date) do
    booking_list = build_booking_list(from_date, to_date)

    File.write!("booking_report.csv", booking_list)

    {:ok, "Report generated successfully"}
  end

  defp build_booking_list(%NaiveDateTime{} = from_date, %NaiveDateTime{} = to_date) do
    BookingAgent.get(from_date, to_date)
    |> map_bookings()
  end

  defp map_bookings({:ok, bookings}) do
    bookings
    |> Enum.map(&booking_string/1)
  end

  defp booking_string(%Booking{
         data_completa: data_completa,
         cidade_origem: cidade_origem,
         cidade_destino: cidade_destino,
         id_usuario: id_usuario
       }) do
    "#{id_usuario},#{cidade_origem},#{cidade_destino},#{NaiveDateTime.to_string(data_completa)}\n"
  end
end
