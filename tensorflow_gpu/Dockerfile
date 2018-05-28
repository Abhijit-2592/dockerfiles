ARG cuda_version=9.0
ARG cudnn_version=7
FROM nvidia/cuda:${cuda_version}-cudnn${cudnn_version}-devel

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

    # Install conda
ENV CONDA_DIR /opt/conda
ENV PATH $CONDA_DIR/bin:$PATH

RUN wget --quiet --no-check-certificate https://repo.continuum.io/miniconda/Miniconda3-4.2.12-Linux-x86_64.sh && \
    echo "c59b3dd3cad550ac7596e0d599b91e75d88826db132e4146030ef471bb434e9a *Miniconda3-4.2.12-Linux-x86_64.sh" | sha256sum -c - && \
    /bin/bash /Miniconda3-4.2.12-Linux-x86_64.sh -f -b -p $CONDA_DIR && \
    rm Miniconda3-4.2.12-Linux-x86_64.sh && \
    echo export PATH=$CONDA_DIR/bin:'$PATH' > /etc/profile.d/conda.sh

# change username
ENV NB_USER abhijit

RUN useradd -m -s /bin/bash -N $NB_USER
RUN chown $NB_USER $CONDA_DIR -R
COPY jupyter_notebook_config.py /
RUN chown $NB_USER jupyter_notebook_config.py # thus the user can accerss the config file
RUN mkdir /abhijit_home
RUN chown $NB_USER -R /abhijit_home

USER $NB_USER


# Install Python packages and keras
ARG python_version=3.6

RUN conda install -y python=${python_version}
RUN pip install --upgrade pip
RUN pip install tensorflow-gpu==1.7.1
RUN conda install Pillow scikit-learn scikit-image matplotlib mkl nose pyyaml six h5py bokeh scipy numpy
RUN conda install pandas=0.20.2
RUN pip install keras==2.1.4
RUN pip install keras-vis==0.4.1
RUN pip install opencv-python==3.4.1.15

RUN conda install -c conda-forge jupyterlab \
                                 pymongo=3.6.1

RUN conda install -c anaconda protobuf=3.4.0

RUN conda clean -yt

#ENV PYTHONPATH='/src/:$PYTHONPATH'

# RUN mkdir /start_jupyter
# COPY run_jupyter.sh /start_jupyter
#COPY jupyter_notebook_config.py /root/.jupyter/
EXPOSE 8888 6006 27017

WORKDIR /abhijit_home
# CMD jupyter lab "$@" --no-browser --allow-root --port=8888 --ip=0.0.0.0
CMD jupyter lab --config=/jupyter_notebook_config.py --no-browser --port=8888 --ip=0.0.0.0
