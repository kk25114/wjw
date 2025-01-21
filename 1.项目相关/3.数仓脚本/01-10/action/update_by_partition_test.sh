#!/bin/bash
function update_by_partitions() {
    local database_name=$1
    local table_name=$2

    # 列出所有的分区
    partitions=$(hive -e "SHOW PARTITIONS ${database_name}.${table_name};")

    # 循环每个分区
    for partition in $partitions; do
        # 拆分字段
        partition_column=$(echo $partition | cut -d'=' -f1)
        partition_value=$(echo $partition | cut -d'=' -f2)

        # 分区字段格式
        partition_condition="${partition_column}='${partition_value}'"

	echo $partition_condition

        	impala-shell -q "use wjw_wk; INSERT OVERWRITE table dw_pf_yryj_socre_t partition(${partition_condition})
select ksh, ksdfd, mdfd, ksdzdf, answer_id, qk, sjid, sjdm, sjname, jb_old, jbname, zyid, zycdm, zydm_old, zyname, kmid, kmcdm, kmdm_old, kmname, tg, mf, jb, zydm, kmdm, ksdf, jbcdm from dw_pf_yryj_socre_t_bak WHERE ${partition_condition};"	
        # 查询分区
    done

    echo "分区更新完毕"
}




# 参数
DATABASE_NAME=$1
TABLE_NAME=$2

# 调用参数
update_by_partitions $DATABASE_NAME $TABLE_NAME
