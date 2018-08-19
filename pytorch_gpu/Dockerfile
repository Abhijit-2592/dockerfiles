ARG cuda_version=9.0
ARG cudnn_version=7
ARG PYTHON_VERSION=3.6
FROM nvidia/cuda:${cuda_version}-cudnn${cudnn_version}-devel


RUN apt-get update && apt-get install -y --no-install-recommends \
      bzip2 \
      g++ \
      git \
      graphviz \
      libgl1-mesa-glx \
      libhdf5-dev \
      openmpi-bin \
      zip \
      unzip \
      wget && \
    rm -rf /var/lib/apt/lists/*

ENV CONDA_DIR /opt/conda
ENV PATH $CONDA_DIR/bin:$PATH

#install anaconda
RUN wget --quiet --no-check-certificate https://repo.continuum.io/miniconda/Miniconda3-4.2.12-Linux-x86_64.sh && \
    echo "c59b3dd3cad550ac7596e0d599b91e75d88826db132e4146030ef471bb434e9a *Miniconda3-4.2.12-Linux-x86_64.sh" | sha256sum -c - && \
    /bin/bash /Miniconda3-4.2.12-Linux-x86_64.sh -f -b -p $CONDA_DIR && \
    rm Miniconda3-4.2.12-Linux-x86_64.sh && \
    echo export PATH=$CONDA_DIR/bin:'$PATH' > /etc/profile.d/conda.sh

# change username
ENV NB_USER pytorch_user
# change ownership for conda dir
RUN useradd -m -s /bin/bash -N $NB_USER
RUN chown $NB_USER $CONDA_DIR -R
COPY jupyter_notebook_config.py /
RUN chown $NB_USER jupyter_notebook_config.py # thus the user can access the config file

USER $NB_USER

# Install Python packages and pytorch
ARG python_version=3.6
RUN conda install -y python=${python_version}
RUN pip install --upgrade pip
RUN conda install pytorch torchvision -c pytorch
RUN conda install Pillow scikit-learn scikit-image matplotlib mkl nose pyyaml six h5py bokeh scipy numpy
RUN conda install pandas=0.20.2
RUN conda install -c conda-forge jupyterlab=0.32.0

RUN conda clean -yt

EXPOSE 8888 6006

WORKDIR /home/$NB_USER
# CMD jupyter lab "$@" --no-browser --allow-root --port=8888 --ip=0.0.0.0
CMD jupyter lab --config=/jupyter_notebook_config.py --no-browser --port=8888 --ip=0.0.0.0
