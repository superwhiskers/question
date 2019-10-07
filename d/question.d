import std.stdio, std.array;

// implementation of the question function in d
string question(string prompt, string[] valid) {

  string inp;

  while (true) {

    writef("%s\n", prompt);
    if (valid.length != 0) {

      writef("(%s): ", join(valid, ", "));

    } else {

      writef(": ");

    }

    inp = stdin.readln()[0 .. $-1];

    if (valid.length == 0) {

      return inp;

    }

    foreach (ele; valid) {

      if (ele == inp) {

	return inp;

      }

    }

    writef("\"%s\" is not a valid answer\n", inp);

  }
  
}

void main() {

  question("foo", ["bar", "baz"]);

}
