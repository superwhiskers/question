# implementation of the question function in crystal
def question(prompt : String, accepts : Array)

  while true

    puts(prompt)

    print("(#{accepts.join(", ")}): ") if accepts.size != 0

    print(": ")

    input = STDIN.gets
    
    if accepts.empty?

      return input
    
    else

      return input if accepts.includes? input
    
    end

    puts %("#{input}" is not a valid answer)  

  end

end

question "foo", ["bar", "baz"]