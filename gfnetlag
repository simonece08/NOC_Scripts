#!/bin/bash

echo "Paste the output (end with Ctrl+D):"

lags=()
bng_name=""

while IFS= read -r line; do
  # Capture BNG name (the prompt line)
  if [[ $line =~ \*A:([a-zA-Z0-9.-]+)# ]]; then
    bng_name="${BASH_REMATCH[1]}"
  fi

  # Capture LAG numbers
  if [[ $line =~ \[A=LAG-([0-9]+)\] ]]; then
    lag="lag-${BASH_REMATCH[1]}"
    lags+=("$lag")
  fi
done

# Remove duplicate LAGs
unique_lags=($(printf "%s\n" "${lags[@]}" | sort -u))

# Output
echo ""
echo "$bng_name"

for lag in "${unique_lags[@]}"; do
  echo "show service id 1 host-connectivity-verify statistics | match $lag post-lines 2"
done
