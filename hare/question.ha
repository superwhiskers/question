use fmt;
use io;
use bufio;
use os;
use strings;
use encoding::utf8;
use sort;

type unexpected_eof = !void;

fn scmp(a: const *void, b: const *void) int = {
	let a = a: const *str, b = b: const *str;
	return strings::strcmp(*a, *b);
};

fn question(prompt: str, valid: []str) (io::error | utf8::invalid | unexpected_eof | str) = {
	let joined_valid = strings::join(", ", valid...);
	defer free(joined_valid);

	for (true) {
		fmt::println(prompt)?;
		if (len(valid) != 0) {
			fmt::printf("({})", joined_valid)?;
		};
		fmt::print(": ")?;
		bufio::flush(&os::stdout_bufio)?;

		const input = match (bufio::scanline(os::stdin)?) {
		case io::EOF =>
			return unexpected_eof;
		case let buf: []u8 =>
			yield strings::try_fromutf8(buf)?;
		};
		defer free(input);

		const trimmed_input = strings::trimsuffix(input, "\n");

		if (len(valid) == 0 || sort::search(valid, size(str), &trimmed_input, &scmp) != null) {
			return input;
		};

		fmt::printf("\"{}\" is not a valid answer\n", trimmed_input)?;
	};

	return "unreachable";
};

export fn main() void = {
	question("foo", ["bar", "baz"])!;
};
