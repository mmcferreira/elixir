ExUnit.start()

defmodule NumeroPorExtenso do
  @doc """
  Converte um número inteiro em sua representação por extenso em português.

  ## Dicas
  - Divida o problema em casos menores, como unidades, dezenas, centenas, etc.
  - Utilize recursão para lidar com números maiores.

  ## Exemplos

      iex> NumeroPorExtenso.run(42)
      "quarenta e dois"

      iex> NumeroPorExtenso.run(102)
      "cento e dois"
  """
  @spec run(integer()) :: String.t()
  def run(num) do
    numeros_por_extenso(num)
  end

  defp numeros_por_extenso(0), do: "zero"

  defp numeros_por_extenso(num) when num < 0 do
    "menos " <> numeros_por_extenso(-num)
  end

  defp numeros_por_extenso(num) when num < 20 do
    ["zero", "um", "dois", "três", "quatro", "cinco", "seis", "sete", "oito", "nove",
     "dez", "onze", "doze", "treze", "quatorze", "quinze", "dezesseis", "dezessete", "dezoito", "dezenove"]
    |> Enum.at(num)
  end

  defp numeros_por_extenso(num) when num < 100 do
    dezenas = ["vinte", "trinta", "quarenta", "cinquenta", "sessenta", "setenta", "oitenta", "noventa"]
    dezena = div(num, 10)
    unidade = rem(num, 10)

    if unidade == 0 do
      Enum.at(dezenas, dezena - 2)
    else
      Enum.at(dezenas, dezena - 2) <> " e " <> numeros_por_extenso(unidade)
    end
  end

  defp numeros_por_extenso(num) when num < 1000 do
    centenas = ["cem", "cento", "duzentos", "trezentos", "quatrocentos", "quinhentos", "seiscentos", "setecentos", "oitocentos", "novecentos"]
    centena = div(num, 100)
    resto = rem(num, 100)

    if resto == 0 do
      Enum.at(centenas, centena)
    else
      Enum.at(centenas, centena) <> " e " <> numeros_por_extenso(resto)
    end
  end

  defp numeros_por_extenso(num) when num < 1_000_000 do
    milhares = div(num, 1000)
    resto = rem(num, 1000)

    if resto == 0 do
      numeros_por_extenso(milhares) <> " mil"
    else
      numeros_por_extenso(milhares) <> " mil e " <> numeros_por_extenso(resto)
    end
  end
end

defmodule NumeroPorExtensoTest do
  use ExUnit.Case, async: true

  test "converte números pequenos por extenso" do
    assert NumeroPorExtenso.run(5) == "cinco"
    assert NumeroPorExtenso.run(13) == "treze"
  end

  test "converte números com dezenas por extenso" do
    assert NumeroPorExtenso.run(21) == "vinte e um"
    assert NumeroPorExtenso.run(99) == "noventa e nove"
  end

  test "converte centenas por extenso" do
    assert NumeroPorExtenso.run(101) == "cento e um"
    assert NumeroPorExtenso.run(200) == "duzentos"
  end

  test "converte milhares por extenso" do
    assert NumeroPorExtenso.run(1001) == "mil e um"
    assert NumeroPorExtenso.run(2020) == "dois mil e vinte"
  end
end
