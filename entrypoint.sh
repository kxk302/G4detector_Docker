#!/bin/bash

if [ $# -ne 2 ]; then 
    echo "Incorrect number of parameters"
    echo "Specify the input fasta file, and the model file"
    exit
fi

FastaFile=$1
ModelFile=$2

echo "FastaFile: <$FastaFile>"
echo "ModelFile: <$ModelFile>"

cd /G4detector
python3 ./code/g4_inference.py -d $FastaFile -m $ModelFile 
