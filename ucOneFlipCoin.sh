#!/bin/bash -x

#FLIP COIN COMBINATION: USE CASE 1 -> FLIP A COIN AND DISPLAY HEAD OR TAIL AS WINNER.

getFlipCoinResult () {
	result=$(( RANDOM%2 ));

	if [ $result -eq 1 ]
	then
		echo "HEAD";
	else
		echo "TAIL";
	fi;
}

flipCoinMain () {
	getFlipCoinResult;
}

flipCoinMain;
