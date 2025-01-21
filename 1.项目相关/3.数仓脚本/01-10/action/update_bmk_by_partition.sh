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


	#if [ $partition_value = "2006-05" ]; then

		# 1.更新dw_kw_bmk_t
		impala-shell -q"
		use $database_name;
		drop table if exists dw_kw_bmk_t_partition;
		create table dw_kw_bmk_t_partition as
		select * from dw_kw_bmk_t where ${partition_condition};

		DROP TABLE if exists dw_kw_bmk_t_updated1;
		CREATE table dw_kw_bmk_t_updated1 as
		SELECT 
			d.ksid,
			d.name,
			d.dah,
			d.xb_old,
			d.mz_old,
			d.xl_old,
			d.xw_old,
			d.byzy_old,
			d.sr,
			d.xzqy_old,
			d.ssdm_old,
			d.sqdm_old,
			d.qxdm_old,
			d.dwmc_old,
			d.dwss_old,
			d.dwxz_old,
			d.gznx,
			d.ksh,
			d.zjlx_old,
			d.zjh,
			d.xyjszg_old,
			d.kslx_old,
			d.jgjb_old,
			w_xb.new_code AS xb,
			w_mz.new_code AS mz,
			w_xl.new_code AS xl,
			w_xw.new_code AS xw,
			w_byzy.new_code AS byzy,
			'' AS xzqy,
			w_ssdm.new_code AS ssdm,
			w_sqdm.new_code AS sqdm,
			w_qxdm.new_code AS qxdm,
			d.dwmc_old as dwmc,
			'' AS dwss,
			'' AS dwxz,
			'' as zjlx,
			'' AS xyjszg,
			'' AS kslx,
			'' AS jgjb,
			d.xzqy_gb,
			d.ssdm_gb,
			d.sqdm_gb,
			d.qxdm_gb,
			d.ymonth
		FROM 
			dw_kw_bmk_t_partition AS d
		LEFT JOIN 
			m_dimension_t AS w_xb ON d.xb_old = w_xb.code AND w_xb.code_type = 'XB' AND d.ymonth = w_xb.ymonth
		LEFT JOIN
			m_dimension_t AS w_mz ON d.mz_old = w_mz.code AND w_mz.code_type = 'MZ' AND d.ymonth = w_mz.ymonth
		LEFT JOIN
			m_dimension_t AS w_xl ON d.xl_old = w_xl.code AND w_xl.code_type = 'XL' AND d.ymonth = w_xl.ymonth
		LEFT JOIN
			m_dimension_t AS w_xw ON d.xw_old = w_xw.code AND w_xw.code_type = 'XW' AND d.ymonth = w_xw.ymonth
		LEFT JOIN 
			m_dimension_t AS w_byzy ON d.byzy_old = w_byzy.code AND w_byzy.code_type = 'BYZY' AND d.ymonth = w_byzy.ymonth
		LEFT JOIN 
			m_dimension_t AS w_ssdm ON d.ssdm_old = w_ssdm.code AND w_ssdm.code_type = 'SSDM' AND d.ymonth = w_ssdm.ymonth
		LEFT JOIN 
			m_dimension_t AS w_sqdm ON d.sqdm_old = w_sqdm.code AND w_sqdm.code_type = 'SQDM' AND d.ymonth = w_sqdm.ymonth
		LEFT JOIN 
			m_dimension_t AS w_qxdm ON d.qxdm_old = w_qxdm.code AND w_qxdm.code_type = 'QXDM' AND d.ymonth = w_qxdm.ymonth;

		DROP TABLE IF EXISTS dw_kw_bmk_t_updated2;
		CREATE table dw_kw_bmk_t_updated2 as
		SELECT 
			d.ksid,
			d.name,
			d.dah,
			d.xb_old,
			d.mz_old,
			d.xl_old,
			d.xw_old,
			d.byzy_old,
			d.sr,
			d.xzqy_old,
			d.ssdm_old,
			d.sqdm_old,
			d.qxdm_old,
			d.dwmc_old,
			d.dwss_old,
			d.dwxz_old,
			d.gznx,
			d.ksh,
			d.zjlx_old,
			d.zjh,
			d.xyjszg_old,
			d.kslx_old,
			d.jgjb_old,
			d.xb,
			d.mz,
			d.xl,
			d.xw,
			d.byzy,
			'' AS xzqy,
			d.ssdm,
			d.sqdm,
			d.qxdm,
			d.dwmc,
			w_dwss.new_code AS dwss,
			w_dwxz.new_code AS dwxz,
			w_zjlx.new_code as zjlx,
			w_xyjszg.new_code AS xyjszg,
			d.kslx_old AS kslx,
			d.jgjb_old AS jgjb,
			d.xzqy_gb,
			d.ssdm_gb,
			d.sqdm_gb,
			d.qxdm_gb,
			d.ymonth
		FROM 
			dw_kw_bmk_t_updated1 AS d
		LEFT JOIN 
			m_dimension_t AS w_dwss ON d.dwss_old = w_dwss.code AND w_dwss.code_type = 'DWSS' AND  w_dwss.ymonth =d.ymonth
		LEFT JOIN 
			m_dimension_t AS w_dwxz ON d.dwxz_old = w_dwxz.code AND w_dwxz.code_type = 'DWXZ' AND  w_dwxz.ymonth =d.ymonth
		LEFT JOIN
			m_dimension_t AS w_zjlx ON d.zjlx_old = w_zjlx.code AND w_zjlx.code_type = 'ZJLX' AND  w_zjlx.ymonth = d.ymonth
		LEFT JOIN 
			m_dimension_t AS w_xyjszg ON d.xyjszg_old = w_xyjszg.code AND w_xyjszg.code_type = 'XYJSZG' AND w_xyjszg.ymonth =d.ymonth
		LEFT JOIN 
			m_dimension_t AS w_kslx ON d.kslx_old = w_kslx.code AND w_kslx.code_type = 'KSLX' AND w_kslx.ymonth  =d.ymonth
		LEFT JOIN 
			m_dimension_t AS w_jgjb ON d.jgjb_old = w_jgjb.code AND w_jgjb.code_type = 'JGJB' AND w_jgjb.ymonth =d.ymonth;

		INSERT OVERWRITE TABLE dw_kw_bmk_t partition (${partition_condition})

		SELECT d.ksid, d.name, d.dah, d.xb_old, d.mz_old, d.xl_old, d.xw_old, d.byzy_old, d.sr, d.xzqy_old, d.ssdm_old, d.sqdm_old, 
		d.qxdm_old, d.dwmc_old, d.dwss_old, d.dwxz_old, d.gznx, d.ksh, d.zjlx_old, d.zjh, d.xyjszg_old, d.kslx_old, d.jgjb_old, d.xb, d.mz, 
		d.xl, d.xw, d.byzy, m.parent_code as xzqy, d.ssdm, d.sqdm, d.qxdm, d.dwmc, d.dwss, d.dwxz, d.zjlx, d.xyjszg, d.kslx, d.jgjb,m.parent_code as xzqy_gb, g_ssdm.new_code as ssdm_gb,g_sqdm.new_code as sqdm_gb, 
		d.qxdm_gb FROM dw_kw_bmk_t_updated2 d 
		LEFT JOIN 
		m_dimension_t m ON d.ssdm_old=m.code and m.code_type='SSDM' and  m.ymonth = d.ymonth
		LEFT JOIN 
		m_dimension_t g_ssdm ON d.ssdm=g_ssdm.code and g_ssdm.code_type='SSDM_GB' and g_ssdm.ymonth = d.ymonth
		LEFT JOIN 
		m_dimension_t g_sqdm ON d.sqdm=g_sqdm.code and g_sqdm.code_type='SQDM_GB' and g_sqdm.ymonth = d.ymonth;

		drop table IF EXISTS dw_kw_bmk_t_partition;
		drop table IF EXISTS dw_kw_bmk_t_updated1;
		drop table IF EXISTS dw_kw_bmk_t_updated2;
		REFRESH dw_kw_bmk_t partition(${partition_condition});"

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
