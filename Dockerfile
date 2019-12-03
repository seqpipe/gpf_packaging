FROM seqpipe/seqpipe-node-base:latest

RUN mkdir /data
RUN mkdir /code

RUN mkdir /builds
ADD conda-environment.yml /

RUN conda create \
    -c conda-forge -c bioconda -c iossifovlab \
    -n gpf --file /conda-environment.yml

# GPF ENV
ENV PATH /opt/conda/envs/gpf/bin:$PATH

# HADOOP CONFIG
ENV JAVA_HOME /opt/conda/envs/gpf
ENV HADOOP_HOME /opt/conda/envs/gpf
ENV HADOOP_CONF_DIR /opt/conda/envs/gpf/etc/hadoop

# GPF
RUN mkdir -p /code
COPY ./gpf-*.tar.gz /
RUN tar -xzvf /gpf-*.tar.gz -C /code --strip-components=1
RUN cd /code/dae && pip install . \
    && cd /code/wdae && pip install .

# SCRIPTS

COPY jenkins*.sh /


WORKDIR /

SHELL ["/bin/bash", "-c"]
