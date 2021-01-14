import Swift
import Foundation

func question(prompt: String, valid: [String]) -> String {
	let joinedValid = valid.joined(separator: ", ")

	while true {
		print(prompt)
		if !valid.isEmpty {
			print("(\(joinedValid))", terminator: "")
		}
		print(": ", terminator: "")

		if let inp = readLine() {
			if valid.isEmpty {
				return inp
			}

			for s in valid {
				if s == inp {
					return s
				}
			}

			print("\"\(inp)\" is not a valid answer!")
		} else {
			print("Error reading from stdin")
			abort()
		}
	}
}

print(question(prompt: "Foo", valid: ["Bar", "Baz"]))
