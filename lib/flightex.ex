defmodule Flightex do
  alias Flightex.Users.Create, as: CreateUser
  alias Flightex.Users.Agent, as: UserAgent
  alias Flightex.Bookings.Agent, as: BookingAgent
  alias Flightex.Bookings.Create, as: CreateBooking
  alias Flightex.Bookings.Get, as: GetBooking

  @doc """
  Starts the agents.

  ## Examples

      iex> Flightex.start_agents()
      {:ok, "Agents started"}

  """
  def start_agents() do
    UserAgent.start_link(%{})
    BookingAgent.start_link(%{})

    {:ok, "Agents started"}
  end

  @moduledoc """
  Documentation for `Flightex`.
  """

  @doc """
  Create an user.

  ## Examples

      iex> Flightex.create_user(%{})
      {:error, "Invalid params"}

      _iex> Flightex.create_user(%{name: "Cassio", email: "example@email.com", cpf: "12345678910"})
      {:ok, _user_id}

  """
  defdelegate create_user(params), to: CreateUser, as: :call

  @doc """
  Create a booking.

  ## Examples

      iex> Flightex.create_booking("invalid", %{data_completa: "2020-09-01 10:00:00",cidade_origem: "Sao Leopoldo", cidade_destino: "Porto Alegre"})
      {:error, "User not found"}

      iex> Flightex.create_booking("invalid", %{})
      {:error, "Invalid params"}

      _iex> Flightex.create_booking("07f90095-36b7-4e4c-8dca-2a0b578526c2", %{data_completa: "2020-09-01 10:00:00",cidade_origem: "Sao Leopoldo", cidade_destino: "Porto Alegre"})
      {:ok, booking_id}

  """
  defdelegate create_booking(user_id, params), to: CreateBooking, as: :call

  @doc """
  Get a booking.

  ## Examples

      iex> Flightex.get_booking("1e81ab8a-e775-4b26-be80-5537fe156067")
      {
        :ok,
        %Flightex.Bookings.Booking{
          cidade_destino: "Porto Alegre",
          cidade_origem: "São Leopoldo",
          data_completa: ~N[2020-09-01 12:00:00],
          id: "1e81ab8a-e775-4b26-be80-5537fe156067",
          id_usuario: "70831e44-5820-4b4c-aae1-87b079a2882f"
        }
      }

      iex> Flightex.get_booking("invalid")
      {:error, "Flight Booking not found"}

  """
  defdelegate get_booking(booking_id), to: GetBooking, as: :call
end
