## List all installed kernel
#### RedHat / CentOS / RHEL / Fedora Linux user
```
rpm -qa kernel
```
#### Debian / Ubuntu Linux user
```
dpkg --list | grep linux-image
```

## How to Connect to Cisco AnyConnect VPN in Ubuntu
http://ubuntuhandbook.org/index.php/2014/11/connect-cisco-anyconnect-vpn-ubuntu/
```
# Install OpenConnect:
sudo apt-get install openconnect

# Connect to VPN, run:
sudo openconnect yourvpn.example.com
```

## CPU enable/disable
```
# Enable
for x in {2..4} ; do  echo 1 > /sys/devices/system/cpu/cpu${x}/online ; done

# Disable
for x in {2..4} ; do  echo 0 > /sys/devices/system/cpu/cpu${x}/online ; done
```

## perf command
Use root or sudo to take cpu profile 
```
# Start profile
perf record -a <command>
perf record -a -p <pid>

# profile result
perf report -i perf.data
```

## Create softlink
```
# Create a softlink python of python3
ln -s python3 python -f
# -f option to force
```

## Send command in background in for loop
```
for d in train/* ; do find $d -name "*.jpg" | xargs -I {} file {} >> train_info.txt & done
# Note: there is no ';' before done
```

## find command
```
find train -name "*.jpg" | xargs -I {} file {} >> train_info.txt
for d in train/* ; do find $d -name "*.jpg" | xargs -I {} file {} >> train_info.txt & done
```

## Calculate average
```
lines=$(data_filter_to_a_single_column) ; avg=0; n=0; for l in $(echo "$lines") ; do avg=$(echo "scale=12; ($avg  * $n + $l)/($n + 1)" | bc) ; n=$(expr $n + 1) ; done; echo $avg
```

## Install JDK 8 on Ubuntu

#### Ubuntu Trusty (14.04 LTS). 
OpenJDK 8 is not available on Trusty. To install Oracle JDK 8:
```
sudo apt-get install software-properties-common
sudo add-apt-repository ppa:webupd8team/java
sudo apt-get update
sudo apt-get install oracle-java8-installer
```
#### Ubuntu Wily (15.10) and above. 
To install OpenJDK 8:
```
sudo apt-get install openjdk-8-jdk
```

## Replace matched pattern of a file
```
sed -i ':a;N;$!ba;s/Hello\/World\/hello.c:11[^\n]*\n//g' logfile    # This remove new line too
sed -i 's,text,'$text',g' file
```

## git commands
```
# git clone a particular branch
git clone -b branch-name https://github.com/abc/xyz.git

git clone https://github.com/abc/xyz.git
cd xyz
git checkout branch-name/b46130b922d47ff20ac40ebbdef01f7771e1d0bc

# code change
git add inception/inception/inception_train.py
git commit

# Apply patch
git apply file.patch

# cherry-pick
git remote add ibmsoe https://github.com/abc/xyz 
git fetch pqr 
git cherry-pick b46130b922d47ff20ac40ebbdef01f7771e1d0bc
```

## Extract a pattern from a text
```
matched_text=$(echo $single_line_text | sed 's/.*xyz=\([^ ][^ ]*\).*/\1/')

# Note: Need to change the pattern accordingly
```

## Timestamp
```
ext=$(date +%d%b%Y_%H%M%S)
```

## A command success or not
```
if echo $line | grep "xyz" > /dev/null ; then
	echo "xyz present"
elif echo $line | grep "XYZ" > /dev/null ; then
	echo "XYZ present"
else
	echo "not present"
fi
```

## Array or dictonary in bash
```
declare -A arr
arr[$key]=$val
val=${arr[$key]}
```

## tar commands
```
tar -cvf filename.tar directory         # Create a .tar file
tar -cvzf filename.tar.gz directory     # Create a .tar.gz file
tar -cvjSf filename.tar.bz2 directory    # Create a .tar.bz2 file
tar -xvf filename.tar                   # Untar a .tar file
tar -xvzf filename.tar.gz               # Uncompress a .tar.gz file 
tar -xvjf filename.tar.bz2              # Uncompress a .tar.bz2 file

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


## Recursive find/replace of a string
```
find <DIR> -type f -print0 | xargs -0 sed -i 's/TEXT1/TEXT2/g'
```
