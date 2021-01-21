-module(question).
-export([main/1, question/1, question/2]).

question(Prompt) ->
    io:format("~s~n: ", [Prompt]),
    Line = io:get_line(""),
    string:strip(string:strip(Line, both, 13), both, 10).
question(Prompt, Valid) ->
    io:format("~s~n(~s): ", [Prompt, lists:join(", ", Valid)]),
    Line = io:get_line(""),
    Inp = string:strip(string:strip(Line, both, 13), both, 10),
    Mem = lists:member(Inp, Valid),
    if Mem -> Inp;
       true -> io:format("\"~s\" is not a valid response!~n", [Inp]),
               question(Prompt, Valid)
    end.

main(_) -> 
    A = question("Foo", ["Bar", "Baz"]),
    io:format("~s~n", [A]),
    B = question("Foo"),
    io:format("~s~n", [B]).
