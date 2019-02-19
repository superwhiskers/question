# implementation of the question function in python
def question(prompt, valid):
	while True:
		inp = ''
	
		print(prompt)
		if len(valid) != 0:
			inp = input(f'({", ".join(valid)}): ')
		else:
			inp = input(': ')
		
		if len(valid) == 0:
			return inp
		
		for ele in valid:
			if ele == inp:
				return inp
		
		print(f'"{inp}" is not a valid answer')
		
question('foo', ['bar', 'baz'])
