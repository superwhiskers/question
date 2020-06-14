import { readLines } from "https://deno.land/std@v0.41.0/io/bufio.ts";

const writeLine = (...str: string[]) =>
  Deno.stdout.write(new TextEncoder().encode(str.join("")));

// implementation of the question function in deno
async function question(prompt: string, valid: string[]) {
  const displayPrompt = () =>
    writeLine(prompt, valid.length !== 0 ? `(${valid.join(", ")})` : "", ": ");

  displayPrompt();
  for await (const input of readLines(Deno.stdin)) {
    if (valid.length === 0 || valid.includes(input.trim())) {
      return input.trim();
    } else {
      console.log(`"${input.trim()}" is not a valid answer`);
      displayPrompt();
    }
  }
}

question("foo", ["bar", "baz"]);
