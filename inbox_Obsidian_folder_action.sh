#!/bin/bash

local_path= ~/Dropbox

cd $local_path/inbox

find . -type f ! -name "*.md"| while read fullfile
do
	# remove path
	filename_w_ext=$(basename -- "$fullfile")
	# extraxt file extension and name
	extension="${filename_w_ext##*.}"
	filename="${filename_w_ext%.*}"
	
	# search for folder and tags in filename
	at_foldername="$(grep -o -w  '@[A-Za-z0-9]*' <<<  "$filename")"
	taglist="$(grep -o -w  '#[A-Za-z0-9]*' <<<  "$filename")"
		
	# remove @ from foldername
	foldername="$(sed s/@//g <<< "$at_foldername")"
		
	# remove taglist from filename
	for tag in $taglist; do filename="$(sed s/$tag//g <<< "$filename")"; done
	
	
	# rename input file
	input_filename="${filename}".$extension
	echo $input_filename
	mv "$fullfile"  "$input_filename"
	
	# create .md file

	filename_md="${filename}.md"
	echo  --- >> "$filename_md"
	echo created: $(date '+%Y-%m-%d %H:%M') >> "$filename_md"
	echo  --- >> "$filename_md"
	echo  >> "$filename_md"
	#insert link
	echo [["${input_filename}"]]  >> "$filename_md"
	echo  >> "$filename_md"
	echo  --- >> "$filename_md"
	echo Tags:  >> "$filename_md"
	echo "$taglist" >> "$filename_md"
	# insert exclamation mark so that linked file is inline
	sed 's/\[/!\[/' "$filename_md" > "${filename_md}.tmp"
	mv "${filename_md}.tmp" "${filename_md}"
	
	
	# find directory folder to match foldername
	target_folder="$(find "${local_path}" -iname "$foldername" -type d)"
	
#	echo target_folder $target_folder
	
	if [ ! -z $target_folder ]
	then

	# remove @foldername from filename_md
	filename_md_stripped="$(sed s/"$at_foldername"//g <<< "$filename_md")"
	mv "${filename_md}" "${filename_md_stripped}"

	# move md file to target folder
	mv "${filename_md_stripped}" "$target_folder"

	fi
	
	
	# move input file to ressources
	mv "$input_filename" "$local_path"/_resources


done

exit

