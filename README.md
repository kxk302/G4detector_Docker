# G4detector

G4detector [1][2] is a convolutional neural network (CNN) based method to predict G4s from DNA sequences.
human genomeG4detector is trained on novel high-throughput benchmarks over multiple species genomes measured by the
G4-seq protocol. CNN model trained on human genome can successfully predicts G4 formation in non-human species.
G4detector is written in Python programming language. The source code is available at https://github.com/OrensteinLab/G4detector.

G4 prediction with G4detector requires training a model on a genome, an then querying the trained model. Training a model
requires installation of a specific version of Keras/Tensorflow, and specific versions of several other Python packages such as
pandas, scikit-learn, etc. Configuring the environment and performing the training takes some time and the configuration step is
different for different operating systems. In this project, we Dockerize G4detector to avoid repeating these configuration/training
steps everytime a user wants to run G4detector. A text file called a Dockerfile is used to specify all the
configuration/training steps. A Docker engine creates a Docker image from the Dockerfile. Docker engine runs containers created
off of the docker image. Container technologies such as Docker also offer other benefits such as portability, performance, agility,
isolation, and scalability [3].

In order to run the Dockerized version of G4detector, you need to have the Docker engine installed on your box. Please refer to
instructions at https://docs.docker.com/engine/install/. You also need the G4detector Docker image. You can either get the G4detector
Docker image from Docker Hub, or you can build the image locally. If you are getting the image from the Docker Hub (preferred),
you can skip the instructions for building/pushing the image, and go to the instructions for running G4detector Docker container.

# Getting the G4detector Docker Image

To pull the G4detector Docker image from your Docker Hub repository:
> docker pull kxk302/g4detector:1.0.0

To view the pulled image:
> docker images -f "reference=kxk302/g4detector:1.0.0"

# Building/Pushing the G4detector Docker Image

All the commands are run in the same directory, say, /Users/kxk302/workspace/

Clone G4detector_Docker repository (This creates a folder called G4detector_Docker):
> git clone https://github.com/kxk302/G4detector_Docker.git

Change your directory to G4detector_Docker folder:
> cd ./G4detector_Docker

To create a Docker image:
> docker build --progress=plain -t kxk302/g4detector:1.0.0 .

To view the created image:
> docker images -f "reference=kxk302/g4detector:1.0.0"

To push the created image to your Docker Hub repository (You need to regsitered at https://hub.docker.com/):
> docker login\
> docker push kxk302/g4detector:1.0.0

# Running the G4detector Docker Container

Suppose you want to run G4detector on a .fasta file located at '/Users/kxk302/workspace/G4detector_Docker/dataset/pos_ex_K_125.fa'
folder. The input file name is 'pos_ex_K_125.fa', the input file folder is '/Users/kxk302/workspace/G4detector_Docker/dataset/',
and absolute path to input file name is '/Users/kxk302/workspace/G4detector_Docker/dataset/pos_ex_K_125.fa'.

Suppose you want G4detector to save the output file at '/Users/kxk302/workspace/G4detector_Docker/output/'. G4detector's output
file name is 'G4detector_prediction.csv', by default.

When building the G4detector Docker image, a CNN model is trained on human genome data -- positive dataset: pos_ex_K_125.f;
negative dataset: neg_ex_K_random_125.fa (random negative set). The model is saved to '/G4detector/models/K_random_125nt_base_model'
file within the container. This path needs to be passed in as an input parameter for predictions using G4detector.

G4detector requires input fasta file, the model file, and the output directory as input parameters.

On Unix/Mac OS, to run the containerized version of G4detector, run the following command:
> ./scripts/run_g4detector.sh FastaFile ModelFile OutputDir

For example:

> ./scripts/run_g4detector.sh /Users/kxk302/workspace/G4detector_Docker/dataset/pos_ex_K_125.fa /G4detector/models/K_random_125nt_base_model /Users/kxk302/workspace/G4detector_Docker/output

On Windows, to run the containerized version of G4detector, run the following command:

> docker run -v InputFileAbsolutePath:/InputFileName kxk302/g4detector:1.0.0 /InputFileName ModelFile

Below is an actual invocation of Dockerzed G4detector:

> docker run -v /Users/kxk302/workspace/G4detector_Docker/dataset/pos_ex_K_125.fa:/pos_ex_K_125.fa kxk302/g4detector:1.0.0 /pos_ex_K_125.fa /G4detector/models/K_random_125nt_base_model

The -v flag simply mounts a folder on your host machine to the container, to make your local files accessible to the container.

# References

1. Barshai M, Aubert A, Orenstein Y. G4detector: Convolutional Neural Network to Predict DNA G-Quadruplexes. IEEE/ACM Trans Comput Biol Bioinform. 2022 Jul-Aug;19(4):1946-1955. doi: 10.1109/TCBB.2021.3073595. Epub 2022 Aug 8. PMID: 33872156.

2. https://github.com/OrensteinLab/G4detector

3. https://www.microfocus.com/documentation/visual-cobol/vc60/EclUNIX/GUID-F5BDACC7-6F0E-4EBB-9F62-E0046D8CCF1B.html
