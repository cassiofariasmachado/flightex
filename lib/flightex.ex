defmodule Flightex do
  alias Flightex.Users.Create, as: CreateUser
  alias Flightex.Users.Agent, as: UserAgent
  alias Flightex.Bookings.Agent, as: BookingAgent
  alias Flightex.Bookings.Create, as: CreateBooking
  alias Flightex.Bookings.Get, as: GetBooking

  defdelegate create_user(params), to: CreateUser, as: :call

  defdelegate create_booking(user_id, params), to: CreateBooking, as: :call
  defdelegate get_booking(booking_id), to: GetBooking, as: :call

  def start_agents() do
    UserAgent.start_link(%{})
    BookingAgent.start_link(%{})
  end
end
