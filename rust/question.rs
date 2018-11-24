use std::io;
use std::mem;
use std::io::{Write};

// implementation of the question function in rust
fn question(prompt: &str, valid: &[&str]) -> &'static str {

    loop {

        let mut input = String::new();

        println!("{}", prompt);
        if valid.len() != 0 {

            print!("({}): ", valid.join(", "));

        } else {

            print!(": ")

        }

        let _ = io::stdout().flush();
        io::stdin().read_line(&mut input)
            .expect("[err]: failed to read input...");
        input.pop();

        if valid.len() == 0 {

            return string_to_static_str(input);

        }

        for ele in valid.iter() {

            if ele.to_string() == input {

                    return string_to_static_str(input);

            }

        }

        println!("\"{}\" is not a valid answer", input)

    }

}

fn string_to_static_str(s: String) -> &'static str {

    unsafe {
    
        let ret = mem::transmute(&s as &str);
        mem::forget(s);
        ret
        
    }
    
}

fn main()  {

	question("foo", &["bar", "baz"])
	
}