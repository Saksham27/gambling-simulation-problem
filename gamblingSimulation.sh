#!/bin/bash -x

# constants
START_STAKE_FOR_DAY=100
BET=1
GAMBLE_WON=1 # so GAMBLE_LOST will be 0

# variables
stake=0
# function for gamble game
# param1 : curret availible stakes
function GambleGame() {
	temp=$((RANDOM%2))
	if [ $temp -eq $GAMBLE_WON ]
	then
		currentStake=$(( $currentStake+$BET ))
	else
		currentStake=$(( $currentStake-$BET ))
	fi
}

currentStake=$START_STAKE_FOR_DAY
GambleGame $currentStake
