#!/bin/bash

YELLOW='\033[0;33m'
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color
BOLD='\033[1m'

printf "\n${BOLD}### C2 Node Check ###${NC}\n\n"


ENDPOINTS_LIST=/opt/scripts/endpoints
readarray -t ENDPOINTS <$ENDPOINTS_LIST

for ENDPOINT in "${ENDPOINTS[@]}"
do
	IFS=':'; VALUES=($ENDPOINT); unset IFS;
	#VALUES=(${ENDPOINT//:/ })
	OPEN=$(nmap -Pn ${VALUES[1]} -p ${VALUES[2]} | grep open)
	
	if [ -z "$OPEN" ]
	then
		printf "${YELLOW}${VALUES[0]}${NC} at ${VALUES[1]} port ${VALUES[2]} is ${RED}CLOSED${NC}\n"
	else
		printf "${YELLOW}${VALUES[0]}${NC} at ${VALUES[1]} port ${VALUES[2]} is ${GREEN}OPEN${NC}\n"
	fi
done

printf "\n"
