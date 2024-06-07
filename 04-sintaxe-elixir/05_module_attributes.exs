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

      iex> ponto = CriacaoStruct.criar(4, 6)
      iex> CriacaoStruct.mover(ponto, 8, 14)
      %{x: 12, y: 20}
  """
  @spec criar(integer, integer) :: map
  @spec mover(map, integer, integer) :: map
  def criar(x, y) do
    %Ponto{x: x, y: y}
  end

  def mover(ponto, dx, dy) do
    %{ponto | x: ponto.x + dx, y: ponto.y + dy }
  end
end

defmodule CriacaoStructTest do
  use ExUnit.Case, async: true

  test "move o ponto corretamente" do
    ponto = CriacaoStruct.criar(4, 6)
    assert CriacaoStruct.mover(ponto, 8, 14) == %Ponto{x: 12, y: 20}
  end
end
