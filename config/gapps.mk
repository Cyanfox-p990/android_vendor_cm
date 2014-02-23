# app
PRODUCT_COPY_FILES += \
    vendor/cm/prebuilt/common/gapps/app/GoogleLatinIme.apk:system/app/GoogleLatinIme.apk \
    vendor/cm/prebuilt/common/gapps/app/Hangouts.apk:system/app/Hangouts.apk \
    vendor/cm/prebuilt/common/gapps/app/CalendarGoogle.apk:system/app/CalendarGoogle.apk \
    vendor/cm/prebuilt/common/gapps/app/Chrome.apk:system/app/Chrome.apk \
    vendor/cm/prebuilt/common/gapps/app/SlidingExplorer.apk:system/app/SlidingExplorer.apk \
    vendor/cm/prebuilt/common/gapps/app/ChromeBookmarksSyncAdapter.apk:system/app/ChromeBookmarksSyncAdapter.apk

# priv-app
PRODUCT_COPY_FILES += \
    vendor/cm/prebuilt/common/gapps/priv-app/CalendarProvider.apk:system/priv-app/CalendarProvider.apk

# lib
PRODUCT_COPY_FILES += \
    vendor/cm/prebuilt/common/gapps/lib/libvideochat_jni.so:system/lib/libvideochat_jni.so \
    vendor/cm/prebuilt/common/gapps/lib/libjni_unbundled_latinimegoogle.so:system/lib/libjni_unbundled_latinimegoogle.so \
    vendor/cm/prebuilt/common/gapps/lib/libvcdecoder_jni.so:system/lib/libvcdecoder_jni.so \
    vendor/cm/prebuilt/common/gapps/lib/libchromeview.so:system/lib/libchromeview.so \
    vendor/cm/prebuilt/common/gapps/lib/libjni_latinime.so:system/lib/libjni_latinime.so
