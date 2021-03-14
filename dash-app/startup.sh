#!/bin/bash

if [ -f ./env.bash ]; then
   . ./env.bash
fi

python3 ./index.py
