#!/usr/bin/python

import socket
import sys
from subprocess import check_output

DEFAULT_PORT = 8888
SHELL_CMD = 'ps aux | grep "\./bin/" | awk \'{print $11 " " $12 " " $13}\''
HTTP_HEADER = "HTTP/1.1 200 OK\nContent-Type: text/html\n"

if (len(sys.argv) > 2 or (len(sys.argv) == 2 and not sys.argv[1].isdigit())):
  print('Usage: oms_processes <port>')
  exit()

p = DEFAULT_PORT
if len(sys.argv) > 1:
  p = int(sys.argv[1])
while True:
  s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
  try:
    s.bind(('', p))
    s.listen(5)
    (connection, address) = s.accept()
    oms_processes = check_output(SHELL_CMD, shell=True)
    http_response = '{}\n{}'.format(HTTP_HEADER, oms_processes)
    connection.sendall(http_response)
    print('%d: connection from %s' % (address[1], address[0]))
  finally:
    connection.shutdown(socket.SHUT_RDWR)
    connection.close()
