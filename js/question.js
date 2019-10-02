const readline = require('readline')

// implementation of the question function in crystal
function question(prompt, valid) {
	let rl
  let final_answer
  if (valid.length === 0) {
    rl = readline.createInterface({
		  input: process.stdin,
		  output: process.stdout,
		  prompt: `${prompt}\n: `
	  })
  } else {
    rl = readline.createInterface({
		  input: process.stdin,
		  output: process.stdout,
		  prompt: `${prompt}\n(${valid.join(', ')}): `
	  })
  }

	rl.on('line', answer => {
	  if (valid.length == 0 || valid.includes(answer)) {
			rl.close()
      final_answer = answer
      return
		}

    console.log(`"${answer}" is not a valid answer`)
    rl.prompt()
	})

	rl.prompt()
  return final_answer
}

question('foo', ['bar', 'baz'])
