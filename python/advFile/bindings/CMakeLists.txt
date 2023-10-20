# Copyright 2020 Free Software Foundation, Inc.
#
# This file is part of GNU Radio
#
# SPDX-License-Identifier: GPL-3.0-or-later
#

########################################################################
# Check if there is C++ code at all
########################################################################
if(NOT advFile_sources)
    MESSAGE(STATUS "No C++ sources... skipping python bindings")
    return()
endif(NOT advFile_sources)

########################################################################
# Check for pygccxml
########################################################################
GR_PYTHON_CHECK_MODULE_RAW(
    "pygccxml"
    "import pygccxml"
    PYGCCXML_FOUND
    )

include(GrPybind)

########################################################################
# Python Bindings
########################################################################

list(APPEND advFile_python_files
    python_bindings.cc)

GR_PYBIND_MAKE_OOT(advFile
   ../../..
   gr::advFile
   "${advFile_python_files}")

# copy bindings extension for use in QA test module
add_custom_command(TARGET advFile_python POST_BUILD
    COMMAND ${CMAKE_COMMAND} -E copy $<TARGET_FILE:advFile_python>
    ${PROJECT_BINARY_DIR}/test_modules/gnuradio/advFile/
)

install(TARGETS advFile_python DESTINATION ${GR_PYTHON_DIR}/gnuradio/advFile COMPONENT pythonapi)
