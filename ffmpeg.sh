#!/bin/bash

# the input json to read from
file="input.json"

# get json and set corresponding values
json=$(jq .  $file) 
input=$(echo $json| jq -r .input)
output=$(echo $json| jq -r .output)
speed=$(echo $json | jq -r .speed)
intervals=($(echo $json | jq -r .intervals[]))
no_of_interval=${#intervals[@]}

# initalise required ffmpeg command parameters
complex_filter=""
concat_filter=""

# loop through interval
for (( i=0; i<$no_of_interval; i++)); do
    interval=$(echo "${intervals[$i]}" | sed "s/\:/\\\:/g;s/\-/\:/g" )
    complex_filter="$complex_filter[0:v]trim='$interval',setpts=PTS-STARTPTS[part$i];"
    concat_filter="$concat_filter[part$i]"
done

# finialise parameters
concat_filter="$concat_filter""concat=n=$no_of_interval[part$no_of_interval]"
complex_filter="$complex_filter$concat_filter;"
complex_filter="$complex_filter[part$no_of_interval]setpts=$speed*PTS[final]"

# echo complex filter
echo "complex filter is $complex_filter"


# run ffmpeg commands
ffmpeg -i $input -filter_complex "$complex_filter" -map [final] -an $output