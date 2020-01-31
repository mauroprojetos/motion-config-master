###
### makefile
###

SHELL := /bin/bash

# logging
LOGGER_DEFAULT := $(if $(wildcard LOGGER_DEFAULT),$(shell v=$$(cat LOGGER_DEFAULT) && echo "** SPECIFIED: LOGGER_DEFAULT: $${v}" > /dev/stderr && echo "$${v}"),$(shell v="warn" && echo "!! UNSPECIFIED: LOGGER_DEFAULT unset; default: $${v}" > /dev/stderr && echo "$${v}"))

# automation(s)
AUTOMATION_internet := $(if $(wildcard AUTOMATION_internet),$(shell v=$$(cat AUTOMATION_internet) && echo "** SPECIFIED: AUTOMATION_internet: $${v}" > /dev/stderr && echo "$${v}"),$(shell echo "!! UNSPECIFIED: AUTOMATION_internet unset; default: off" > /dev/stderr && echo "off"))
AUTOMATION_startup := $(if $(wildcard AUTOMATION_startup),$(shell v=$$(cat AUTOMATION_startup) && echo "** SPECIFIED: AUTOMATION_startup: $${v}" > /dev/stderr && echo "$${v}"),$(shell echo "!! UNSPECIFIED: AUTOMATION_startup unset; default: off" > /dev/stderr && echo "off"))
AUTOMATION_sdr2msghub := $(if $(wildcard AUTOMATION_sdr2msghub),$(shell v=$$(cat AUTOMATION_sdr2msghub) &&  echo "** SPECIFIED: AUTOMATION_sdr2msghub: $${v}" > /dev/stderr && echo "$${v}"),$(shell echo "!! UNSPECIFIED: AUTOMATION_sdr2msghub unset; default: off" > /dev/stderr && echo "off"))
AUTOMATION_yolo2msghub := $(if $(wildcard AUTOMATION_yolo2msghub),$(shell v=$$(cat AUTOMATION_yolo2msghub) && echo "** SPECIFIED: AUTOMATION_yolo2msghub: $${v}" > /dev/stderr && echo "$${v}"),$(shell echo "!! UNSPECIFIED: AUTOMATION_yolo2msghub unset; default: off" > /dev/stderr && echo "off"))
AUTOMATION_highlow := $(if $(wildcard AUTOMATION_highlow),$(shell v=$$(cat AUTOMATION_highlow) && echo "** SPECIFIED: AUTOMATION_highlow: $${v}" > /dev/stderr && echo "$${v}"),$(shell echo "!! UNSPECIFIED: AUTOMATION_highlow unset; default: off" > /dev/stderr && echo "off"))

# domain
DOMAIN_NAME := $(if $(wildcard DOMAIN_NAME),$(shell v=$$(cat DOMAIN_NAME) && echo "** SPECIFIED: DOMAIN_NAME: $${v}" > /dev/stderr && echo "$${v}"),$(shell v="local" && echo "!! UNSPECIFIED: DOMAIN_NAME unset; default: $${v}" > /dev/stderr && echo "$${v}"))

# host
HOST_NAME := $(if $(wildcard HOST_NAME),$(shell v=$$(cat HOST_NAME) && echo "** SPECIFIED: HOST_NAME: $${v}" > /dev/stderr && echo "$${v}"),$(shell v=$$(hostname -f) && v=$${v%%.*} && echo "!! UNSPECIFIED: HOST_NAME unset; default: $${v}" > /dev/stderr && echo "$${v}"))
HOST_IPADDR := $(if $(wildcard HOST_IPADDR),$(shell v=$$(cat HOST_IPADDR) && echo "** SPECIFIED: HOST_IPADDR: $${v}" > /dev/stderr && echo "$${v}"),$(shell v=$$(hostname -I | awk '{ print $$1 }') && echo "!! UNSPECIFIED: HOST_IPADDR unset; default: $${v}" > /dev/stderr && echo "$${v}"))
HOST_PORT := $(if $(wildcard HOST_PORT),$(shell v=$$(cat HOST_PORT) && echo "** SPECIFIED: HOST_PORT: $${v}" > /dev/stderr && echo "$${v}"),$(shell v="8123" && echo "!! UNSPECIFIED: HOST_PORT unset; default: $${v}" > /dev/stderr && echo "$${v}"))
HOST_THEME := $(if $(wildcard HOST_THEME),$(shell v=$$(cat HOST_THEME) && echo "** SPECIFIED: HOST_THEME: $${v}" > /dev/stderr && echo "$${v}"),$(shell v="default" && echo "!! UNSPECIFIED: HOST_THEME unset; default: $${v}" > /dev/stderr && echo "$${v}"))
HOST_NETWORK := $(shell export HOST_IPADDR=$(HOST_IPADDR) && echo $${HOST_IPADDR%.*}.0)
HOST_NETWORK_MASK := 24

# MQTT
MQTT_HOST := $(if $(wildcard MQTT_HOST),$(shell v=$$(cat MQTT_HOST) && echo "** SPECIFIED: MQTT_HOST: $${v}" > /dev/stderr && echo "$${v}"),$(shell v="core-mosquitto" && echo "!! UNSPECIFIED: MQTT_HOST unset; default: $${v}" > /dev/stderr && echo "$${v}"))
MQTT_PORT := $(if $(wildcard MQTT_PORT),$(shell v=$$(cat MQTT_PORT) && echo "** SPECIFIED: MQTT_PORT: $${v}" > /dev/stderr && echo "$${v}"),$(shell v="1883" && echo "!! UNSPECIFIED: MQTT_PORT unset; default: $${v}" > /dev/stderr && echo "$${v}"))
MQTT_USERNAME := $(if $(wildcard MQTT_USERNAME),$(shell v=$$(cat MQTT_USERNAME) && echo "** SPECIFIED: MQTT_USERNAME: $${v}" > /dev/stderr && echo "$${v}"),$(shell v="username" && echo "!! UNSPECIFIED: MQTT_USERNAME unset; default: $${v}" > /dev/stderr && echo "$${v}"))
MQTT_PASSWORD := $(if $(wildcard MQTT_PASSWORD),$(shell v=$$(cat MQTT_PASSWORD) && echo "** SPECIFIED: MQTT_PASSWORD: $${v}" > /dev/stderr && echo "$${v}"),$(shell v="password" && echo "!! UNSPECIFIED: MQTT_PASSWORD unset; default: $${v}" > /dev/stderr && echo "$${v}"))

# webcam
NETCAM_USERNAME := $(if $(wildcard NETCAM_USERNAME),$(shell v=$$(cat NETCAM_USERNAME) && echo "** SPECIFIED: NETCAM_USERNAME: $${v}" > /dev/stderr && echo "$${v}"),$(shell v="username" && echo "!! UNSPECIFIED: NETCAM_USERNAME unset; default: $${v}" > /dev/stderr && echo "$${v}"))
NETCAM_PASSWORD := $(if $(wildcard NETCAM_PASSWORD),$(shell v=$$(cat NETCAM_PASSWORD) && echo "** SPECIFIED: NETCAM_PASSWORD: $${v}" > /dev/stderr && echo "$${v}"),$(shell read -p "Specify NETCAM_PASSWORD: " && echo $${REPLY} | tee NETCAM_PASSWORD))

MOTIONCAM_USERNAME := $(if $(wildcard MOTIONCAM_USERNAME),$(shell v=$$(cat MOTIONCAM_USERNAME) && echo "** SPECIFIED: MOTIONCAM_USERNAME: $${v}" > /dev/stderr && echo "$${v}"),$(shell v="username" && echo "!! UNSPECIFIED: MOTIONCAM_USERNAME unset; default: $${v}" > /dev/stderr && echo "$${v}"))
MOTIONCAM_PASSWORD := $(if $(wildcard MOTIONCAM_PASSWORD),$(shell v=$$(cat MOTIONCAM_PASSWORD) && echo "** SPECIFIED: MOTIONCAM_PASSWORD: $${v}" > /dev/stderr && echo "$${v}"),$(shell read -p "Specify MOTIONCAM_PASSWORD: " && echo $${REPLY} | tee MOTIONCAM_PASSWORD))

# netdata
NETDATA_URL := $(if $(wildcard NETDATA_URL),$(shell v=$$(cat NETDATA_URL) && echo "** SPECIFIED: NETDATA_URL: $${v}" > /dev/stderr && echo "$${v}"),$(shell v="http://${HOST_IPADDR}:19999/" && echo "!! UNSPECIFIED: NETDATA_URL unset; default: $${v}" > /dev/stderr && echo "$${v}"))

# internet
INTERNET_SCAN_INTERVAL := $(if $(wildcard INTERNET_SCAN_INTERVAL),$(shell v=$$(cat INTERNET_SCAN_INTERVAL) && echo "** SPECIFIED: INTERNET_SCAN_INTERVAL: $${v}" > /dev/stderr && echo "$${v}"),$(shell v="14400" && echo "!! UNSPECIFIED: INTERNET_SCAN_INTERVAL unset; default: $${v}" > /dev/stderr && echo "$${v}"))
INTRANET_SCAN_INTERVAL := $(if $(wildcard INTRANET_SCAN_INTERVAL),$(shell v=$$(cat INTRANET_SCAN_INTERVAL) && echo "** SPECIFIED: INTRANET_SCAN_INTERVAL: $${v}" > /dev/stderr && echo "$${v}"),$(shell v="1800" && echo "!! UNSPECIFIED: INTRANET_SCAN_INTERVAL unset; default: $${v}" > /dev/stderr && echo "$${v}"))

###
### TARGETS
###

## subdirectories containing addition makefile
PACKAGES := motion

## directories for output files from scripts
MOTION_DIRS := camera/motion group/motion counter/motion sensor/motion automation/motion device_tracker/motion history_graph/motion

default: all

all: motion/webcams.json $(MOTION_DIRS) $(PACKAGES) secrets.yaml

motion/webcams.json:
	@echo "Please create $(PWD)/$@ from example template: $(PWD)/$@.tmpl"

$(MOTION_DIRS):
	-mkdir -p $@

$(PACKAGES): makefile
	@echo "making $@"
	@export \
	  HOST_NAME="$(HOST_NAME)" \
	  MQTT_HOST="$(MQTT_HOST)" \
	  MQTT_PORT="$(MQTT_PORT)" \
	  MQTT_USERNAME="$(MQTT_USERNAME)" \
	  MQTT_PASSWORD="$(MQTT_PASSWORD)" \
	  && ${MAKE} -C $@

run: all configuration.yaml 
	docker start homeassistant

stop:
	-docker stop homeassistant

restart: stop tidy logclean run

logs:
	docker logs -f homeassistant

secrets.yaml: secrets.yaml.tmpl makefile $(PWD)
	@echo "making $@"
	@export \
	  AUTOMATION_internet="$(AUTOMATION_internet)" \
	  AUTOMATION_startup="$(AUTOMATION_startup)" \
	  AUTOMATION_sdr2msghub="$(AUTOMATION_sdr2msghub)" \
	  AUTOMATION_yolo2msghub="$(AUTOMATION_yolo2msghub)" \
	  AUTOMATION_highlow="$(AUTOMATION_highlow)" \
	  HOST_NAME="$(HOST_NAME)" \
	  HOST_IPADDR="$(HOST_IPADDR)" \
	  HOST_NETWORK="$(HOST_NETWORK)" \
	  HOST_NETWORK_MASK="$(HOST_NETWORK_MASK)" \
	  HOST_PORT="$(HOST_PORT)" \
	  HOST_THEME="$(HOST_THEME)" \
	  HZNMONITOR_URL="$(HZNMONITOR_URL)" \
	  CONSUL_URL="$(CONSUL_URL)" \
	  COUCHDB_URL="$(COUCHDB_URL)" \
	  DIGITS_URL="$(DIGITS_URL)" \
	  EDGEX_URL="$(EDGEX_URL)" \
	  EXCHANGE_URL="$(EXCHANGE_URL)" \
	  EXCHANGE_APIKEY="$(EXCHANGE_APIKEY)" \
	  EXCHANGE_ORG="$(EXCHANGE_ORG)" \
	  EXCHANGE_ORG_ADMIN="$(EXCHANGE_ORG_ADMIN)" \
	  GRAFANA_URL="$(GRAFANA_URL)" \
	  NETDATA_URL="$(NETDATA_URL)" \
	  INFLUXDB_HOST="$(INFLUXDB_HOST)" \
	  INFLUXDB_PASSWORD="$(INFLUXDB_PASSWORD)" \
	  INTERNET_SCAN_INTERVAL="$(INTERNET_SCAN_INTERVAL)" \
	  INTRANET_SCAN_INTERVAL="$(INTRANET_SCAN_INTERVAL)" \
	  MQTT_HOST="$(MQTT_HOST)" \
	  MQTT_PORT="$(MQTT_PORT)" \
	  MQTT_USERNAME="$(MQTT_USERNAME)" \
	  MQTT_PASSWORD="$(MQTT_PASSWORD)" \
	  NETCAM_USERNAME="$(NETCAM_USERNAME)" \
	  NETCAM_PASSWORD="$(NETCAM_PASSWORD)" \
	  MOTIONCAM_USERNAME="$(MOTIONCAM_USERNAME)" \
	  MOTIONCAM_PASSWORD="$(MOTIONCAM_PASSWORD)" \
	  LOGGER_DEFAULT="$(LOGGER_DEFAULT)" \
	&& cat secrets.yaml.tmpl | envsubst > $@

## clean and clean and clean ..

tidy: 
	@echo "making $@"
	@${MAKE} -C motion clean

clean: stop logclean tidy
	@echo "making $@"
	-rm -f secrets.yaml
	-rm -f .storage/lovelace 
	-rm -f .storage/core.restore_state

realclean: clean
	rm -f known_devices.yaml
	rm -fr home-assistant.log
	rm -fr home-assistant_v2.*

logclean:
	@for i in $$(sudo find "/var/lib/docker/containers" -name "*.log" -print); do echo "Cleaning $${i}" && sudo cp /dev/null $${i}; done

distclean: realclean
	rm -fr .uuid .HA_VERSION .cloud deps tts .storage

.PHONY: all default build run stop logs restart clean realclean distclean $(PACKAGES)
