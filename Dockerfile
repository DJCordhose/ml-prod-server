# FROM tiangolo/uwsgi-nginx-flask:python3.8
FROM tiangolo/uvicorn-gunicorn-fastapi:python3.8

# FROM continuumio/miniconda3
# can not base on two images, so copied straight from
# https://hub.docker.com/r/continuumio/miniconda3/dockerfile

ENV LANG=C.UTF-8 LC_ALL=C.UTF-8
ENV PATH /opt/conda/bin:$PATH

RUN apt-get update --fix-missing && \
    apt-get install -y wget bzip2 ca-certificates curl git && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN wget --quiet https://repo.anaconda.com/miniconda/Miniconda3-py38_4.8.3-Linux-x86_64.sh -O ~/miniconda.sh && \
    /bin/bash ~/miniconda.sh -b -p /opt/conda && \
    rm ~/miniconda.sh && \
    /opt/conda/bin/conda clean -tipsy && \
    ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh && \
    echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc && \
    echo "conda activate base" >> ~/.bashrc
# end of copy

WORKDIR /app
ADD environment.yml /tmp/environment.yml
RUN conda env create -f /tmp/environment.yml

ARG conda_env=ml-prod-server
RUN echo "source activate ${conda_env}" > ~/.bashrc
ENV PATH /opt/conda/envs/${conda_env}/bin:$PATH

COPY ./app /app

# EXPOSE 8888
# ENTRYPOINT ["python", "server.py"]
