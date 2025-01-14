#!/bin/bash
# 使用方法: ./3.import_oracle_by_year.sh <用户名> <密码> <年份> <Hive数据库名> <Oracle数据库IP>
# 示例: ./3.import_oracle_by_year.sh sms_cnepm2022 sms_cnepm2022 2099 ods_sms_cnepm 192.168.9.100
# 功能: 将Oracle数据库中的表导入到Hive中,并在表名后添加年份后缀，全库导入

#如果导入某个表取消注释
#TABLE_LIST="SUBJECT PAPER"

# 参数定义
USERNAME=$1  
PASSWORD=$2
YEAR=$3 #导入的年份表名加year
HIVE_DB=$4  # 将数据库名称作为参数
IP=$5 # Oracle数据库IP地址

# 连接字符串，提前定义以便复用
CONNECTION_STRING="jdbc:oracle:thin:@${IP}:1521:orcl"

# 获取数据库表的列结构并生成 Java 映射
TABLE_LIST=$(sqoop list-tables \
--connect $CONNECTION_STRING \
--username $USERNAME \
--password $PASSWORD | awk 'NR>2')

#如果导入某个表
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
    NEW_TABLE_NAME="${TABLE}_${YEAR}"
    #检查删除落地表名是否存在，存在就删除表名
    hive -e "USE $HIVE_DB; DROP TABLE IF EXISTS $NEW_TABLE_NAME";

    # Sqoop 导入单个表到 Hive，每个表单独处理字段映射
    sqoop import \
        --connect $CONNECTION_STRING \
        --username $USERNAME \
        --password $PASSWORD \
        --table $TABLE \
        --hive-import \
        --hive-overwrite \
        --create-hive-table \
        --hive-table $HIVE_DB.$NEW_TABLE_NAME \
        --map-column-hive $MAP_COLUMN_JAVA \
        --as-textfile \
        --num-mappers 1 \
        --fields-terminated-by '\t' \
        --compression-codec snappy \
        --autoreset-to-one-mapper \
        --lines-terminated-by '\n' \
        --hive-drop-import-delims \
        --escaped-by '\\'
done


# Hive 命令以更改表名
#hive -e "USE $HIVE_DB; SHOW TABLES;" | while read TABLE
#do
# 检查表名是否不以 'bak' 结尾
#  if [[ ${TABLE: -3} != "bak" ]]; then
#    NEW_TABLE_NAME="${TABLE}_${YEAR}_bak"
#    hive -e "USE $HIVE_DB; ALTER TABLE $TABLE RENAME TO $NEW_TABLE_NAME;"
#  fi
#done

rm -rf ./*.java
echo "All tables have been renamed successfully."



