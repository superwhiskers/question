import { assertEquals } from "https://deno.land/std@0.90.0/testing/asserts.ts";

const encoder = new TextEncoder();
const decoder = new TextDecoder();

async function testCmd(cmd: string[], prompts: [string, string][]) {
  const process = Deno.run({
    cmd: [...cmd],
    stdout: "piped",
    stdin: "piped",
  });

  const iter = Deno.iter(process.stdout);

  async function inputExpect(input: string, expected: string) {
    await process.stdin.write(encoder.encode(input));
    const next = await iter.next();
    const text = decoder.decode(next.value);

    assertEquals(text, expected);
  }

  for(const [input, expected] of prompts) {
    await inputExpect(input, expected)
  }

  // must manually be close to not leak
  process.stdin.close();
  process.stdout.close();
  process.close();
}

const validate = (cmd: string[]) =>
  testCmd(cmd, [
    ["", "foo(bar, baz): "],
    ["WRONG\n", '"WRONG" is not a valid answer\n'],
    ["", "foo(bar, baz): "],
    ["\n", '"" is not a valid answer\n'],
    ["bar\n", "foo(bar, baz): "],
    ["", ""],
  ]);

Deno.test("question.ts matches the specification", () =>
  validate(["deno", "run", "question.ts"]));
