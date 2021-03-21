# Flightex

[![Language](https://img.shields.io/badge/language-elixir-purple)](https://img.shields.io/badge/language-elixir-purple) [![License](https://img.shields.io/badge/license-MIT-lightgrey)](/LICENSE)

Repository for the fourth challenge of the Elixir's path from [Rocketseat Ignite](https://rocketseat.com.br).

## :rocket: Techs

* [Elixir](https://elixir-lang.org/)

## :wrench: Setup

  * Install dependencies with `mix deps.get`
  * For interactive testing use `iex -S mix`

## :memo: Examples

```elixir
iex> Flightex.start_agents()
# -> {:ok, "Agents started"}

iex> Flightex.create_user(%{name: "Cassio", email: "example@email.com", cpf: "12345678910"})
# -> {:ok, user_id}

iex> Flightex.create_user(invalid_params)
# -> {:error, "Invalid params"}

iex> Flightex.create_booking(user_id, %{data_completa: "2020-09-01 10:00:00",cidade_origem: "Sao Leopoldo", cidade_destino: "Porto Alegre"})
# -> {:ok, booking_id}

iex> Flightex.create_booking(invalid_user_id, params)
# -> {:error, "User not found"}

iex> Flightex.create_booking(invalid_user_id, invalid_params)
# -> {:error, "Invalid params"}

iex> Flightex.get_booking(booking_id)
# -> {:ok, %Booking{...}}

iex> Flightex.get_booking(invalid_booking_id)
# -> {:error, "Flight Booking not found"}

iex> Flightex.generate_report(from_date, to_date)
# -> {:ok, "Report generated successfully"}
```

## :white_check_mark: Test

To run tests:

* Run with `mix test --cover`

## :page_facing_up: License

* [MIT](/LICENSE.txt)
