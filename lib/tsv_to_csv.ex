defmodule TsvToCsv do
  def main([separator | files]) do
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
      tsv_to_csv "\t" file1.tsv file2.tsv
    """
  end

  def convert(filepath, [separator]) do
    csv_path = (filepath |> Path.rootname) <> ".csv"
    File.stream!(filepath)
    |> CSV.decode(separator: separator)
    |> CSV.encode
    |> Enum.into(File.stream!(csv_path))
  end
end
