use strict;
use warnings;
use v5.10;

# implementation of the question function in perl
sub question {
    my ($prompt, @valid) = @_;
    my $input;

    for(;;) {
	say($prompt);
	if (scalar(@valid) != 0) {
	    printf("(%s): ", join(", ", @valid));
	} else {
	    print(": ");
	}

	chomp($input = <STDIN>);

	if (scalar(@valid) == 0) {
	    return $input;
	}

	foreach (@valid) {
	    if ($_ eq $input) {
		return $input;
	    }
	}

	say("\"$input\" is not a valid answer");
    }
}

question("foo", ("bar", "baz"));
