defmodule TsvToCsv do
  def main([separator | [_ | _] = files]) do
    files
    |> Enum.each(fn file ->
      convert(file, separator |> to_charlist)
    end)
  end

  def main(_) do
    IO.puts """
    Usage:
      tsv_to_csv separator file1 file2 ....
    e.g.
      tsv_to_csv $'\\t' file1.tsv file2.tsv
      tsv_to_csv '|' file1.txt file2.txt
    """
  end

  def convert(filepath, [separator]) do
    File.stream!(filepath)
    |> Enum.map(& String.split(to_string separator))
    |> CSV.encode
    |> Enum.into(IO.stream(:stdio, :line))
  end
end
