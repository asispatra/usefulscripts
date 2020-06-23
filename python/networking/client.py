#!/usr/bin/python3           # This is client.py file

import socket
import sys

CMD=sys.argv[1]

# create a socket object
s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

# get local machine name
host = socket.gethostname()

port = 9999

# connection to hostname on the port.
s.connect((host, port))

# Receive no more than 1024 bytes
s.send(CMD.encode('ascii'))
msg = s.recv(1024)

print (msg.decode('ascii'))
s.close()
