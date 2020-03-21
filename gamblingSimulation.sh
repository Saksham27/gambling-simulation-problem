#!/bin/bash -x

# constants
START_STAKE_FOR_DAY=100
BET=1
GAMBLE_WON=1 # so GAMBLE_LOST will be 0
STOP_AT_MIN_STAKE=50
STOP_AT_MAX_STAKE=150

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

while [ $currentStake -gt $STOP_AT_MIN_STAKE ] && [ $currentStake -lt $STOP_AT_MAX_STAKE ]
do
	GambleGame $currentStake
done
