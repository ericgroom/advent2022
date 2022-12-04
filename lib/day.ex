defmodule Advent2022.Day do
  @callback part_one(String.t() | any()) :: any()
  @callback part_two(String.t() | any()) :: any()

  defmacro __using__(_) do
    quote do
      @behaviour unquote(__MODULE__)
      @day_module __MODULE__
      @day_no Advent2022.Day.parse_day_from_module_name(@day_module)
      @input Advent2022.Inputs.input(@day_no)
      @external_resource Advent2022.Inputs.input_path(@day_no)

      Module.register_attribute(__MODULE__, :day, persist: true)
      Module.put_attribute(__MODULE__, :day, @day_no)

      alias Advent2022.Parser

      def part_one, do: call_if_exists(:part_one)
      def part_two, do: call_if_exists(:part_two)
      def raw_input, do: @input
      def input, do: parse_if_exists(@input)

      defp call_if_exists(func) do
        if Kernel.function_exported?(__MODULE__, func, 1) do
          parsed = parse_if_exists(@input)
          apply(__MODULE__, func, [parsed])
        else
          raise "#{__MODULE__} has not implemented #{func}/1"
        end
      end

      defp parse_if_exists(input) do
        if Kernel.function_exported?(__MODULE__, :parse, 1) do
          apply(__MODULE__, :parse, [@input])
        else
          @input
        end
      end
    end
  end

  def parse_day_from_module_name(module_name) when is_atom(module_name) do
    day_name =
      module_name
      |> Atom.to_string()
      |> String.split(".")
      |> List.last()

    if not String.starts_with?(day_name, "Day") do
      raise "invalid format, expected 'Day' prefix"
    end

    day_no = String.replace_prefix(day_name, "Day", "")

    {day, _} = Integer.parse(day_no)

    day
  end
end
