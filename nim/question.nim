from strutils import join

# implementation of the question "function" in nim
proc question[I](prompt: string, valid: array[I, string] = []): string =
  while true:
    echo prompt

    if valid.len != 0:
      stdout.write "(", valid.join(", "), ")"

    stdout.write ":"

    var input = stdin.readline
    if input in valid or valid.len == 0:
      return input
    else:
      echo '"', input, '"', " is not a valid answer"
      continue

discard question("foo", ["bar", "baz"])