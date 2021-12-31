defmodule ElixcepTest do
  use ExUnit.Case
  doctest Elixcep

  test "retorna informacoes do cep fornecido" do
    assert Elixcep.get_address_by_cep(85801002) != nil
  end

  test "retorna informacoes do endereco fornecido" do
    assert Elixcep.get_cep_by_address("Rua Frei Caneca") != nil
  end
end
