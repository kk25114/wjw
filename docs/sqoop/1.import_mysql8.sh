#!/bin/bash

# 脚本功能: 将MySQL数据库中的表导入到Hive中，全库导入
# 使用方法: bash 1.import_mysql8.sh <mysql用户名> <mysql密码> <hive数据库名> <mysql服务器IP> <mysql服务器端口> <mysql数据库名>
# 示例: bash 1.import_mysql8.sh root root hhrdc_signup_manage 192.168.50.171 13306 hhrdc_signup_manage
#2024-05
# 示例: bash 1.import_mysql8.sh root 123456 ods_hhrdc_signup_manage 192.168.50.171 13306 hhrdc_signup_manage

#如果导入某2个表
#HIVE_TABLE_LIST="SUBJECT PAPER"




# 参数定义
USERNAME=$1
PASSWORD=$2
HIVE_DB=$3  # 将数据库名称作为参数
MYSQL_IP=$4  # MySQL IP地址作为参数
MYSQL_PORT=$5  # MySQL端口作为参数

# 连接字符串，提前定义以便复用
MYSQL_DB=$6 # MySQL数据库名作为参数
CONNECTION_STRING="jdbc:mysql://${MYSQL_IP}:${MYSQL_PORT}/${MYSQL_DB}"

# 获取 MySQL 数据库表列表
MYSQL_TABLE_LIST=$(sqoop list-tables \
--connect $CONNECTION_STRING \
--username $USERNAME \
--password $PASSWORD | awk 'NR>2')

# 获取 Hive 数据库表列表
HIVE_TABLE_LIST=$(hive -e "SHOW TABLES IN $HIVE_DB" | awk '{print $1}')

#如果导入某2个表
#HIVE_TABLE_LIST="SUBJECT PAPER"

# 使用 Bash 命令将 Hive 的表列表转换为数组
declare -A HIVE_TABLE_MAP
for TABLE in $HIVE_TABLE_LIST; do
    HIVE_TABLE_MAP[$TABLE]=1
done

# 检查每个 MySQL 表是否在 Hive 中已存在，并只处理不存在的表
for TABLE in $MYSQL_TABLE_LIST; do
    if [[ -z ${HIVE_TABLE_MAP[$TABLE]} ]]; then
        echo "导入新表------: $TABLE"
        
        # 清理该表的HDFS目录
        hdfs dfs -rm -r -f /user/root/${TABLE} 2>/dev/null
        
        # 获取列名
        COLUMN_LIST=$(sqoop eval \
            --connect $CONNECTION_STRING \
            --username $USERNAME \
            --password $PASSWORD \
            --query "SELECT column_name FROM information_schema.columns WHERE table_name = '$TABLE' AND table_schema = '$(basename $CONNECTION_STRING)'" | \
            grep '|' | grep -v 'COLUMN_NAME' | grep -Eo '\|\s+[a-z_]+\s+\|' | tr -d '|' | awk '{$1=$1; print}')

        # 生成 map-column-java 参数，将所有字段映射为 String
        MAP_COLUMN_JAVA=$(echo "$COLUMN_LIST" | awk '{printf "%s=String,", $1}')
        MAP_COLUMN_JAVA=${MAP_COLUMN_JAVA%,}  # 移除最后一个逗号
        
        # Sqoop 导入单个表到 Hive
        sqoop import \
            --connect $CONNECTION_STRING \
            --username $USERNAME \
            --password $PASSWORD \
            --hive-import \
            --hive-overwrite \
            --hive-database $HIVE_DB \
            --hive-table $TABLE \
            --target-dir /tmp/$TABLE \
            --create-hive-table \
            --delete-target-dir \
            --num-mappers 1 \
            --null-string '\\N' \
            --null-non-string '\\N' \
            --hive-drop-import-delims \
            --fields-terminated-by '\t' \
            --compression-codec snappy \
            --map-column-java $MAP_COLUMN_JAVA \
            --query "SELECT * FROM $TABLE WHERE \$CONDITIONS"
    else
        echo "跳过hive中已存的表: $TABLE"
    fi
done

# 清理临时文件
rm -rf ./*.java

# 导入完成提示
echo "所有表导入完成"
echo "导入的目标Hive数据库: $HIVE_DB"
echo "源MySQL数据库: $MYSQL_DB"


