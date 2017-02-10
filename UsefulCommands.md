## tar commands
```
tar -cvf filename.tar directory         # Create a .tar file
tar -cvzf filename.tar.gz directory     # Create a .tar.gz file
tar -cvfj filename.tar.bz2 directory    # Create a .tar.bz2 file
tar -xvf filename.tar                   # Untar a .tar file
tar -xvzf filename.tar.gz               # Uncompress a .tar.gz file 
tar -xvfj filename.tar.bz2              # Uncompress a .tar.bz2 file

# Note: Use -C option to extract files to a specific directory
```

## Redirect output(stdout and stderr) to a file
```
$ command >> filename 2>&1
```


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


## Extract Debian Packages 
```
sudo dpkg -x package.deb /tmp/out
```


## Execute script in a remote system
```
sshpass -p $PASS ssh -o StrictHostKeyChecking=no $USER@$HOST "mkdir -p ~/tmp_$dir"
sshpass -p $PASS scp -r $dir/* $USER@$HOST:~/tmp_$dir
sshpass -p $PASS ssh -f $USER@$HOST "cd ~/tmp_$dir ; screen -dm -S label_$(date +%d%b%Y_%H%M%S) ./startBatch.sh"
# sshpass -p $PASS ssh -f $USER@$HOST "cd ~/tmp_$dir ; nohup ./startBatch.sh &"
```
