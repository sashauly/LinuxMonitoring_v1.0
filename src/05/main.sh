# #!/bin/bash
if [[ -z $1 ]]; then
  exit 1
fi

if [[ ! -d $1 ]]; then
  exit 1
fi

dir_path="$1"
if [[ ${dir_path: -1} != '/' ]]; then
  dir_path="$dir_path/"
fi

start_time=$(date +%s)

#Total folders
total_folders=$(find "$dir_path" -type d | wc | awk '{print $1}')
echo "Total number of folders (including all nested ones) = $total_folders"

#TOP 5 max size
top_folders=($(du -h --max-depth=1 "$dir_path" | sort -rh | awk '{print $2}'))
top_folders_size=($(du -h --max-depth=1 "$dir_path" | sort -rh | awk '{print $1}'))
echo "TOP 5 folders of maximum size arranged in descending order (path and size): "
for i in {1..5}; do
  echo "$((i)) - ${top_folders[$i]}, ${top_folders_size[$i]}"
done

# Total number of files
total_files=$(find "$dir_path" -type f | wc | awk '{print $1}')
echo "Total number of files = $total_files"

# Number of different types of files
conf_files=$(find "$dir_path" -type f -name "*.conf" | wc | awk '{print $1}')
text_files=$(find "$dir_path" -type f -name "*.txt" | wc | awk '{print $1}')
exe_files=$(find "$dir_path" -type f -executable | wc | awk '{print $1}')
log_files=$(find "$dir_path" -type f -name "*.log" | wc | awk '{print $1}')
archive_files=$(find "$dir_path" -type f -name "*.zip" -o -name "*.tar" -o -name "*.gz" | wc | awk '{print $1}')
sym_links=$(find "$dir_path" -type l | wc | awk '{print $1}')
echo "Number of:"
echo "Configuration files (with the .conf extension) = $conf_files"
echo "Text files = $text_files"
echo "Executable files = $exe_files"
echo "Log files (with the extension .log) = $log_files"
echo "Archive files = $archive_files"
echo "Symbolic links = $sym_links"
# Total number of folders (including all nested ones) = 6
# TOP 5 folders of maximum size arranged in descending order (path and size):
# 1 - /var/log/one/, 100 GB
# 2 - /var/log/two/, 100 MB
# etc up to 5
# Total number of files = 30
# Number of:
# Configuration files (with the .conf extension) = 1
# Text files = 10
# Executable files = 5
# Log files (with the extension .log) = 2
# Archive files = 3
# Symbolic links = 4
# TOP 10 files of maximum size arranged in descending order (path, size and type):
# 1 - /var/log/one/one.exe, 10 GB, exe
# 2 - /var/log/two/two.log, 10 MB, log
# etc up to 10
# TOP 10 executable files of the maximum size arranged in descending order (path, size and MD5 hash of file)
# 1 - /var/log/one/one.exe, 10 GB, 3abb17b66815bc7946cefe727737d295
# 2 - /var/log/two/two.exe, 9 MB, 53c8fdfcbb60cf8e1a1ee90601cc8fe2
# etc up to 10
# Script execution time (in seconds) = 1.5
