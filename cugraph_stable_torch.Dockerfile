ARG CUDA_VER=11.8
ARG LINUX_VER=ubuntu20.04
FROM gpuci/miniforge-cuda:$CUDA_VER-devel-$LINUX_VER

ARG PYTHON_VER=3.10
ARG RAPIDS_VER=23.04
ARG PYTORCH_VER=2.0.0
ARG CUDATOOLKIT_VER=11.8

RUN conda config --set ssl_verify false

RUN conda install -c gpuci gpuci-tools

RUN gpuci_conda_retry install -c conda-forge mamba
RUN gpuci_mamba_retry install -y -c pytorch -c rapidsai -c conda-forge -c nvidia \
    cudf=$RAPIDS_VER \
    cugraph=$RAPIDS_VER \
    dask-cudf=$RAPIDS_VER \
    dask-cuda=$RAPIDS_VER \
    pylibcugraphops=$RAPIDS_VER \
    pytorch=$PYTORCH_VER \
    pytorch-cuda=$CUDATOOLKIT_VER \
    python=$PYTHON_VER \
    setuptools \
    scipy \
    networkx \
    requests \
    cmake \
    make \
    tqdm

# RUN cd / && git clone https://github.com/dmlc/dgl.git
# RUN cd / && cd dgl && git submodule update --init --recursive
# RUN cd /dgl && mkdir build && cd build && cmake -DUSE_CUDA=ON -DUSE_NCCL=ON  -DBUILD_CPP_TEST=ON  .. && make -j64
