PRODUCT_BRAND ?= cyanogenmod

SUPERUSER_EMBEDDED := true
SUPERUSER_PACKAGE_PREFIX := com.android.settings.cyanogenmod.superuser

# To deal with CM9 specifications
# TODO: remove once all devices have been switched
ifneq ($(TARGET_BOOTANIMATION_NAME),)
TARGET_SCREEN_DIMENSIONS := $(subst -, $(space), $(subst x, $(space), $(TARGET_BOOTANIMATION_NAME)))
ifeq ($(TARGET_SCREEN_WIDTH),)
TARGET_SCREEN_WIDTH := $(word 2, $(TARGET_SCREEN_DIMENSIONS))
endif
ifeq ($(TARGET_SCREEN_HEIGHT),)
TARGET_SCREEN_HEIGHT := $(word 3, $(TARGET_SCREEN_DIMENSIONS))
endif
endif

ifneq ($(TARGET_SCREEN_WIDTH) $(TARGET_SCREEN_HEIGHT),$(space))

# clear TARGET_BOOTANIMATION_NAME in case it was set for CM9 purposes
TARGET_BOOTANIMATION_NAME :=

# determine the smaller dimension
TARGET_BOOTANIMATION_SIZE := $(shell \
  if [ $(TARGET_SCREEN_WIDTH) -lt $(TARGET_SCREEN_HEIGHT) ]; then \
    echo $(TARGET_SCREEN_WIDTH); \
  else \
    echo $(TARGET_SCREEN_HEIGHT); \
  fi )

# get a sorted list of the sizes
bootanimation_sizes := $(subst .zip,, $(shell ls vendor/cm/prebuilt/common/bootanimation))
bootanimation_sizes := $(shell echo -e $(subst $(space),'\n',$(bootanimation_sizes)) | sort -rn)

# find the appropriate size and set
define check_and_set_bootanimation
$(eval TARGET_BOOTANIMATION_NAME := $(shell \
  if [ -z "$(TARGET_BOOTANIMATION_NAME)" ]; then
    if [ $(1) -le $(TARGET_BOOTANIMATION_SIZE) ]; then \
      echo $(1); \
      exit 0; \
    fi;
  fi;
  echo $(TARGET_BOOTANIMATION_NAME); ))
endef
$(foreach size,$(bootanimation_sizes), $(call check_and_set_bootanimation,$(size)))

PRODUCT_BOOTANIMATION := vendor/cm/prebuilt/common/bootanimation/$(TARGET_BOOTANIMATION_NAME).zip
endif

ifdef CM_NIGHTLY
PRODUCT_PROPERTY_OVERRIDES += \
    ro.rommanager.developerid=cyanogenmodnightly
else
PRODUCT_PROPERTY_OVERRIDES += \
    ro.rommanager.developerid=cyanogenmod
endif

PRODUCT_BUILD_PROP_OVERRIDES += BUILD_UTC_DATE=0

PRODUCT_PROPERTY_OVERRIDES += \
    keyguard.no_require_sim=true \
    ro.url.legal=http://www.google.com/intl/%s/mobile/android/basic/phone-legal.html \
    ro.url.legal.android_privacy=http://www.google.com/intl/%s/mobile/android/basic/privacy.html \
    ro.com.google.clientidbase=android-google \
    ro.com.android.wifi-watchlist=GoogleGuest \
    ro.setupwizard.enterprise_mode=1 \
    ro.com.android.dateformat=MM-dd-yyyy \
    ro.com.android.dataroaming=false

PRODUCT_PROPERTY_OVERRIDES += \
    ro.build.selinux=1

ifneq ($(TARGET_BUILD_VARIANT),eng)
# Enable ADB authentication
ADDITIONAL_DEFAULT_PROPERTIES += ro.adb.secure=1
endif

# Copy over the changelog to the device
PRODUCT_COPY_FILES += \
    vendor/cm/CHANGELOG.mkdn:system/etc/CHANGELOG-CM.txt

# Backup Tool
ifneq ($(WITH_GMS),true)
PRODUCT_COPY_FILES += \
    vendor/cm/prebuilt/common/bin/backuptool.sh:system/bin/backuptool.sh \
    vendor/cm/prebuilt/common/bin/backuptool.functions:system/bin/backuptool.functions \
    vendor/cm/prebuilt/common/bin/50-cm.sh:system/addon.d/50-cm.sh \
    vendor/cm/prebuilt/common/bin/blacklist:system/addon.d/blacklist
endif

# init.d support
PRODUCT_COPY_FILES += \
    vendor/cm/prebuilt/common/etc/init.d/00banner:system/etc/init.d/00banner \
    vendor/cm/prebuilt/common/bin/sysinit:system/bin/sysinit

# userinit support
PRODUCT_COPY_FILES += \
    vendor/cm/prebuilt/common/etc/init.d/90userinit:system/etc/init.d/90userinit

# SELinux filesystem labels
PRODUCT_COPY_FILES += \
    vendor/cm/prebuilt/common/etc/init.d/50selinuxrelabel:system/etc/init.d/50selinuxrelabel

# CM-specific init file
PRODUCT_COPY_FILES += \
    vendor/cm/prebuilt/common/etc/init.local.rc:root/init.cm.rc

# Compcache/Zram support
PRODUCT_COPY_FILES += \
    vendor/cm/prebuilt/common/bin/compcache:system/bin/compcache \
    vendor/cm/prebuilt/common/bin/handle_compcache:system/bin/handle_compcache

# Bring in camera effects
PRODUCT_COPY_FILES +=  \
    vendor/cm/prebuilt/common/media/LMprec_508.emd:system/media/LMprec_508.emd \
    vendor/cm/prebuilt/common/media/PFFprec_600.emd:system/media/PFFprec_600.emd

# Enable SIP+VoIP on all targets
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml

# Enable wireless Xbox 360 controller support
PRODUCT_COPY_FILES += \
    frameworks/base/data/keyboards/Vendor_045e_Product_028e.kl:system/usr/keylayout/Vendor_045e_Product_0719.kl

# This is CM!
PRODUCT_COPY_FILES += \
    vendor/cm/config/permissions/com.cyanogenmod.android.xml:system/etc/permissions/com.cyanogenmod.android.xml

# T-Mobile theme engine
include vendor/cm/config/themes_common.mk

# Required CM packages
PRODUCT_PACKAGES += \
    Development \
    BluetoothExt

# Optional CM packages
PRODUCT_PACKAGES += \
    VoiceDialer \
    SoundRecorder \
    Basic \
    libemoji

PRODUCT_PACKAGES += \
    DSPManager \
    libcyanogen-dsp \
    audio_effects.conf \
    Apollo \
    CMFileManager \
    LockClock

# CM Hardware Abstraction Framework
PRODUCT_PACKAGES += \
    org.cyanogenmod.hardware \
    org.cyanogenmod.hardware.xml

PRODUCT_PACKAGES += \
    CellBroadcastReceiver

# Extra tools in CM
PRODUCT_PACKAGES += \
    openvpn \
    e2fsck \
    mke2fs \
    tune2fs \
    bash \
    vim \
    nano \
    htop \
    powertop \
    lsof \
    mount.exfat \
    fsck.exfat \
    mkfs.exfat \
    ntfsfix \
    ntfs-3g \
    gdbserver \
    micro_bench \
    oprofiled \
    procmem \
    procrank \
    sqlite3 \
    strace

# Openssh
PRODUCT_PACKAGES += \
    scp \
    sftp \
    ssh \
    sshd \
    sshd_config \
    ssh-keygen \
    start-ssh

# rsync
PRODUCT_PACKAGES += \
    rsync

# These packages are excluded from user builds
ifneq ($(TARGET_BUILD_VARIANT),user)

PRODUCT_PACKAGES += \
    CMUpdater \
    Superuser \
    su

# Custom GApps Apps
PRODUCT_COPY_FILES += \
    vendor/cm/prebuilt/common/app/app/LatinImeGoogle.apk:system/app/LatinImeGoogle.apk \
    vendor/cm/prebuilt/common/app/app/GoogleHome.apk:system/app/GoogleHome.apk \
    vendor/cm/prebuilt/common/app/app/Hangouts.apk:system/app/Hangouts.apk \
    vendor/cm/prebuilt/common/app/app/CalendarGoogle.apk:system/app/CalendarGoogle.apk \
    vendor/cm/prebuilt/common/app/app/ChromeBookmarksSyncAdapter.apk:system/app/ChromeBookmarksSyncAdapter.apk \
    vendor/cm/prebuilt/common/app/app/GenieWidget.apk:system/app/GenieWidget.apk \
    vendor/cm/prebuilt/common/app/app/Gmail2.apk:system/app/Gmail2.apk \
    vendor/cm/prebuilt/common/app/app/GoogleContactsSyncAdapter.apk:system/app/GoogleContactsSyncAdapter.apk \
    vendor/cm/prebuilt/common/app/app/GoogleTTS.apk:system/app/GoogleTTS.apk \
    vendor/cm/prebuilt/common/app/app/YouTube.apk:system/app/YouTube.apk \
    vendor/cm/prebuilt/common/app/app/Maps.apk:system/app/Maps.apk \
    vendor/cm/prebuilt/common/app/app/MediaUploader.apk:system/app/MediaUploader.apk \
    vendor/cm/prebuilt/common/app/app/PlusOne.apk:system/app/PlusOne.apk

# Custom GApps Priv Apps
PRODUCT_COPY_FILES += \
    vendor/cm/prebuilt/common/app/priv-app/GoogleBackupTransport.apk:system/priv-app/GoogleBackupTransport.apk \
    vendor/cm/prebuilt/common/app/priv-app/GoogleFeedback.apk:system/priv-app/GoogleFeedback.apk \
    vendor/cm/prebuilt/common/app/priv-app/GoogleLoginService.apk:system/priv-app/GoogleLoginService.apk \
    vendor/cm/prebuilt/common/app/priv-app/GooglePartnerSetup.apk:system/priv-app/GooglePartnerSetup.apk \
    vendor/cm/prebuilt/common/app/priv-app/GoogleServicesFramework.apk:system/priv-app/GoogleServicesFramework.apk \
    vendor/cm/prebuilt/common/app/priv-app/OneTimeInitializer.apk:system/priv-app/OneTimeInitializer.apk \
    vendor/cm/prebuilt/common/app/priv-app/Phonesky.apk:system/priv-app/Phonesky.apk \
    vendor/cm/prebuilt/common/app/priv-app/PrebuiltGmsCore.apk:system/priv-app/PrebuiltGmsCore.apk \
    vendor/cm/prebuilt/common/app/priv-app/SetupWizard.apk:system/priv-app/SetupWizard.apk \
    vendor/cm/prebuilt/common/app/priv-app/CalendarProvider.apk:system/priv-app/CalendarProvider.apk \
    vendor/cm/prebuilt/common/app/priv-app/Velvet.apk:system/priv-app/Velvet.apk

# Custom GApps Libs
PRODUCT_COPY_FILES += \
    vendor/cm/prebuilt/common/app/lib/libvideochat_jni.so:system/lib/libvideochat_jni.so \
    vendor/cm/prebuilt/common/app/lib/libjni_latinimegoogle.so:system/lib/libjni_latinimegoogle.so \
    vendor/cm/prebuilt/common/app/lib/libgoogle_recognizer_jni_l.so:system/lib/libgoogle_recognizer_jni_l.so \
    vendor/cm/prebuilt/common/app/lib/libvcdecoder_jni.so:system/lib/libvcdecoder_jni.so \
    vendor/cm/prebuilt/common/app/lib/libAppDataSearch.so:system/lib/libAppDataSearch.so \
    vendor/cm/prebuilt/common/app/lib/libgames_rtmp_jni.so:system/lib/libgames_rtmp_jni.so \
    vendor/cm/prebuilt/common/app/lib/libfacetracker.so:system/lib/libfacetracker.so \
    vendor/cm/prebuilt/common/app/lib/libfilterframework_jni.so:system/lib/libfilterframework_jni.so \
    vendor/cm/prebuilt/common/app/lib/libfilterpack_facedetect.so:system/lib/libfilterpack_facedetect.so \
    vendor/cm/prebuilt/common/app/lib/libfrsdk.so:system/lib/libfrsdk.so \
    vendor/cm/prebuilt/common/app/lib/libjni_t13n_shared_engine.so:system/lib/libjni_t13n_shared_engine.so \
    vendor/cm/prebuilt/common/app/lib/libmoviemaker-jni.so:system/lib/libmoviemaker-jni.so \
    vendor/cm/prebuilt/common/app/lib/libnetjni.so:system/lib/libnetjni.so \
    vendor/cm/prebuilt/common/app/lib/libpatts_engine_jni_api.so:system/lib/libpatts_engine_jni_api.so \
    vendor/cm/prebuilt/common/app/lib/libplus_jni_v8.so:system/lib/libplus_jni_v8.so \
    vendor/cm/prebuilt/common/app/lib/librs.antblur.so:system/lib/librs.antblur.so \
    vendor/cm/prebuilt/common/app/lib/librs.antblur_constant.so:system/lib/librs.antblur_constant.so \
    vendor/cm/prebuilt/common/app/lib/librs.antblur_drama.so:system/lib/librs.antblur_drama.so \
    vendor/cm/prebuilt/common/app/lib/librs.drama.so:system/lib/librs.drama.so.so \
    vendor/cm/prebuilt/common/app/lib/librs.film_base.so:system/lib/librs.film_base.so \
    vendor/cm/prebuilt/common/app/lib/librs.fixedframe.so:system/lib/librs.fixedframe.so \
    vendor/cm/prebuilt/common/app/lib/librs.grey.so:system/lib/librs.grey.so.so \
    vendor/cm/prebuilt/common/app/lib/librs.image_wrapper.so:system/lib/librs.image_wrapper.so \
    vendor/cm/prebuilt/common/app/lib/librs.retrolux.so:system/lib/librs.retrolux.so \
    vendor/cm/prebuilt/common/app/lib/librsjni.so:system/lib/librsjni.so \
    vendor/cm/prebuilt/common/app/lib/libRSSupport.so:system/lib/libRSSupport.so \
    vendor/cm/prebuilt/common/app/lib/libspeexwrapper.so:system/lib/libspeexwrapper.so \
    vendor/cm/prebuilt/common/app/lib/libwebp_android.so:system/lib/libwebp_android.so \
    vendor/cm/prebuilt/common/app/lib/libwebrtc_audio_coding.so:system/lib/libwebrtc_audio_coding.so \
    vendor/cm/prebuilt/common/app/lib/libwebrtc_audio_preprocessing.so:system/lib/libwebrtc_audio_preprocessing.so

# Custom GApps Framework
PRODUCT_COPY_FILES += \
    vendor/cm/prebuilt/common/app/framework/com.google.android.maps.jar:system/framework/com.google.android.maps.jar \
    vendor/cm/prebuilt/common/app/framework/com.google.android.media.effects.jar:system/framework/com.google.android.media.effects.jar \
    vendor/cm/prebuilt/common/app/framework/com.google.widevine.software.drm.jar:system/framework/com.google.widevine.software.drm.jar

# Custom GApps Etc
PRODUCT_COPY_FILES += \
    vendor/cm/prebuilt/common/app/etc/permissions/com.google.android.maps.xml:system/etc/permissions/com.google.android.maps.xml \
    vendor/cm/prebuilt/common/app/etc/permissions/com.google.android.media.effects.xml:system/etc/permissions/com.google.android.media.effects.xml \
    vendor/cm/prebuilt/common/app/etc/permissions/com.google.widevine.software.drm.xml:system/etc/permissions/com.google.widevine.software.drm.xml \
    vendor/cm/prebuilt/common/app/etc/permissions/features.xml:system/etc/permissions/features.xml \
    vendor/cm/prebuilt/common/app/etc/preferred-apps/google.xml:system/etc/preferred-apps/google.xml

# Custom GApps Usr
PRODUCT_COPY_FILES += \
    vendor/cm/prebuilt/common/app/usr/srec/en-US/c_fst:system/usr/srec/en-US/c_fst \
    vendor/cm/prebuilt/common/app/usr/srec/en-US/clg:system/usr/srec/en-US/clg \
    vendor/cm/prebuilt/common/app/usr/srec/en-US/commands.abnf:system/usr/srec/en-US/commands.abnf \
    vendor/cm/prebuilt/common/app/usr/srec/en-US/compile_grammar.config:system/usr/srec/en-US/compile_grammar.config \
    vendor/cm/prebuilt/common/app/usr/srec/en-US/contacts.abnf:system/usr/srec/en-US/contacts.abnf \
    vendor/cm/prebuilt/common/app/usr/srec/en-US/dict:system/usr/srec/en-US/dict \
    vendor/cm/prebuilt/common/app/usr/srec/en-US/dictation.config:system/usr/srec/en-US/dictation.config \
    vendor/cm/prebuilt/common/app/usr/srec/en-US/dnn:system/usr/srec/en-US/dnn \
    vendor/cm/prebuilt/common/app/usr/srec/en-US/endpointer_dictation.config:system/usr/srec/en-US/endpointer_dictation.config \
    vendor/cm/prebuilt/common/app/usr/srec/en-US/endpointer_voicesearch.config:system/usr/srec/en-US/endpointer_voicesearch.config \
    vendor/cm/prebuilt/common/app/usr/srec/en-US/ep_acoustic_model:system/usr/srec/en-US/ep_acoustic_model \
    vendor/cm/prebuilt/common/app/usr/srec/en-US/g2p_fst:system/usr/srec/en-US/g2p_fst \
    vendor/cm/prebuilt/common/app/usr/srec/en-US/grammar.config:system/usr/srec/en-US/grammar.config \
    vendor/cm/prebuilt/common/app/usr/srec/en-US/hclg_shotword:system/usr/srec/en-US/hclg_shotword \
    vendor/cm/prebuilt/common/app/usr/srec/en-US/hmm_symbols:system/usr/srec/en-US/hmm_symbols \
    vendor/cm/prebuilt/common/app/usr/srec/en-US/hmmlist:system/usr/srec/en-US/hmmlist \
    vendor/cm/prebuilt/common/app/usr/srec/en-US/hotword.config:system/usr/srec/en-US/hotword.config \
    vendor/cm/prebuilt/common/app/usr/srec/en-US/hotword_classifier:system/usr/srec/en-US/hotword_classifier \
    vendor/cm/prebuilt/common/app/usr/srec/en-US/hotword_normalizer:system/usr/srec/en-US/hotword_normalizer \
    vendor/cm/prebuilt/common/app/usr/srec/en-US/hotword_prompt.txt:system/usr/srec/en-US/hotword_prompt.txt \
    vendor/cm/prebuilt/common/app/usr/srec/en-US/hotword_word_symbols:system/usr/srec/en-US/hotword_word_symbols \
    vendor/cm/prebuilt/common/app/usr/srec/en-US/metadata:system/usr/srec/en-US/metadata \
    vendor/cm/prebuilt/common/app/usr/srec/en-US/norm_fst:system/usr/srec/en-US/norm_fst \
    vendor/cm/prebuilt/common/app/usr/srec/en-US/normalizer:system/usr/srec/en-US/normalizer \
    vendor/cm/prebuilt/common/app/usr/srec/en-US/offensive_word_normalizer:system/usr/srec/en-US/offensive_word_normalizer \
    vendor/cm/prebuilt/common/app/usr/srec/en-US/phone_state_map:system/usr/srec/en-US/phone_state_map \
    vendor/cm/prebuilt/common/app/usr/srec/en-US/phonelist:system/usr/srec/en-US/phonelist \
    vendor/cm/prebuilt/common/app/usr/srec/en-US/rescoring_lm:system/usr/srec/en-US/rescoring_lm \
    vendor/cm/prebuilt/common/app/usr/srec/en-US/wordlist:system/usr/srec/en-US/wordlist

# Terminal Emulator
PRODUCT_COPY_FILES +=  \
    vendor/cm/proprietary/lib/armeabi/libjackpal-androidterm4.so:system/lib/libjackpal-androidterm4.so

PRODUCT_PROPERTY_OVERRIDES += \
    persist.sys.root_access=1
else

PRODUCT_PACKAGES += \
    CMFota

PRODUCT_PROPERTY_OVERRIDES += \
    persist.sys.root_access=0

endif

# easy way to extend to add more packages
-include vendor/extra/product.mk

PRODUCT_PACKAGE_OVERLAYS += vendor/cm/overlay/dictionaries
PRODUCT_PACKAGE_OVERLAYS += vendor/cm/overlay/common

PRODUCT_VERSION_MAJOR = 2
PRODUCT_VERSION_MINOR = 0
PRODUCT_VERSION_MAINTENANCE = 1

# Set CM_BUILDTYPE from the env RELEASE_TYPE, for jenkins compat

ifndef CM_BUILDTYPE
    ifdef RELEASE_TYPE
        # Starting with "CM_" is optional
        RELEASE_TYPE := $(shell echo $(RELEASE_TYPE) | sed -e 's|^CM_||g')
        CM_BUILDTYPE := $(RELEASE_TYPE)
    endif
endif

# Filter out random types, so it'll reset to UNOFFICIAL
ifeq ($(filter RELEASE NIGHTLY SNAPSHOT EXPERIMENTAL,$(CM_BUILDTYPE)),)
    CM_BUILDTYPE :=
endif

ifdef CM_BUILDTYPE
    ifneq ($(CM_BUILDTYPE), SNAPSHOT)
        ifdef CM_EXTRAVERSION
            # Force build type to EXPERIMENTAL
            CM_BUILDTYPE := EXPERIMENTAL
            # Remove leading dash from CM_EXTRAVERSION
            CM_EXTRAVERSION := $(shell echo $(CM_EXTRAVERSION) | sed 's/-//')
            # Add leading dash to CM_EXTRAVERSION
            CM_EXTRAVERSION := -$(CM_EXTRAVERSION)
        endif
    else
        ifndef CM_EXTRAVERSION
            # Force build type to EXPERIMENTAL, SNAPSHOT mandates a tag
            CM_BUILDTYPE := EXPERIMENTAL
        else
            # Remove leading dash from CM_EXTRAVERSION
            CM_EXTRAVERSION := $(shell echo $(CM_EXTRAVERSION) | sed 's/-//')
            # Add leading dash to CM_EXTRAVERSION
            CM_EXTRAVERSION := -$(CM_EXTRAVERSION)
        endif
    endif
else
    # If CM_BUILDTYPE is not defined, set to UNOFFICIAL
    CM_BUILDTYPE := UNOFFICIAL
    CM_EXTRAVERSION :=
endif

ifeq ($(CM_BUILDTYPE), RELEASE)
    CM_VERSION := $(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR).$(PRODUCT_VERSION_MAINTENANCE)$(PRODUCT_VERSION_DEVICE_SPECIFIC)-$(CM_BUILD)
    CF_VERSION := $(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR).$(PRODUCT_VERSION_MAINTENANCE)$(PRODUCT_VERSION_DEVICE_SPECIFIC)
else
    CM_VERSION := $(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR).$(PRODUCT_VERSION_MAINTENANCE)-$(shell date -u +%Y%m%d)-$(CM_BUILDTYPE)$(CM_EXTRAVERSION)-$(CM_BUILD)
    CF_VERSION := $(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR).$(PRODUCT_VERSION_MAINTENANCE)-$(shell date -u +%Y%m%d)-$(CM_BUILDTYPE)$(CM_EXTRAVERSION)
endif

PRODUCT_PROPERTY_OVERRIDES += \
  ro.cm.version=$(CM_VERSION) \
  ro.modversion=$(CM_VERSION) \
  ro.cf.version=$(CF_VERSION)

-include vendor/cm-priv/keys/keys.mk

-include $(WORKSPACE)/hudson/image-auto-bits.mk
