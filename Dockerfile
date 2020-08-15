FROM tiangolo/uwsgi-nginx-flask:python3.8
FROM continuumio/miniconda3

WORKDIR /app
ADD environment.yml /tmp/environment.yml
RUN conda env create -f /tmp/environment.yml

ARG conda_env=ml-prod-server
RUN echo "source activate ${conda_env}" > ~/.bashrc
ENV PATH /opt/conda/envs/${conda_env}/bin:$PATH

COPY ./app /app

EXPOSE 8888
ENTRYPOINT ["python", "server.py"]
