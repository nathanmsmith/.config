function folderize --description "Take a file, make it a folder, and move the contents of the file into an index.md file inside that folder"
  set file_name $argv[1]
  set file_split (string split . $file_name)
  set folder_name $file_split[1]
  set file_extension $file_split[2]
  mkdir $folder_name
  mv $file_name $folder_name/index.$file_extension
end
