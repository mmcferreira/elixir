ExUnit.start()

defmodule Ponto do
  defstruct x: 0, y: 0
end

defmodule CriacaoStruct do
  @doc """
  Cria uma struct para representar um ponto no espaço 2D e uma função para mover o ponto.

  ## Dicas
  - Defina uma struct com campos para coordenadas x e y.
  - Crie uma função que recebe uma struct ponto e um par de valores para mover o ponto.

  ## Exemplos

      iex> ponto = CriacaoStruct.criar(2, 3)
      iex> CriacaoStruct.move(ponto, 5, 7)
      %{x: 7, y: 10}
  """
  @spec criar(integer, integer) :: map
  @spec move(map, integer, integer) :: map
  def criar(x, y) do
    %Ponto{x: x, y: y}
  end

  def move(ponto, dx, dy) do
    %{ponto | x: ponto.x + dx, y: ponto.y + dy }
  end
end

defmodule CriacaoStructTest do
  use ExUnit.Case, async: true

  test "move o ponto corretamente" do
    ponto = CriacaoStruct.criar(2, 3)
    assert CriacaoStruct.move(ponto, 5, 7) == %Ponto{x: 7, y: 10}
  end
end