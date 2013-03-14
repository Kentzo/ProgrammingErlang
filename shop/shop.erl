-module (shop).
-export ([total/1, cost/1, sum/1, map/2, filter/2]).

total(L)    ->
    sum(map(fun({What, N}) -> cost(What) * N end, L)).

cost(oranges)   -> 5;
cost(newspaper) -> 8;
cost(apples)    -> 2;
cost(pears)     -> 9;
cost(milk)      ->7.

sum([H|T])  -> H + sum(T);
sum([])     -> 0.   

map(_, [])      -> [];
map(F, [H|T])   -> [F(H)|map(F, T)].

filter(P, [H|T]) ->
    case P(H) of
        true ->
            [H|filter(P, T)];
        false ->
            filter(P, T) 
    end;
filter(P, []) ->
    [].
