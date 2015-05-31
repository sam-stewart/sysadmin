#!/bin/bash

CHK=$1

if who | grep $CHK
  then
    echo $CHK Is logged in!
    exit 1
  else
    echo $CHK Not logged in
    exit 0
fi
