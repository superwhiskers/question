# implementation of the question function in crystal
def question(prompt : String, valid : Array)

  while true

    puts  prompt
    print "(#{valid.join(", ")})" if valid.size != 0
    print ": "

    input = STDIN.gets
    
    if valid.empty?


      return input if valid.includes? input
    
    end

    puts %("#{input}" is not a valid answer)  

  end

end

question "foo", ["bar", "baz"]
