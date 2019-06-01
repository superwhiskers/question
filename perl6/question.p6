use v6;

sub question(Str $prompt, @valid --> Str) {
    my Str $input;

    loop {
	say($prompt);
	if (@valid.elems != 0) {
	    $input = prompt(sprintf("(%s): ", join(", ", @valid)));
	} else {
	    $input = prompt(": ");
	}

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
