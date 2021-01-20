using System;
using System.Collections.Generic;

class Program
{
    // Implementation of the question function in C#
    public static string Question(string prompt, List<string> valid = null)
    {
        string r;

        while (true)
        {
            Console.WriteLine(prompt);
            if (valid != null && valid.Count != 0)
            {
                Console.Write($"({string.Join(", ", valid.ToArray())}): ");
            }
            else
            {
                Console.Write($": ");
            }

            r = Console.ReadLine();

            if (valid != null && valid.Count != 0)
            {
                if (valid.Contains(r))
                {
                    return r;
                }
            }
            else
            {
                return r;
            }

            Console.WriteLine($"\"{r}\" is not a valid answer!");
        }
    }

    public static void Main(string[] args)
    {
        Question("foo", new List<string> { "bar", "baz" });
    }
}
