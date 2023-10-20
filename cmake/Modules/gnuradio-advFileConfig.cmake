find_package(PkgConfig)

PKG_CHECK_MODULES(PC_GR_ADVFILE gnuradio-advFile)

FIND_PATH(
    GR_ADVFILE_INCLUDE_DIRS
    NAMES gnuradio/advFile/api.h
    HINTS $ENV{ADVFILE_DIR}/include
        ${PC_ADVFILE_INCLUDEDIR}
    PATHS ${CMAKE_INSTALL_PREFIX}/include
          /usr/local/include
          /usr/include
)

FIND_LIBRARY(
    GR_ADVFILE_LIBRARIES
    NAMES gnuradio-advFile
    HINTS $ENV{ADVFILE_DIR}/lib
        ${PC_ADVFILE_LIBDIR}
    PATHS ${CMAKE_INSTALL_PREFIX}/lib
          ${CMAKE_INSTALL_PREFIX}/lib64
          /usr/local/lib
          /usr/local/lib64
          /usr/lib
          /usr/lib64
          )

include("${CMAKE_CURRENT_LIST_DIR}/gnuradio-advFileTarget.cmake")

INCLUDE(FindPackageHandleStandardArgs)
FIND_PACKAGE_HANDLE_STANDARD_ARGS(GR_ADVFILE DEFAULT_MSG GR_ADVFILE_LIBRARIES GR_ADVFILE_INCLUDE_DIRS)
MARK_AS_ADVANCED(GR_ADVFILE_LIBRARIES GR_ADVFILE_INCLUDE_DIRS)
