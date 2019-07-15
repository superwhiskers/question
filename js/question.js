const readline = require('readline')

function question(prompt, valid) {
	const rl = readline.createInterface({
		input: process.stdin,
		output: process.stdout,
		prompt: `${prompt}\n(${valid.join(', ')}): `
	})

	rl.on('line', answer => {
		if (!valid.includes(answer)) {
			console.log(`"${answer}" is not a valid answer`)
			rl.prompt()
		}
		else {
			rl.close()
		}
	})

	rl.prompt()
}

question('foo', ['baz', 'bar'])
