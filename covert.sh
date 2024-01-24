#!/bin/bash

# Covert NMAP Port Scan Script

# Optional features
covert_mode=false
use_encrypt_output=true
use_output_display=false

# Function to get user input
get_user_input() {
  echo -n "Enter the target IP address or hostname to scan: "
  read target
}

# Function to choose output format and filename
choose_output_format() {
  echo "Select format for output:"
  echo "1. Text file"
  echo "2. CSV file"
  echo "3. XML file"
  read -p "Enter the number for your selection: " format

  echo -n "Enter the name for the output file (without extension): "
  read filename

  # Use file extension check
  if [ $format -eq 1 ]; then
    extension=".txt"
  elif [ $format -eq 2 ]; then
    extension=".csv"
  elif [ $format -eq 3 ]; then
    extension=".xml"
  else
    echo "Invalid selection"
    exit 1
  fi
}

# Function to perform NMAP scan
perform_nmap_scan() {
  # Covert mode
  if [ "$covert_mode" = true ]; then
    if [ "$use_encrypt_output" = true ]; then
      proxychains nmap -T0 -oN "$filename$extension" $target && gpg -c "$filename$extension"
      echo "Covert mode scan complete with encryption!"
    else
      proxychains nmap -T0 -oN "$filename$extension" $target
      echo "Covert mode scan complete!"
    fi
  else
    nmap -T0 -oN "$filename$extension" $target
    echo "Scan complete!"
  fi
}

# Function to display output
display_output() {
  # Covert mode
  if [ "$covert_mode" = true ]; then
    echo "Output display disabled."
  else
    # Display output
    cat "$filename$extension"
  fi
}

# Main execution
echo "Do you want to enable covert mode? (y/n)"
read covert_choice

if [ "$covert_choice" = "y" ]; then
  covert_mode=true
  echo "Covert mode enabled."
fi

get_user_input
choose_output_format
perform_nmap_scan
display_output
