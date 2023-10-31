@REM Build Windows package from tracktable source

:: MSVC is preferred.
set CC=cl.exe
set CXX=cl.exe

set HERE=%CD%
mkdir build
mkdir install

if errorlevel 1 exit 1
cd build
if errorlevel 1 exit 1
cmake^
  -G"Ninja"^
  -DBOOST_ROOT:PATH=%BUILD_PREFIX%^
  -DCMAKE_INSTALL_PREFIX:PATH=%HERE%\install^
  -DCMAKE_BUILD_TYPE="Release"^
  -DBUILD_DOCUMENTATION=OFF^
  -DPython3_EXECUTABLE:FILEPATH=%PYTHON%^
  -DPython3_ROOT_DIR:PATH=%PREFIX%^
  -DBUILD_TESTING=OFF^
  -DBUILD_EXAMPLES=OFF^
 %SRC_DIR%
if errorlevel 1 exit 1
ninja -j%CPU_COUNT%
if errorlevel 1 exit 1
ninja install
if errorlevel 1 exit 1
cd %HERE%\install
if errorlevel 1 exit 1
%PYTHON% -m pip install --no-deps .
if errorlevel 1 exit 1
