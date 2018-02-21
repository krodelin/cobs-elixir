defmodule CobsTest do
  use ExUnit.Case
  doctest Cobs

  test "empty" do
    assert Cobs.encode(<<>>) == {:ok, <<0x01>>}
    assert Cobs.decode(<<0x01>>) == {:ok, <<>>}
  end

  test "1" do
    assert Cobs.encode(<<0x01>>) == {:ok, <<0x02, 0x01>>}
    assert Cobs.decode(<<0x02, 0x01>>) == {:ok, <<0x01>>}
  end

  test "0" do
    assert Cobs.encode(<<0x00>>) == {:ok, <<0x01, 0x01>>}
    assert Cobs.decode(<<0x01, 0x01>>) == {:ok, <<0x00>>}
  end

  test "double 0" do
    assert Cobs.encode(<<0x00, 0x00>>) == {:ok, <<0x01, 0x01, 0x01>>}
    assert Cobs.decode(<<0x01, 0x01, 0x01>>) == {:ok, <<0x00, 0x00>>}
  end

  test "middle 0" do
    assert Cobs.encode(<<0x01, 0x02, 0x00, 0x03>>) == {:ok, <<0x03, 0x01, 0x02, 0x02, 0x03>>}
    assert Cobs.decode(<<0x03, 0x01, 0x02, 0x02, 0x03>>) == {:ok, <<0x01, 0x02, 0x00, 0x03>>}
  end

  test "no 0" do
    assert Cobs.encode(<<0x01, 0x02, 0x03, 0x04>>) == {:ok, <<0x05, 0x01, 0x02, 0x03, 0x04>>}
    assert Cobs.decode(<<0x05, 0x01, 0x02, 0x03, 0x04>>) == {:ok, <<0x01, 0x02, 0x03, 0x04>>}
  end

  test "tripple 0" do
    assert Cobs.encode(<<0x01, 0x00, 0x00, 0x00>>) == {:ok, <<0x02, 0x01, 0x01, 0x01, 0x01>>}
    assert Cobs.decode(<<0x02, 0x01, 0x01, 0x01, 0x01>>) == {:ok, <<0x01, 0x00, 0x00, 0x00>>}
  end

  test "too long" do
    {return, _} = Cobs.encode(<<-1 :: unit(8) - size(254)>>)
    assert return == :ok
    {return, _} = Cobs.encode(<<-1 :: unit(8) - size(255)>>)
    assert return == :error
    {return, _} = Cobs.encode(<<-1 :: unit(8) - size(256)>>)
    assert return == :error
  end

  test "invalid" do
    # The appended binary specifies ten remaining bytes although only one is present
    invalid = Cobs.encode(<<-1 :: unit(8) - size(253)>>) <> <<10, 0>>
    {return, _} = Cobs.decode(invalid)
    assert return == :error
  end
  
end
