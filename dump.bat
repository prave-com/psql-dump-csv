@echo off
setlocal

:: Prompt for database connection details
set /p DB_NAME=Enter database name: 
set /p DB_USER=Enter username: 
set /p DB_PASS=Enter password: 
set /p DB_HOST=Enter host (default is localhost): 
set /p DB_PORT=Enter port (default is 5432): 
set /p SSL_MODE=Enter SSL mode (default is prefer) [options: disable, require, verify-ca, verify-full]: 

:: Use default values if not provided
if "%DB_HOST%"=="" set DB_HOST=localhost
if "%DB_PORT%"=="" set DB_PORT=5432
if "%SSL_MODE%"=="" set SSL_MODE=prefer

:: Set environment variable for SSL mode
set PGSSLMODE=%SSL_MODE%

:: Set environment variable for password
set PGPASSWORD=%DB_PASS%

:: Set output directory to current directory
set OUTPUT_DIR=%cd%

:: Display SSL mode
echo Using SSL mode: %SSL_MODE%

:: Fetch the list of tables
echo Getting list of tables...
for /f "tokens=*" %%A in ('psql -U %DB_USER% -d %DB_NAME% -h %DB_HOST% -p %DB_PORT% -t -c "SELECT tablename FROM pg_tables WHERE schemaname = 'public';"') do (
    set "TABLE=%%A"
    call :export_table
)

echo All tables have been exported to CSV files.
goto :eof

:export_table
:: Trim leading/trailing whitespace from table name
set "TABLE=%TABLE:~0,255%"
if "%TABLE%" neq "" (
    echo Exporting table %TABLE%...
    psql -U %DB_USER% -d %DB_NAME% -h %DB_HOST% -p %DB_PORT% -c "\COPY ""%TABLE%"" TO %OUTPUT_DIR%\%DB_NAME%_%TABLE%.csv CSV HEADER;"
)
goto :eof
