#!/bin/bash

vote=$(tr -dc 0-9 </dev/urandom | head -c 10 ;)

./voting.sh -v $vote -q $vote -n 10000
