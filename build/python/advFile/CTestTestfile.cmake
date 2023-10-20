# CMake generated Testfile for 
# Source directory: /home/roland23/gr-advFile/python/advFile
# Build directory: /home/roland23/gr-advFile/build/python/advFile
# 
# This file includes the relevant testing commands required for 
# testing this directory and lists subdirectories to be tested as well.
add_test(qa_customFileSink "/usr/bin/sh" "qa_customFileSink_test.sh")
set_tests_properties(qa_customFileSink PROPERTIES  _BACKTRACE_TRIPLES "/usr/lib/x86_64-linux-gnu/cmake/gnuradio/GrTest.cmake;119;add_test;/home/roland23/gr-advFile/python/advFile/CMakeLists.txt;42;GR_ADD_TEST;/home/roland23/gr-advFile/python/advFile/CMakeLists.txt;0;")
subdirs("bindings")
