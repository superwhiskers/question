# implementation of the question function in raku
sub question(Str $prompt, @valid --> Str) {
  my Str $input;
  my Str $joined_valid = join(", ", @valid);

  loop {
    say $prompt;

    if @valid {
        print "($joined_valid)";
    }

    $input = prompt(": ").trim;

    if (@valid.elems == 0 || $input ~~ any @valid) {
        return $input;
    }

    say "\"$input\" is not a valid answer";
  }
}

question("foo", ("bar", "baz"));
