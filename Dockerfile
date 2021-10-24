FROM nvcr.io/nvidia/l4t-base:r32.6.1

# ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Europe/Zurich
ARG DEBIAN_FRONTEND=noninteractiv

RUN apt-get update && apt-get install -y locales && rm -rf /var/lib/apt/lists/* \
    && localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8
ENV LANG en_US.utf8

RUN apt-get update && apt-get install -y --no-install-recommends \
      apt-transport-https \
      build-essential \
      ca-certificates \
      dirmngr \
      gnupg \
      r-base \
      r-base-dev \
      r-cran-devtools \
      libcurl4-gnutls-dev \
      software-properties-common \
      libssl-dev \
      libssh2-1-dev \
      libxml2-dev \
      zlib1g-dev

RUN apt install -y --no-install-recommends \
      libcurl4-openssl-dev  && \
    apt-get upgrade -y

#  RUN R -e "install.packages(c('usethis'))"
#  RUN R -e "install.packages(c('devtools'), dependencies = TRUE)"
#  RUN R -e "install.packages(c('testthat'))"

RUN R -e "install.packages(c('usethis','testthat', 'roxygen2', 'Rcpp'), dependencies = TRUE)"
RUN R -e "install.packages(c('pkgbuild','cpp11'), dependencies = TRUE)"
RUN R -e "install.packages(c('RcppParallel'), dependencies=TRUE)"
RUN R -e "install.packages(c('assertthat'), dependencies=TRUE)" 
RUN R -e "install.packages(c('tidyr'), dependencies=TRUE)" 
RUN R -e "install.packages(c('reshape2'), dependencies=TRUE)" 
# RUN R -e "install.packages(c('rTRNG'), dependencies=TRUE)" 
RUN R -e "install.packages(c('RcppArmadillo'), dependencies=TRUE)" 
RUN R -e "install.packages(c('dplyr'), dependencies=TRUE)" 

# RUN R -e "install.packages(c('devtools', 'testthat', 'roxygen2'))"

# RUN echo $(pwd)
# WORKDIR /tmp/install
# COPY ./build/load.R /tmp/install
# RUN Rscript load.R
# RUN echo "$(which R)"

WORKDIR /home/workspace

# R --vanilla -e "Rcpp::Rcpp.package.skeleton('plain')"
# devtools::create("myfirstpackage")
# library(devtools)
# devtools::check_man()
# cudaexample::rcpp_hello_world()
# roxygen2::roxygenize(".", roclets="rd")
