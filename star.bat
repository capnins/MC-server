@echo off

:start

REM ���java.sii�ļ��Ƿ����
if not exist java.sii (
    echo java.sii�ļ������ڣ���������find.bat...
    call find.bat
    goto start
)

::=======================================



REM ��ȡjava.sii�ļ��е�jar�ļ���
for /f "tokens=2 delims==" %%i in ('findstr "jar" java.sii') do set JAR_FILE=%%i

REM ȥ�����ܵĿո�
set JAR_FILE=%JAR_FILE: =%

REM ����Ƿ�ɹ���ȡ��jar�ļ���
if "%JAR_FILE%"=="" (
    echo �޷���java.sii�ļ��ж�ȡjar�ļ�����
    call find.bat
    exit /b 1
)

REM ִ��java����
java -Xmx2g -Xms2g -jar %JAR_FILE%

pause