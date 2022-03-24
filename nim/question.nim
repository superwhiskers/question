import std/[strutils, strbasics, strformat, rdstdin]

# implementation of the question "function" in nim
proc question(prompt: string): string =
  echo prompt
  readLineFromStdin(": ")

proc question[I](prompt: string, valid: array[I, string]): string =
  let joined_prompt = &"""({valid.join(", ")}): """

  while true:
    echo prompt
    var input = readLineFromStdin(joined_prompt)
    input.strip()
    if input in valid: return input
    echo '"', input, '"', " is not a valid answer"

when isMainModule:
  discard question("foo", ["bar", "baz"])
