use v6;

# implementation of the question function in perl6
sub question(Str $prompt, @valid --> Str) {
    my Str $input;
    my Str $joined_valid = join(", ", @valid);

    loop {
	say($prompt);
	if (@valid.elems != 0) {
	    $input = printf("(%s)", joined_valid);
	}
	$input = prompt(": ");

	if (@valid.elems == 0) {
	    return $input;
	}

	if ($input ~~ any @valid) {
	    return $input;
	}

	say("\"$input\" is not a valid answer");
    }
}

question("foo", ("bar", "baz"));
