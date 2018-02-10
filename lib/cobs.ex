defmodule Cobs do
  @moduledoc """
  Elixir implementation of [Consistent Overhead Byte Stuffing](https://en.wikipedia.org/wiki/Consistent_Overhead_Byte_Stuffing)
  """

  @doc """
  Convert a binary (with `0` bytes) into a COBS encoded binary (without `0` bytes).

  ## Examples

      iex> Cobs.encode(<< 0x11, 0x22, 0x00, 0x33 >>)
      << 0x03, 0x11, 0x22, 0x02, 0x33 >>
  """
  def encode binary do
    {result, buffer} = binary
                       |> :binary.bin_to_list
                       |> Enum.reverse
                       |> Enum.reduce({[], []}, fn (v, a) -> process(v, a) end)
    result = concat({result, buffer})
    Kernel.to_string(result)
  end

  defp process(0, {result, buffer}) do
    {concat({result, buffer}), []}
  end

  defp process(v, {result, buffer}) do
    {result, [v | buffer]}
  end

  defp concat({result, buffer}) do
    [(length(buffer) + 1) | buffer] ++ result
  end

end