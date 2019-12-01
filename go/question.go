package main

import (
	"bufio"
	"fmt"
	"os"
	"strings"
)

// implementation of the question function in go
func question(prompt string, valid []string) string {
	var inp string
	joinedValid := strings.Join(valid, ", ")

	for {
		fmt.Printf("%s\n", prompt)
		if len(valid) != 0 {
			fmt.Printf("(%s)", joinedValid)
		}
		fmt.Printf(": ")

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
