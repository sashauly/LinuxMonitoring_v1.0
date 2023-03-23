#!/bin/bash

source ./color.conf
source ./default_color.conf

column1_background=${column1_background:=${default_column1_background}}
column1_font_color=${column1_font_color:=${default_column1_font_color}}
column2_background=${column2_background:=${default_column2_background}}
column2_font_color=${column2_font_color:=${default_column2_font_color}}

color_list=(
  $column1_background
  $column1_font_color
  $column2_background
  $column2_font_color
)

function default_colors() {
  echo "Setting the default colors..."
  FLAG_DEFAULT=1
  column1_background=${default_column1_background}
  column1_font_color=${default_column1_font_color}
  column2_background=${default_column2_background}
  column2_font_color=${default_column2_font_color}
}

if [[ $# -gt 0 ]]; then
  echo "Too few arguments"
  default_colors
fi
if [[ ${column1_background} -eq ${column1_font_color} || ${column2_background} -eq ${column2_font_color} ]]; then
  echo "Color of text and background should not match"
  default_colors
fi

for i in "${!color_list[@]}"; do
  if [[ ${color_list[$i]} == *[[:digit:]]* ]]; then
    if [[ ${color_list[$i]} -gt 6 || ${color_list[$i]} -lt 1 ]]; then
      echo "Incorrect arguments(color number must be in range 1-6)"
      default_colors
    fi
  else
    echo "All arguments must be a digit number"
    default_colors
  fi
done

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

column1_bg=$(pick_color ${column1_background} 4)
column1_font=$(pick_color ${column1_font_color} 3)
column2_bg=$(pick_color ${column2_background} 4)
column2_font=$(pick_color ${column2_font_color} 3)

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

function print_data {
  for i in "${!keys[@]}"; do
    echo -e "$column1_bg$column1_font${keys[$i]}\033[0m" = "$column2_bg$column2_font${data[$i]}\033[0m"
  done
}

function print_colors {
  if [[ $FLAG_DEFAULT -eq 0 ]]; then

    echo -e "Column 1 background = ${column1_background} (${NAME_COLOR[column1_background]})"
    echo -e "Column 1 font color = ${column1_font_color} (${NAME_COLOR[column1_font_color]})"
    echo -e "Column 2 background = ${column2_background} (${NAME_COLOR[column2_background]})"
    echo -e "Column 2 font color = ${column2_font_color} (${NAME_COLOR[column2_font_color]})"
  else
    echo "Column 1 background = default (${NAME_COLOR[$default_column1_background]})"
    echo "Column 1 font color = default (${NAME_COLOR[$default_column1_font_color]})"
    echo "Column 2 background = default (${NAME_COLOR[$default_column2_background]})"
    echo "Column 2 font color = default (${NAME_COLOR[$default_column2_font_color]})"
  fi
}

print_data
echo
print_colors
