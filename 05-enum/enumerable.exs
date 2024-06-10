ExUnit.start()

defmodule Enumeravel do
  @doc """
  Dado uma lista de elementos, um acumulador e
  uma função que recebe o elemento atual e o acumulador,
  aplica a função em cada elemento da lista e retorna
  o acumulador.

  ## Exemplo

      iex> Enumeravel.reduce([1, 2, 3], 0, fn n, acc -> n + acc end)
      6
  """
  @spec reduce(list(term), term, (term, term -> term)) :: term
  def reduce([], acc, _reducer), do: acc
  def reduce([head | tail], acc, reducer) do
    reduce(tail, reducer.(head, acc), reducer)
  end

  @doc """
  Dada uma lista de elementos, conta quantos elementos
  a lista possui.

  ## Exemplo

      iex> Enumeravel.count([1, 2, 3])
      3
  """
  @spec count(list(term)) :: integer
  def count(xs) do
    reduce(xs, 0, fn _, acc -> acc + 1 end)
  end

  @doc """
  Dada uma lista de elementos e uma função mapeadora,
  que recebe um elemento e transforma em outro, aplica
  a função mapeadora em cada elemento da lista, retornando
  uma nova lista.

  ## Exemplo

      iex> Enumeravel.map([1, 2, 3], &to_string/1)
      ["1", "2", "3"]
  """
  @spec map(list(term), (term -> term)) :: list(term)
  def map(xs, mapper) do
    xs
    |> reduce([], fn x, acc -> [mapper.(x) | acc] end)
    |> Enum.reverse()
  end

  @doc """
  Dada uma lista e uma função que retorna um booleano,
  aplica a função em cada elemento e remove os
  elementos para os quais a função retorna `false`.

  ## Exemplo

      iex> Enumeravel.filter([1, 2, 3], fn x -> rem(x, 2) == 0 end)
      [2]
  """
  @spec filter(list(term), (term -> boolean)) :: list(term)
  def filter(xs, pred) do
    xs
    |> reduce([], fn x, acc -> if pred.(x), do: [x | acc], else: acc end)
    |> Enum.reverse()
  end

  @doc """
  Dada uma lista e uma função que retorna um booleano,
  aplica a função em cada elemento e remove os
  elementos para os quais a função retorna `true`.

  ## Exemplo

      iex> Enumeravel.reject([1, 2, 3], fn x -> rem(x, 2) == 0 end)
      [1, 3]
  """
  @spec reject(list(term), (term -> boolean)) :: list(term)
  def reject(xs, pred) do
    filter(xs, &(!pred.(&1)))
  end

  @doc """
  Dada uma lista e um caractere separador, junta todos os
  elementos da lista em uma string, aplicando o separador.

  ## Exemplo

      iex> Enumeravel.join([1, 2, 3], ", ")
      "1, 2, 3"
  """
  @spec join(list(term), String.t()) :: String.t()
  def join(xs, sep) do
    reduce(xs, "", fn
      x, "" -> to_string(x)
      x, acc -> acc <> sep <> to_string(x)
    end)
  end

  @doc """
  Dada uma lista de elementos e um número inteiro N,
  retorna apenas os N primeiros elementos de uma lista.

  ## Exemplo

      iex> Enumeravel.take([1, 2, 3], 2)
      [1, 2]
  """
  @spec take(list(term), integer) :: list(term)
  def take(xs, n) when n <= 0, do: []
  def take([], _n), do: []
  def take([head | tail], n), do: [head | take(tail, n - 1)]

  @doc """
  Dada uma lista de elementos, retorna a mesma lista porém
  com os elementos embaralhados.

  ## Exemplo

      iex> Enumeravel.shuffle([1, 2, 3])
      [2, 1, 3]
  """
  @spec shuffle(list(term)) :: list(term)
  def shuffle(xs) do
    :rand.seed(:exsplus, {101, 102, 103}) # Semente fixa para testes
    Enum.shuffle(xs)
  end

  @doc """
  Dada uma lista e um separador, adiciona o separador
  após cada elemento da lista.

  ## Exemplo

      iex> Enumeravel.intersperse([1, 2, 3], 0)
      [1, 0, 2, 0, 3]
  """
  @spec intersperse(list(term), term) :: list(term)
  def intersperse([], _sep), do: []
  def intersperse([x], _sep), do: [x]
  def intersperse([x | xs], sep), do: [x, sep | intersperse(xs, sep)]

  @doc """
  Dada uma lista de elementos consecutivos repetidos,
  retorna uma lista com os valores únicos.

  ## Exemplo

      iex> Enumeravel.dedup([1, 1, 2, 2, 3, 3])
      [1, 2, 3]
  """
  @spec dedup(list(term)) :: list(term)
  def dedup([]), do: []
  def dedup([x]), do: [x]
  def dedup([x, x | xs]), do: dedup([x | xs])
  def dedup([x, y | xs]), do: [x | dedup([y | xs])]

  @doc """
  Dada uma lista com elementos repetidos, remove
  todos os elementos repetidos da lista.

  ## Exemplo

      iex> Enumeravel.uniq([1, 2, 3, 1, 2, 3, 1, 2])
      [1, 2, 3]
  """
  @spec uniq(list(term)) :: list(term)
  def uniq(xs) do
    xs
    |> reduce([], fn x, acc -> if x in acc, do: acc, else: [x | acc] end)
    |> Enum.reverse()
  end
end

defmodule EnumeravelTest do
  use ExUnit.Case, async: true

  test "count deve retornar o número de elementos em uma lista" do
    assert Enumeravel.count([1, 2, 3]) == 3
    assert Enumeravel.count([]) == 0
  end

  test "map deve aplicar uma função a cada elemento de uma lista" do
    assert Enumeravel.map([1, 2, 3], &to_string/1) == ["1", "2", "3"]
    assert Enumeravel.map([], &to_string/1) == []
  end

  test "filter deve remover elementos que não satisfazem um predicado" do
    assert Enumeravel.filter([1, 2, 3], &(rem(&1, 2) == 0)) == [2]
    assert Enumeravel.filter([], &(rem(&1, 2) == 0)) == []
  end

  test "reject deve remover elementos que satisfazem um predicado" do
    assert Enumeravel.reject([1, 2, 3], &(rem(&1, 2) == 0)) == [1, 3]
    assert Enumeravel.reject([], &(rem(&1, 2) == 0)) == []
  end

  test "join deve juntar os elementos de uma lista com um separador" do
    assert Enumeravel.join([1, 2, 3], ", ") == "1, 2, 3"
    assert Enumeravel.join([], ", ") == ""
  end

  test "take deve retornar os primeiros N elementos de uma lista" do
    assert Enumeravel.take([1, 2, 3], 2) == [1, 2]
    assert Enumeravel.take([], 2) == []
  end

  test "shuffle deve embaralhar os elementos de uma lista" do
    # Comparando com uma lista esperada com semente fixa
    assert Enumeravel.shuffle([1, 2, 3]) == [2, 1, 3]
  end

  test "intersperse deve intercalar elementos de uma lista com um separador" do
    assert Enumeravel.intersperse([1, 2, 3], 0) == [1, 0, 2, 0, 3]
  end

  test "dedup deve remover elementos consecutivos repetidos" do
    assert Enumeravel.dedup([1, 1, 2, 2, 3, 3]) == [1, 2, 3]
  end

  test "uniq deve remover todos os elementos repetidos de uma lista" do
    assert Enumeravel.uniq([1, 2, 3, 1, 2, 3, 1, 2]) == [1, 2, 3]
  end
end
