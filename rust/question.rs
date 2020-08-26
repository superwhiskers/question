use std::io::{self, Write};

fn question<'a>(prompt: &str, valid: Option<&[&'a str]>) -> io::Result<&'a str> {
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

        if let Some(value) = valid.unwrap_or_default().iter().find(|&&v| v == trimmed) {
            return Ok(value);
        } else {
            println!("\"{}\" is not a valid answer", trimmed);
            input.clear();
        }
    }
}

fn main() {
    question("foo", Some(&["bar", "baz"])).unwrap();
}
