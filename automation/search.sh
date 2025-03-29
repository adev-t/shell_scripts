#!/bin/bash

#copy your text that you want to search...
xdotool key ctrl+c
sleep 0.1
# Wait until the clipboard is populated
for i in {1..10}; do
    query=$(xclip -o 2>/dev/null)
    if [[ -n "$query" ]]; then
        break
    fi
    sleep 0.1
done


# Check if the clipboard is empty
if [[ -z "$query" ]]; then
    notify-send "Search Script" "Clipboard is empty. Try again."
    exit 1
fi


#check if the copied text is a link or string...
if [[ $query == *"http"* && *"://"* ]]; then
    xdg-open "$query"

else
    xdg-open "https://www.google.com/search?q=${query// /+}"
fi


#clear the clipboard
sleep 5
echo -n "" | xclip -selection clipboard
