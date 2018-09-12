# Echo server program
import socket
import sys
import os

HOST = None               # Symbolic name meaning all available interfaces
PORT = 50007              # Arbitrary non-privileged port
if len(sys.argv)==2:
  PORT=int(sys.argv[1])

s = None
for res in socket.getaddrinfo(HOST, PORT, socket.AF_UNSPEC,
                              socket.SOCK_STREAM, 0, socket.AI_PASSIVE):
    af, socktype, proto, canonname, sa = res
    try:
        s = socket.socket(af, socktype, proto)
    except socket.error as msg:
        s = None
        continue
    try:
        s.bind(sa)
        s.listen(5)
    except socket.error as msg:
        s.close()
        s = None
        continue
    break
if s is None:
    print 'could not open socket'
    sys.exit(1)
while 1:
  conn, addr = s.accept()
  print 'Connected by', addr
  if not os.fork():
    s.close()
    data = conn.recv(1024)
    print data
    conn.close()
    sys.exit(0)
