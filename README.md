# Tally

Tally provides a macro and protocol enabling the use of infix operators (e.g. `+`, `-` `*`, `/`)
with complex types such as [Decimal](https://hexdocs.pm/decimal/). This makes writing calculations
more natural.

## Example

Without Tally:

```elixir
a = Decimal.new(1)
b = Decimal.new(2)

c =  Decimal.add(a, b)
```

With Tally:

```elixir
use Tally

calc do
  a = Decimal.new(1)
  b = Decimal.new(2)

  c = a + b
end
```

## Protocols

Tally uses a protocol, `Tally.Protocol` to dynamically dispatch arithmetic operations. `Tally`
provides a default fallback implementation that retains the existing behaviour of Elixir. An
implementation for `Decimal` is also provided and is only compiled if you include the `decimal`
package in your `mix` file as a dependency.

You can implement the `Tally.Protocol` for your own or third-party libraries such as `Money`
giving you a natural, infix implementation for money calculations.

```elixir
calc do
  a = Money.new(100)
  b = Money.new(200)

  c = a + b
end
```

## To-do

- [x] `left * right` Arithmetic multiplication.
- [ ] `+value` Arithmetic unary plus.
- [x] `left + right` Arithmetic addition.
- [ ] `-value` Arithmetic unary minus.
- [x] `left - right` Arithmetic subtraction.
- [x] `left / right` Arithmetic division.
- [ ] `abs(number)` Returns an integer or float which is the arithmetical absolute value of number.
