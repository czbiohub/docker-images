FROM ibmcom/powerai:1.5.4-all-ubuntu18.04-py3

# Optional args
ARG cuda=0
ARG python_version=3.6
ARG pyro_branch=release
ARG pytorch_branch=release
ARG uid=1000
ARG gid=1000
ARG ostype=Linux

# Configurable settings
ENV USER_NAME pwrai
ENV CONDA_DIR /home/pwrai/anaconda3
ENV WORK_DIR /home/${USER_NAME}/workspace
ENV PATH ${CONDA_DIR}/bin:${PATH}

# Install linux utils
RUN sudo apt-get update && sudo apt-get install -y --no-install-recommends \
         build-essential \
         cmake \
         git \
         curl \
         ca-certificates && \
    sudo rm -rf /var/lib/apt/lists/*

ENV CMAKE_PREFIX_PATH="$(dirname $(which conda))/../"

# Move to home directory; and copy the install script
WORKDIR ${WORK_DIR}
COPY install.sh ${WORK_DIR}/install.sh

# Install python 2/3, PyTorch and Pyro
RUN echo 1 | sudo /opt/DL/license/bin/accept-powerai-license.sh
RUN sudo chown ${USER_NAME} ${WORK_DIR}
RUN sudo chgrp ${USER_NAME} ${WORK_DIR}
RUN cd ${WORK_DIR} && conda update -n base conda -c defaults && bash install.sh

# Run Jupyter notebook
# (Ref: http://jupyter-notebook.readthedocs.io/en/latest/public_server.html#docker-cmd)
EXPOSE 8888
CMD ["jupyter", "notebook", "--port=8888", "--no-browser", "--ip=0.0.0.0"]
