use std::io;
use std::io::Write;

fn question(prompt: &str, valid: &Option<&[&str]>) -> String {
	loop {
		print!("{}", prompt);

		if valid.is_some() {
			print!(" ({}): ", valid.as_ref().unwrap().join(", "));
		} else {
			print!(": ");
		}

		io::stdout().flush().expect("Failed to flush stdout!");

		let mut response = String::new();

		io::stdin().read_line(&mut response).expect("Failed to read from stdin!");

		response = String::from(response.trim());

		if valid.is_some() {
			if valid.as_ref().unwrap().contains(&response.as_str()) {
				return response
			} else {
				println!("\"{}\" is not a valid answer!", response)
			}
		} else if response.trim() == "" {
			println!("Your answer cannot be blank!");
		} else {
			return response;
		}
	}
}

fn main()  {

	question("foo", &Some(&["bar", "baz"]));
	
}
