@echo off

REM 检查java.sii文件是否存在
if exist java.sii (
    REM 读取java.sii文件中的jar文件名
    set JAR_FILE=
    for /f "tokens=2 delims==" %%i in ('findstr "jar" java.sii 2^>nul') do set JAR_FILE=%%i
    set JAR_FILE=%JAR_FILE: =%

    REM 显示已存在的jar文件名
    if "%JAR_FILE%"=="" (
        echo 当前java.sii文件内容无效或为空。
    ) else (
        echo 当前java.sii文件中的jar文件为: %JAR_FILE%
    )

    REM 询问用户是否保留原文件
    choice /m "是否保留原文件 (Y) 或删除后生成新的文件 (N)？"
    if errorlevel 2 (
        REM 用户选择删除并生成新的文件
        goto list_jars
    ) else (
        REM 用户选择保留原文件
        echo 已保留原java.sii文件。
        pause
        exit /b 0
    )
) else (
    REM 文件不存在，直接列出jar文件
    goto list_jars
)

:list_jars
REM 查找当前目录下的所有jar文件
setlocal enabledelayedexpansion
set COUNT=0
echo 当前目录下的jar文件列表：
for %%f in (*.jar) do (
    set /a COUNT+=1
    echo !COUNT!. %%f
    set JAR_!COUNT!=%%f
)

REM 检查是否找到jar文件
if %COUNT%==0 (
    echo 未找到任何jar文件。
    pause
    exit /b 1
)

REM 提示用户选择jar文件
:select_jar
set /p CHOICE=请选择要使用的jar文件编号（1-%COUNT%）： 
if "%CHOICE%"=="" goto select_jar
if %CHOICE% lss 1 goto select_jar
if %CHOICE% gtr %COUNT% goto select_jar

REM 获取用户选择的jar文件名
for /f "tokens=1,2 delims==" %%i in ('set JAR_') do (
    if %%i==JAR_%CHOICE% set SELECTED_JAR=%%j
)

REM 生成新的java.sii文件
echo jar = %SELECTED_JAR% > java.sii
echo 已生成新的java.sii文件，内容为: jar = %SELECTED_JAR%
call start.bat