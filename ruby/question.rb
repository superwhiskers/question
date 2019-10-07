# implementation of the question function in ruby
def question(prompt, valid)

  while true

    puts  prompt
    print "(#{valid.join(", ")})" if valid.size != 0
    print ": "

    input = STDIN.gets.chomp
    
    if valid.empty?

      return input
    
    else

      return input if valid.include? input
    
    end

    puts %("#{input}" is not a valid answer)  

  end

end

question("foo", ["bar", "baz"])
