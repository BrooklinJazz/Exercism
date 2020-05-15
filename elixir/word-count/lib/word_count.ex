defmodule WordCount do
  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """
  @spec count(String.t()) :: map
  def count(sentence) do
    sentence
    |> filter_punctuation
    |> split_sentence
    |> count_words
  end

  def filter_punctuation(sentence) do
    Regex.replace( ~r/[[:punct:]]/, sentence, " ")
  end

  def split_sentence(sentence) do
    String.split(sentence)
  end

  def count_words(word_list) do
    Enum.reduce(word_list, %{}, fn each, total -> Map.update(total, each, 1, &(&1 + 1)) end)
  end
end
