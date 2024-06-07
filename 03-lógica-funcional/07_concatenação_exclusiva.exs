ExUnit.start()

defmodule ConcatenacaoExclusiva do
  @doc """
  Concatena duas listas, excluindo da primeira lista os elementos já presentes na segunda.

  ## Dicas
  - Utilize recursão para percorrer a primeira lista e verificar se um elemento está na segunda lista.
  - Pode ser útil criar uma função auxiliar para verificar se um elemento está contido em uma lista.

  ## Exemplos

      iex> ConcatenacaoExclusiva.run([1, 2, 3], [3, 4, 5])
      [1, 2, 4, 5]

      iex> ConcatenacaoExclusiva.run([], [1, 2, 3])
      [1, 2, 3]
  """
  @spec run(list(any), list(any)) :: list(any)
  # Quando as duas listas estão vazias, retornamos o acumulador, pois todos os elementos foram processados.
  def run([], [], acc, _remove), do: Enum.reverse(acc)

  # Quando a primeira lista está vazia e não há elementos a serem removidos, concatenamos a segunda lista ao acumulador.
  def run([], [h | t], acc, []) do
    run([], t, [h | acc], [])
  end

  # Quando a primeira lista está vazia, processamos a segunda lista verificando se os elementos devem ser removidos.
  # Se um elemento está na lista de remoção, não o adicionamos ao acumulador.
  def run([], [h | t], acc, [hd | tl]) do
    if run_aux(h, [hd | tl]) do
      run([], t, acc, tl)
    else
      run([], t, [h | acc], [hd | tl])
    end
  end

  # Função inicial que compara os elementos da primeira lista com a segunda lista.
  # Se um elemento da primeira lista está na segunda lista, adicionamos este elemento à lista de remoção.
  # Caso contrário, adicionamos ao acumulador.
  def run([head | tail], lista2, acc \\ [], remove \\ []) do
    if run_aux(head, lista2) do
      run(tail, lista2, acc, [head | remove])
    else
      run(tail, lista2, [head | acc], remove)
    end
  end

  # Função auxiliar usada para verificar se um elemento está em uma lista.
  # Retorna true se o elemento estiver na lista, caso contrário, false.
  defp run_aux(_el, []), do: false
  defp run_aux(el, [hd | tl]) when el != hd, do: run_aux(el, tl)
  defp run_aux(el, [hd | _tl]) when el == hd, do: true

end

defmodule ConcatenacaoExclusivaTest do
  use ExUnit.Case, async: true

  test "concatena listas excluindo elementos repetidos" do
    assert ConcatenacaoExclusiva.run([1, 2, 3], [3, 4, 5]) == [1, 2, 4, 5]
  end

  test "concatena uma lista vazia com uma lista não vazia" do
    assert ConcatenacaoExclusiva.run([], [1, 2, 3]) == [1, 2, 3]
  end
end
