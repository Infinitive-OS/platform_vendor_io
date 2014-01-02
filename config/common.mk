PRODUCT_BUILD_PROP_OVERRIDES += BUILD_UTC_DATE=0

ifeq ($(PRODUCT_GMS_CLIENTID_BASE),)
PRODUCT_PROPERTY_OVERRIDES += \
    ro.com.google.clientidbase=android-google
else
PRODUCT_PROPERTY_OVERRIDES += \
    ro.com.google.clientidbase=$(PRODUCT_GMS_CLIENTID_BASE)
endif

PRODUCT_PROPERTY_OVERRIDES += \
    keyguard.no_require_sim=true \
    ro.url.legal=http://www.google.com/intl/%s/mobile/android/basic/phone-legal.html \
    ro.url.legal.android_privacy=http://www.google.com/intl/%s/mobile/android/basic/privacy.html \
    ro.com.android.wifi-watchlist=GoogleGuest \
    ro.setupwizard.enterprise_mode=1 \
    ro.com.android.dateformat=MM-dd-yyyy \
    ro.com.android.dataroaming=false

PRODUCT_PROPERTY_OVERRIDES += \
    ro.build.selinux=1

# Disable excessive dalvik debug messages
PRODUCT_PROPERTY_OVERRIDES += \
    dalvik.vm.debug.alloc=0

# Backup Tool
PRODUCT_COPY_FILES += \
    vendor/io/prebuilt/common/bin/backuptool.sh:install/bin/backuptool.sh \
    vendor/io/prebuilt/common/bin/backuptool.functions:install/bin/backuptool.functions \
    vendor/io/prebuilt/common/bin/50-io.sh:system/addon.d/50-io.sh \
    vendor/io/prebuilt/common/bin/99-backup.sh:system/addon.d/99-backup.sh \
    vendor/io/prebuilt/common/etc/backup.conf:system/etc/backup.conf

# Signature compatibility validation
PRODUCT_COPY_FILES += \
    vendor/io/prebuilt/common/bin/otasigcheck.sh:install/bin/otasigcheck.sh

# IO-specific init file
PRODUCT_COPY_FILES += \
    vendor/io/prebuilt/common/etc/init.local.rc:root/init.io.rc

# Copy latinime for gesture typing
PRODUCT_COPY_FILES += \
    vendor/io/prebuilt/common/lib/libjni_latinimegoogle.so:system/lib/libjni_latinimegoogle.so

# SELinux filesystem labels
PRODUCT_COPY_FILES += \
    vendor/io/prebuilt/common/etc/init.d/50selinuxrelabel:system/etc/init.d/50selinuxrelabel

# Enable SIP+VoIP on all targets
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml

# Don't export PS1 in /system/etc/mkshrc.
PRODUCT_COPY_FILES += \
    vendor/io/prebuilt/common/etc/mkshrc:system/etc/mkshrc \
    vendor/io/prebuilt/common/etc/sysctl.conf:system/etc/sysctl.conf

PRODUCT_COPY_FILES += \
    vendor/io/prebuilt/common/etc/init.d/00banner:system/etc/init.d/00banner \
    vendor/io/prebuilt/common/etc/init.d/90userinit:system/etc/init.d/90userinit \
    vendor/io/prebuilt/common/bin/sysinit:system/bin/sysinit

# Embed SuperUser
SUPERUSER_EMBEDDED := true

# Required packages
PRODUCT_PACKAGES += \
    CellBroadcastReceiver \
    Development \
    Eleven \
    SpareParts \
    Superuser \
    IOWallpapers \
    IOLauncher \
    libscreenrecorder \
    ScreenRecorder \
    WallpaperPicker \
    LockClock \
    su

# Optional packages
PRODUCT_PACKAGES += \
    Basic \
    LiveWallpapersPicker \
    PhaseBeam

# AudioFX
PRODUCT_PACKAGES += \
    AudioFX

# CM Hardware Abstraction Framework
PRODUCT_PACKAGES += \
    org.cyanogenmod.hardware \
    org.cyanogenmod.hardware.xml

# Extra Optional packages
PRODUCT_PACKAGES += \
    LatinIME \
    BluetoothExt \
    DashClock

# Extra tools
PRODUCT_PACKAGES += \
    openvpn \
    e2fsck \
    mke2fs \
    tune2fs \
    mount.exfat \
    fsck.exfat \
    mkfs.exfat \
    ntfsfix \
    ntfs-3g

# Stagefright FFMPEG plugin
PRODUCT_PACKAGES += \
    libffmpeg_extractor \
    libffmpeg_omx \
    media_codecs_ffmpeg.xml

PRODUCT_PACKAGE_OVERLAYS += vendor/io/overlay/common

PRODUCT_PROPERTY_OVERRIDES += \
    media.sf.omx-plugin=libffmpeg_omx.so \
    media.sf.extractor-plugin=libffmpeg_extractor.so

# SuperSU
PRODUCT_COPY_FILES += \
     vendor/io/prebuilt/common/UPDATE-SuperSU.zip:system/addon.d/UPDATE-SuperSU.zip \
     vendor/io/prebuilt/common/etc/init.d/99SuperSUDaemon:system/etc/init.d/99SuperSUDaemon

# Boot animation include
#ifneq ($(TARGET_SCREEN_WIDTH) $(TARGET_SCREEN_HEIGHT),$(space))

# HFM Files
PRODUCT_COPY_FILES += \
	vendor/io/prebuilt/common/etc/hosts.alt:system/etc/hosts.alt \
	vendor/io/prebuilt/common/etc/hosts.og:system/etc/hosts.og

# determine the smaller dimension
#TARGET_BOOTANIMATION_SIZE := $(shell \
#  if [ $(TARGET_SCREEN_WIDTH) -lt $(TARGET_SCREEN_HEIGHT) ]; then \
#    echo $(TARGET_SCREEN_WIDTH); \
#  else \
#    echo $(TARGET_SCREEN_HEIGHT); \
#  fi )

# get a sorted list of the sizes
#bootanimation_sizes := $(subst .zip,, $(shell ls vendor/slim/prebuilt/common/bootanimation))
#bootanimation_sizes := $(shell echo -e $(subst $(space),'\n',$(bootanimation_sizes)) | sort -rn)

# find the appropriate size and set
#define check_and_set_bootanimation
#$(eval TARGET_BOOTANIMATION_NAME := $(shell \
#  if [ -z "$(TARGET_BOOTANIMATION_NAME)" ]; then
#    if [ $(1) -le $(TARGET_BOOTANIMATION_SIZE) ]; then \
#      echo $(1); \
#      exit 0; \
#    fi;
#  fi;
#  echo $(TARGET_BOOTANIMATION_NAME); ))
#endef
#$(foreach size,$(bootanimation_sizes), $(call check_and_set_bootanimation,$(size)))

#ifeq ($(TARGET_BOOTANIMATION_HALF_RES),true)
#PRODUCT_COPY_FILES += \
#    vendor/slim/prebuilt/common/bootanimation/halfres/$(TARGET_BOOTANIMATION_NAME).zip:system/media/bootanimation.zip
#else
#PRODUCT_COPY_FILES += \
#    vendor/slim/prebuilt/common/bootanimation/$(TARGET_BOOTANIMATION_NAME).zip:system/media/bootanimation.zip
#endif
#endif

# Versioning System
# InfinitveOS first version.
PRODUCT_VERSION_MAJOR = 5.1.1
PRODUCT_VERSION_MINOR = 1.0
PRODUCT_VERSION_MAINTENANCE =
ifdef IO_BUILD_EXTRA
    IO_POSTFIX := -$(IO_BUILD_EXTRA)
endif
ifndef IO_BUILD_TYPE
    IO_BUILD_TYPE := UNOFFICIAL
    PLATFORM_VERSION_CODENAME := UNOFFICIAL
    IO_POSTFIX := -$(shell date +"%Y%m%d-%H%M")
endif

# Chromium Prebuilt
ifeq ($(PRODUCT_PREBUILT_WEBVIEWCHROMIUM),yes)
-include prebuilts/chromium/$(TARGET_DEVICE)/chromium_prebuilt.mk
endif

# Set all versions
IO_VERSION := InfinitiveOS-$(PRODUCT_VERSION_MAJOR)-$(PRODUCT_VERSION_MINOR)$(PRODUCT_VERSION_MAINTENANCE)-$(IO_POSTFIX)
IO_MOD_VERSION := InfinitiveOS-$(IO_BUILD)-$(PRODUCT_VERSION_MAJOR)-$(PRODUCT_VERSION_MINOR)$(PRODUCT_VERSION_MAINTENANCE)-$(IO_BUILD_TYPE)$(IO_POSTFIX)

PRODUCT_PROPERTY_OVERRIDES += \
    BUILD_DISPLAY_ID=$(BUILD_ID) \
    io.ota.version=$(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR).$(PRODUCT_VERSION_MAINTENANCE) \
    ro.io.version=$(IO_VERSION) \
    ro.modversion=$(IO_MOD_VERSION) \
    ro.io.buildtype=$(IO_BUILD_TYPE)
