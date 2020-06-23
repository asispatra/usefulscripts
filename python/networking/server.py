#!/usr/bin/python3           # This is server.py file
import subprocess
import shlex
import socket

def run_bash_commands(bash_command_list):
  first_time=True
  for bashCommand in bash_command_list:
    if first_time==True:
      first_time=False
      process = subprocess.Popen(shlex.split(bashCommand), stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
    else:
      process = subprocess.Popen(shlex.split(bashCommand), stdin=process.stdout, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
  output, error = process.communicate()
  return output.decode('utf-8').strip() # + '\n' + error.decode('utf-8').strip()

# create a socket object
serversocket = socket.socket(
                socket.AF_INET, socket.SOCK_STREAM)
serversocket.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)

# get local machine name
host = socket.gethostname()

port = 9999

# bind to the port
serversocket.bind((host, port))

# queue up to 5 requests
serversocket.listen(5)

while True:
   # establish a connection
   clientsocket,addr = serversocket.accept()

   print("Got a connection from %s" % str(addr))
   cmd = clientsocket.recv(1024)
   CMD = cmd.decode('ascii')
   print(CMD)
   bashCommands = [ CMD ]
   clientsocket.send(run_bash_commands(bashCommands).encode('ascii'))
   clientsocket.close()
