#
# Copyright 2020 the original author jacky.eastmoon
#
# All commad module need 3 method :
# [command]        : Command script
# [command]-args   : Command script options setting function
# [command]-help   : Command description
# Basically, CLI will not use "--options" to execute function, "--help, -h" is an exception.
# But, if need exception, it will need to thinking is common or individual, and need to change BREADCRUMB variable in [command]-args function.
#
# Ref : https://www.cyberciti.biz/faq/category/bash-shell/
# Ref : https://blog.longwin.com.tw/2017/04/bash-shell-script-get-self-file-name-2017/

# ------------------- shell setting -------------------

#!/bin/bash
set -e

# ------------------- declare CLI file variable -------------------

CLI_DIRECTORY=${PWD}
CLI_FILE=${BASH_SOURCE}
CLI_FILENAME=${BASH_SOURCE%.*}
CLI_FILEEXTENSION=${BASH_SOURCE##*.}

# ------------------- declare CLI variable -------------------

BREADCRUMB="cli"
COMMAND=""
COMMAND_BC_AGRS=()
COMMAND_AC_AGRS=()

# ------------------- declare variable -------------------

PROJECT_NAME=${PWD##*/}
PROJECT_ENV="dev"

# ------------------- declare function -------------------

# Command Parser
function main() {
    argv-parser ${@}
    for arg in ${COMMAND_BC_AGRS[@]}
    do
        IFS='=' read -ra ADDR <<< "${arg}"
        key=${ADDR[0]}
        value=${ADDR[1]}
        eval ${BREADCRUMB}-args ${key} ${value}
        main-args ${key} ${value}
    done
    # Execute command
    if [ ! -z ${COMMAND} ];
    then
        BREADCRUMB=${BREADCRUMB}-${COMMAND}
        main ${COMMAND_AC_AGRS[@]}
    else
        eval ${BREADCRUMB}
    fi
}

function main-args() {
    key=${1}
    value=${2}
    case ${key} in
        "--help")
            BREADCRUMB="${BREADCRUMB}-help"
            ;;
        "-h")
            BREADCRUMB="${BREADCRUMB}-help"
            ;;
    esac
}

function argv-parser() {
    COMMAND=""
    COMMAND_BC_AGRS=()
    COMMAND_AC_AGRS=()
    is_find_cmd=0
    for arg in ${@}
    do
        if [ ${is_find_cmd} -eq 0 ]
        then
            if [[ ${arg} =~ -+[a-zA-Z1-9]* ]]
            then
                COMMAND_BC_AGRS+=(${arg})
            else
              COMMAND=${arg}
              is_find_cmd=1
            fi
        else
            COMMAND_AC_AGRS+=(${arg})
        fi
    done
}


# ------------------- Main mathod -------------------

function cli() {
    cli-help
}

function cli-args() {
    key=${1}
    value=${2}
    case ${key} in
        "--prod")
            PROJECT_ENV="prod"
            ;;
    esac
}

function cli-help() {
    echo "This is a docker control script with project ${PROJECT_NAME}"
    echo "If not input any command, at default will show HELP"
    echo "Options:"
    echo "    --help, -h        Show more information with CLI."
    echo "    --prod            Setting project environment with "prod", default is "dev""
    echo ""
    echo "Command:"
    echo "    demo              Execute demo code."
    echo ""
    echo "Run 'cli [COMMAND] --help' for more information on a command."
}

# ------------------- Command "demo" mathod -------------------

function cli-demo {
    echo "> Execute Demo code ${DEMO_DIRECTORY}"
    if [ -d ${CLI_DIRECTORY}/demo/${DEMO_DIRECTORY} ]
    then
        cd ${CLI_DIRECTORY}/demo/${DEMO_DIRECTORY}
        c++ -std=c++11 -lpthread main.cpp -o ${CLI_DIRECTORY}/build/${DEMO_DIRECTORY}
        source test.sh | ${CLI_DIRECTORY}/build/${DEMO_DIRECTORY}
        cd ${CLI_DIRECTORY}
    fi
}

function cli-demo-args {
    key=${1}
    value=${2}
    case ${key} in
        "-t")
            DEMO_DIRECTORY=${value}
            ;;
    esac
    return 0
}

function cli-demo-help {
    echo "This is a Command Line Interface with project ${PROJECT_NAME}"
    echo "Execute demo directory main.cpp and assignment come from test.sh"
    echo ""
    echo "Options:"
    echo "    -d                Assign target directory."
    echo "    --help, -h        Show more information with UP Command."
}



# ------------------- execute script -------------------

main ${@}
