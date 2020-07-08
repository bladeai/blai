FROM jupyter/minimal-notebook:latest
# Get the latest image tag at:
# https://hub.docker.com/r/jupyter/minimal-notebook/tags/
# Inspect the Dockerfile at:
# https://github.com/jupyter/docker-stacks/tree/master/minimal-notebook/Dockerfile
USER root
# install additional package...

RUN apt-get update && apt-get install -yq --no-install-recommends \
    curl \
    && mkdir /tmp/s2i/ && cd /tmp/s2i/  \
    && curl -s https://api.github.com/repos/openshift/source-to-image/releases/latest \
	  | grep browser_download_url \
	  | grep linux-amd64 \
	  | cut -d '"' -f 4 \
	  | wget -qi -  \
	&& tar xvf source-to-image*.gz \
	&& mv s2i /usr/local/bin \
	&& rm -rf /tmp/s2i/ 
	
USER $NB_UID