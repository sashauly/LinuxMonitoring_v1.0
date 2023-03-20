#!/bin/bash
func() {
  echo "HOSTNAME = $(hostname)"
  echo "TIMEZONE =" "$(timedatectl | grep "Time zone" | awk '{print $3, $4, $5}')"
  echo "USER = $(whoami)"
  echo "OS = $(hostnamectl | grep "Operating System" | cut -b 19-)" #$(cat /etc/issue)
  echo "DATE = $(date | cut -d " " -f 2-5)"
  echo "UPTIME = $(uptime -p)"
  echo "UPTIME_SEC = $(awk '{print $1,"sec"}' /proc/uptime)"
  echo "IP = $(hostname -I)"
  echo "MASK = $(ifconfig | grep -v "127.0.0.1" | grep -i "netmask" | awk '{print $4}')"
  echo "GATEWAY = $(ip r | grep "default" | awk '{print $3}')"
  echo "RAM_TOTAL = $(free | awk '/Mem:/{printf "%.3f Gb", $2/(1024*1024)}')"
  echo "RAM_USED = $(free | awk '/Mem:/{printf "%.3f Gb", $3/(1024*1024)}')"
  echo "RAM_FREE = $(free | awk '/Mem:/{printf "%.3f Gb", $4/(1024*1024)}')"
  echo "SPACE_ROOT = $(df /root | awk '/\/$/ {printf "%.2f MB", $2/1024}')"
  echo "SPACE_ROOT_USED = $(df /root | awk '/\/$/ {printf "%.2f MB", $3/1024}')"
  echo "SPACE_ROOT_FREE = $(df /root | awk '/\/$/ {printf "%.2f MB", $4/1024}')"
}

func

read -p "Write data into a file? (y/n) " choice
if [[ $choice == "y" ]] || [[ $choice == "Y" ]]; then
  func >./$(date +"%d_%m_%y_%H_%M_%S").status
fi
