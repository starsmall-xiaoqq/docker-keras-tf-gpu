FROM tensorflow/tensorflow:1.10.0-rc1-devel-gpu-py3

#ENV http_proxy http://your-proxy-server:port
#ENV https_proxy http://your-proxy-sever:port

#remove warning of "debconf: delaying package configuration"
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update
RUN apt-get install -y build-essential
RUN apt-get install -y screen nano htop git wget links less

# Install Python 3
#RUN apt-get install -y python python-pip python-dev
RUN apt-get install -y python3-pip python3-dev


# Install ML Dependencies
RUN apt-get install -y pkg-config libpng12-dev libgtk2.0-dev gfortran libatlas-base-dev libatlas-dev libatlas3-base ffmpeg
RUN apt-get -y install graphviz python3-tk libxslt-dev libhdf5-dev libxml2-dev

## Install miscellaneous dependencies (Needed?)
RUN apt-get -y install libfreetype6-dev libboost-program-options-dev zlib1g-dev libboost-python-dev

##install devvelopment tool (if necessary)
RUN apt-get -y install vim
RUN pip3 install -U pip
#RUN pip3 install gym

## copy necessary customization file
COPY requirements.txt requirements.txt
COPY jupyter_notebook_config.py /jupyter/jupyter_notebook_config.py

#RUN pip install -r requirements.txt
RUN pip3 install --timeout=60 -r requirements.txt

VOLUME ["/notebooks", "/jupyter/certs"]

ADD test_scripts /test_scripts
ADD jupyter /jupyter
ENV JUPYTER_CONFIG_DIR="/jupyter"

# Install extensions
RUN jupyter contrib nbextension install --user
RUN jupyter serverextension enable --py jupyterlab --sys-prefix

# TensorBoard
EXPOSE 6006
# IPython
EXPOSE 8888

WORKDIR "/notebooks"

CMD ["/run_jupyter.sh", "--allow-root" ]
