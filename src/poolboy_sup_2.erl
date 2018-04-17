%% Poolboy - A hunky Erlang worker pool factory

-module(poolboy_sup_2).
-behaviour(supervisor).

-export([start_link/2, init/1]).

start_link(Mod, Args) ->
    supervisor:start_link(?MODULE, {Mod, Args}).

init({Mod, Args_b}) ->
    Args = Args_b ++ [{parent_pid,self()}],
    {ok, {{one_for_one, 0, 1},
          [{Mod, {Mod, start_link, [Args]},
            temporary, 5000, worker, [Mod]}]}}.
