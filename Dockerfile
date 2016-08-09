FROM cayek/dojo:latest

################################################################################
# install jekyll

## install of node
RUN apt-get update \
  && apt-get install -y \
    node \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/

RUN gem install jekyll

################################################################################
# usefull R package
RUN install2.r --error \
  servr

## this package
RUN R -e \
  'devtools::install_github("cayek/Mokuso@master", dependencies = TRUE)'

EXPOSE 4000
