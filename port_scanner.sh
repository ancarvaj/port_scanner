#!/bin/bash

function sigint()
{
  echo -e "\nExiting $0, exit code 1\n"
  exit 1
}

trap sigint INT

if [ ! $1 ]; then
  echo -e "Usage:\t$0 <ip>"
  exit 1
else
  ip=`grep -oP "\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}" <<< $1`
  if [ $ip ]; then
    for i in `seq 1 65535`;do
      ((echo '' > /dev/tcp/$1/$i) 2> /dev/null && echo "PORT $i OPEN"); done
    exit 0
  else
    echo -e "\nPlease use a correct IP address\n"
    exit 255
  fi
fi
