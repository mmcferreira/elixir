ExUnit.start()

defmodule UsoSigilos do
  @doc """
  Demonstra o uso de sigilos para trabalhar com expressões regulares.

  ## Dicas
  - Use o sigilo ~r para criar uma expressão regular que combine números em uma string.

  ## Exemplos

      iex> UsoSigilos.run("Os números são 789 e 101")
      ["789", "101"]
  """
  @spec run(String.t()) :: list(String.t())
  def run(texto) do
    Regex.scan(~r/[0-9]{3}/, texto)
    |> List.flatten()
  end
end

defmodule UsoSigilosTest do
  use ExUnit.Case, async: true

  test "extrai números da string corretamente" do
    assert UsoSigilos.run("Os números são 789 e 101") == ["789", "101"]
  end
end
