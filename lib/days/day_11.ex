defmodule Advent2022.Days.Day11 do
  alias Advent2022.Days.Day11.Days.Day11.Monkey
  use Advent2022.Day

  alias __MODULE__.Monkey

  defmodule Monkey do
    defstruct [:num, :items, :operation, :test, :inspection_count]

    def receive_item(%__MODULE__{items: items} = monkey, item) do
      %{monkey | items: items ++ [item]}
    end

    def clear_items(%__MODULE__{} = monkey) do
      %{monkey | items: [], inspection_count: monkey.inspection_count + Enum.count(monkey.items)}
    end
  end

  def part_one(input) do
    1..20
    |> Enum.reduce(input, fn _, monkeys ->
      0..(Enum.count(monkeys) - 1)
      |> Enum.reduce(monkeys, fn monkey_index, monkeys ->
        monkey = monkeys[monkey_index]

        item_to_new_monkey =
          Enum.map(monkey.items, fn item ->
            adjusted_item = div(execute_operation(monkey.operation, item), 3)
            new_monkey_index = execute_test(monkey.test, adjusted_item)

            {adjusted_item, new_monkey_index}
          end)

        Enum.reduce(item_to_new_monkey, monkeys, fn {item, new_monkey_index}, monkeys ->
          Map.put(monkeys, new_monkey_index, Monkey.receive_item(monkeys[new_monkey_index], item))
        end)
        |> then(fn monkeys -> update_in(monkeys[monkey_index], &Monkey.clear_items/1) end)
      end)
    end)
    |> Enum.map(fn {_, monkey} -> monkey.inspection_count end)
    |> Enum.sort(:desc)
    |> Enum.take(2)
    |> Enum.product()
  end

  def part_two(input) do
    mod_magic_number =
      input
      |> Enum.map(fn {_, %{test: {divisor, _, _}}} -> divisor end)
      |> Enum.product()

    1..10000
    |> Enum.reduce(input, fn _, monkeys ->
      0..(Enum.count(monkeys) - 1)
      |> Enum.reduce(monkeys, fn monkey_index, monkeys ->
        monkey = monkeys[monkey_index]

        item_to_new_monkey =
          Enum.map(monkey.items, fn item ->
            adjusted_item = rem(execute_operation(monkey.operation, item), mod_magic_number)
            new_monkey_index = execute_test(monkey.test, adjusted_item)

            {adjusted_item, new_monkey_index}
          end)

        Enum.reduce(item_to_new_monkey, monkeys, fn {item, new_monkey_index}, monkeys ->
          Map.put(monkeys, new_monkey_index, Monkey.receive_item(monkeys[new_monkey_index], item))
        end)
        |> then(fn monkeys -> update_in(monkeys[monkey_index], &Monkey.clear_items/1) end)
      end)
    end)
    |> Enum.map(fn {_, monkey} -> monkey.inspection_count end)
    |> Enum.sort(:desc)
    |> Enum.take(2)
    |> Enum.product()
  end

  def execute_operation({first, operator, second}, worry_level) do
    op =
      case operator do
        :+ -> &+/2
        :* -> &*/2
      end

    [first, second] =
      Enum.map([first, second], fn
        :old -> worry_level
        num -> num
      end)

    op.(first, second)
  end

  defp execute_test({divisor, t, f}, worry_level) do
    if rem(worry_level, divisor) == 0, do: t, else: f
  end

  def(parse(raw)) do
    raw
    |> String.split("\n\n", trim: true)
    |> Enum.map(&parse_monkey/1)
    |> Map.new(fn monkey -> {monkey.num, monkey} end)
  end

  defp parse_monkey(raw_monkey) do
    [monkey_num, starting_items, operation, test, t, f] =
      String.split(raw_monkey, "\n", trim: true)
      |> Enum.map(&String.trim_leading/1)

    monkey_num =
      String.replace_leading(monkey_num, "Monkey ", "")
      |> String.replace_trailing(":", "")
      |> String.to_integer()

    starting_items =
      String.replace_leading(starting_items, "Starting items: ", "")
      |> String.split(", ")
      |> Enum.map(&String.to_integer/1)

    operation = parse_operation(operation)

    test = parse_test(test, t, f)

    %Monkey{
      num: monkey_num,
      items: starting_items,
      operation: operation,
      test: test,
      inspection_count: 0
    }
  end

  defp parse_operation(operation) do
    [first, operator, second] =
      String.replace_leading(operation, "Operation: new = ", "")
      |> String.split(" ")

    operation =
      case operator do
        "+" -> :+
        "*" -> :*
      end

    {parse_arg(first), operation, parse_arg(second)}
  end

  defp parse_test(test, t, f) do
    divisor = String.replace(test, "Test: divisible by ", "") |> String.to_integer()
    t = String.replace(t, "If true: throw to monkey ", "") |> String.to_integer()
    f = String.replace(f, "If false: throw to monkey ", "") |> String.to_integer()
    {divisor, t, f}
  end

  defp parse_arg("old"), do: :old
  defp parse_arg(num), do: String.to_integer(num)
end
