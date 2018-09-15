ARG cuda_version=9.0
ARG cudnn_version=7
FROM nvidia/cuda:${cuda_version}-cudnn${cudnn_version}-devel

# An ARG declared before a FROM is outside of a build stage, so it can’t be used in any instruction after a FROM
# Thus declare args here
ARG username=tf_user
ARG userid=1001
RUN echo "building image with username: ${username}, userid: ${userid}"
# Install system packages
RUN apt-get update && apt-get install -y --no-install-recommends \
      bzip2 \
      g++ \
      git \
      graphviz \
      libgl1-mesa-glx \
      libhdf5-dev \
      openmpi-bin \
      wget && \
    rm -rf /var/lib/apt/lists/*

RUN apt-get update
RUN apt-get install -y software-properties-common
# install recent tesseract
RUN add-apt-repository ppa:alex-p/tesseract-ocr
RUN apt-get update
RUN apt install -y tesseract-ocr libtesseract-dev

# Tensorflow 1.8.0 is not compatible with CUDNN 7.1.04 thus down grade it to 7.0.5
RUN apt-get update && apt-get install -y --allow-downgrades --no-install-recommends \
    libcudnn7=7.0.5.15-1+cuda9.0 \
    libcudnn7-dev=7.0.5.15-1+cuda9.0 && \
    rm -rf /var/lib/apt/lists/*

# Install miniconda
ENV CONDA_DIR /opt/conda
ENV PATH $CONDA_DIR/bin:$PATH

RUN wget --quiet --no-check-certificate https://repo.continuum.io/miniconda/Miniconda3-4.2.12-Linux-x86_64.sh && \
    echo "c59b3dd3cad550ac7596e0d599b91e75d88826db132e4146030ef471bb434e9a *Miniconda3-4.2.12-Linux-x86_64.sh" | sha256sum -c - && \
    /bin/bash /Miniconda3-4.2.12-Linux-x86_64.sh -f -b -p $CONDA_DIR && \
    rm Miniconda3-4.2.12-Linux-x86_64.sh && \
    echo export PATH=$CONDA_DIR/bin:'$PATH' > /etc/profile.d/conda.sh

# create user
RUN useradd -u ${userid} -m -s /bin/bash -N ${username}
RUN chown ${username} $CONDA_DIR -R
COPY jupyter_notebook_config.py /
# for the user to access the config file
RUN chown ${username} jupyter_notebook_config.py
USER ${username}

# Install Python, tensorflow, keras and other pacakges
ARG python_version=3.6
RUN conda install -y python=${python_version}
RUN pip install --upgrade pip
RUN pip install pytesseract
RUN pip install tensorflow-gpu==1.8.0
RUN conda install Pillow scikit-learn scikit-image mkl nose pyyaml six h5py bokeh scipy numpy
RUN conda install pandas=0.20.2
RUN pip install keras==2.1.4
RUN pip install keras-vis==0.4.1
RUN pip install opencv-python==3.4.1.15
RUN conda install -c conda-forge jupyterlab pymongo=3.6.1
RUN conda install -c anaconda protobuf=3.4.0
RUN conda install -c anaconda cmake
RUN pip install matplotlib==2.1.2
RUN conda clean -yt

EXPOSE 8888 6006
RUN mkdir /home/${username}/deep_learning
WORKDIR /home/${username}/deep_learning

CMD jupyter lab --config=/jupyter_notebook_config.py --no-browser --port=8888 --ip=0.0.0.0
