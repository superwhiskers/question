#include <vector>
#include <string>
#include <iostream>
#include <sstream>
#include <iterator>
#include <algorithm>

std::string question(std::string prompt, std::vector<std::string> valid) {
	std::string inp, q = prompt;
	if (!valid.empty()) {
		std::ostringstream t;
		std::copy(valid.begin(), valid.end(),
				std::ostream_iterator<std::string>(t, ", "));
		q += " (";
		q += t.str().substr(0,t.str().length()-2);
		q += ")";
	}
	q += ": ";
	
	while (true) {
		std::cout << q;
		std::getline(std::cin, inp);
		if (valid.empty())
			return inp;

		if (std::find(valid.begin(), valid.end(), inp) != valid.end())
			return inp;

		std::cout << inp << " is not a valid answer" << std::endl;
	}
}


int main() {
	question("foo", std::vector<std::string> {"bar", "baz"});
}
