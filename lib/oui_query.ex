defmodule OuiQuery do
  @moduledoc """
  Documentation for OuiQuery.
  """

  @db_url "https://code.wireshark.org/review/gitweb?p=wireshark.git;a=blob_plain;f=manuf"

  @doc """
  Gets the vendor string for the OUI given a MAC address.

  ## Examples

      iex> OuiQuery.get_db |> OuiQuery.get_vendor("80:00:0b:29:56:d5")
      "IntelCor"
  """
  def get_vendor(db, mac) when is_binary(mac) do
    db |> parse_db() |> Enum.find(fn x -> x.id == mac |> String.upcase() |> String.slice(0..7) end) |> Map.get(:vendor)
  end

  @doc """
  Gets the comment string for the OUI given a MAC address.

  ## Examples

      iex> OuiQuery.get_db |> OuiQuery.get_comment("80:00:0b:29:56:d5")
      "Intel Corporate"
  """
  def get_comment(db, mac) when is_binary(mac) do
    db |> parse_db() |> Enum.find(fn x -> x.id == mac |> String.upcase() |> String.slice(0..7) end) |> Map.get(:comment)
  end

  @doc """
  Gets the URL to the latest Wireshark OUI database

  ## Examples
  
    iex> OuiQuery.get_db_url()
    "https://code.wireshark.org/review/gitweb?p=wireshark.git;a=blob_plain;f=manuf"
  """
  def get_db_url(), do: @db_url

  @doc """
  Gets the latest Wireshark OUI database
  """
  def get_db() do
    case get_db_url() |> HTTPoison.get do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        body
      _ -> nil
    end
  end

  @doc """
  Parses OUI database
  """
  def parse_db(data) when is_binary(data) do
    data
    |> String.split("\n")
    |> Enum.filter(fn x -> String.first(x) != "#" end)
    |> Enum.filter(fn x -> x != "" end)
    |> Enum.map(fn x -> String.split(x, "\t") end)
    |> Enum.map(fn x -> case x |> Enum.count do
        3 -> %{id: x |> Enum.at(0), vendor: x |> Enum.at(1), comment: x |> Enum.at(2)}
        _ -> %{id: x |> Enum.at(0), vendor: x |> Enum.at(1), comment: nil}
      end
    end)
  end
end
