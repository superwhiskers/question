require 'io'
require 'string'

-- implementation of the question function in lua
function question(prompt, valid)
	
	while true do
	
		print(prompt)
		if #valid ~= 0 then
		
			io.write(string.format('(%s): ', table.concat(valid, ', ')))
			
		else
		
			io.write(': ')
			
		end
		io.flush()
		
		input = io.read()
		
		if #valid == 0 then
		
			return input
			
		end
		
		for _, ele in pairs(valid) do
		
			if ele == input then
			
				return input
			
  		end
  		
		end
		
		print(string.format('"%s" is not a valid answer', input))
		
	end
	
end

question('foo', {'bar', 'baz'})