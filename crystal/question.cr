# implementation of the question function in crystal
def question(prompt : String, valid : Array)
  
  while true

    puts(prompt)
    if valid.size() != 0

      print("(#{valid.join(", ")}): ")
      
    else

      print(": ")
      
    end

    inp = STDIN.gets()

    if valid.size() == 0

      return inp

    end

    i = 0
    while i < valid.size()

      if valid[i] == inp

        return inp

      end
      i += 1

    end

    puts("\"#{inp}\" is not a valid answer")
    
  end
  
end

question("foo", ["bar", "baz"])
