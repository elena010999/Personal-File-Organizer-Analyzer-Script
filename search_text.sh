#!/bin/bash

read -p "Enter string to search: " search
find / -type f -name "*.txt" -exec grep -H "$search" {} \;

