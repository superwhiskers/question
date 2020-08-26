use std::io::{self, Write};

fn question(prompt: &str, valid: Option<&[&str]>) -> io::Result<String> {
    let mut input = String::new();

    loop {
        println!("{}", prompt);
        if valid.is_some() {
            print!("({})", &valid.unwrap_or_default().join(","));
        }
        print!(": ");

        io::stdout().flush()?;
        io::stdin().read_line(&mut input)?;

        let trimmed = input.trim();

        if valid.is_none() || valid.unwrap_or_default().iter().find(|&&v| v == trimmed).is_some() {
            return Ok(trimmed.to_string());
        } else {
            println!("\"{}\" is not a valid answer", trimmed);
            input.clear();
        }
    }
}

fn main() {
    question("foo", Some(&["bar", "baz"])).unwrap();
}
