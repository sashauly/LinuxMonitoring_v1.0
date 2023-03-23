#!/bin/bash

source ./color.conf
source ./default_color.conf

color_list[0]=$column1_background
color_list[1]=$column1_font_color
color_list[2]=$column2_background
color_list[3]=$column2_font_color

default_color_list[0]=$default_column1_background
default_color_list[1]=$default_column1_font_color
default_color_list[2]=$default_column2_background
default_color_list[3]=$default_column2_font_color

function default_colors() {
  echo "Setting default colors..."
  column1_background=${default_column1_background}
  column1_font_color=${default_column1_font_color}
  column2_background=${default_column2_background}
  column2_font_color=${default_column2_font_color}
}

for ((i = 0; i < 4; i++)); do
  if [[ ${color_list[$i]} =~ ^[1-6$]+$ ]]; then
    :
  else
    color_list[$i]=${default_color_list[$i]}
  fi
done

if [[ $# -gt 0 ]]; then
  echo "Too few arguments"
  default_colors
fi
if [[ ${column1_background} -eq ${column1_font_color} ]]; then
  color_list[0]=${default_color_list[0]}
  color_list[1]=${default_color_list[1]}
fi
if [[ ${column2_background} -eq ${column2_font_color} ]]; then
  color_list[2]=${default_color_list[2]}
  color_list[3]=${default_color_list[3]}
fi

# for i in "${!color_list[@]}"; do
#   if [[ ${color_list[$i]} == *[[:digit:]]* ]]; then
#     if [[ ${color_list[$i]} -gt 6 || ${color_list[$i]} -lt 1 ]]; then
#       echo "Incorrect arguments(color number must be in range 1-6)"
#       color_list[$i]=${default_color_list[$i]}
#     fi
#   else
#     echo "All arguments must be a digit number"
#     color_list[$i]=${default_color_list[$i]}
#   fi

# done

NAME_COLOR=(
  default
  white
  red
  green
  blue
  purple
  black
)

function pick_color() {
  case "$1" in
  1) echo -e "\033["$2"7m" ;; # white
  2) echo -e "\033["$2"1m" ;; # red
  3) echo -e "\033["$2"2m" ;; # green
  4) echo -e "\033["$2"4m" ;; # blue
  5) echo -e "\033["$2"5m" ;; # purple
  6) echo -e "\033["$2"0m" ;; # black
  esac
}

column1_background=$(pick_color ${column1_background} 4)
column1_font_color=$(pick_color ${column1_font_color} 3)
column2_background=$(pick_color ${column2_background} 4)
column2_font_color=$(pick_color ${column2_font_color} 3)

declare -a keys=(
  "HOSTNAME"
  "TIMEZONE"
  "USER"
  "OS"
  "DATE"
  "UPTIME"
  "UPTIME_SEC"
  "IP"
  "MASK"
  "GATEWAY"
  "RAM_TOTAL"
  "RAM_USED"
  "RAM_FREE"
  "SPACE_ROOT"
  "SPACE_ROOT_USED"
  "SPACE_ROOT_FREE")

declare -a data=(
  "$(hostname)"
  "$(timedatectl | grep "Time zone" | awk '{print $3, $4, $5}')"
  "$(whoami)"
  "$(hostnamectl | grep "Operating System" | cut -b 19-)" #$(cat /etc/issue)
  "$(date -R | cut -d " " -f 2-5)"
  "$(uptime -p)"
  "$(awk '{print $1,"sec"}' /proc/uptime)"
  "$(hostname -I)"
  "$(ifconfig | grep -v "127.0.0.1" | grep -i "netmask" | awk '{print $4}')"
  "$(ip r | grep "default" | awk '{print $3}')"
  "$(free | awk '/Mem:/{printf "%.3f Gb", $2/(1024*1024)}')"
  "$(free | awk '/Mem:/{printf "%.3f Gb", $3/(1024*1024)}')"
  "$(free | awk '/Mem:/{printf "%.3f Gb", $4/(1024*1024)}')"
  "$(df /root | awk '/\/$/ {printf "%.2f MB", $2/1024}')"
  "$(df /root | awk '/\/$/ {printf "%.2f MB", $3/1024}')"
  "$(df /root | awk '/\/$/ {printf "%.2f MB", $4/1024}')")

# function print_data {
for i in "${!keys[@]}"; do
  echo -e "$column1_background$column1_font_color${keys[$i]}\033[0m" = "$column2_background$column2_font_color${data[$i]}\033[0m"
done
# }
echo
# function print_colors {
for ((i = 0; i < 2; i++)); do
  echo -en "Column $((i + 1))" "background = "
  if [ ${color_list[($i * 2)]} -eq ${default_color_list[($i * 2)]} ]; then
    echo "default" "(${NAME_COLOR[${color_list[($i * 2)]}]})"
  else
    echo "${color_list[($i * 2)]}" "(${NAME_COLOR[${color_list[($i * 2)]}]})"
  fi
  echo -en "Column $((i + 1))" "font color = "
  if [ ${color_list[($i * 2) + 1]} -eq ${default_color_list[($i * 2) + 1]} ]; then
    echo "default" "(${NAME_COLOR[${color_list[($i * 2) + 1]}]})"
  else
    echo "${color_list[($i * 2) + 1]}" "(${NAME_COLOR[${color_list[($i * 2) + 1]}]})"
  fi
done
# }
