ExUnit.start()
defmodule ConcatenacaoListas do
  @doc """
  Concatena duas listas em uma única lista.

  ## Exemplos

      iex> ConcatenacaoListas.run([1, 2, 3], [4, 5, 6])
      [1, 2, 3, 4, 5, 6]
  """
  @spec run(list, list) :: list
  def run([], lista2), do: lista2
  def run(lista1, []), do: lista1
  def run(lista1, [h | t]) do
    run(lista1 ++ [h], t)
  end
end

defmodule ConcatenacaoListasTest do
  use ExUnit.Case, async: true

  test "concatena duas listas não vazias" do
    assert ConcatenacaoListas.run([1, 2, 3], [4, 5]) == [1, 2, 3, 4, 5]
  end

  test "concatena uma lista vazia com uma lista não vazia" do
    assert ConcatenacaoListas.run([], [1, 2, 3]) == [1, 2, 3]
  end
end
