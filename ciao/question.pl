:- module(_, [main/1]).

% question/3: ask a question and unify the user's input with `Res`
question(Res, Prompt, Valid) :-
	write(Prompt), nl,
	write('('), write_list(Valid), write('): '),
	read(Input),
	% if item is in list, unify. otherwise, repeat
	( in(Input, Valid) -> Res = Input ; write('Invalid answer!'), nl, question(Res, Prompt, Valid) ).

% question/2: the same but with no valid list
question(Res, Prompt) :-
	write(Prompt), nl,
	write(': '),
	read(Input),
	Res = Input.
%
% utils
%

% print a list	
write_list([]).
write_list([A|B]) :- format('~w ', A), write_list(B).

% check if an item is in a list
in(Item, [Item|_]).
in(Item, [_|Tail]) :- in(Item, Tail).

main(_) :-
	% Tests
	question(Res, 'Foo', [bar, baz]),
	write(Res), nl,
	question(NewRes, 'Foo!'),
	write(NewRes), nl.
