// implementation of the question function in deno
async function question(prompt: string, valid?: string[]) {
  const joinedPrompt = valid ? `${prompt}(${valid.join(", ")}):` : `${prompt}:`;

  while (true) {
    const input = globalThis.prompt(joinedPrompt)?.trim() ?? "";
    if (valid?.includes(input) ?? true) return input;
    console.log(`"${input}" is not a valid answer`);
  }
}

question("foo", ["bar", "baz"]);
