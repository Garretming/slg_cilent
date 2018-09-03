#!/bin/bash



#运行脚本
run()
{	

	#关闭程序
	if [ -a "${TMP_PATH}kill_${1}.sh" ]; then
		echo "关闭程序："
		sh ${TMP_PATH}kill_${1}.sh
	fi
	#设置日志存储
	DATA_DAY=`date +%Y-%m-%d`
	DATA_SECOND=`date +%Y-%m-%d-%H-%M-%S`

	LOG_NAME="${LOG_PATH}${1}_${DATA_DAY}.log"

	# BACKUP_LOG_NAME="${LOG_PATH}${1}_${DATA_SECOND}_old.log"
	# echo "$LOG_NAME"
	#备份日志
	if [ -a "${LOG_NAME}" ]; then
		# mv ${LOG_NAME} ${BACKUP_LOG_NAME}
		rm -rf ${LOG_NAME}
	fi

	#后台启动
	nohup ${2} >> ${LOG_NAME} 2>&1 &
	



	# #生成关闭的程序
	echo "#!/bin/bash" > ${TMP_PATH}kill_${1}.sh
	echo "echo 'run: ${2}  pid: $!'" >> ${TMP_PATH}kill_${1}.sh	

	echo "kill -9 $!" >> ${TMP_PATH}kill_${1}.sh
	chmod 777 ${TMP_PATH}kill_${1}.sh

			#显示运行的程序
	echo "运行程序："
	echo "run:$2   pid:$!  log:${LOG_NAME} "
	# #打印启动错误
	sleep 3
	if [ -s "${LOG_NAME}" ]; then
		echo "启动日志："
		cat ${LOG_NAME}
	fi
	sleep 1
}

echo "  >>---------- 开始 ----------"
echo ""
echo "  >>----------编译生成模拟器 ---------"
echo ""
cocos run -p mac

# kill -9 $!

#根目录
SHELL_FOLDER=$(cd "$(dirname "$0")";pwd)
echo "项目根目录路径：$SHELL_FOLDER"
# echo (dirname "$0")
# echo `dirname $SHELL_FOLDER`
#不够准确，最好获取项目名

ROOT_NAME="${SHELL_FOLDER##*/}"

echo "项目名："${ROOT_NAME}
PATH_P=${SHELL_FOLDER}'/simulator/mac/'${ROOT_NAME}'-desktop.app/Contents/Resources'



RES=${PATH_P}'/res'
SRC=${PATH_P}'/src'

# SOURCE="${BASH_SOURCE[0]}"
# while [ -h "$SOURCE" ];
# do 
#       DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
#       SOURCE="$(readlink "$SOURCE")"
#       [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE"  
# done
# DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"#软链接

if [ -d $RES ]; then
    # chmod 777 ${ROOT_PATH}'/res'
    rm -rf $RES
fi

if [ -d $SRC ]; then
    # chmod 777 ${ROOT_PATH}'/src'
    rm -rf $SRC
fi


echo ""
echo "  >>----------软连接替换 ---------"
echo ""

ln -s  ${SHELL_FOLDER}'/res' $PATH_P
ln -s  ${SHELL_FOLDER}'/src' $PATH_P


echo ""
echo "  >>----------日志和关闭生成---------"
echo ""
#日志目录
LOG_PATH="./log/"
if [ ! -x "$LOG_PATH" ]; then
	mkdir "$LOG_PATH"
fi

#tmp目录
TMP_PATH="./tmp/"
if [ ! -x "$TMP_PATH" ]; then
	mkdir "$TMP_PATH"
fi


# # ./runtime/mac/ccs-desktop.app/Contents/MacOS/ccs-desktop

echo ""
echo "  >>---------- 执行 ---------"
echo ""
run a ./simulator/mac/${ROOT_NAME}-desktop.app/Contents/MacOS/${ROOT_NAME}-desktop

echo ""
echo "  >>---------- 结束 ----------"
