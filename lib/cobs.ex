defmodule Cobs do
  @moduledoc """
  Elixir implementation of [Consistent Overhead Byte Stuffing](https://en.wikipedia.org/wiki/Consistent_Overhead_Byte_Stuffing)
  """

  @doc """
  Encode a binary (with `0` bytes) into a COBS encoded binary (without `0` bytes).

  ## Example
      iex> Cobs.encode(<<0x01, 0x02, 0x00, 0x03>>)
      {:ok, <<0x03, 0x01, 0x02, 0x02, 0x03>>}
  """

  @spec encode(binary()) :: {:ok, binary()} | {:error | any()}
  def encode(binary) do
    if byte_size(binary) <= 254 do
      {:ok, do_encode(<<>>, <<>>, binary)}
    else
      {:error, nil}
    end
  end

  @spec do_encode(binary(), binary(), binary()) :: binary()
  defp do_encode(head, block, tail)

  defp do_encode(head, block, <<>>),
       do: head <> <<byte_size(block) + 1>> <> block
  defp do_encode(head, block, <<0, tail :: binary>>),
       do: do_encode(head <> <<byte_size(block) + 1>> <> block, <<>>, tail)
  defp do_encode(head, block, <<val, tail :: binary>>),
       do: do_encode(head, block <> <<val>>, tail)

  @doc """
  Decode COBS encoded binary (without `0` bytes) into a binary (with `0` bytes).


  ## Example
      iex> Cobs.decode(<<0x03, 0x01, 0x02, 0x02, 0x03>>)
      {:ok, <<0x01, 0x02, 0x00, 0x03>>}
  """
  @spec decode(binary()) :: {:ok, binary()} | {:error | any()}
  def decode(binary)

  def decode(binary) do
    do_decode(<<>>, binary)
  end

  @spec do_decode(binary(), binary()) :: {:ok, binary()} | {:error | any()}
  defp do_decode(head, tail)

  defp do_decode(head, <<>>) do
    {:ok, head}
  end

  defp do_decode(head, <<ohb, tail :: binary>>) do
    block_length = ohb - 1
    if block_length > byte_size(tail) do
      {:error, nil}
    else
      <<block :: binary - size(block_length), remaining :: binary>> = tail
      new_head = if byte_size(remaining) > 0, do: head <> block <> <<0>>, else: head <> block
      do_decode(new_head, remaining)
    end
  end

end