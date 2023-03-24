# #!/bin/bash

dir_path="$1"

if [[ -z $1 ]]; then
  echo "String is empty"
  exit 1
fi

if [[ ! -d $1 ]]; then
  echo "$dir_path is not a directory!"
  exit 1
fi

start_time=$(date +%s)

total_folders=$(find "$dir_path" -type d | wc | awk '{print $1}')
echo "Total number of folders (including all nested ones) = $total_folders"

top_folders=($(du -h --max-depth=1 "$dir_path" | sort -rh | awk '{print $2}' | head -5))
top_folders_size=($(du -h --max-depth=1 "$dir_path" | sort -rh | awk '{print $1}' | head -5))
echo "TOP 5 folders of maximum size arranged in descending order (path and size): "
for i in {1..5}; do
  echo "$((i)) - ${top_folders[$i]}, ${top_folders_size[$i]}"
done

total_files=$(find "$dir_path" -type f | wc | awk '{print $1}')
echo "Total number of files = $total_files"

conf_files=$(find "$dir_path" -type f -name "*.conf" | wc | awk '{print $1}')
text_files=$(find "$dir_path" -type f -name "*.txt" | wc | awk '{print $1}')
exe_files=$(find "$dir_path" -type f -executable | wc | awk '{print $1}')
log_files=$(find "$dir_path" -type f -name "*.log" | wc | awk '{print $1}')
archive_files=$(find "$dir_path" -type f -name '*.zip' -o \
  -name '*.tar' -o \
  -name '*.tar.gz' -o \
  -name '*.tar.bz2' -o \
  -name '*.tar.xz' -o \
  -name '*.tgz' -o \
  -name '*.7z' | wc | awk '{print $1}')
sym_links=$(find "$dir_path" -type l | wc | awk '{print $1}')
echo "Number of:"
echo "Configuration files (with the .conf extension) = $conf_files"
echo "Text files = $text_files"
echo "Executable files = $exe_files"
echo "Log files (with the extension .log) = $log_files"
echo "Archive files = $archive_files"
echo "Symbolic links = $sym_links"

echo "TOP 10 files of maximum size arranged in descending order (path, size and type): "
top_files=$(find "$dir_path" -type f -exec ls -sh {} \; | sort -hr | head -10)
i=0
while read -r line; do
  i=$((i + 1))
  size=$(echo "$line" | awk '{print $1}')
  path=$(echo "$line" | awk '{print $2}')
  type=$(echo "$line" | awk -F . '{print $NF}')
  echo "$i - $path, $size, $type"
done <<<"$top_files"

echo "TOP 10 executable files of the maximum size arranged in descending order (path, size and MD5 hash of file):"
exec_files=$(find "$dir_path" -type f -executable -exec ls -sh {} \; | sort -hr | head -10)
i=0
while read -r line; do
  i=$((i + 1))
  size=$(echo "$line" | awk '{print $1}')
  path=$(echo "$line" | awk '{print $2}')
  hash=$(echo $(md5sum "$path" | awk '{print $1}'))
  echo "$i - $path, $size, $hash"
done <<<"$exec_files"

end_time=$(date +%s.%N)
elapsed_time=$(echo "$end_time - $start_time" | bc -l)
echo "Script execution time (in seconds) = $elapsed_time"
