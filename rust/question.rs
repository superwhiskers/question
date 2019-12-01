use std::io;
use std::io::Write;

// implementation of the question function in rust
fn question(prompt: &str, valid: Option<&[&str]>) -> String {
    let mut input = String::new();
    let mut joined_valid: String = "".into();
    if let Some(valid) = valid {
        joined_valid = valid.join(", ");
    }

    loop {
        println!("{}", prompt);
        if valid.is_some() {
            print!("({})", &joined_valid);
        }
        print!(": ");

        io::stdout().flush().expect("failed to flush stdout");
        io::stdin()
            .read_line(&mut input)
            .expect("failed to read stdin");
        input.pop();

        if valid.is_none() {
            return input;
        }

        for ele in valid.unwrap().iter() {
            if ele.to_string() == input {
                return input;
            }
        }

        println!("\"{}\" is not a valid answer", input);
        input = "".to_string();
    }
}

fn main() {
    question("foo", Some(&["bar", "baz"]));
}
