import * as readline from "node:readline/promises";
import { stdin as input, stdout as output } from "node:process";

// implementation of the question function in nodejs
async function question(prompt, valid) {
  const rl = readline.createInterface({ input, output });
  const joinedPrompt = valid
    ? `${prompt}\n(${valid.join(", ")}): `
    : `${prompt}: `;

  while (true) {
    const input = await rl.question(joinedPrompt).then((s) => s.trim());
    if (!valid || valid.includes(input)) {
      rl.close();
      return input;
    }
    console.log(`"${input}" is not a valid answer`);
  }
}

question("foo", ["bar", "baz"]);
