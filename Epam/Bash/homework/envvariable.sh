#!/bin/bash

export SURNAME='grasu'
echo "SURNAME in env:"
env | grep SURNAME

echo "Using printenv:"
printenv SURNAME

echo "In a subshell:"
bash -c 'echo $SURNAME' -- "$SURNAME"

unset SURNAME
echo "SURNAME has been unset."
