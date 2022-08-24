ARG CUDA_VER=11.5
ARG LINUX_VER=ubuntu18.04

FROM gpuci/miniforge-cuda:$CUDA_VER-devel-$LINUX_VER

ARG CUDA_VER=11.3
ARG PYTHON_VER=3.8
ARG RAPIDS_VER=22.10
ARG PYTORCH_VER=1.11.0

RUN conda config --set ssl_verify false

RUN conda install -c gpuci gpuci-tools

RUN gpuci_conda_retry install -c conda-forge mamba

RUN gpuci_mamba_retry create -n cugraph_dgl -y -c rapidsai-nightly -c rapidsai -c pytorch -c nvidia -c conda-forge \
    cudatoolkit=$CUDA_VER \
    cudf=$RAPIDS_VER \
    cugraph=$RAPIDS_VER \
    dask-cudf=$RAPIDS_VER \
    dask-cuda=$RAPIDS_VER \
    pytorch=$PYTORCH_VER \
    cmake \ 
    git \ 
    setuptools \ 
    scipy \ 
    networkx \
    requests \
    tqdm \
    python-devtools \
    make
    

# Clean up pkgs to reduce image size and chmod for all users
# RUN chmod -R ugo+w /opt/conda \
#     && conda clean -tipy \
#     && chmod -R ugo+w /opt/conda

# ENTRYPOINT [ "/usr/bin/tini", "--" ]
# CMD [ "/bin/bash" ]