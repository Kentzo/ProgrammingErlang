-module (homework8).

-export ([start/2, bench_ring/2, ring_node/3]).

start(AnAtom, Fun) ->
	Pid = spawn(Fun),
	register(AnAtom, Pid),
	Pid.

bench_ring(N, M) when N > 1 ->
	Pid = add_ring_node(1, N, M, self()),
	statistics(runtime),
	statistics(wall_clock),
	Pid ! {self(), hello},
	ring_node(0, M, Pid),
	{_, Time1} = statistics(runtime),
	{_, Time2} = statistics(wall_clock),
	io:format("Results=~p (~p) microseconds~n", [Time1 * 1000/ N, Time2 * 1000 / N]).

add_ring_node(N, N, M, Pid) ->
	Pid;
add_ring_node(I, N, M, Pid) ->
	Next = spawn(homework8, ring_node, [0, M, Pid]),
	add_ring_node(I+1, N, M, Next).

ring_node(M, M, Next) ->
	void;
ring_node(I, M, Next) ->
	receive
		{From, Message} ->
			% io:format("~p -> ~p: ~p~n", [self(), From, Message]),	
			Next ! {self(), Message},
			ring_node(I+1, M, Next)
	after 10 ->
		void
	end.
