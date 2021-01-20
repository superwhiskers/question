# Implementation of the question function in Ruby
def question(prompt, valid)
  while true
    puts prompt
    print "(#{valid.join ", "})" if valid.size != 0
    print ": "
    input = gets.chomp

    if valid.empty? || valid.include?(input)
      return input
    else
      puts %("#{input}" is not a valid answer)
    end
  end
end

question "foo", ["bar", "baz"]
