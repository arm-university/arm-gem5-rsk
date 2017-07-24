#!/bin/bash

usage="Usage: bash $(basename "$0") {-h | in [out]}
Read specific parameters from the gem5 stats.txt statistics 
and generate the output result based on the parameters 
specified in the input .ini file:
    -h    display this help and exit
    in    positional argument: input .ini configuration file
    [out] optional positional argument: output result file"

error="ERROR: wrong arguments
Try 'bash read_results.sh -h' for more information."

if [[ $# < 1 ]]; then
    echo "$error"
    exit 1
fi

if [ $1 = "-h" ]; then
    echo "$usage"
    exit 0
fi

inFile="$1"
outFile="$2"

bms=$(awk '{if ($1 ~ /^\[Benchmarks\]/) fs=1; else if ($1 ~ /^\[/) fs=0; else if ($1 !~ /^$/ && fs==1) print $1}' $inFile)
ps=$(awk '{if ($1 ~ /^\[Parameters\]/) fs=1; else if ($1 ~ /^\[/) fs=0; else if ($1 !~ /^$/ && fs==1) print $1}' $inFile)
of=$(awk '{if ($1 ~ /^\[Output\]/) fs=1; else if ($1 ~ /^\[/) fs=0; else if ($1 !~ /^$/ && fs==1 && fi==0) {print $1;fi=1}}' $inFile)

if [ -z "$outFile" ]; then 
    if [ -z "$of" ]; then
        outFile="default_results.txt" 
    else
        outFile="$(dirname "$inFile")/$of"
    fi
fi

if [ -f $outFile ];then
    mv $outFile $outFile".bak"
fi

echo -n "Benchmarks" > $outFile
for p in $ps
do
    echo -ne "\t$p" >> $outFile
done
echo "" >> $outFile

for bm in $bms
do
    file_found=$(find . -type f -name "stats.txt" | grep $bm | head -1)
    if [ -z "$file_found" ]; then continue; fi
    echo -n "$bm" >> $outFile
    for p in $ps
    do
        val=$(grep $p $file_found | awk '{print $2}')
        if [ -z "$val" ]; then 
            echo -ne "\tNAN" >> $outFile 
        else
            echo -ne "\t$val" >> $outFile
        fi
    done
    echo "" >> $outFile
done
echo $outFile generated.
exit 0
