#!/bin/bash -x

#FLIP COIN COMBINATION: USE CASE 2 -> FLIP A COIN MULTIPLE TIMES AND STORE THE RESULT IN DICTIONARY
#AND DETERMINE THE PERCENTAGE OF SINGLET COMBINATION.

LIMIT=25;

counter=0;

declare -A singletDictionary;

getFlipCoinResult () {
	result=$(( RANDOM%2 ));

	if [ $result -eq 1 ]
	then
		echo "HEAD";
		storeSingletInDictionary "H";
	else
		echo "TAIL";
		storeSingletInDictionary "T";
	fi;
}

storeSingletInDictionary () {
	key=$1;

	singletDictionary[$key]=$((${singletDictionary[$key]}+1));
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

flipCoinMain () {
	while [ $counter -lt $LIMIT ]
	do
		getFlipCoinResult;
		(( counter++ ));
	done;

	displayDictionaryResult singletDictionary "SINGLET";
	getPercentage singletDictionary;
}

flipCoinMain;
