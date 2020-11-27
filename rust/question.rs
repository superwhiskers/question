use std::io::{self, stdout, stdin, Write};

fn question(prompt: &str, valid: Option<&[&str]>) -> io::Result<String> {
    // declare both the input buffer as well as the string listing the possible responses
    // beforehand to avoid allocating memory
    let joined_valid = valid.map(|v| v.join(", "));
    let mut input = String::new();

    loop {
        // output the prompt, displaying possible responses if necessary
        println!("{}", prompt);
        match &joined_valid {
            Some(joined_valid) => print!("({}): ", joined_valid),
            None => print!(": "),
        }

        // flush the output stream to ensure that the prompt is visible while we await input
        stdout().flush()?;
        stdin().read_line(&mut input)?;
        
        // trim any line ending from the string and save the resulting slice, not allocating any
        // new String as we may not need it
        let trimmed_input = input.trim_end();

        // check if we are accepting all input or if their response is one of the accepted ones
        if valid.map_or(true, |v| v.contains(&trimmed_input)) {
            break Ok(trimmed_input.to_string());
        }

        // otherwise, their response was invalid, so we let them know
        println!("\"{}\" is not a valid answer", trimmed_input);

        // clear the input buffer
        input.clear();

        // ...and loop around, trying again
    }
}

fn main() -> io::Result<()> {
    // we may use a better example here instead of a generic one
    question("foo", Some(&["bar", "baz"]))?;
    question("foo", None)?;
    Ok(())
}
