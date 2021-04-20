function to_pdf --description "Take a file and convert it to a PDF"
  for file in $argv
    echo $file
    set file_split (string split . $file)
    set file_extension $file_split[2]
    set file_name $file_split[1]
    /usr/local/bin/pandoc $file -f $file_extension -t pdf -o "$file_name.pdf" --pdf-engine=xelatex
  end
end
