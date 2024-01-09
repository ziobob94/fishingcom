@echo off
setlocal

:: Update git submodules
git submodule update --init --recursive

:: Constants
set CLIENT_ENV_FILE=fishingcom-client\.env
set SERVER_ENV_FILE=fishingcom-server\.env
set CLIENT_ENV_CONTENT=VUE_APP_SECRET_KEY=
set SERVER_ENV_COMMON=SERVER_HOST=localhost\nSERVER_PORT=8585\nAPP_NAME=fishingcom-server\nCLIENT_INDEX_PATH=C:\path\to\your\fishingcom\client\dist\nMODE=
set SERVER_ENV_PROD=MDB_URI=\nMDB_DATABASE=\nSESSION_DURATION=36000\nJWT_AUDIENCE=localhost\nALLOWED_HOSTS= // !!! WARNING !!!\nMETHODS= // !!! WARNING !!!\nALLOWED_HEADERS= // !!! WARNING !!!\nEXPOSED_HEADERS= // !!! WARNING !!!\nCREDENTIALS= // !!! WARNING !!!\nMAXAGE= // !!! WARNING !!!\nSECRET_KEY=\nOTP_EXPIRATION=1000*60*10\nOTP_DIGITS=8\nGOOGLE_MAPS_API_KEY=
set SERVER_ENV_DEV=MDB_URI=\nMDB_DATABASE=\nSESSION_DURATION=36000\nJWT_AUDIENCE=localhost\nALLOWED_HOSTS=["*"]\nMETHODS=["*"]\nALLOWED_HEADERS=["*"]\nEXPOSED_HEADERS=["*"]\nCREDENTIALS=true\nMAXAGE=86400\nSECRET_KEY=\nOTP_EXPIRATION=1000*60*10\nOTP_DIGITS=8\nGOOGLE_MAPS_API_KEY=

:: Function to display help message
:display_help
echo Usage: %~n0 --mode [dev^|prod] [options]
echo Options:
echo   --help     Display this help message
goto :eof

:: Function to create environment file
:create_env_file
if not exist "%~1" (
    echo %~2 > "%~1"
    echo Created %~1 with content.
) else (
    echo The file %~1 already exists. Not replaced.
)
goto :eof

:: Main script logic
if "%~1"=="" (
    echo No arguments provided.
    call :display_help
    exit /b 1
)

set mode=
:parse_args
if "%~1"=="" goto :check_mode

if "%~1"=="--mode" (
    if "%~2"=="dev" (
        set mode=dev
    ) else if "%~2"=="prod" (
        set mode=prod
    ) else (
        echo Invalid mode value. Use either 'dev' or 'prod'.
        call :display_help
        exit /b 1
    )
    shift
    shift
    goto :parse_args
) else if "%~1"=="--help" (
    call :display_help
    exit /b 0
) else (
    echo Unknown option: %~1
    call :display_help
    exit /b 1
)

:check_mode
if "%mode%"=="" (
    echo Mode is required.
    call :display_help
    exit /b 1
)

echo Selected mode: %mode%

:: Create client and server environment files
call :create_env_file "%CLIENT_ENV_FILE%" "%CLIENT_ENV_CONTENT%"

if "%mode%"=="dev" (
    call :create_env_file "%SERVER_ENV_FILE%" "%SERVER_ENV_COMMON%%SERVER_ENV_DEV%"
) else if "%mode%"=="prod" (
    call :create_env_file "%SERVER_ENV_FILE%" "%SERVER_ENV_COMMON%%SERVER_ENV_PROD%"
)

endlocal
