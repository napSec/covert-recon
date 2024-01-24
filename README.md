# Covert-Recon

# Covert.sh - Covert NMAP Port Scan Script

This Bash script provides a covert NMAP port scanning option to allow. Users can enter the target IP address or hostname, choose an output format (text, CSV, or XML), and specify a name for the output file. 

Additionally, users can enable covert mode, including options for Tor routing, output encryption, proxychains and disabling output display for enhanced stealth.

## Usage

1. Make sure you have NMAP installed on your system.

2. Download the script:

```bash
wget https://example.com/path/to/covert.sh
```

3. Provide execute permissions:

```bash
chmod +x covert.sh
```

4. Run the script:

```bash
./covert.sh
```

## Script Walkthrough

### 1. Target Input

The script begins by prompting the user to input the target IP address or hostname for the covert port scan.

```bash
echo "Enter the target IP address or hostname to scan"
read target
```

### 2. Covert Mode Activation

Users have the option to enable covert mode, enhancing the scan with Tor routing, output encryption, and output display disablement.

```bash
echo "Do you want to enable covert mode? (y/n)"
read covert_choice
```

### 3. Output Format Selection

Users can select the desired output format:

- Text file
- CSV file
- XML file

```bash
echo "Select format for output:"
echo "1. Text file"
echo "2. CSV file"
echo "3. XML file"
read -p "Enter the number for your selection: " format
```

### 4. Output File Name Input

Next, users are prompted to enter a name for the output file (without extension).

```bash
echo "Enter the name for the output file (without extension):"
read filename
```

### 5. File Extension Check

The script checks the user's format selection and sets the corresponding file extension.

```bash
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
```

### 6. NMAP Covert Port Scan

In covert mode, the script utilizes Tor routing, output encryption, and conducts a port scan with NMAP, saving the results to the specified file.

```bash
if [ "$covert_choice" = "y" ]; then
  proxychains nmap -T0 -oN "$filename$extension" $target && gpg -c "$filename$extension"
  echo "Covert mode scan complete with encryption!"
else
  nmap -T0 -oN "$filename$extension" $target
  echo "Scan complete!"
fi
```

### 7. Output Display

The script opens a new terminal session to display the contents of the output file.

```bash
xterm -e "cat $filename$extension"
```


- The command to open a new terminal and execute a command (`xterm -e "command"`) may not work on all systems. You may need to use a different command, such as `gnome-terminal -e "command"`, depending on your system and the terminal emulator you are using.

- Ensure you have the necessary permissions to run the script and execute NMAP, ProxyChains (if using Tor), and GPG (if using output encryption).

