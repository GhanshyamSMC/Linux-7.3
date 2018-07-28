#!/bin/bash

REGISTRY_DIRECTORY="/etc/TAP_REGISTRY"
USER_ID=$(id -u)
if [ $USER_ID -ne 0 ];then
        echo "Kindly ensure TAP Installation is done using \"root\" login."
        exit
fi
TEMP_REGISTRY="/tmp/TAP_REGISTRY"
touch "/tmp/register_installer.log"
REGISTER_INSTALLER_LOG="/tmp/register_installer.log"

if [ ! -d $REGISTRY_DIRECTORY ];then
	mkdir -p "$TEMP_REGISTRY"

	if [ ! -d $TEMP_REGISTRY ]; then
		echo "Cannot create temp registry directory." | tee -a $REGISTER_INSTALLER_LOG
		exit
	fi

	cd /tmp/TAP_REGISTRY
	touch inst_type
	echo "m" > inst_type
	value=$?
	if [ $value -ne 0 ]; then
		echo "Error while registering installer ">>$REGISTER_INSTALLER_LOG
		exit
	fi
	echo "Created registry entry in /tmp directory " >>$REGISTER_INSTALLER_LOG
else
	cd "$REGISTRY_DIRECTORY"
	touch inst_type
	echo "m" > inst_type
	value=$?
	if [ $value -ne 0 ]; then
		echo "Error while registering installer ">>$REGISTER_INSTALLER_LOG
		exit
	fi		
	echo "Created registry entry in /tmp directory " >>$REGISTER_INSTALLER_LOG
fi
