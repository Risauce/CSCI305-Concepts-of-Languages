superheros([likes(_, batman), likes(_, superman), likes(_, spidey)]).

who_likes(X) :- superheros(X), 
		member(likes(bryan, spidey), X), 
                member(likes(tony, Y), X), Y\=superman, 
		member(likes(sean, Z), X).   
