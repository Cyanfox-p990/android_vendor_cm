# app
PRODUCT_COPY_FILES += \
    vendor/cm/prebuilt/common/gapps/app/GoogleLatinIme.apk:system/app/GoogleLatinIme.apk \
    vendor/cm/prebuilt/common/gapps/app/GoogleHome.apk:system/app/GoogleHome.apk \
    vendor/cm/prebuilt/common/gapps/app/Hangouts.apk:system/app/Hangouts.apk \
    vendor/cm/prebuilt/common/gapps/app/CalendarGoogle.apk:system/app/CalendarGoogle.apk \
    vendor/cm/prebuilt/common/gapps/app/Chrome.apk:system/app/Chrome.apk \
    vendor/cm/prebuilt/common/gapps/app/Gmail2.apk:system/app/Gmail2.apk \
    vendor/cm/prebuilt/common/gapps/app/GoogleContactsSyncAdapter.apk:system/app/GoogleContactsSyncAdapter.apk \
    vendor/cm/prebuilt/common/gapps/app/SlidingExplorer.apk:system/app/SlidingExplorer.apk

# priv-app
PRODUCT_COPY_FILES += \
    vendor/cm/prebuilt/common/gapps/priv-app/Velvet.apk:system/priv-app/Velvet.apk \
    vendor/cm/prebuilt/common/gapps/priv-app/CalendarProvider.apk:system/priv-app/CalendarProvider.apk \
    vendor/cm/prebuilt/common/gapps/priv-app/GmsCore.apk:system/priv-app/GmsCore.apk \
    vendor/cm/prebuilt/common/gapps/priv-app/GoogleBackupTransport.apk:system/priv-app/GoogleBackupTransport.apk \
    vendor/cm/prebuilt/common/gapps/priv-app/GoogleFeedback.apk:system/priv-app/GoogleFeedback.apk \
    vendor/cm/prebuilt/common/gapps/priv-app/GoogleLoginService.apk:system/priv-app/GoogleLoginService.apk \
    vendor/cm/prebuilt/common/gapps/priv-app/GoogleOneTimeInitializer.apk:system/priv-app/GoogleOneTimeInitializer.apk \
    vendor/cm/prebuilt/common/gapps/priv-app/GooglePartnerSetup.apk:system/priv-app/GooglePartnerSetup.apk \
    vendor/cm/prebuilt/common/gapps/priv-app/GoogleServicesFramework.apk:system/priv-app/GoogleServicesFramework.apk \
    vendor/cm/prebuilt/common/gapps/priv-app/Phonesky.apk:system/priv-app/Phonesky.apk \
    vendor/cm/prebuilt/common/gapps/priv-app/SetupWizard.apk:system/priv-app/SetupWizard.apk \
    vendor/cm/prebuilt/common/gapps/priv-app/ConfigUpdater.apk:system/priv-app/ConfigUpdater.apk

# lib
PRODUCT_COPY_FILES += \
    vendor/cm/prebuilt/common/gapps/lib/libvideochat_jni.so:system/lib/libvideochat_jni.so \
    vendor/cm/prebuilt/common/gapps/lib/libjni_unbundled_latinimegoogle.so:system/lib/libjni_unbundled_latinimegoogle.so \
    vendor/cm/prebuilt/common/gapps/lib/libgoogle_recognizer_jni_l.so:system/lib/libgoogle_recognizer_jni_l.so \
    vendor/cm/prebuilt/common/gapps/lib/libvcdecoder_jni.so:system/lib/libvcdecoder_jni.so \
    vendor/cm/prebuilt/common/gapps/lib/libAppDataSearch.so:system/lib/libAppDataSearch.so \
    vendor/cm/prebuilt/common/gapps/lib/libchromeview.so:system/lib/libchromeview.so \
    vendor/cm/prebuilt/common/gapps/lib/libgames_rtmp_jni.so:system/lib/libgames_rtmp_jni.so \
    vendor/cm/prebuilt/common/gapps/lib/libjni_latinime.so:system/lib/libjni_latinime.so

# framework
PRODUCT_COPY_FILES += \
    vendor/cm/prebuilt/common/gapps/framework/com.google.android.maps.jar:system/framework/com.google.android.maps.jar \
    vendor/cm/prebuilt/common/gapps/framework/com.google.android.media.effects.jar:system/framework/com.google.android.media.effects.jar \
    vendor/cm/prebuilt/common/gapps/framework/com.google.widevine.software.drm.jar:system/framework/com.google.widevine.software.drm.jar

# etc
PRODUCT_COPY_FILES += \
    vendor/cm/prebuilt/common/gapps/etc/permissions/com.google.android.maps.xml:system/etc/permissions/com.google.android.maps.xml \
    vendor/cm/prebuilt/common/gapps/etc/permissions/com.google.android.media.effects.xml:system/etc/permissions/com.google.android.media.effects.xml \
    vendor/cm/prebuilt/common/gapps/etc/permissions/com.google.widevine.software.drm.xml:system/etc/permissions/com.google.widevine.software.drm.xml \
    vendor/cm/prebuilt/common/gapps/etc/permissions/features.xml:system/etc/permissions/features.xml \
    vendor/cm/prebuilt/common/gapps/etc/preferred-apps/google.xml:system/etc/preferred-apps/google.xml

# usr
PRODUCT_COPY_FILES += \
    vendor/cm/prebuilt/common/gapps/usr/srec/en-US/c_fst:system/usr/srec/en-US/c_fst \
    vendor/cm/prebuilt/common/gapps/usr/srec/en-US/clg:system/usr/srec/en-US/clg \
    vendor/cm/prebuilt/common/gapps/usr/srec/en-US/commands.abnf:system/usr/srec/en-US/commands.abnf \
    vendor/cm/prebuilt/common/gapps/usr/srec/en-US/compile_grammar.config:system/usr/srec/en-US/compile_grammar.config \
    vendor/cm/prebuilt/common/gapps/usr/srec/en-US/contacts.abnf:system/usr/srec/en-US/contacts.abnf \
    vendor/cm/prebuilt/common/gapps/usr/srec/en-US/dict:system/usr/srec/en-US/dict \
    vendor/cm/prebuilt/common/gapps/usr/srec/en-US/dictation.config:system/usr/srec/en-US/dictation.config \
    vendor/cm/prebuilt/common/gapps/usr/srec/en-US/dnn:system/usr/srec/en-US/dnn \
    vendor/cm/prebuilt/common/gapps/usr/srec/en-US/endpointer_dictation.config:system/usr/srec/en-US/endpointer_dictation.config \
    vendor/cm/prebuilt/common/gapps/usr/srec/en-US/endpointer_voicesearch.config:system/usr/srec/en-US/endpointer_voicesearch.config \
    vendor/cm/prebuilt/common/gapps/usr/srec/en-US/ep_acoustic_model:system/usr/srec/en-US/ep_acoustic_model \
    vendor/cm/prebuilt/common/gapps/usr/srec/en-US/g2p_fst:system/usr/srec/en-US/g2p_fst \
    vendor/cm/prebuilt/common/gapps/usr/srec/en-US/grammar.config:system/usr/srec/en-US/grammar.config \
    vendor/cm/prebuilt/common/gapps/usr/srec/en-US/hclg_shotword:system/usr/srec/en-US/hclg_shotword \
    vendor/cm/prebuilt/common/gapps/usr/srec/en-US/hmm_symbols:system/usr/srec/en-US/hmm_symbols \
    vendor/cm/prebuilt/common/gapps/usr/srec/en-US/hmmlist:system/usr/srec/en-US/hmmlist \
    vendor/cm/prebuilt/common/gapps/usr/srec/en-US/hotword.config:system/usr/srec/en-US/hotword.config \
    vendor/cm/prebuilt/common/gapps/usr/srec/en-US/hotword_classifier:system/usr/srec/en-US/hotword_classifier \
    vendor/cm/prebuilt/common/gapps/usr/srec/en-US/hotword_normalizer:system/usr/srec/en-US/hotword_normalizer \
    vendor/cm/prebuilt/common/gapps/usr/srec/en-US/hotword_prompt.txt:system/usr/srec/en-US/hotword_prompt.txt \
    vendor/cm/prebuilt/common/gapps/usr/srec/en-US/hotword_word_symbols:system/usr/srec/en-US/hotword_word_symbols \
    vendor/cm/prebuilt/common/gapps/usr/srec/en-US/metadata:system/usr/srec/en-US/metadata \
    vendor/cm/prebuilt/common/gapps/usr/srec/en-US/norm_fst:system/usr/srec/en-US/norm_fst \
    vendor/cm/prebuilt/common/gapps/usr/srec/en-US/normalizer:system/usr/srec/en-US/normalizer \
    vendor/cm/prebuilt/common/gapps/usr/srec/en-US/offensive_word_normalizer:system/usr/srec/en-US/offensive_word_normalizer \
    vendor/cm/prebuilt/common/gapps/usr/srec/en-US/phone_state_map:system/usr/srec/en-US/phone_state_map \
    vendor/cm/prebuilt/common/gapps/usr/srec/en-US/phonelist:system/usr/srec/en-US/phonelist \
    vendor/cm/prebuilt/common/gapps/usr/srec/en-US/rescoring_lm:system/usr/srec/en-US/rescoring_lm \
    vendor/cm/prebuilt/common/gapps/usr/srec/en-US/wordlist:system/usr/srec/en-US/wordlist
