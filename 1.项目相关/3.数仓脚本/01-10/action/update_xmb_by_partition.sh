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


	#if [ $partition_value != "2020-05" ]; then
        	# impala-shell -q "SELECT COUNT(1) FROM ${database_name}.${table_name} WHERE ${partition_condition};"	
		# 2.更新 dw_tk_sxxmb_t
		use $database_name;
		impala-shell -q "
		DROP TABLE IF exists dw_tk_sxxmb_t_partition;
		CREATE table dw_tk_sxxmb_t_partition as 
		SELECT * FROM dw_tk_sxxmb_t WHERE ${partition_condition};

		INSERT OVERWRITE TABLE dw_tk_sxxmb_t partition (${partition_condition})

		SELECT d.jb_old, d.jbname, d.sjid, d.sjdm, d.sjname, d.zyid, d.zydm_old, d.zyname, d.kmid, d.kmdm_old, d.kmname, 
		d.questions_id, d.code, d.parent_id, d.questiontype, d.display_code, d.display_order, 
		d.sanswer, d.mdfd, d.speciality_id, d.zsdid, d.tkzyname, d.zsd, d.jbfl, d.zsmk, w_zydm.new_code zydm, d.kmdm_old kmdm, w_jb.new_code jb,d.zsmkname, d.jbflname
		FROM dw_tk_sxxmb_t_partition d
		LEFT JOIN
		m_dimension_t AS w_zydm ON d.zydm_old = w_zydm.code AND w_zydm.code_type = 'ZYDM' AND 
		d.ymonth = w_zydm.ymonth
                LEFT JOIN
                m_dimension_t AS w_jb ON d.jb_old = w_jb.code AND w_jb.code_type = 'JB' AND
                d.ymonth = w_jb.ymonth;
		drop table IF EXISTS dw_tk_sxxmb_t_partition;
		REFRESH dw_tk_sxxmb_t partition(${partition_condition});"
	#fi
        # 查询分区
    done

    echo "分区更新完毕"
}




# 参数
DATABASE_NAME=$1
TABLE_NAME=$2

# 调用参数
update_by_partitions $DATABASE_NAME $TABLE_NAME
