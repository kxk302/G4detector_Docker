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

FastaFileName=`basename $FastaFile`

DOCKER_CMD="docker run -v $FastaFile:/$FastaFileName kxk302/g4detector:1.0.0 /$FastaFileName $ModelFile"
echo $DOCKER_CMD
$DOCKER_CMD
