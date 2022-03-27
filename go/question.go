package main

import (
	"bufio"
	"fmt"
	"os"
	"strings"
	"unicode"
)

// implementation of the question function in go
func question(prompt string, valid []string) string {
	var input string
	joinedValid := strings.Join(valid, ", ")

	for {
		fmt.Printf("%s\n", prompt)
		if len(valid) != 0 {
			fmt.Printf("(%s)", joinedValid)
		}
		fmt.Printf(": ")

		scanner := bufio.NewScanner(os.Stdin)
		scanner.Scan()
		input = strings.TrimFunc(scanner.Text(), unicode.IsSpace)

		if len(valid) == 0 {
			return input
		}

		for _, ele := range valid {
			if ele == input {
				return input
			}
		}

		fmt.Printf("\"%s\" is not a valid answer\n", input)
	}
}

func main() {
	question("foo", []string{"bar", "baz"})
}
