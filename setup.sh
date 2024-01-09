#!/usr/bin/bash

# Update git submodules
git submodule update --init --recursive

# Constants
CLIENT_ENV_FILE="fishingcom-client/.env"
SERVER_ENV_FILE="fishingcom-server/.env"
CLIENT_ENV_CONTENT="VUE_APP_SECRET_KEY="
SERVER_ENV_COMMON="SERVER_HOST=localhost\nSERVER_PORT=8585\nAPP_NAME=fishingcom-server\nCLIENT_INDEX_PATH=/home/mauro/dev/fishingcom/client/dist\nMODE="
SERVER_ENV_DEV="SERVER_HOST="http://localhost"
SERVER_PORT=8585

APP_NAME="fishingcom"
CLIENT_INDEX_PATH="/home/mauro/dev/fishingcom/client/dist"

MODE="dev"

MDB_URI=
MDB_DATABASE=


SESSION_DURATION="36000"
JWT_AUDIENCE="localhost"

#CORS
ALLOWED_HOSTS=["*"]
METHODS= ["*"]
ALLOWED_HEADERS= ["*"]
EXPOSED_HEADERS= ["*"]
CREDENTIALS=true
MAXAGE=86400


#AUTH
SECRET_KEY=
OTP_EXPIRATION=1000*60*10
OTP_DIGITS=8


GOOGLE_MAPS_API_KEY="

SERVER_ENV_DEV="SERVER_HOST="http://localhost"
SERVER_PORT=8585

APP_NAME="fishingcom"
CLIENT_INDEX_PATH="/home/mauro/dev/fishingcom/client/dist"
MODE="prod"

MDB_URI= // ***!!! SETUP THIS !!!***
MDB_DATABASE= // ***!!! SETUP THIS !!!***


SESSION_DURATION="36000"
JWT_AUDIENCE="localhost"

#CORS
ALLOWED_HOSTS= // ***!!! SETUP THIS !!!***
METHODS= // ***!!! SETUP THIS !!!***
ALLOWED_HEADERS= // ***!!! SETUP THIS !!!***
EXPOSED_HEADERS= // ***!!! SETUP THIS !!!***
CREDENTIALS=true // ??? SETUP THIS ???
MAXAGE=86400 // ??? SETUP THIS ???


#AUTH
SECRET_KEY=// ***!!! SETUP THIS !!!***
OTP_EXPIRATION=1000*60*10 // ??? SETUP THIS ???
OTP_DIGITS=8 // ??? SETUP THIS ???


GOOGLE_MAPS_API_KEY= // ??? SETUP THIS ??? "

# Function to display help message
display_help() {
    echo "Usage: $0 --mode [dev|prod] [options]"
    echo "Options:"
    echo "  --help     Display this help message"
}

# Function to create environment file
create_env_file() {
    local file="$1"
    local content="$2"
    if [ ! -e "$file" ]; then
        echo -e "$content" > "$file"
        echo "Created $file with content."
    else
        echo "The file $file already exists. Not replaced."
    fi
}

# Main script logic
if [ $# -eq 0 ]; then
    echo "No arguments provided."
    display_help
    exit 1
fi

mode=""

while [[ "$#" -gt 0 ]]; do
    case "$1" in
        --mode)
            if [[ "$2" == "dev" || "$2" == "prod" ]]; then
                mode="$2"
            else
                echo "Invalid mode value. Use either 'dev' or 'prod'."
                display_help
                exit 1
            fi
            shift 2
            ;;
        --help)
            display_help
            exit 0
            ;;
        *) 
            echo "Unknown option: $1"
            display_help
            exit 1
            ;;
    esac
done

if [ -z "$mode" ]; then
    echo "Mode is required."
    display_help
    exit 1
fi

echo "Selected mode: $mode"

# Create client and server environment files
create_env_file "$CLIENT_ENV_FILE" "$CLIENT_ENV_CONTENT"

if [ "$mode" == "dev" ]; then
    create_env_file "$SERVER_ENV_FILE" "$SERVER_ENV_COMMON$SERVER_ENV_DEV"
elif [ "$mode" == "prod" ]; then
    create_env_file "$SERVER_ENV_FILE" "$SERVER_ENV_COMMON$SERVER_ENV_PROD"
fi

