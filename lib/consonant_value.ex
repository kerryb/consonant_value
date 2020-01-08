defmodule ConsonantValue do
  @doc """
  Given a lowercase string that has alphabetic characters only and no spaces,
  return the highest value of consonant substrings, where a = 1, b = 2 etc.

  ## Examples

  NB. these are executable doctests

      iex> ConsonantValue.solve("zodiacs")
      26

      iex> ConsonantValue.solve("strength")
      57
  """
  def solve(string) do
    string
    |> String.codepoints()
    |> Enum.chunk_while([], &chunk_fun/2, &after_fun/1)
    |> Enum.map(&letter_values/1)
    |> Enum.max()
  end

  defp chunk_fun(letter, []) when letter in ~w[a e i o u], do: {:cont, []}
  defp chunk_fun(letter, acc) when letter in ~w[a e i o u], do: {:cont, acc, []}
  defp chunk_fun(letter, acc), do: {:cont, [letter | acc]}

  defp after_fun(acc), do: {:cont, acc, []}

  defp letter_values(letters) do
    letters |> Enum.reduce(0, fn letter, acc -> acc + :binary.first(letter) - 96 end)
  end
end
