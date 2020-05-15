defmodule WordCount do
  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """
  @spec count(String.t()) :: map
  def count(sentence) do
    sentence
    |> String.downcase
    |> filter_punctuation
    |> String.split
    |> count_words
  end

  def filter_punctuation(sentence) do
    Regex.replace( ~r/@|#|\$|%|&|\^|:|_|!|,/u, sentence, " ")
  end

  def count_words(word_list) do
    Enum.reduce(word_list, %{}, &combine/2)
  end

  def combine(word, map) do
    Map.update(map, word, 1, &(&1 + 1))
  end
end
