defmodule Flightex.Bookings.Booking do
  @keys [:id, :data_completa, :cidade_origem, :cidade_destino, :id_usuario]
  @enforce_keys @keys

  defstruct @keys

  def build(data_completa, cidade_origem, cidade_destino, id_usuario)
      when is_bitstring(cidade_origem) and is_bitstring(cidade_destino) and
             is_bitstring(id_usuario) do
    new_id = UUID.uuid4()

    parse_date(data_completa)
    |> handle_build(new_id, cidade_origem, cidade_destino, id_usuario)
  end

  def build(_data_completa, _cidade_origem, _cidade_destino, _id_usuario) do
    {:error, "Invalid parameters"}
  end

  defp handle_build({:error, reason}, _id, _cidade_origem, _cidade_destino, _id_usuario) do
    {:error, reason}
  end

  defp handle_build(data_completa, id, cidade_origem, cidade_destino, id_usuario) do
    {:ok,
     %__MODULE__{
       id: id,
       data_completa: data_completa,
       cidade_origem: cidade_origem,
       cidade_destino: cidade_destino,
       id_usuario: id_usuario
     }}
  end

  defp parse_date(date) when is_bitstring(date) do
    case NaiveDateTime.from_iso8601(date) do
      {:ok, date} -> date
      {:error, _reason} -> {:error, "Invalid date, cannot convert string to date"}
    end
  end

  defp parse_date(%NaiveDateTime{} = date), do: date

  defp parse_date(_date), do: {:error, "Invalid date"}
end
