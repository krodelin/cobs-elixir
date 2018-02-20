defmodule Cobs do
  @moduledoc """
  Elixir implementation of [Consistent Overhead Byte Stuffing](https://en.wikipedia.org/wiki/Consistent_Overhead_Byte_Stuffing)
  """

  @doc """
  Convert a binary (with `0` bytes) into a COBS encoded binary (without `0` bytes).

  ## Examples

      iex> Cobs.encode(<< 0x11, 0x22, 0x00, 0x33 >>)
      << 0x03, 0x11, 0x22, 0x02, 0x33, 0x00 >>

      iex> Cobs.decode(<< 0x03, 0x11, 0x22, 0x02, 0x33, 0x00 >>)
      << 0x11, 0x22, 0x00, 0x33 >>

  """


  def encode(binary) do
    encode(<<>>, binary) <> <<0>>
  end

  defp encode(head, <<>>) do
    ohb = byte_size(head) + 1
    <<ohb>> <> head
  end

  defp encode(head, <<0, tail :: binary>>) do
    ohb = byte_size(head) + 1
    <<ohb>> <> head <> encode(<<>>, tail)
  end

  defp encode(head, <<val, tail :: binary>>) do
    encode(head <> <<val>>, tail)
  end


  def decode(<<>>) do
    <<>>
  end

  def decode(<<ohb, tail :: binary>>) do
    if ohb == 0 do
      <<>>
    else
      head_length = ohb - 1
      <<head :: binary - size(head_length), tail :: binary>> = tail
      head <> <<0>> <> decode(tail)
    end

  end
end