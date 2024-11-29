#!/bin/bash

# Composed with help of Claude 3.5 Sonnet AI. see artifact:
# 20241129_Format-text-eml-files-for-dragging-to-outlook

cd /Volumes/Data/People/DuW/PhD-RecLetters-shared/Subfiles/Additional-Letters/

for place in CBO FedBoard JCT; do

    cd $place
    dstn=../../../../PhD-RecLetters-private/$place
    mkdir -p "$dstn"

    for addresseemd in *.md; do
	if [[ "$addresseemd" != *"recommendation-email"* ]]; then
	    ls -lash "$addresseemd"

	    addressee="$(basename $addresseemd .${addresseemd##*.})"
	    firstname="${addressee%%.*}"
	    Firstname="$(tr '[:lower:]' '[:upper:]' <<< ${firstname:0:1})${firstname:1}"  
	    #	echo "$Firstname"
	    #	echo "$addressee"
	    eml="$dstn/$addressee.eml"
	    cat recommendation-email-$place.md | grep -vs '%' > "$eml"
	    rpl --fixed-strings '[firstname]'         "$Firstname" "$eml"
	    rpl --fixed-strings 'recipient@place.dom' "$addressee" "$eml"
	    
	    ls -lash "$addresseemd"
	    if [ -s "$addresseemd" ]; then # substitute contents of md file into drafto
		echo "$addressee is not empty, inserting content from $addresseemd"
		cat "$addresseemd"

		sed -i '' -e "/$Firstname/r $addresseemd" "$eml"
	    fi
	    if [[ "$place" == "CBO" ]]; then
		rpl --fixed-strings 'Cc:' 'Cc: mark.doms@cbo.gov, phillip.swagel@cbo.gov' "$eml" 
	    fi
	    echo '' >>  "$eml" 
	    echo 'Excerpt from my letter for Will:' >>  "$eml" 
	    echo '' >>  "$eml" 
	    cat ../../../../PhD-RecLetters-private/Letter_excerpt-for-email.txt >> "$eml"
	fi
    done
    cd ..
done

