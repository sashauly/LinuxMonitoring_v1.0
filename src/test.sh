#!/bin/bash
cd $(dirname $0)

chmod +x 01/main.sh
chmod +x 02/main.sh
chmod +x 03/main.sh
chmod +x 04/main.sh
chmod +x 05/main.sh

function try_again {
  read -p "Another test? (y/n) " choice
  case $choice in
  y | Y) ./test.sh ;;
  *) exit ;;
  esac
}

read -p "Which script will we test (1-5)? " script_number
case $script_number in
1)
  echo "---TEST 01 script---"
  read -p "Enter 1 parameter: " param_1
  01/main.sh $param_1
  echo
  try_again
  ;;
2)
  echo "---TEST 02 script---"
  02/main.sh
  echo
  try_again
  ;;
3)
  echo "---TEST 03 script---"
  read -p "Enter 4 parameters separated by a space: " ONE TWO THREE FOUR
  03/main.sh $ONE $TWO $THREE $FOUR
  echo
  try_again
  ;;
4)
  echo "---TEST 04 script---"
  read -p "Do you want to change configuration file? (y/n) " choice
  case $choice in
  y | Y) nano ./04/color.conf ;;
  *) : ;;
  esac
  04/main.sh
  echo
  try_again
  ;;
5)
  echo "---TEST 05 script---"
  read -p "Enter the path to be checked: " dir_path
  05/main.sh $dir_path
  echo
  try_again
  ;;
*)
  echo "Enter a number from 1 to 5!"
  echo
  try_again
  ;;
esac
