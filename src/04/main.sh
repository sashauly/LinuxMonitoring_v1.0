#!/bin/bash

source ./color.conf

default_column1_background=0
default_column1_font_color=6
default_column2_background=2
default_column2_font_color=4

column1_background=${column1_background:=${default_column1_background}}
column1_font_color=${column1_font_color:=${default_column1_font_color}}
column2_background=${column2_background:=${default_column2_background}}
column2_font_color=${column2_font_color:=${default_column2_font_color}}

# function pick_color() {
#   case "$1" in
#   1) echo -e "\033["$2"7m" ;; # white
#   2) echo -e "\033["$2"1m" ;; # red
#   3) echo -e "\033["$2"2m" ;; # green
#   4) echo -e "\033["$2"4m" ;; # blue
#   5) echo -e "\033["$2"5m" ;; # purple
#   6) echo -e "\033["$2"0m" ;; # black
#   esac
# }
echo column1_background
echo column1_font_color
echo column2_background
echo column2_font_color
# column1_background=$(pick_color $1 4)
# column1_font_color=$(pick_color $2 3)
# column2_background=$(pick_color $3 4)
# column2_font_color=$(pick_color $4 3)

# declare -a keys=(
#   "HOSTNAME"
#   "TIMEZONE"
#   "USER"
#   "OS"
#   "DATE"
#   "UPTIME"
#   "UPTIME_SEC"
#   "IP"
#   "MASK"
#   "GATEWAY"
#   "RAM_TOTAL"
#   "RAM_USED"
#   "RAM_FREE"
#   "SPACE_ROOT"
#   "SPACE_ROOT_USED"
#   "SPACE_ROOT_FREE")

# declare -a data=(
#   "$(hostname)"
#   "$(timedatectl | grep "Time zone" | awk '{print $3, $4, $5}')"
#   "$(whoami)"
#   "$(hostnamectl | grep "Operating System" | cut -b 19-)" #$(cat /etc/issue)
#   "$(date -R | cut -d " " -f 2-5)"
#   "$(uptime -p)"
#   "$(awk '{print $1,"sec"}' /proc/uptime)"
#   "$(hostname -I)"
#   "$(ifconfig | grep -v "127.0.0.1" | grep -i "netmask" | awk '{print $4}')"
#   "$(ip r | grep "default" | awk '{print $3}')"
#   "$(free | awk '/Mem:/{printf "%.3f Gb", $2/(1024*1024)}')"
#   "$(free | awk '/Mem:/{printf "%.3f Gb", $3/(1024*1024)}')"
#   "$(free | awk '/Mem:/{printf "%.3f Gb", $4/(1024*1024)}')"
#   "$(df /root | awk '/\/$/ {printf "%.2f MB", $2/1024}')"
#   "$(df /root | awk '/\/$/ {printf "%.2f MB", $3/1024}')"
#   "$(df /root | awk '/\/$/ {printf "%.2f MB", $4/1024}')")

# function print_data {
#   for i in "${!keys[@]}"; do
#     echo -e "$column1_background$column1_font_color${keys[$i]}\033[0m" = "$column2_background$column2_font_color${data[$i]}\033[0m"
#   done
# }

# for i in "$@"; do
#   if [[ "$i" > 6 || "$i" < 1 ]]; then
#     echo "Incorrect arguments(color number is in range 1-6)"
#     exit
#   fi
# done

# if [ $# != 4 ]; then
#   echo "Too few arguments"
# else
#   if [[ $1 -eq $2 || $3 -eq $4 ]]; then
#     echo "Color of text and background should not match"
#   else

print_data

#   fi
# fi
