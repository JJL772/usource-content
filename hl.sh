#!/bin/bash

# figure out the absolute path to the script being run a bit
# non-obvious, the ${0%/*} pulls the path out of $0, cd's into the
# specified directory, then uses $PWD to figure out where that
# directory lives - and all this in a subshell, so we don't affect
# $PWD

GAMEROOT=$(cd "${0%/*}" && echo $PWD)

# and launch the game
cd "$GAMEROOT"
export LD_LIBRARY_PATH="$(pwd):$LD_LIBRARY_PATH"
if [[ ! -z $GAME_DEBUGGER ]]; then 
	if [[ "$GAME_DEBUGGER" == "gdbgui" || "$GAME_DEBUGGER" == "gdb" ]]; then
		"$GAME_DEBUGGER" --args "./xash3d $@"
	else 
		$GAME_DEBUGGER ./xash3d $@
	fi
else 
	./xash3d $@
fi
