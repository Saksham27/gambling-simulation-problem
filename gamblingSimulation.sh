#!/bin/bash -x

# constants
START_STAKE_FOR_DAY=100
BET=1
GAMBLE_WON=1 # so GAMBLE_LOST will be 0
STOP_AT_MIN_STAKE=50
STOP_AT_MAX_STAKE=150
DAYS_TO_PLAY_IN_MONTH=20

# variables
stake=0
day=1
totalWon=0
totalLost=0

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


while [ $day -le $DAYS_TO_PLAY_IN_MONTH ]
do
	currentStake=$START_STAKE_FOR_DAY
	while [ $currentStake -gt $STOP_AT_MIN_STAKE ] && [ $currentStake -lt $STOP_AT_MAX_STAKE ] # stopping for day
	do
		GambleGame $currentStake
	done

	if [ $currentStake -eq $STOP_AT_MIN_STAKE ]
	then
		totalLost=$(( $totalLost+$START_STAKE_FOR_DAY-$currentStake ))
	else
		totalWon=$(( $totalWon+$currentStake--$START_STAKE_FOR_DAY ))
	fi
	(( day++ ))
done

