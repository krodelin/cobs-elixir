defmodule Cobs do
  @moduledoc """
  Elixir implementation of [Consistent Overhead Byte Stuffing](https://en.wikipedia.org/wiki/Consistent_Overhead_Byte_Stuffing)
  """

  @doc """
  Encode a binary (with `0` bytes) into a COBS encoded binary (without `0` bytes).

  ## Example
      iex> Cobs.encode(<<0x01, 0x02, 0x00, 0x03>>)
      <<0x03, 0x01, 0x02, 0x02, 0x03>>
  """

  @spec encode(binary()) :: binary()
  def encode(binary) do
    do_encode(<<>>, binary)
  end

  defp do_encode(head, <<>>) do
    ohb = byte_size(head) + 1
    <<ohb>> <> head
  end

  defp do_encode(head, <<0, tail :: binary>>) do
    ohb = byte_size(head) + 1
    <<ohb>> <> head <> do_encode(<<>>, tail)
  end

  defp do_encode(head, <<val, tail :: binary>>) do
    do_encode(head <> <<val>>, tail)
  end

  @doc """
  Decode COBS encoded binary (without `0` bytes) into a binary (with `0` bytes).


  ## Example
      iex> Cobs.decode(<<0x03, 0x01, 0x02, 0x02, 0x03>>)
      <<0x01, 0x02, 0x00, 0x03>>
  """
  @spec decode(binary()) :: binary()
  def decode(binary)
  
  def decode(<<>>) do
    <<>>
  end

  def decode(<<ohb, tail :: binary>>) do
    head_length = ohb - 1
    <<block :: binary - size(head_length), remaining :: binary>> = tail
    if byte_size(remaining) > 0, do: block <> <<0>> <> decode(remaining), else: block
  end
end