# ffmpeg_cut_join

## what ?
a tools to cut portion of video and join them back

## how ?
- edit input.json as required (sample proivided)
  - input: the input file 
  - output: the output file (do not have same names please)
  - intervals: the list of time intervals which have to be joined together
  - speed: the frame rate of output multiplier 
- run ffmpeg.sh

## why?
- i was bored of writing the whole comand for cutting and joining

## requirements ?
- linux/wsl
- ffmpeg
- jq

## thanks to !
stackoverflow
ffmpeg and jq devlopers
myself