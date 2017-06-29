#!/bin/sh

# tshark -r botnet-capture-20110810-neris.pcap -T fields -e ip.src -e ip.dst

FILENAME=${1:-"botnet-capture-20110810-neris.csv"}
EXT=${FILENAME##*.}
DATASET=$(echo $FILENAME | cut -f 1 -d '.')

OUTPUT=./output
mkdir -p ${OUTPUT}

sed 's/,/\t/g'    ${DATASET}.${EXT}            > ${OUTPUT}/${DATASET}.tab
sort -k1 -n -t\t  ${OUTPUT}/${DATASET}.tab     > ${OUTPUT}/${DATASET}.sorted
awk '{print $1}'  ${OUTPUT}/${DATASET}.sorted  > ${OUTPUT}/${DATASET}.nodes
awk '{print $2}'  ${OUTPUT}/${DATASET}.sorted  > ${OUTPUT}/${DATASET}.nodes
sed '/^\s*$/d'    ${OUTPUT}/${DATASET}.nodes   > ${OUTPUT}/${DATASET}.clean
cat               ${OUTPUT}/${DATASET}.clean | sort | uniq > ${OUTPUT}/${DATASET}.unique
awk '{printf("%d %s\n", NR, $0)}' ${OUTPUT}/${DATASET}.unique > ${OUTPUT}/${DATASET}.dict

awk '{print $1"\t"$2}' ${OUTPUT}/${DATASET}.tab  > ${OUTPUT}/${DATASET}.proc
sed '/^\s*$/d'    ${OUTPUT}/${DATASET}.proc   > ${OUTPUT}/${DATASET}.mm
awk 'NR==FNR{ a[$2]=$1; next }{ $1=a[$1]; $2=a[$2] }1' ${OUTPUT}/${DATASET}.dict ${OUTPUT}/${DATASET}.mm > ${OUTPUT}/${DATASET}.mtx
NODES=$(wc -l < ${OUTPUT}/${DATASET}.dict)
EDGES=$(wc -l < ${OUTPUT}/${DATASET}.mtx)
# echo ${NODES} ${NODES} ${EDGES}
sed -i '1s/^/'"${NODES} ${NODES} ${EDGES}"'\n/' ${OUTPUT}/${DATASET}.mtx
sed -i '1s/^/%-------------------------------------------------------------------------------\n/' ${OUTPUT}/${DATASET}.mtx
sed -i '1s/^/%%MatrixMarket matrix coordinate pattern \n/' ${OUTPUT}/${DATASET}.mtx
sed -i '1s/^/%-------------------------------------------------------------------------------\n/' ${OUTPUT}/${DATASET}.mtx

echo "CSV to MTX Conversion: \n \
MatrixMarket: ${OUTPUT}/${DATASET}.mtx \n \
Dictionary: ${OUTPUT}/${DATASET}.mtx \n \
Raw: ${OUTPUT}/${DATASET}.mm"

