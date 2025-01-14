#!/bin/bash
# 使用方法: ./4.import_history.sh <用户名> <密码> <Hive数据库名> <Oracle数据库IP>
# 示例: ./4.import_history.sh himszs himszs ods_himszs 192.168.7.217
# 功能: 将Oracle数据库中的表导入到Hive中，全库

# 参数定义
USERNAME=$1  
PASSWORD=$2
HIVE_DB=$3  # 将数据库名称作为参数
IP=$4 # Oracle数据库IP地址

# 连接字符串，提前定义以便复用
CONNECTION_STRING="jdbc:oracle:thin:@${IP}:1521:orcl"

# 获取数据库表的列结构并生成 Java 映射
TABLE_LIST=$(sqoop list-tables \
--connect $CONNECTION_STRING \
--username $USERNAME \
--password $PASSWORD | awk 'NR>2')


#如果导入某个表:
#TABLE_LIST="SUBJECT PAPER"

for TABLE in $TABLE_LIST; do
    echo "--------------$TABLE------------------"

    COLUMN_LIST=$(sqoop eval \
        --connect $CONNECTION_STRING \
        --username $USERNAME \
        --password $PASSWORD \
        --query "SELECT COLUMN_NAME FROM ALL_TAB_COLUMNS WHERE OWNER = UPPER('$USERNAME') AND TABLE_NAME = UPPER('$TABLE')" | \
        grep '|' | grep -v 'COLUMN_NAME' | grep -Eo '\|\s+[A-Z_]+\s+\|' | tr -d '|' | awk '{$1=$1; print}')

    # 生成 map-column-java 参数，将所有字段映射为 String
    MAP_COLUMN_JAVA=$(echo "$COLUMN_LIST" | awk '{printf "%s=String,", $1}')
    MAP_COLUMN_JAVA=${MAP_COLUMN_JAVA%,}  # 移除最后一个逗号

    # 打印 MAP_COLUMN_JAVA 以供调试
    echo "-----------MAP_COLUMN_JAVA-------- for $TABLE:"
    echo "$MAP_COLUMN_JAVA"
    echo "---------------------------------------------"

    #导入表并且命名
    #检查删除落地表名是否存在，存在就删除表名
    hive -e "USE $HIVE_DB; DROP TABLE IF EXISTS $TABLE";

    # Sqoop 导入单个表到 Hive，每个表单独处理字段映射
    echo "sqoop的命令为-------------------------"
    echo "sqoop的命令为-------------------------"

    sqoop_comand="sqoop import \
        --connect $CONNECTION_STRING \
        --username $USERNAME \
        --password $PASSWORD \
        --table $TABLE \
        --hive-import \
        --hive-overwrite \
        --create-hive-table \
        --hive-table $HIVE_DB.$TABLE \
        --map-column-hive $MAP_COLUMN_JAVA \
        --as-textfile \
        --num-mappers 1 \
        --fields-terminated-by '\t' \
        --lines-terminated-by '\n'  \
        --compression-codec snappy \
        --hive-drop-import-delims \
        --autoreset-to-one-mapper"
    echo $sqoop_comand
    eval $sqoop_comand

done


#rm -rf ./*.java
echo "All tables have been renamed successfully."



