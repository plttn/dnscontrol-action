#!/bin/bash

# source: https://git.io/J86QD
grep -v -e '^\.\.\.0 corrections$' |\
  grep -v -e '^0 corrections' |\
  grep -v -e '\.\.\. (skipping)' |\
  grep -v -e '^----- DNS Provider: ' |\
  grep -v -e '^----- Registrar: ' |\
  grep -v -e -i '^Concurrently ' |\
  grep -v -e -i '^Serially ' |\
  grep -v -e '^Waiting for concurrent ' |\
  grep -v -e '^----- Getting nameservers from:' | \
  sed -r "s/\x1B\[([0-9]{1,3}(;[0-9]{1,2};?)?)?[mGK]//g" # remove ANSI color codes
  ## https://stackoverflow.com/questions/17998978/removing-colors-from-output