#!/bin/bash

if [ $# -ne 3 ]; then
    echo "Incorrect number of parameters"
    echo "Specify the input fasta file, the model file, and the output directory"
    exit   
fi

FastaFile=$1
ModelFile=$2
OutputDir=$3

echo "FastaFile: <$FastaFile>"
echo "ModelFile: <$ModelFile>"
echo "OutputDir: <$OutputDir>"

FastaFileName=`basename $FastaFile`

# Remove old container with the same name
DOCKER_RM_CMD="docker rm -f g4detector"
echo $DOCKER_RM_CMD
$DOCKER_RM_CMD

DOCKER_CMD="docker run --name g4detector -v $FastaFile:/$FastaFileName kxk302/g4detector:1.0.0 /$FastaFileName $ModelFile"
echo $DOCKER_CMD
$DOCKER_CMD

# Copy output file from container to host
# First, get container ID
CONTAINER_ID=`docker ps -aqf "name=g4detector"`

# Next, copy file from container to host
DOCKER_CP_CMD="docker cp $CONTAINER_ID:/G4detector/G4detector_prediction.csv $OutputDir"
echo $DOCKER_CP_CMD
$DOCKER_CP_CMD
