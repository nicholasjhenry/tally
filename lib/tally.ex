defprotocol Tally.Protocol do
  @fallback_to_any true

  @doc "Arithmetic addition."
  def add(left, right)

  @doc "Arithmetic multiplication."
  def mult(left, right)

  @doc "Arithmetic subtraction."
  def sub(left, right)

  @doc "Arithmetic division."
  def div(left, right)
end

if Code.ensure_compiled?(Decimal) do
  defimpl Tally.Protocol, for: Decimal do
    def add(left, right), do: Decimal.add(left, right)
    def mult(left, right), do: Decimal.mult(left, right)
    def sub(left, right), do: Decimal.sub(left, right)
    def div(left, right), do: Decimal.div(left, right)
  end
end

defimpl Tally.Protocol, for: Any do
  def add(left, right), do: left + right
  def mult(left, right), do: left * right
  def sub(left, right), do: left - right
  def div(left, right), do: left / right
end

defmodule Tally do
  @moduledoc """
  Tally provides a macro and protocol enabling the use of infix operators (e.g. `+`, `-` `*`, `/`)
  with complex types such as [Decimal](https://hexdocs.pm/decimal/). This makes writing calculations
  more natural.
  """

  defmodule Arithmetic do
    import Kernel, except: [+: 2, *: 2, -: 2, /: 2]

    def left + right do
      Tally.Protocol.add(left, right)
    end

    def left * right do
      Tally.Protocol.mult(left, right)
    end

    def left - right do
      Tally.Protocol.sub(left, right)
    end

    def left / right do
      Tally.Protocol.div(left, right)
    end
  end

  defmacro __using__(_opts \\ []) do
    quote do
      import Tally
    end
  end

  defmacro calc(do: ast) do
    quote do
      import Kernel, except: [+: 2, *: 2, -: 2, /: 2]
      import Arithmetic

      unquote(ast)
    end
  end
end
