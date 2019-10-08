import java.io.BufferedReader;
import java.io.InputStreamReader;

public class question {
	public static void main(String[] args) {
		Question q = new Question();
		String s = q.ask("Enter something", new String[]{"yes", "no"});
		System.out.println(s);
	}
}

class Question {
	String ask(String prompt, String[] valid) {
		BufferedReader buf = new BufferedReader(new InputStreamReader(System.in));

		System.out.printf("%s (%s): ", prompt, String.join(", ", valid));
		while (true) {
			String inp = "";
			try {inp = buf.readLine();} 
			catch(Exception e) { 
				System.out.println(e);
				System.exit(1);
			}

			if (valid.length == 0) {
				return inp;
			}

			for (String s : valid) {
				if (s.equals(inp)) { // assuming that equals() was overriden
					return s;
    				}
			}
			System.out.printf("\"%s\" is not a valid answer\n", inp);
		}
	}
}
