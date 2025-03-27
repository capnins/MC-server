@echo off

REM ���java.sii�ļ��Ƿ����
if exist java.sii (
    REM ��ȡjava.sii�ļ��е�jar�ļ���
    set JAR_FILE=
    for /f "tokens=2 delims==" %%i in ('findstr "jar" java.sii 2^>nul') do set JAR_FILE=%%i
    set JAR_FILE=%JAR_FILE: =%

    REM ��ʾ�Ѵ��ڵ�jar�ļ���
    if "%JAR_FILE%"=="" (
        echo ��ǰjava.sii�ļ�������Ч��Ϊ�ա�
    ) else (
        echo ��ǰjava.sii�ļ��е�jar�ļ�Ϊ: %JAR_FILE%
    )

    REM ѯ���û��Ƿ���ԭ�ļ�
    choice /m "�Ƿ���ԭ�ļ� (Y) ��ɾ���������µ��ļ� (N)��"
    if errorlevel 2 (
        REM �û�ѡ��ɾ���������µ��ļ�
        goto list_jars
    ) else (
        REM �û�ѡ����ԭ�ļ�
        echo �ѱ���ԭjava.sii�ļ���
        pause
        exit /b 0
    )
) else (
    REM �ļ������ڣ�ֱ���г�jar�ļ�
    goto list_jars
)

:list_jars
REM ���ҵ�ǰĿ¼�µ�����jar�ļ�
setlocal enabledelayedexpansion
set COUNT=0
echo ��ǰĿ¼�µ�jar�ļ��б�
for %%f in (*.jar) do (
    set /a COUNT+=1
    echo !COUNT!. %%f
    set JAR_!COUNT!=%%f
)

REM ����Ƿ��ҵ�jar�ļ�
if %COUNT%==0 (
    echo δ�ҵ��κ�jar�ļ���
    pause
    exit /b 1
)

REM ��ʾ�û�ѡ��jar�ļ�
:select_jar
set /p CHOICE=��ѡ��Ҫʹ�õ�jar�ļ���ţ�1-%COUNT%���� 
if "%CHOICE%"=="" goto select_jar
if %CHOICE% lss 1 goto select_jar
if %CHOICE% gtr %COUNT% goto select_jar

REM ��ȡ�û�ѡ���jar�ļ���
for /f "tokens=1,2 delims==" %%i in ('set JAR_') do (
    if %%i==JAR_%CHOICE% set SELECTED_JAR=%%j
)

REM �����µ�java.sii�ļ�
echo jar = %SELECTED_JAR% > java.sii
echo �������µ�java.sii�ļ�������Ϊ: jar = %SELECTED_JAR%
call start.bat