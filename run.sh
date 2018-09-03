#!/bin/bash

#根目录
SHELL_FOLDER=$(cd "$(dirname "$0")";pwd)

# echo (dirname "$0")
# echo `dirname $SHELL_FOLDER`
#不够准确，最好获取项目名

ROOT_NAME="${SHELL_FOLDER##*/}"
echo ${ROOT_NAME}
# PATH_P=${SHELL_FOLDER}'/simulator/mac/'${ROOT_NAME}'-desktop.app/Contents/Resources'



# RES=${PATH_P}'/res'
# SRC=${PATH_P}'/src'

# # SOURCE="${BASH_SOURCE[0]}"
# # while [ -h "$SOURCE" ];
# # do 
# #       DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
# #       SOURCE="$(readlink "$SOURCE")"
# #       [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE"  
# # done
# # DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"#软链接

# if [ -d $RES ]; then
#     # chmod 777 ${ROOT_PATH}'/res'
#     rm -rf $RES
# fi

# if [ -d $SRC ]; then
#     # chmod 777 ${ROOT_PATH}'/src'
#     rm -rf $SRC
# fi




# ln -s  ${SHELL_FOLDER}'/res' $PATH_P
# ln -s  ${SHELL_FOLDER}'/src' $PATH_P

# # ./runtime/mac/ccs-desktop.app/Contents/MacOS/ccs-desktop
./simulator/mac/${ROOT_NAME}-desktop.app/Contents/MacOS/${ROOT_NAME}-desktop
