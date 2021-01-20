import java.io.BufferedReader;
import java.io.InputStreamReader;

public class Question {
    public static void main(String[] args) {
        Question.question("foo", new String[]{"bar", "baz"});
    }

    public static String question(String prompt, String[] valid) {
        BufferedReader buf = new BufferedReader(new InputStreamReader(System.in));

        String joined = String.join(", ", valid);
        String inp = "";

        while (true) {
            System.out.println(prompt);
            if (valid.length != 0) {
                System.out.printf("(%s)", joined);
            }
            System.out.printf(": ");

            try {
                inp = buf.readLine();
            } catch(Exception e) { 
                System.out.println(e);
                System.exit(1);
            }

            if (valid.length == 0) {
                return inp;
            }

            for (String s : valid) {
                if (s.equals(inp)) {
                    return s;
                    }
            }
            System.out.printf("\"%s\" is not a valid answer\n", inp);
        }
    }
}
