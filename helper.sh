#!/bin/sh

ORANGE="\e[38;5;208m"
RESET="\e[0m"

# Function for orange output
info() {
    echo "${ORANGE}$*${RESET}"
}