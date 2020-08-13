function gifify --description 'Make a movie into a gif'
  set --local filename $argv[1]
  set --local rootname (echo "$filename" | sed 's/\.[^.]*$//')
  ffmpeg -i "$filename" -r 10 -filter:v "setpts=0.5*PTS" -f gif - | gifsicle > "$rootname".gif
  open -a Google\ Chrome "$rootname".gif
end
