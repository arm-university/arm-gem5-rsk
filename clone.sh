#!/bin/bash

usage="Usage: bash $(basename "$0") [-h]
Clone the gem5 repository into the gem5 directory.
Clone the arm-gem5-rsk repository into the arm-gem5-rsk directory.
    -h    display this help and exit"

error="ERROR: already in the arm-gem5-rsk directory. Move this script to a different location."

gem5_git="https://gem5.googlesource.com/public/gem5"
arm_gem5_rsk_git="https://github.com/arm-university/arm-gem5-rsk.git"
gem5_dest="gem5"
arm_gem5_rsk_dest="arm-gem5-rsk"

git_clone()
{
    local repo=$1
    local dest=$2

    if [ ! -e "$dest" ]; then
        git clone "$repo" "$dest"
    else
        echo "Skipping $dest: Destionation already exists."
    fi
    echo
}

echo "ARM Research Starter Kit: System Modeling using gem5
Find more information at: http://www.arm.com/ResearchEnablement/SystemModeling
..."
sleep 1

if [ ${PWD##*/} = "arm-gem5-rsk" ]; then
    echo "$error"
    exit 1
fi

if [ $# = 1 ] && [ $1 = "-h" ]; then
    echo "$usage"
    exit 0
else
    git_clone "${gem5_git}" "${gem5_dest}"
    git_clone "${arm_gem5_rsk_git}" "${arm_gem5_rsk_dest}"
fi
