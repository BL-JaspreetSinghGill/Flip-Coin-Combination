#!/bin/bash -x

#FLIP COIN COMBINATION: USE CASE 4 -> FLIP A COIN MULTIPLE TIMES AND STORE THE RESULT(TRIPLET COMBINATION) IN DICTIONARY
#AND DETERMINE THE PERCENTAGE OF TRIPLET COMBINATION.

LIMIT=25;

counter=0;

declare -A singletDictionary;
declare -A doubletDictionary;
declare -A tripletDictionary;

getFlipCoinResult () {
	result=$(( RANDOM%2 ));

	if [ $result -eq 1 ]
	then
		echo "H";
	else
		echo "T";
	fi;
}

storeInDictionary () {
	local -n dictionary=$1;
	key=$2;

	dictionary[$key]=$((${dictionary[$key]}+1));
}

displayDictionaryResult () {
	local -n dictionary=$1;
	dictionaryName=$2; #dictionaryName can be singlet, doublet or triplet

	echo $dictionaryName "DICTIONARY KEYS: " ${!dictionary[@]};
	echo $dictionaryName "DICTIONARY ELEMENTS: " ${dictionary[@]};
}

getPercentage () {
	local -n dictionary=$1;

	for key in ${!dictionary[@]}
	do
		percentage=$(( ${dictionary[$key]}*100/$LIMIT ));
		echo "KEY: "$key "ELEMENT:" ${dictionary[$key]} "PERCENTAGE: " $percentage;
	done;
}

getFlipCoinCombination () {
	endRange=$1;
	local value="";

	for (( i=0; i<$endRange; i++ ))
	do
		value="$value""$(getFlipCoinResult)";
	done;

	echo $value;
}

flipCoinMultipleTimes () {
	local -n coinDictionary=$1;
	local combination=$2;
	counter=0;

	while [ $counter -lt $LIMIT ]
	do
		value=$(getFlipCoinCombination $combination);
		storeInDictionary coinDictionary $value;
		(( counter++ ));
	done;
}

#THIS METHOD TAKES 3 PARAMETERS
#1: DICTIONARY NAME WHICH CAN BE SINGLET, DOUBLET OR TRIPLET DICTIONARY.
#2: COMBINATION WHICH CAN BE 1 FOR SINGLET, 2 FOR DOUBLET AND 3 FOR TRIPLET.
#3: MESSAGE WHICH CAN BE SINGLET, DOUBLET OR TRIPLET.
getResult () {
	local -n flipCoinDictionary=$1;
	local combination=$2;
	local message=$3;

	flipCoinMultipleTimes flipCoinDictionary $combination;
	displayDictionaryResult flipCoinDictionary $message;
	getPercentage flipCoinDictionary;
}

flipCoinMain () {
	getResult singletDictionary 1 "SINGLET";
	getResult doubletDictionary 2 "DOUBLET";
	getResult tripletDictionary 3 "TRIPLET";
}

flipCoinMain;
