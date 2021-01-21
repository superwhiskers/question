# Implementation of the question function in crystal
def question(prompt : String, valid : Array(String)) : String
  loop do
    puts prompt
    print "(#{valid.join(", ")})" unless valid.empty?
    print ": "

    input = STDIN.gets

    if !input.nil? && (valid.empty? || valid.includes?(input))
      return input
    else
      puts %("#{input}" is not a valid answer)
    end
  end
end

question("foo", ["bar", "baz"])
