ARG CUDA_VER=11.5
ARG LINUX_VER=ubuntu18.04
FROM gpuci/miniforge-cuda:$CUDA_VER-devel-$LINUX_VER

ARG PYTHON_VER=3.9
ARG RAPIDS_VER=22.10
ARG PYTORCH_VER=1.11.0
ARG CUDATOOLKIT_VER=11.6

RUN conda config --set ssl_verify false

RUN conda install -c gpuci gpuci-tools

RUN gpuci_conda_retry install -c conda-forge mamba
RUN gpuci_mamba_retry install -y -c pytorch -c rapidsai-nightly -c rapidsai -c nvidia -c conda-forge \
    cudatoolkit=$CUDATOOLKIT_VER \
    cudf=$RAPIDS_VER \
    cugraph=$RAPIDS_VER \
    dask-cudf=$RAPIDS_VER \
    dask-cuda=$RAPIDS_VER \
    pytorch=$PYTORCH_VER \
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
