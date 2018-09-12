# Echo client program
import socket
import sys


HOST = ''    # The remote host
PORT = 50007              # The same port as used by the server

if len(sys.argv)==4:
  HOST=str(sys.argv[1])
  PORT=int(sys.argv[2])
  MSG=str(sys.argv[3])

s = None
for res in socket.getaddrinfo(HOST, PORT, socket.AF_UNSPEC, socket.SOCK_STREAM):
    af, socktype, proto, canonname, sa = res
    try:
        s = socket.socket(af, socktype, proto)
    except socket.error as msg:
        s = None
        continue
    try:
        s.connect(sa)
    except socket.error as msg:
        s.close()
        s = None
        continue
    break
if s is None:
    print 'could not open socket'
    sys.exit(1)
s.sendall(MSG)
s.close()
