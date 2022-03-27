# implementation of the question function in Python
def question(prompt, valid):
    inp = ""
    while True:

        print(prompt)
        if len(valid) != 0:
            inp = input(f'({", ".join(valid)}): ').strip()
        else:
            inp = input(": ").strip()

        if len(valid) == 0 or inp in valid:
            return inp

        print(f'"{inp}" is not a valid answer')


question("foo", ["bar", "baz"])
