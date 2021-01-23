-module(question).
-export([main/1, question/1, question/2]).

% question implementation in erlang
question(Prompt) ->
	string:trim(io:get_line(Prompt ++ ": ")).

question(Prompt, Valid) ->
	io:format("~s~n(~s): ", [Prompt, string:join(Valid, ", ")]),
	Input = string:trim(io:get_line("")),
	case lists:member(Input, Valid) of
		true  -> Input;
	  false ->
			io:format("\"~s\" is not a valid answer~n", [Input]),
			question(Prompt, Valid)
	end.

main(_) ->
	question("foo", ["bar", "baz"]).