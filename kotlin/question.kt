fun question(prompt: String, valid: Collection<String>): String {
	val joined_valid = valid.joinToString()

	while (true) {
		println(prompt)
		if (valid.count() != 0) {
			print("($joined_valid)")
		}
		print(": ")

		val inp = readLine()!!
		
		if (valid.count() == 0) {
			return inp
		}

		for (i in valid) {
			if (i == inp) {
				return inp
			}
		}

		println("'$inp' is not a valid answer")
	}
}

fun main() {
	println("You answered " + question("Foo", listOf("Bar", "Baz")))
}
