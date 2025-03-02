FROM nvidia/cuda:11.4.3-cudnn8-runtime-ubuntu20.04
#FROM nvidia/cuda:11.2.2-cudnn8-devel-ubuntu18.04
ARG DEBIAN_FRONTEND=noninteractive
RUN apt update && \
    apt install --no-install-recommends -y build-essential software-properties-common && \
    add-apt-repository -y ppa:deadsnakes/ppa && \
    apt install --no-install-recommends -y python3 python3-pip python3-setuptools python3-distutils && \
    apt clean && rm -rf /var/lib/apt/lists/*

COPY req.txt /req.txt
COPY ./src /src
RUN python3 -m pip install --upgrade pip && \
    python3 -m pip install --no-cache-dir -r /req.txt
CMD ["jupyter", "notebook", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root"]
