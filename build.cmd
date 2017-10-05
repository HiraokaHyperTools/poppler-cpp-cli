@set TOP_DIR=%~dp0

@md    work

@set WHAT=zlib
@md    work\%WHAT% 2> NUL
@pushd work\%WHAT%
@cmake -DCMAKE_INSTALL_PREFIX=%TOP_DIR%\build -DBUILD_SHARED_LIBS=OFF ..\..\%WHAT%
@msbuild INSTALL.vcxproj /p:Configuration=Release
@popd

@set WHAT=freetype2
@md    work\%WHAT% 2> NUL
@pushd work\%WHAT%
@cmake -DCMAKE_INSTALL_PREFIX=%TOP_DIR%\build ..\..\%WHAT%
@msbuild INSTALL.vcxproj /p:Configuration=Release
@popd

@set WHAT=libjpeg
@md    work\%WHAT% 2> NUL
@pushd work\%WHAT%
@cmake -DCMAKE_INSTALL_PREFIX=%TOP_DIR%\build ..\..\%WHAT%
@msbuild INSTALL.vcxproj /p:Configuration=Release
@popd

@set WHAT=libtiff
@md    work\%WHAT% 2> NUL
@pushd work\%WHAT%
@cmake -DCMAKE_INSTALL_PREFIX=%TOP_DIR%\build -DBUILD_SHARED_LIBS=OFF ..\..\%WHAT%
@msbuild INSTALL.vcxproj /p:Configuration=Release
@popd

@set WHAT=poppler
@md    work\%WHAT% 2> NUL
@pushd work\%WHAT%
@cmake -DCMAKE_INSTALL_PREFIX=%TOP_DIR%\build ..\..\%WHAT%
@msbuild INSTALL.vcxproj /p:Configuration=Release
@popd

exit /b

@SET FLAGS=
@SET FLAGS=%FLAGS% "-DZLIB_INCLUDE_DIR=%TOP_DIR%\zlib;%TOP_DIR%\zlib\build"
@SET FLAGS=%FLAGS% "-DZLIB_LIBRARY_DEBUG=%TOP_DIR%\zlib\build\Debug\zlibstaticd.lib"
@SET FLAGS=%FLAGS% "-DZLIB_LIBRARY_RELEASE=%TOP_DIR%\zlib\build\Release\zlibstatic.lib"
@SET FLAGS=%FLAGS% "-DZLIB_LIBRARY=%TOP_DIR%\zlib\build\Release\zlibstatic.lib"
@SET FLAGS=%FLAGS% "-DJPEG_INCLUDE_DIR=%TOP_DIR%\libjpeg\build\include"
@SET FLAGS=%FLAGS% "-DJPEG_LIBRARY=%TOP_DIR%\libjpeg\build\Release\jpeg.lib"
@SET FLAGS=%FLAGS% "-DFREETYPE_LIBRARY=%TOP_DIR%\freetype2\build\Release\freetype.lib"
@SET FLAGS=%FLAGS% "-DFREETYPE_INCLUDE_DIRS=%TOP_DIR%\freetype2\build\include;%TOP_DIR%\freetype2\devel"
@SET FLAGS=%FLAGS% "-DTIFF_LIBRARY="
@SET FLAGS=%FLAGS% "-DTIFF_INCLUDE_DIR="
@SET FLAGS4LIB=%FLAGS% " -DBUILD_SHARED_LIBS=OFF"

@SET CMAKEFLAGS=%FLAGS4LIB%
@CALL :Builder zlib
@CALL :Builder libjpeg
@CALL :Builder libjpeg
@CALL :Builder libtiff
@SET CMAKEFLAGS=%FLAGS%
@CALL :Builder poppler
@EXIT /B

:Builder
@MKDIR %1\build 2> NUL
@PUSHD %1\build
cmake %CMAKEFLAGS% ..
@POPD
@EXIT /B
