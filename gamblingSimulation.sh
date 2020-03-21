#!/bin/bash -x

# constants
START_STAKE_FOR_DAY=100
BET=1
GAMBLE_WON=1 # so GAMBLE_LOST will be 0
STOP_AT_MIN_STAKE=50
STOP_AT_MAX_STAKE=150
DAYS_TO_PLAY_IN_MONTH=20
BET_LIMIT=50
COUNT_RESET=0

# variables 

stake=$COUNT_RESET
day=$(( $COUNT_RESET+1 ))
totalWon=$COUNT_RESET
totalLost=$COUNT_RESET
daysWon=$COUNT_RESET
daysLost=$COUNT_RESET
stakesBetted=$COUNT_RESET
stakesWon=$COUNT_RESET
stakesLost=$COUNT_RESET
luckiestDay=$START_STAKE_FOR_DAY
unluckiestDay=$START_STAKE_FOR_DAY

# function for gamble game
# param1 : curret availible stakes
function gambleGame() {
	temp=$((RANDOM%2))
	if [ $temp -eq $GAMBLE_WON ]
	then
		currentStake=$(( $1+$BET ))
		(( stakesWon++ ))
	else
		currentStake=$(( $1-$BET ))
		(( stakesLost++ ))
	fi
}


while [ $day -le $DAYS_TO_PLAY_IN_MONTH ] 
do
	currentStake=$START_STAKE_FOR_DAY
	stakesWon=$COUNT_RESET
	stakesLost=$COUNT_RESET
	while [ $stakesWon -lt $BET_LIMIT ] && [ $stakesLost -lt $BET_LIMIT ] # stopping for day
	do
		gambleGame $currentStake # one gamble
	done

	if [ $currentStake -lt $unluckiestDay ]
	then
		unluckiestDay=$currentStake
	fi

	if [ $currentStake -gt $luckiestDay ]
	then
		luckiestDay=$currentStake
	fi

	if [ $stakesLost -eq $BET_LIMIT ]
	then
		totalLost=$(( $totalLost+$START_STAKE_FOR_DAY-$currentStake )) # setting total lost
		(( daysLost++ )) # increasing total days lost
	else
		totalWon=$(( $totalWon+$currentStake-$START_STAKE_FOR_DAY )) # setting total won
		(( daysWon++ )) # increasing total days won
	fi
	(( day++ ))
done

