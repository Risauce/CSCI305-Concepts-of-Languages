
% Define the list of bedrooms:
hallway([bedroom(_, 5), bedroom(_, 4), bedroom(_, 3), bedroom(_, 2), bedroom(_, 1)]).

% Define Adjecency to be used within our rules (these are facts):
adjacent(1,2).
adjacent(1,5).
adjacent(2,1).
adjacent(2,3).
adjacent(3,2).
adjacent(3,4).
adjacent(4,3).
adjacent(4,5).
adjacent(5,4).
adjacent(5,1).


% Figure out the actual layout of the students within rooms. Contains all the rules to be run on hallway
layout(X) :- hallway(X), 
		member(bedroom(hunter, A), X), A\=5,
            member(bedroom(laura, Y), X), Y\=1,
		member(bedroom(ramey, N), X), N > Y,
		member(bedroom(addiley, T), X),
		member(bedroom(arnie, Z), X), Z\= 1, Z\= 5, \+ adjacent(Z,Y), \+ adjacent(Z,T).
