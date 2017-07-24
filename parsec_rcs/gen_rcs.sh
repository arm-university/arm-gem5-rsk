#!/bin/bash

usage="Usage: bash $(basename "$0") {-h | -p pkgname -i insize -n nthreads}
Generate PARSEC benchmark runscripts for gem5:
    -h  display this help and exit
    -p  set the parsec package to use
    -i  set the input size: {simsmall | simmedium | simlarge}
    -n  set the minimum number of threads to use"

error="ERROR: wrong arguments
Try 'bash gen_rcs.sh -h' for more information."

if [ $# = 1 ] && [ $1 = "-h" ]; then
    echo "$usage"
    exit 0
fi

if [ $# != 6 ]; then
    echo "$error"
    exit 1
fi

while [[ $# -gt 1 ]]
do
key="$1"

case $key in
    -p)
    PKGNAME="$2"
    shift
    ;;
    -i)
    INSIZE="$2"
    shift
    ;;
    -n)
    NTHREADS="$2"
    shift
    ;;
    *)
    echo "$error" # unknown option
    exit 1
    ;;
esac
shift
done

echo  '#!/bin/bash

PARSEC_DIR="/home/root/parsec-3.0"
cd $PARSEC_DIR
pwd

source ./env.sh
parsecmgmt -a run -p '${PKGNAME}' -c gcc-hooks -i '${INSIZE}' -n '${NTHREADS}'
m5 exit' > ${PKGNAME}_${INSIZE}_${NTHREADS}.rcS

echo "Benchmark runscript "${PKGNAME}"_"${INSIZE}"_"${NTHREADS}".rcS generated."
exit 0
