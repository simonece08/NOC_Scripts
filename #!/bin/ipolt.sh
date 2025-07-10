#!/bin/bash

# Read a single line of input (hostnames separated by spaces or tabs)
echo "Enter hostnames (one per line). Press Enter on an empty line to finish:"

hosts=()

while true; do
  read -r line
  [[ -z "$line" ]] && break  # stop when Enter is pressed on a blank line
  hosts+=("$line")
done


echo -e '\n'
 echo 'for host in '"${hosts[*]}"'; do'
  echo 'echo "$host"'
  echo 'traceroute $host | grep -i bng'
  echo 'echo "-------------------------"'
echo 'done'

echo -e "\n"
echo "------------------------------------"
for host in "${hosts[@]}"; do
echo "show port description | match expression \"$host\" ignore-case"
done

