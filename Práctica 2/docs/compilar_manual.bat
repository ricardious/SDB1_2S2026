@echo off
setlocal
pushd "%~dp0"
set "TECTONIC_CACHE_DIR=%~dp0..\.tools\tectonic\cache"
"%~dp0..\.tools\tectonic\tectonic.exe" "Manual.tex" --keep-logs
set "COMPILATION_EXIT_CODE=%errorlevel%"
popd
exit /b %COMPILATION_EXIT_CODE%
