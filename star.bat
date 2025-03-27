@echo off

:start

REM 检查java.sii文件是否存在
if not exist java.sii (
    echo java.sii文件不存在，正在运行find.bat...
    call find.bat
    goto start
)

::=======================================



REM 读取java.sii文件中的jar文件名
for /f "tokens=2 delims==" %%i in ('findstr "jar" java.sii') do set JAR_FILE=%%i

REM 去除可能的空格
set JAR_FILE=%JAR_FILE: =%

REM 检查是否成功读取到jar文件名
if "%JAR_FILE%"=="" (
    echo 无法从java.sii文件中读取jar文件名。
    call find.bat
    exit /b 1
)

REM 执行java命令
java -Xmx2g -Xms2g -jar %JAR_FILE%

pause