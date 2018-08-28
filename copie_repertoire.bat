@echo off 

SET TIMESTAMP=%DATE:~6,4%%DATE:~3,2%%DATE:~0,2%
SET FIC_LISTE=C:\copy.txt
SET FIC_LOG=C:\copy.%TIMESTAMP%.log
SET FIC_LOG2=C:\copy.%TIMESTAMP%.txt
SET /A CR=0
SET /A CR_C=0
SET /A NB=0
SET /A NBRE=0


goto :fn_main


:fn_copy

REM a changer par le repertoire en question source et destination
xcopy C:\temp\* \\%1\C$\%1 /e /i


set CR_C=%ERRORLEVEL%
IF %CR_C% EQU 0 (
	echo serveur %1 OK >> %FIC_LOG2%
	SET /A NBRE=%NBRE%+1
	) ELSE (
	echo ---serveur %1 KO >> %FIC_LOG2%
	SET /A CR=%CR%+%CR_C%
	)
goto :eof


REM Fonction de comptage du nombre de fichier present
:fn_compte
SET /A NB=%NB%+1
echo serveur %NB% : %1 >> %FIC_LOG2%
echo serveur %NB% : %1 >> %FIC_LOG%
call :fn_copy %1 >> %FIC_LOG%
goto :eof


:fn_main
FOR /F %%A in ( 'type %FIC_LISTE%' ) DO call :fn_compte %%A
echo Il y a %NB% serveur dans le fichier %FIC_LISTE% >> %FIC_LOG2%
echo %NBRE% / %NB% Serveurs OK >> %FIC_LOG2%


:fin
echo exit %CR% >> %FIC_LOG2%
rem exit %CR%
pause