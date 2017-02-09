## How to find all files containing specific text on Linux?
```
grep -rnw '/path/to/somewhere/' -e "pattern"
```
http://stackoverflow.com/questions/16956810/how-to-find-all-files-containing-specific-text-on-linux#answer-16957078


## How To Create a Sudo User on Ubuntu 


If you are not root user use sudo for the following commands.

A. Use the adduser command to add a new user to your system.
```
# adduser <username>
```
B. Use the usermod command to add the user to the sudo group.
```
# usermod -aG sudo <username>
```
--- OR ---

B. Grant Root Privileges to the User
```
# visudo
```
Find the following code:

\# User privilege specification
```
root ALL=(ALL:ALL) ALL
```
In this case, we’re granting root privileges to the user username. Add the following below that code:
```
username ALL=(ALL:ALL) ALL
```
Then exit and save the file with the key commands Ctrl-x, Y, enter.


## Update a single package in Ubuntu 
```
sudo apt-get --only-upgrade install <packagename>
```
