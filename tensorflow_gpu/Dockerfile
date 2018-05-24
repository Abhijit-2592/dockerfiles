#building docker image for tensorflow gpu from scratch
FROM ubuntu:16.04
LABEL maintainer="abhijit balaji"
LABEL email="balaabhijit5@gmail.com"
LABEL version="v1"

# update and configure
RUN apt-get update && apt-get install -y --no-install-recommends \
      bzip2 \
      unzip \
      python-pydot \
      python-pydot-ng \
      g++ \
      git \
      graphviz \
      libgl1-mesa-glx \
      libhdf5-dev \
      openmpi-bin \
      wget && \
    rm -rf /var/lib/apt/lists/*

# Install miniconda
ENV CONDA_DIR /opt/conda
ENV PATH $CONDA_DIR/bin:$PATH

RUN wget --quiet --no-check-certificate https://repo.continuum.io/miniconda/Miniconda3-4.2.12-Linux-x86_64.sh && \
    echo "c59b3dd3cad550ac7596e0d599b91e75d88826db132e4146030ef471bb434e9a *Miniconda3-4.2.12-Linux-x86_64.sh" | sha256sum -c - && \
    /bin/bash /Miniconda3-4.2.12-Linux-x86_64.sh -f -b -p $CONDA_DIR && \
    rm Miniconda3-4.2.12-Linux-x86_64.sh && \

# install python
RUN conda install -y python=3.6

# upgrade pip
RUN pip install --upgrade pip

# install other important libraries
RUN conda install -y Pillow  \
                     scikit-learn \
                     scikit-image \
                     notebook \
                     matplotlib \
                     mkl \
                     nose \
                     pyyaml \
                     six \
                     h5py \
                     bokeh \
                     scipy \
                     numpy \
                     pygpu \
                     six \
                     pandas=0.20.2

RUN conda install -c -y anaconda pymongo=3.4.0
RUN conda install -c -y conda-forge opencv=3.4.1 \
                                    jupyterlab \
                                    protobuf=3.4.0

# Install Tensorflow-gpu : followed from official guide.
# Install CUDA and CUDNN using conda
RUN conda install -c anaconda cudatoolkit=9.0 \
                              cudnn=7.0.5
# hold the cudnn version at 7.0.5 because tensorflow recommends version 7.0
RUN apt-mark hold libcudnn7 libcudnn7-dev
# to unhold use RUN apt-mark unhold libcudnn7 libcudnn7-dev

# install nvidia driver, the below number 387 is GPU specific, works for GTX-1060 and other GTX-10Series
RUN apt install nvidia-387
# The libcupti-dev library for advanced profiling
RUN apt install cuda-command-line-tools
RUN export LD_LIBRARY_PATH=${LD_LIBRARY_PATH:+${LD_LIBRARY_PATH}:}/usr/local/cuda/extras/CUPTI/lib64
# actual installation of tensorflow-GPU
conda install -y -c anaconda tensorflow-gpu=1.7.0
# install keras
conda install -y -c conda-forge keras=2.1.5

#install keras vis
RUN pip install keras-vis==0.4.1
# clean up
RUN  conda clean -yt

ENV PYTHONPATH='/src/:$PYTHONPATH'
ADD run_jupyter.sh /root/run_jupyter.sh
ADD jupyter_notebook_config.py /root/.jupyter/jupyter_notebook_config.py

# expose 8888 for jupyter-lab, 6006 for tensorboard, 27017 for mongodb
EXPOSE 8888 6006 27017

CMD /root/run_jupyter.sh
