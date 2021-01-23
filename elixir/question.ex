# question implementation in elixir
defmodule Question do
  def question(prompt), do: IO.gets("#{prompt}: ")

  def question(prompt, valid) do
    input = String.trim(IO.gets("#{prompt}\n(#{Enum.join(valid, ", ")}): "))

    if input in valid do
      input
    else
      IO.puts("\"#{input}\" is not a valid answer")
      question(prompt, valid)
    end
  end
end

Question.question("foo", ["bar", "baz"])
