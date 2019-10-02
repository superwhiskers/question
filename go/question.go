package main

import (
	"bufio"
	"fmt"
	"os"
	"strings"
)

// original implementation of the question function
func question(prompt string, valid []string) string {

	var inp string

	for {

		fmt.Printf("%s\n", prompt)
		if len(valid) != 0 {

			fmt.Printf("(%s): ", strings.Join(valid, ", "))

		} else {

			fmt.Printf(": ")

		}

		scanner := bufio.NewScanner(os.Stdin)
		scanner.Scan()
		inp = scanner.Text()

		if len(valid) == 0 {

			return inp

		}

		for _, ele := range valid {

			if ele == inp {

				return inp

			}

		}

		fmt.Printf("\"%s\" is not a valid answer\n", inp)

	}

}

func main() {

	question("foo", []string{"bar", "baz"})

}
