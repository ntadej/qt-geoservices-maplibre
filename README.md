# MapLibre GL Native Plugin for Qt Location Services

This is a community maintained [MapLibre GL Native](https://github.com/maplibre/maplibre-gl-native) plugin for Qt Location Services.

Only Qt 5.15 is supported for now. Qt 6 support depends on upstream mapping support.

Supported platforms:

- macOS
- Linux
- Windows (MSVC and MinGW)
- iOS
- Android

## Building maplibre-gl-native

A compatible version of `maplibre-gl-native` needs to be built as a static library before building this plugin. For convenience a submodule is provided under [dependencies/maplibre-gl-native](dependencies).

A minimal command is

```shell
cmake ../qt-geoservices-maplibre/dependencies/maplibre-gl-native/ \
  -G Ninja \
  -DMBGL_WITH_QT=ON \
  -DMBGL_QT_LIBRARY_ONLY=ON \
  -DMBGL_QT_STATIC=ON \
  -DMBGL_QT_WITH_INTERNAL_ICU=OFF \  # only on Linux
  -DMBGL_QT_WITH_INTERNAL_SQLITE=OFF \
  -DCMAKE_BUILD_TYPE=Release \
  -DCMAKE_INSTALL_PREFIX=../install-gl
```

which can be then built with

```shell
ninja
ninja install
```

For more details look at the individual CI pipelines.

### iOS Specific

iOS version is built directly by XCode so the following flags need to be passed

```shell
  -DCMAKE_TOOLCHAIN_FILE=../source/dependencies/maplibre-gl-native/platform/ios/platform/ios/toolchain.cmake \
  -G Xcode \
  -DPLATFORM=OS64COMBINED \
  -DDEPLOYMENT_TARGET=12.0 \
  -DENABLE_BITCODE=ON \
  -DMBGL_WITH_WERROR=OFF \
```

### Android Specific

Androd also requires some specific flags

```shell
  -DCMAKE_TOOLCHAIN_FILE="${ANDROID_NDK_ROOT}/build/cmake/android.toolchain.cmake" \
  -DANDROID_ABI="${ANDROID_ABI}" \
  -DANDROID_CCACHE=ccache \
  -DANDROID_NATIVE_API_LEVEL=21 \
```

## Building qt-geoservices-mapblibre

Run `qmake` passing the path to the `maplibre-gl-native` install location

```shell
qmake ../qt-geoservices-maplibre/ MBGL_PATH=../install-gl
```

Build and install with the following commands.
Note that the default installation location is the Qt location.

```shell
make
make install
```

## Copyright

Copyright (C) 2021 Tadej Novak
Copyright (C) 2017 The Qt Company Ltd.
Copyright (C) 2017 Mapbox, Inc.

This project follows the Qt project licensing as it derives the original code from there. See [LICENSE.GPL](LICENSE.GPL) and [LICENSE.LGPLv3](LICENSE.LGPLv3) for more details.
