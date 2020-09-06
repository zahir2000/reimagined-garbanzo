#!/bin/bash

. ./configs.sh
clear

printf "%s\n" "+————————————————————————————————————————————————+"
printf "%s ${BOLD}%s${NC} %s\n" "|" "          Performance Review Search           " "|"
printf "%s\n\n" "+————————————————————————————————————————————————+"

while

. ./ReviewSearch.sh

while  

if [[ $employeeFound -eq 1 ]]; then
    printf "\n${UNDERLINEBOLD}Employee Details:${NC}\n"
	echo -e "Employee Name  : ${LIGHTBLUE}$name${NC}"
	echo -e "Job Title      : ${LIGHTBLUE}$jobTitle${NC}"
	echo -e "Department     : ${LIGHTBLUE}$department${NC}"
    echo; printf "Searching for KPI Results."; sleep 1; printf "."; sleep 1; printf ".\n"

    printf "\n${UNDERLINEBOLDYELLOW}Search Results:${NC}\n"

    resultCounter=0; files=()
    if [[ -d "${icNo}KPIResult" && -r "${icNo}KPIResult" ]]; then
        filesCount=$(( $( ls -l "${icNo}KPIResult/" | wc -l ) - 1 ))
        #ls "${icNo}KPIResult/" | sort -k1.4,1.7 
        for entry in "${icNo}KPIResult"/*
        do
            file=$( echo ${entry} | cut -d "/" -f 2 | cut -d "." -f 1 )
            files+=("$file")
            resultCounter=$(( $resultCounter + 1 ))
            printf "${BOLD}%3s${NC} %-20s\n" "$resultCounter." "$file"
        done
    fi
 
    if [[ resultCounter -ne 0 ]]; then
    
        while
            printf "\nWhich file would you like to see (1 - $resultCounter): "
            read openFile; openFile=$(echo "$openFile" | tr 'A-Z' 'a-z')

            if [[ $openFile == 'q' ]]; then
                ./PerformanceReviewMenu.sh
                exit 0
            fi

            if [[ $openFile -lt 1 || $openFile -gt $resultCounter ]]; then
                printf "\n${LIGHTRED}Incorrect file number selected.${NC}\nPlease ensure it is within (${GREEN}1 - $resultCounter${NC})\n"
            fi

        [[ $openFile -lt 1 || $openFile -gt $resultCounter ]]
        do :
        done

        openFile=$(( $openFile - 1 ))
        resultFile="${icNo}KPIResult/${files[$openFile]}.txt"

        if [[ -f "$resultFile" && -r "$resultFile" ]]; then
            printf "\n${WHITE}================================================================================${WHITEBACKGROUND}\n\n"
            cat "$resultFile"
            echo -e "${WHITE}\n================================================================================${NC}"
        else
            echo -e "${RED}An error has occured. Please contact the administrator!${NC}"
        fi

        anotherFile="x"
        printf "\n${UNDERLINEBOLDYELLOW}Would you like to see another file?${NC}"

        while
            printf "\n\n(${RED}y${NC})es or (${GREEN}n${NC})o: "
            read -n1 anotherFile; anotherFile=$(echo "$anotherFile" | tr 'A-Z' 'a-z')

            if [[ "$anotherFile" == "n" ]]; then
                ./PerformanceReviewMenu.sh
                exit 0
            elif [[ "$anotherFile" == "y" ]]; then
                clear
                printf "%s\n" "+————————————————————————————————————————————————+"
                printf "%s ${BOLD}%s${NC} %s\n" "|" "          Performance Review Search           " "|"
                printf "%s\n" "+————————————————————————————————————————————————+"
            fi

        [[ "$anotherFile" != "y" && "$anotherFile" != "n" ]]
        do :
        done
    else
        echo -e "${ITALIC}No KPI results found.${NC}"

        printf "\n${UNDERLINEBOLDYELLOW}Would you like to search again?${NC}"

        while
            printf "\n\n(${RED}y${NC})es or (${GREEN}n${NC})o: "
            read -n1 searchAgain; searchAgain=$(echo "$searchAgain" | tr 'A-Z' 'a-z')

            if [[ "$searchAgain" == "n" ]]; then
                ./PerformanceReviewMenu.sh
                exit 0
            elif [[ "$searchAgain" == "y" ]]; then
                employeeFound=0
                clear
                printf "%s\n" "+————————————————————————————————————————————————+"
                printf "%s ${BOLD}%s${NC} %s\n" "|" "          Performance Review Search           " "|"
                printf "%s\n\n" "+————————————————————————————————————————————————+"
            fi

        [[ "$searchAgain" != "y" && "$searchAgain" != "n" ]]
        do :
        done
    fi
else
    echo; echo -e "Employee with ${LIGHTBLUE}$icNo${LIGHTRED} does not exist.\n${NC}Enter (${YELLOW}q${NC}) to return to HR Management Menu\n"
fi

[[ $anotherFile == "y" ]]
do : 
done

[[ $employeeFound -eq 0 ]]
do :
done