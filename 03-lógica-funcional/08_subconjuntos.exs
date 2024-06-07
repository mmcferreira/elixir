ExUnit.start()

defmodule Subconjuntos do
  @doc """
  Retorna todos os subconjuntos possíveis de uma lista.

  ## Dicas
  - Uma abordagem recursiva pode considerar dois casos para cada elemento: incluindo ou não o elemento no subconjunto.
  - Lembre-se de que o conjunto vazio é um subconjunto de qualquer conjunto.

  ## Exemplos

      iex> Subconjuntos.run([1, 2])
      [[], [1], [2], [1, 2]]

      iex> Subconjuntos.run([])
      [[]]
  """
  @spec run(list(any)) :: list(list(any))

  # Função base para quando a lista é vazia.
  def run([], acc), do: [[]]

  # Inicializa a recursão com o acumulador padrão [[]].
  def run(list, acc \\ [[]]) do
    add_unit(list, [list | acc])
  end

  # Auxiliar, adiciona elementos à lista de subconjuntos.
  defp add_unit([], unitary), do: unitary

  # Processa a lista
  defp add_unit([hd | tl], unitary \\ []) do
    # Adiciona o elemento atual (hd) a cada subconjunto existente.
    new_unitary = Enum.map(unitary, fn subset -> [hd | subset] end)
    add_unit(tl, unitary ++ new_unitary)
  end
end

defmodule SubconjuntosTest do
  use ExUnit.Case, async: true

  test "retorna todos os subconjuntos de uma lista" do
    assert Enum.sort(Subconjuntos.run([1, 2])) == Enum.sort([[], [1], [2], [1, 2]])
  end

  test "inclui o conjunto vazio como subconjunto" do
    assert Subconjuntos.run([]) == [[]]
  end
end
