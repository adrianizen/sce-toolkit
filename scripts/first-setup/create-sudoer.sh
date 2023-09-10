#!/bin/bash
# Create new user and add to sudoer group

adduser $1
usermod -aG sudo $1