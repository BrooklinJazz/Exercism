defmodule RnaTranscription do
  @doc """
  Transcribes a character list representing DNA nucleotides to RNA

  ## Examples

  iex> RnaTranscription.to_rna('ACTG')
  'UGAC'
  """
  def convert_rna_char(char) do
    case char do
     ?G -> 'C'
     ?C -> 'G'
     ?T -> 'A'
     ?A -> 'U'
    end
  end
  @spec to_rna([char]) :: [char]
  def to_rna(dna) do
    List.to_charlist(Enum.map(dna, fn each -> convert_rna_char(each) end))
  end
end
