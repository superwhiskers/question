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
		inp := strings.trim(string(slc[:raw]), "\n");

		if len(valid) == 0 {
			return inp;
		}

		for ele in valid {
			if ele == inp {
				return inp;
			}
		}

		fmt.printf("\"%s\" is not a valid answer!\n", inp);
	}
}

main :: proc() {
	fmt.println(question("Foo", []string{"Bar", "Baz"}));
}
