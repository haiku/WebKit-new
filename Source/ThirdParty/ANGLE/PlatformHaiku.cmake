# Allow building ANGLE on platforms that don't provide X11 headers.
list(APPEND ANGLE_DEFINITIONS USE_SYSTEM_EGL)

list(APPEND ANGLE_SOURCES
    ${angle_system_utils_sources_posix}
    src/common/system_utils_haiku.cpp
)

list(APPEND ANGLE_DEFINITIONS
    ANGLE_ENABLE_OPENGL
)

list(APPEND ANGLEGLESv2_LIBRARIES
    z
)
