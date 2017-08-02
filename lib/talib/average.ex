defmodule Talib.Average do
  alias Talib.Utility

  @moduledoc ~S"""
  Module containing average functions, such as the mean,
  mode and median.
  """

  @doc """
  Gets the mean of a list.

  Version: 1.0  
  Source: http://mathworld.wolfram.com/ArithmeticMean.html  
  Audited by:

  | Name         | Title             |
  | :----------- | :---------------- |
  |              |                   |

  """

  @spec mean([number]) :: number | nil
  def mean([]), do: nil
  def mean([n]), do: n
  def mean(list) when is_list(list) do
    Enum.sum(list) / length(list)
  end

  @doc """
  Gets the median of a list.

  Version: 1.0  
  Source: http://mathworld.wolfram.com/StatisticalMedian.html  
  Audited by:

  | Name         | Title             |
  | :----------- | :---------------- |
  |              |                   |

  """

  @spec median([number]) :: number | nil
  def median([]), do: nil
  def median([n]), do: n
  def median(list) when is_list(list) do
    midpoint = list
    |> length
    |> Integer.floor_div(2)

    # 0 is even, 1 is odd
    case list |> length |> rem(2) do
      0 ->
        {_, [med1, med2 | _]} = Enum.split(list, midpoint - 1)
        (med1 + med2) / 2
      1 ->
        {_, [median | _]} = Enum.split(list, midpoint)
        median
    end
  end

  @doc """
  Gets the midrange of a list.

  Version: 1.0  
  Source: http://mathworld.wolfram.com/Midrange.html  
  Audited by:

  | Name         | Title             |
  | :----------- | :---------------- |
  |              |                   |

  """

  @spec midrange([number]) :: number | nil
  def midrange([]), do: nil
  def midrange([n]), do: n
  def midrange(list) when is_list(list) do
    max = list |> Enum.max
    min = list |> Enum.min

    (max + min) / 2
  end

  @doc """
  Gets the most frequently occuring value in a list.

  Version: 1.0  
  Source: http://mathworld.wolfram.com/Mode.html  
  Audited by:

  | Name         | Title             |
  | :----------- | :---------------- |
  |              |                   |

  """

  @spec mode([number]) :: number | nil
  def mode([]), do: nil
  def mode([n]), do: n
  def mode(list) when is_list(list) do
    list
    |> Utility.occur
    |> map_max
  end

  @doc false
  @spec map_max(map()) :: number | [number, ...]
  defp map_max(map) when is_map(map) do
    max = map
    |> Map.values
    |> Enum.max

    # Create array of maximums
    # Add key to maximums array
    maxes = Enum.reduce(map, [], fn({key, value}, acc) ->
      case value do
        ^max -> [key | acc]
        _ -> acc
      end
    end)

    # Support multiple maximums %{a: 3, b: 3} => [:a, :b]
    # Or single maximum %{a: 3, b: 2} => [:a]
    case maxes do
      [n] -> n
      [_ | _] = array -> Enum.reverse(array)
    end
  end
end
