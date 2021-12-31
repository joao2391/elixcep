defmodule Elixcep do
  @moduledoc """
  Documentation for `Elixcep`.
  """
  alias Elixcep.Address
  @url_correio "https://buscacepinter.correios.com.br/app/endereco/carrega-cep-endereco.php"

  @doc """
  Retorna todas informacoes do CEP fornecido.
  """
  def get_address_by_cep(cep) do

    get_address_by_cep_from_correios(cep)
  end

  @doc """
  Retorna todas informacoes do endereco fornecido.
  """
  def get_cep_by_address(address) do
    get_cep_by_address_from_correios(address)
  end

  defp get_address_by_cep_from_correios(cep) do

    case HTTPoison.post(
      @url_correio,
      {:form, [{"pagina", "/app/endereco/index.php"}, {"endereco",cep}, {"tipoCEP", "ALL"}]},
      %{"Content-Type" => "application/x-www-form-urlencoded", "source" => "elixcep"}
      ) do
        {:ok, %{body: raw_body, status_code: code}} -> {code, raw_body}

        sct = Jason.decode!(raw_body)
        dados = sct["dados"] |> hd
        address = %Address{rua: dados["logradouroDNEC"], bairro: dados["bairro"], cep: dados["cep"], cidade: dados["localidade"], uf: dados["uf"]}

        address
      end
  end

  defp get_cep_by_address_from_correios(address) do

    case HTTPoison.post(
      @url_correio,
      {:form, [{"pagina", "/app/endereco/index.php"}, {"endereco",address}, {"tipoCEP", "ALL"}]},
      %{"Content-Type" => "application/x-www-form-urlencoded", "source" => "elixcep"}
      ) do
        {:ok, %{body: raw_body, status_code: code}} -> {code, raw_body}

        sct = Jason.decode!(raw_body)
        dados = sct["dados"] |> hd
        address = %Address{rua: dados["logradouroDNEC"], bairro: dados["bairro"], cep: dados["cep"], cidade: dados["localidade"], uf: dados["uf"]}

        address
      end
  end

end
