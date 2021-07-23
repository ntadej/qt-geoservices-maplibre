TARGET = qtgeoservices_maplibre

QT += \
    quick-private \
    location-private \
    positioning-private \
    network \
    sql \
    sql-private

HEADERS += \
    src/qgeoserviceproviderpluginmaplibre.h \
    src/qgeomappingmanagerenginemapboxgl.h \
    src/qgeomapmapboxgl.h \
    src/qgeomapmapboxgl_p.h \
    src/qmapboxglstylechange_p.h \
    src/qsgmapboxglnode.h

SOURCES += \
    src/qgeoserviceproviderpluginmaplibre.cpp \
    src/qgeomappingmanagerenginemapboxgl.cpp \
    src/qgeomapmapboxgl.cpp \
    src/qmapboxglstylechange.cpp \
    src/qsgmapboxglnode.cpp

# Mapbox GL Native is always a static
# library linked to this plugin
QMAKE_CXXFLAGS += \
    -DQT_MAPBOXGL_STATIC

RESOURCES += resources/maplibre.qrc

OTHER_FILES += \
    maplibre_plugin.json

include(zlib_dependency.pri)

load(qt_build_paths)

message("MapLibre-GL path: $$MBGL_PATH")

INCLUDEPATH += $$MBGL_PATH/include
LIBS += -L$$MBGL_PATH/lib \
    -lQMapboxGL$$qtPlatformTargetSuffix() \
    -lmbgl-core$$qtPlatformTargetSuffix() \
    -lmbgl-vendor-nunicode$$qtPlatformTargetSuffix() \
    -lmbgl-vendor-parsedate$$qtPlatformTargetSuffix() \
    -lmbgl-vendor-csscolorparser$$qtPlatformTargetSuffix()

qtConfig(icu) {
    QMAKE_USE_PRIVATE += icu
}

PLUGIN_TYPE = geoservices
PLUGIN_CLASS_NAME = QGeoServiceProviderFactoryMapLibre
load(qt_plugin)
