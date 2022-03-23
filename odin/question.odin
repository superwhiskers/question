package main

import "core:fmt"
import "core:os"
import "core:strings"

question :: proc(prompt: string, valid: []string) -> string {
	joined_valid := strings.join(valid, ", ");
	
	for {
		fmt.println(prompt);

		if len(valid) != 0 {
			fmt.printf("(%s)", joined_valid);
		}
		fmt.print(": ");

		slc := make_slice([]byte, 1024);
		raw, _ := os.read(os.stdin, slc[:]);
		input := strings.trim_space(string(slc[:raw]));

		if len(valid) == 0 {
			return input;
		}

		for ele in valid {
			if ele == input {
				return input;
			}
		}

		fmt.printf("\"%s\" is not a valid answer!\n", input);
	}
}

main :: proc() {
	fmt.println(question("foo", []string{"bar", "baz"}));
}
