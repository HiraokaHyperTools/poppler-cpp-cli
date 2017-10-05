# CMake build for poppler-cpp-cli

cmake_minimum_required(VERSION 3.9.4)

set(TOP_DIR ${CMAKE_SOURCE_DIR})

set(Flags "${Flags} -DZLIB_INCLUDE_DIR=${TOP_DIR}/zlib;${TOP_DIR}/zlib/build")
set(Flags "${Flags} -DZLIB_LIBRARY_DEBUG=${TOP_DIR}/zlib/build/Debug/zlibstaticd.lib")
set(Flags "${Flags} -DZLIB_LIBRARY_RELEASE=${TOP_DIR}/zlib/build/Release/zlibstatic.lib")
set(Flags "${Flags} -DZLIB_LIBRARY=${TOP_DIR}/zlib/build/Release/zlibstatic.lib")
set(Flags "${Flags} -DJPEG_INCLUDE_DIR=${TOP_DIR}/libjpeg/build/include")
set(Flags "${Flags} -DJPEG_LIBRARY=${TOP_DIR}/libjpeg/build/Release/jpeg.lib")
set(Flags "${Flags} -DFREETYPE_LIBRARY=")
set(Flags "${Flags} -DFREETYPE_INCLUDE_DIRS=")
set(Flags4Lib "${Flags} -DBUILD_SHARED_LIBS=OFF")

macro(cmakeb NAME FLAGS)
  message(STATUS "CMAKE: ${NAME} = ${CMAKE_COMMAND} ${FLAGS} ..")
  file(MAKE_DIRECTORY ${CMAKE_SOURCE_DIR}/${NAME}/build)
  execute_process(
    COMMAND ${CMAKE_COMMAND} ${FLAGS} ..
    WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}/${NAME}/build
    )
endmacro()

# Process subdirectories
#cmakeb(freetype2 "${Flags4Lib}")
#cmakeb(zlib "${Flags4Lib}")
#cmakeb(libjpeg "${Flags4Lib}")
cmakeb(libtiff "${Flags4Lib}")
#cmakeb(poppler ${Flags})
