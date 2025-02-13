include(Headers.cmake)

file(MAKE_DIRECTORY ${DERIVED_SOURCES_HAIKU_API_DIR})

configure_file(UIProcess/API/haiku/WebKitVersion.h.in ${DERIVED_SOURCES_HAIKU_API_DIR}/WebKitVersion.h)

list(APPEND WebKit_SOURCES
    NetworkProcess/cache/NetworkCacheDataHaiku.cpp
    NetworkProcess/cache/NetworkCacheIOChannelHaiku.cpp
    NetworkProcess/haiku/NetworkProcessHaiku.cpp
    NetworkProcess/haiku/NetworkProcessMainHaiku.cpp

    Platform/IPC/unix/AttachmentUnix.cpp
    Platform/IPC/unix/ConnectionUnix.cpp
    Platform/haiku/LoggingHaiku.cpp
    Platform/haiku/ModuleHaiku.cpp
    Platform/unix/SharedMemoryUnix.cpp

    Shared/WebCoreArgumentCoders.cpp
    Shared/haiku/AuxiliaryProcessMainHaiku.cpp
    Shared/haiku/ProcessExecutablePathHaiku.cpp
    Shared/haiku/WebCoreArgumentCodersHaiku.cpp
    Shared/haiku/WebMemorySamplerHaiku.cpp

    UIProcess/API/haiku/APIWebsiteDataStoreHaiku.cpp
    UIProcess/DefaultUndoController.cpp
    UIProcess/Launcher/haiku/ProcessLauncherHaiku.cpp
    UIProcess/LegacySessionStateCodingNone.cpp
    UIProcess/WebsiteData/haiku/WebsiteDataStoreHaiku.cpp
    UIProcess/haiku/TextCheckerHaiku.cpp
    UIProcess/haiku/WebInspectorProxyHaiku.cpp
    UIProcess/haiku/WebPageProxyHaiku.cpp
    UIProcess/haiku/WebProcessPoolHaiku.cpp

    WebProcess/Cookies/haiku/WebCookieManagerHaiku.cpp
    WebProcess/InjectedBundle/haiku/InjectedBundleHaiku.cpp
    WebProcess/InjectedBundle/haiku/InjectedBundleHaiku.cpp
    WebProcess/WebCoreSupport/haiku/WebFrameNetworkingContext.cpp
    WebProcess/WebPage/AcceleratedDrawingArea.cpp
    WebProcess/WebPage/CoordinatedGraphics/CoordinatedLayerTreeHost.cpp
    WebProcess/WebPage/DrawingAreaImpl.cpp
    WebProcess/WebPage/LayerTreeHost.cpp
    WebProcess/WebPage/haiku/WebInspectorHaiku.cpp
    WebProcess/WebPage/haiku/WebPageHaiku.cpp
    WebProcess/haiku/WebProcessHaiku.cpp
    WebProcess/haiku/WebProcessMainHaiku.cpp
)

list(APPEND WebKit_INCLUDE_DIRECTORIES
    "${DERIVED_SOURCES_HAIKU_API_DIR}"
    "${WEBKIT_DIR}/NetworkProcess/unix"
    "${WEBKIT_DIR}/Platform"
    "${WEBKIT_DIR}/Platform/IPC/unix"
    "${WEBKIT_DIR}/Shared/API/c/haiku"
    "${WEBKIT_DIR}/Shared/CoordinatedGraphics"
    "${WEBKIT_DIR}/Shared/unix"
    "${WEBKIT_DIR}/Shared/haiku"
    "${WEBKIT_DIR}/UIProcess/API/C/CoordinatedGraphics"
    "${WEBKIT_DIR}/UIProcess/API/C/haiku"
    "${WEBKIT_DIR}/UIProcess/API/haiku"
    "${WEBKIT_DIR}/UIProcess/haiku"
    "${WEBKIT_DIR}/UIProcess/CoordinatedGraphics"
    "${WEBKIT_DIR}/WebProcess/unix"
    "${WEBKIT_DIR}/WebProcess/WebCoreSupport/haiku"
    "${WEBKIT_DIR}/WebProcess/WebPage/CoordinatedGraphics"
    ${LIBXML2_INCLUDE_DIR}
    ${LIBXSLT_INCLUDE_DIRS}
    ${SQLITE_INCLUDE_DIRS}
    ${WTF_DIR}
    "${DERIVED_SOURCES_WEBCORE_DIR}"
)

list(APPEND WebKit_LIBRARIES
    ${CMAKE_DL_LIBS}
    ${FONTCONFIG_LIBRARIES}
    ${FREETYPE2_LIBRARIES}
    ${JPEG_LIBRARIES}
    ${LIBXML2_LIBRARIES}
    ${OPENGL_LIBRARIES}
    ${PNG_LIBRARIES}
    ${SQLITE_LIBRARIES}
)

list(APPEND WebProcess_SOURCES
    WebProcess/EntryPoint/unix/WebProcessMain.cpp
)

list(APPEND NetworkProcess_SOURCES
    NetworkProcess/EntryPoint/unix/NetworkProcessMain.cpp
)

list(APPEND WebProcess_LIBRARIES
    ${LIBXML2_LIBRARIES}
    ${LIBXSLT_LIBRARIES}
    ${OPENGL_LIBRARIES}
    ${SQLITE_LIBRARIES}
)

add_custom_target(forwarding-headerHaiku
    COMMAND ${PERL_EXECUTABLE} ${WEBKIT_DIR}/Scripts/generate-forwarding-headers.pl ${WEBKIT_DIR} ${DERIVED_SOURCES_WEBKIT_DIR}/include haiku
    COMMAND ${PERL_EXECUTABLE} ${WEBKIT_DIR}/Scripts/generate-forwarding-headers.pl ${WEBKIT_DIR} ${DERIVED_SOURCES_WEBKIT_DIR}/include CoordinatedGraphics
)

set(WEBKIT_EXTRA_DEPENDENCIES
    forwarding-headerHaiku
)

add_definitions(
    -DLIBEXECDIR=\"${EXEC_INSTALL_DIR}\"
    -DWEBPROCESSNAME=\"WebProcess\"
    -DPLUGINPROCESSNAME=\"PluginProcess\"
    -DNETWORKPROCESSNAME=\"NetworkProcess\"
)

set(WebKit_FORWARDING_HEADERS_DIRECTORIES
   Shared/API/c
   Shared/API/c/haiku
   UIProcess/API/C
   Platform/IPC/unix
   WebProcess/InjectedBundle/API/c
)

list(APPEND WebKit_PUBLIC_FRAMEWORK_HEADERS
    Shared/API/c/haiku/WKBaseHaiku.h
)

