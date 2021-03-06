#!/bin/bash

WORSE="0"
BEST="16777216"
MED="0"
COUNTER="0"
SUM="0"

trap "echo -e '\rPi\033[?25h\033[3B'; exit" INT

if [[ $# -gt 1 ]]
then
	echo -e "\033[?25l\c"
	while [[ ${COUNTER} -lt $2 ]]
	do
		ARG=`ruby -e "puts (1..$1).to_a.shuffle.join(' ')"`
		TMP=`./push_swap $ARG | wc -l | sed 's/ //g'`
		(( COUNTER += 1 ))
		PERCENT=$((COUNTER * 100 / $2))
		(( SUM += ${TMP} ))
		(( MED = ${SUM} / ${COUNTER} ))
		if [[ ${TMP} -gt ${WORSE} ]]
		then
			WORSE=${TMP}
		fi
		if [[ ${TMP} -lt ${BEST} ]]
		then
			BEST=${TMP}
		fi
		echo -e "Pire = \033[31;1m${WORSE}\033[0m instructions"
		echo -e "Moyenne = \033[33;1m${MED}\033[0m instructions  "
		echo -e "Meilleur = \033[36;1m${BEST}\033[0m instructions  "
		echo -e "\033[32;1m${PERCENT}\033[0m % effectuÃ©\r\033[3A\c"
	done
	echo -e "\033[?25h\033[3B"
else
	echo "./complexity [stack_size] [test number]"
fi
