FROM debian:11

# Step 1: Install Python3
RUN apt -y update && \
    apt -y upgrade && \
    apt -y install python3-pip && \
    apt -y install build-essential && \
    apt -y install libssl-dev && \
    apt -y install libffi-dev && \
    apt -y install python3-dev

# Step 2: Install pandas, matplotlib, and scikit-learn
RUN pip install pandas && \
    pip install matplotlib && \
    pip install -U scikit-learn

# Step 3: Upgrade pip
RUN pip install --upgrade pip

# Step 4: Install tensorflow
RUN pip install tensorflow

# Step 5: Install Keras
RUN pip install keras

# Install Git, clone G4detector repo, and make required directories in G4detecor folder
RUN apt -y update && \
    apt -y install git && \
    git clone https://github.com/kxk302/G4detector.git && \
    cd ./G4detector && \
    mkdir plots; mkdir predictions; mkdir plots_arrays; mkdir plots_arrays/roc; mkdir plots_arrays/pr && \
    cd -

# Copy the dataset folder
ADD dataset /dataset

# Copy scripts folder
ADD scripts /scripts

# Train G4detector on human dataset
RUN cd ./G4detector && \
    python3 ./code/g4.py -p /dataset/pos_ex_K_125.fa -n /dataset/neg_ex_K_random_125.fa

COPY ./entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]
