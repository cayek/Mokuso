.PHONY: all

all:

################################################################################
# docker
IMAGE_NAME = cayek/mokuso:latest
CONTAINER_NAME = mokuso

include	docker.mk

################################################################################
# Mokusu
include	mokuso.mk
