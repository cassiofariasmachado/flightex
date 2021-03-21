defmodule Flightex.Bookings.Create do
  alias Flightex.Bookings.Agent, as: BookingAgent
  alias Flightex.Bookings.Booking
  alias Flightex.Users.Agent, as: UserAgent

  def call(user_id, %{
        data_completa: data_completa,
        cidade_origem: cidade_origem,
        cidade_destino: cidade_destino
      }) do
    with {:ok, _user} <- UserAgent.get(user_id),
         {:ok, %Booking{id: booking_id} = booking} <-
           Booking.build(data_completa, cidade_origem, cidade_destino, user_id) do
      BookingAgent.save(booking)

      {:ok, booking_id}
    else
      error -> error
    end
  end

  def call(_user_id, _params), do: {:error, "Invalid params"}
end
