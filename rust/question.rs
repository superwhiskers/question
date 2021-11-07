use std::io::{self, Write};

fn question(prompt: &str, valid: Option<&[&str]>) -> io::Result<String> {
    let joined_valid = valid.map(|v| v.join(", "));
    let mut input = String::new();

    loop {
        println!("{}", prompt);
        if let Some(ref valid) = joined_valid {
            print!("({})", valid);
        }
        print!(": ");

        io::stdout().flush()?;
        io::stdin().read_line(&mut input)?;

        let trimmed_input = input.trim_end();

        if valid.map_or(true, |v| v.contains(&trimmed_input)) {
            break Ok(trimmed_input.to_string());
        }

        println!("\"{}\" is not a valid answer", trimmed_input);

        input.clear();
    }
}

fn main() -> io::Result<()> {
    question("foo", Some(&["bar", "baz"]))?;
    Ok(())
}
