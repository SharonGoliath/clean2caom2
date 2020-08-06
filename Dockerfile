FROM opencadc/astropy:3.8-slim

RUN apt-get update
RUN apt-get install -y \
    build-essential \
    git
    
RUN pip install cadcdata \
    cadctap \
    caom2 \
    caom2repo \
    caom2utils \
    deprecated \
    ftputil \
    importlib-metadata \
    pytz \
    PyYAML \
    spherical-geometry \
    vos

WORKDIR /usr/src/app

ARG OPENCADC_REPO=opencadc
ARG OMC_REPO=opencadc-metadata-curation

RUN git clone https://github.com/${OPENCADC_REPO}/caom2tools.git && \
  pip install ./caom2tools/caom2util

RUN git clone https://github.com/${OMC_REPO}/caom2pipe.git && \
  pip install ./caom2pipe

RUN git clone https://github.com/${OMC_REPO}/ngvs2caom2.git && \
  pip install ./ngvs2caom2
  
RUN git clone https://github.com/${OMC_REPO}/clean2caom2.git && \
  cp ./clean2caom2/scripts/config.yml / && \
  cp ./clean2caom2/scripts/docker-entrypoint.sh / && \
  pip install ./clean2caom2

ENTRYPOINT ["/docker-entrypoint.sh"]
