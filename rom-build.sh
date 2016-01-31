#!/bin/bash

# Version 2
# Infinitive-OS

# Console Colors
red='tput setaf 1'              # red
green='tput setaf 2'            # green
yellow='tput setaf 3'           # yellow
blue='tput setaf 4'             # blue
violet='tput setaf 5'           # violet
cyan='tput setaf 6'             # cyan
white='tput setaf 7'            # white
txtbld=$(tput bold)             # Bold
bldred=${txtbld}$(tput setaf 1) # Bold red
bldgrn=${txtbld}$(tput setaf 2) # Bold green
bldblu=${txtbld}$(tput setaf 4) # Bold blue
bldcya=${txtbld}$(tput setaf 6) # Bold cyan
normal='tput sgr0'

# Get start time
res1=$(date +%s.%N)

#check for architecture
#ARCH=$(uname -m | sed 's/x86_//;s/i[3-6]86/32/')
ARCH=32
# Manage jobs parameter
if   
	expr $1 : '[-][j][0-9]' >/dev/null 2>&1; then export JOBS=$1 && export PRODUCT=$2
else
	if
		expr $2 : '[-][j][0-9]' >/dev/null 2>&1; then export JOBS=$2 && export PRODUCT=$1
	else
		export PRODUCT=$1
	fi
fi

if [ $ARCH = "64" ]; then
	if [[ -n $PRODUCT ]]; then
		source build/envsetup.sh
		lunch io_$PRODUCT-userdebug

		if [[ -n $PRODUCT ]]; then
			wget https://raw.githubusercontent.com/Infinitive-OS/platform_vendor_io/mm6.0/io.devices
			if [[ -f "./io.devices" ]]; then
					while IFS='' read -r line || [[ -n $line ]]; do
						#export ${i}=`grep "${i}" "io.config" | cut -d'=' -f2`
						if [[ $PRODUCT == $line ]]; then
							export IO_BUILDTYPE=OFFICIAL
							echo -e "${bldcya}$PRODUCT is an OFFICIAL InfinitiveOS device"
							echo -e "${bldcya}Building as official"
							tput sgr0
						fi
					done < "io.devices"
					rm ./io.devices
			fi
		fi

		export USE_PREBUILT_CHROMIUM=true
		echo "USE_PREBUILT_CHROMIUM=true"

		#build
		echo -e "Starting Compilation..."
		echo -e "Building InfinitiveOS for ${bldcya}"${PRODUCT}
		tput sgr0
		make bacon $JOBS

	else
		echo "Error : Product not defined."
		echo "USAGE: "
		echo "	${bldred}./rom-build.sh -jX <device>"
		tput sgr0
		echo ""
		echo "device name not specified... bailing out.. "
	fi
	
	# Get elapsed time
	res2=$(date +%s.%N)
	echo -e "${bldgrn}Total time elapsed: ${txtrst}${grn}$(echo "($res2 - $res1) / 60"|bc ) minutes ($(echo "$res2 - $res1"|bc ) seconds)${txtrst}"
	tput sgr0
else
  echo -e "${bldred}This script only supports 64 bit architecture${txtrst}"
fi
