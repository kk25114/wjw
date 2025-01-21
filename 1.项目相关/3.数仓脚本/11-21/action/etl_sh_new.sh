#!/bin/bash
# 启动语句  bash etl_sh_new.sh '{"kw_ocl_ip":"192.168.2.72","kw_ocl_port":"1521","kw_ocl_db":"orcl","kw_ocl_user":"exam2020","kw_ocl_pw":"exam2020","pf_ocl_ip":"192.168.2.72","pf_ocl_port":"1521","pf_ocl_db":"orcl","pf_ocl_user":"sms_exam2020","pf_ocl_pw":"sms_exam2020","tk_ocl_ip":"192.168.2.72","tk_ocl_port":"1521","tk_ocl_db":"orcl","tk_ocl_user":"eqbms_czj_hyt","tk_ocl_pw":"eqbms_czj_hyt","hive_db":"wjw_wk","ymonth":"2024-01"}' 
# bash etl_sh_new.sh '{"kw_ocl_ip":"192.168.2.72","kw_ocl_port":"1521","kw_ocl_db":"orcl","kw_ocl_user":"exam2020","kw_ocl_pw":"exam2020","pf_ocl_ip":"192.168.2.72","pf_ocl_port":"1521","pf_ocl_db":"orcl","pf_ocl_user":"sms_exam2020","pf_ocl_pw":"sms_exam2020","tk_ocl_ip":"192.168.2.72","tk_ocl_port":"1521","tk_ocl_db":"orcl","tk_ocl_user":"eqbms_czj_hyt","tk_ocl_pw":"eqbms_czj_hyt","hive_db":"wjw_wk","ymonth":"2026-08"}' 
kw_hive_t="ods_kw_"
pf_hive_t="ods_pf_"
tk_hive_t="ods_tk_"

kw_tables=(
"SYS_CODE:SYS_CODE_ID,PROJECT_ID,TYPE_NAME,TYPE_CODE,NAME,CODE,SERIAL_NO,APP_NAME"
"CANDIDATE:CANDIDATE_ID,PROJECT_ID,PHOTO_ID,ARCHIVENO,NAME,CARDTYPE,CARDNO,NATION,GENDER,YEAROFQUALIFY,BIRTHDATE,ORGNAME,ORGPROPERTY,ORG_BELONG,YEAROFWORK,SCHOOL,EDULEVEL,BYZY,CERTTIME,DEGREE,SCHOOL_REMARK,POSTCODE,ADDRESS,MOBILE,TEL,EMAIL,QUALIFY,ABODE,ZZQK,XL,MAJOR,WORK_TIME,NOW_QUALIFY,NOW_QUALIFY_DATE,HISTORY_SIGN,NAME_ENGLISH,NAME_USED,NATIONALITY,DISTRICT_ID,EDU_CERT_NO"
"ENROLLMENT:ENROLLMENT_ID,PROJECT_ID,CANDIDATE_ID,COMPNO,COMPDATE,SUB_ZY_ID,SUB_JB_ID,ORG_CHECK_ID,ORG_CHECK_LEVEL,CHECK_STATE,ORG_BMD_ID,ORG_SHIJI_ID,ORG_SHENGJI_ID,COMPMODE,ORG_SHIJISEAT_ID,TESTCARDNO,EXAMINEE_TYPE"
"SUBJECT:SUBJECT_ID,SUBJECT_NAME,SUBJECT_CODE,SUBJECT_STANDARD_CODE,PARENT_ID,SUB_LEVEL,EXAM_TYPE"
"REGISTER:REGISTER_ID,SUB_JB_ID,SUB_ZY_ID,SUB_KM_ID,ENROLLMENT_ID,AVOID_SIGN,EXAM_TYPE"
"ORGANIZATION:ORG_ID,ORG_NAME,ORG_CODE,ORG_STANDARD_CODE,ORG_LEVEL,PARENT_ID"
"EXAMTIMES:EXAMTIMES_ID,PROJECT_ID,TIMES,EXAM_STARTTIME,EXAM_ENDTIME,EXAM_TYPE,EXAMBATCH"
"EXAMFLD:EXAMFLD_ID,ORG_ID,PROJECT_ID,EXAMFLD_CODE,EXAMFLD_NAME,EXAMFLD_ADDRESS,EXAM_TYPE"
"EXAMROOM:EXAMROOM_ID,PROJECT_ID,EXAMFLD_ID,EXAMROOM_NAME,EXAMROOM_CODE,SEATNUM,CONDITION,EXAM_TYPE,ORG_SHIJI_ID,ORG_SHENGJI_ID"
"SEATINFO:SEATINFO_ID,PROJECT_ID,EXAMFLD_NAME,EXAMFLD_ADDRESS,EXAMROOM_NAME,EXAMROOM_ID,SEATNO,REGISTER_ID,EXAMTIMES_ID,SUB_ZY_ID,NAME,CARDTYPE,CARDNO,TESTCARDNO,ARCHIVENO,EXAM_STARTTIME,EXAM_ENDTIME,EXAM_TYPE,GENDER,ORGNAME,CANDIDATE_ID"
"KWEXT_EXAM:CANDIDATE_ID,HEALTH_CONDITION,EDU_YEAR,EDU_HISTORY,WORKING_SIGN,BYZY_REMARK,CERTIFY_TYPE,PRINT_ALLOW_SIGN,NATIONALITY_REMARK,PRIMARY_HEALTH,EXPIRY_DATE"
"KWEXT_CNEPM:CANDIDATE_ID,HEALTH_CONDITION,EDU_YEAR,EDU_HISTORY,WORKING_SIGN,PRINT_ALLOW_SIGN,PRACTICE,NATIONALITY_REMARK,EXPIRY_DATE"
)

pj_tables=(
"PAPER:PAPER_ID,PAPERCODE,PAPERNAME,PAPERTYPE,PROJECT_ID,TOTALSCORE"
"QUESTION:QUESTION_ID,PAPER_ID,CODE,DISPLAY_CODE,DISPLAY_ORDER,QUESTIONTYPE,PARENT_ID,ANSWERXML,SANSWER,PROJECT_ID,FULLPOINT"
"SUBJECT_PAPER_REL:SUBJECT_PAPER_REL_ID,PROJECT_ID,SUBJECT_ID,PAPER_ID,PAPERCODE,TIMES"
"SCORE:SCORE_ID,PAPER_ID,PROJECT_ID,ANSWER_ID,EXAMINEENO,TOTAL_POINT,FULL_POINT,FINAL_SCORE,ISVALID,ISHISTORY,EXAMRECORD_ID"
"SEATINFO:TIMES,SUB_ZY_ID,EXAMINEENO,PROJECT_ID,SUB_KM_ID,ISVALID,EXAMTYPE"
"PASSEDEXAMINEE:PASSEDEXAMINEE_ID,PROJECT_ID,EXAMINEENO,ISHISTORY"
"EXAMRECORD:EXAMRECORD_ID,PROJECT_ID,EXAMINEENO,EXAMRECORDTYPE_ID,REMARK,ISVALID,SUB_ZY_ID,SUB_KM_ID,REASON"
"EXAMRECORDTYPE:EXAMRECORDTYPE_ID,PROJECT_ID,CODE,NAME,TYPE"
"SUBJECT:SUBJECT_ID,PROJECT_ID,CODE,STANDARD_CODE,NAME,OLEVEL,PARENT_ID,WMP_SUBJECT_ID"
"EXAMINEE:EXAMINEE_ID,ARCHIVE_ID,EXAMINEENO,NAME,CARDNO"
"ANSWERSCORE:ANSWERSCORE_ID,EXAMINEENO,PAPER_ID,QUESTIONS_ID,ANSWER_ID,QUESTIONPOINT,SCORE,SELECTINFO,PROJECT_ID"
)

tk_tables=(
"SYS_CODE:SYS_CODE_ID,TYPE_NAME,TYPE_CODE,NAME,CODE"
"PAPER_EDITION_QUESTION:PAPER_EDITION_QUESTION_ID,PAPER_EDITION_ID,QUESTION_ID,ORDER_NUM"
"PAPER_EDITION:PAPER_EDITION_ID,PAPER_ID,NAME"
"PAPER:PAPER_ID,NAME"
"QUESTION:QUESTION_ID,QUESTION_TYPE_CODE,SUB_NUM,SPECIALITY_ID,KEY_POINT_ID"
"OUTLINE:OUTLINE_ID,NAME,CODE,OLEVEL,PARENT_ID,TYPE,ZSMK,JBMK"
)

############################
#逻辑：先删分区后写入分区
############################
function sqoop_table(){
    echo "Starting import for table: $4  to $hive_db.$6  "  
    echo "---------------执行信息：1- $1 ,2- $2 ,3- $3, 4- $4, 5- $5,6- $6 " 
    hive -e "alter table $hive_db.$6 drop if exists partition(ymonth='$ymonth');"

    # Sqoop 导入
    sqoop import  --connect $1  --username $2  --password $3  --table $4 --fields-terminated-by '\t' --columns "$5" \
    --hcatalog-database  $hive_db --hcatalog-table "$6" --hcatalog-storage-stanza "STORED AS parquet" \
    --mapreduce-job-name sqoop_parquet --hive-partition-key 'ymonth' --hive-partition-value $ymonth  --m 1
    echo "导入完成:$hive_db.$6  分区为 $ymonth"  
}

############################
#步骤一、抽取报名、成绩、细目表数据所以表至ods层
#步骤二、抽取在oracle中转换后的专项表至dw表层
#步骤三、根据细目表科目及题号，融合新的成绩表数据，生成临时表
#步骤四、报名、成绩、细目临时表导出
# 启动语句：  bash test.sh '{"ocl_ip":"192.168.50.174","ocl_port":"1521","ocl_db":"helowin","ocl_user":"yank"}'
############################

##数据抽取
function load(){ 
      # 考务库表名列表c
    # 遍历表名列表并执行 Sqoop 命令
    for table in "${kw_tables[@]}"
    do  
      tName=`echo $table | awk -F ":" '{print$1}'`
      tField=`echo $table | awk -F ":" '{print$2}'`
      echo "-------------导入考务库表：$tName ,字段： $tField ---------------"
      sqoop_table "jdbc:oracle:thin:@$kw_ocl_ip:$kw_ocl_port:$kw_ocl_db" $kw_ocl_user $kw_ocl_pw  $tName "$tField"  "$kw_hive_t$tName""_t" 
    done
    

    #题库表名列表c 
    for table in "${tk_tables[@]}"
    do  
      tName=`echo $table | awk -F ":" '{print$1}'`
      tField=`echo $table | awk -F ":" '{print$2}'`
      echo "-------------导入题库表：$tName ,字段： $tField ---------------"
      sqoop_table "jdbc:oracle:thin:@$tk_ocl_ip:$tk_ocl_port:$tk_ocl_db" $tk_ocl_user $tk_ocl_pw  $tName "$tField"   "$tk_hive_t$tName""_t" 
    done
    
    # 评分库表名列表c
    for table in "${pj_tables[@]}"
    do  
      tName=`echo $table | awk -F ":" '{print$1}'`
      tField=`echo $table | awk -F ":" '{print$2}'`
      echo "-------------导入评分库表：$tName ,字段： $tField ---------------"
      sqoop_table "jdbc:oracle:thin:@$pf_ocl_ip:$pf_ocl_port:$pf_ocl_db" $pf_ocl_user $pf_ocl_pw  $tName "$tField"   "$pf_hive_t$tName""_t" 
    done
    
}


#################
#合并考务报名表数据，并进行抽取
#################
function dw_kw_transform(){ 
    sqoop eval \
    --connect jdbc:oracle:thin:@$kw_ocl_ip:$kw_ocl_port:$kw_ocl_db  \
    --username $kw_ocl_user \
    --password $kw_ocl_pw  \
    -e "drop table  dw_kw_bmk_t "
    
    echo '------------生成报名库数据表------------' 
    sqoop eval \
    --connect jdbc:oracle:thin:@$kw_ocl_ip:$kw_ocl_port:$kw_ocl_db  \
    --username $kw_ocl_user \
    --password $kw_ocl_pw  \
    -e "create table dw_kw_bmk_t as 
    select  
		c.candidate_id AS KSID, --考生流水号
		c.name AS NAME, --姓名
		c.archiveno AS DAH, --档案号
		c.gender AS XB_OLD, --性别
		c.nation AS MZ_OLD, --民族
		c.edulevel AS XL_OLD, --最高学历
		c.degree AS XW_OLD, --学位
		c.byzy AS BYZY_OLD, --毕业专业
		c.birthdate AS SR, --生日
		c.district_id AS XZQY_OLD, --行政区划
		org_sheng.org_standard_code AS SSDM_OLD, --省份
		org_shi.org_standard_code AS SQDM_OLD, --市区CODE
		org_qu.org_standard_code AS QXDM_OLD, --区县CODE
		c.orgname AS DWMC_OLD, --单位名称
		c.org_belong AS DWSS_OLD, --单位所属
		c.orgproperty AS DWXZ_OLD, --单位性质
		c.yearofwork AS GZNX, --工作年限
		e.testcardno AS KSH, --考生考试编号
		c.cardtype AS ZJLX_OLD, --考生证件类型
		c.cardno AS ZJH, --考生证件号码
		c.qualify AS XYJSZG_OLD, --现有技术资格
		e.examinee_type AS KSLX_OLD, --考生类型
		org.org_level AS JGJB_OLD, --机构级别
		CAST(NULL AS VARCHAR2(10)) AS XB, --性别
		CAST(NULL AS VARCHAR2(50)) AS MZ, --民族
		CAST(NULL AS VARCHAR2(50)) AS XL, --最高学历
		CAST(NULL AS VARCHAR2(50)) AS XW, --学位
		CAST(NULL AS VARCHAR2(100)) AS BYZY, --毕业专业
		CAST(NULL AS VARCHAR2(100)) AS XZQY, --行政区划
		CAST(NULL AS VARCHAR2(50)) AS SSDM, --省份
		CAST(NULL AS VARCHAR2(50)) AS SQDM, --市区CODE
		CAST(NULL AS VARCHAR2(50)) AS QXDM, --区县CODE
		CAST(NULL AS VARCHAR2(255)) AS DWMC, --单位名称
		CAST(NULL AS VARCHAR2(100)) AS DWSS, --单位所属
		CAST(NULL AS VARCHAR2(100)) AS DWXZ, --单位性质
		CAST(NULL AS VARCHAR2(50)) AS ZJLX, --考生证件类型
		CAST(NULL AS VARCHAR2(100)) AS XYJSZG, --现有技术资格
		CAST(NULL AS VARCHAR2(50)) AS KSLX, --考生类型
		CAST(NULL AS VARCHAR2(50)) AS JGJB, --机构级别
		CAST(NULL AS VARCHAR2(50)) AS XZQY_GB, --行政区划国标
		CAST(NULL AS VARCHAR2(100)) AS SSDM_GB, --省份CODE国标
		CAST(NULL AS VARCHAR2(50)) AS SQDM_GB, --市区代码国标
		CAST(NULL AS VARCHAR2(50)) AS QXDM_GB --区县代码国标 
    from
        candidate c
    join
        enrollment e on c.candidate_id = e.candidate_id and e.testcardno is not null
    join
        organization org on e.org_check_id = org.org_id
    left join 
        organization org_sheng  on e.org_shengji_id=org_sheng.org_id
    left join 
        organization org_shi on e.org_shiji_id=org_shi.org_id
    left join 
        organization org_qu on e.org_bmd_id=org_qu.org_id "
		
    echo '------------报名库数据表------------' 
	hive -e "alter table $hive_db.dw_kw_bmk_t drop if exists partition(ymonth='$ymonth');"

    sqoop import --connect jdbc:oracle:thin:@$kw_ocl_ip:$kw_ocl_port:$kw_ocl_db  \
    --username $kw_ocl_user --password $kw_ocl_pw --fields-terminated-by '\t' \
    --query "SELECT * from dw_kw_bmk_t where    \$CONDITIONS " \
    --hcatalog-database $hive_db --hcatalog-table dw_kw_bmk_t --hcatalog-storage-stanza "STORED AS parquet" \
    --mapreduce-job-name sqoop_parquet --hive-partition-key 'ymonth' --hive-partition-value $ymonth   --m 1
	

}


#################
#合并一人一卷表数据，并进行抽取
#################
function dw_pf_transform(){ 
    sqoop eval \
    --connect jdbc:oracle:thin:@$pf_ocl_ip:$pf_ocl_port:$pf_ocl_db  \
    --username $pf_ocl_user \
    --password $pf_ocl_pw  \
    -e "drop table  dw_yryf_t "
    
    echo '------------生成一人一卷得分数据表------------'
    #合并一人一卷得分数据表
    sqoop eval \
    --connect jdbc:oracle:thin:@$pf_ocl_ip:$pf_ocl_port:$pf_ocl_db  \
    --username $pf_ocl_user \
    --password $pf_ocl_pw  \
    -e "create table dw_yryf_t as 
        SELECT
		e.examineeno AS KSH,  -- 考生号
		sc.total_point AS KSDFD, --考生实际得分点
		sc.full_point AS MDFD, -- 满得分点
		sc.final_score AS KSDZDF, -- 调整后的分数（等值分）
		sc.answer_id AS ANSWER_ID, -- 答案ID
		sc.SCOREREMARK AS QK, --缺考标志
		p.paper_id AS SJID, -- 试卷ID
		p.ZJ_PAPER_ID AS SJDM, -- 试卷CODE
		p.papername AS SJNAME, -- 试卷名称
		jb.STANDARD_CODE AS JB_OLD, -- 报考级别
		jb.name AS JBNAME, -- 报考级别名称
		zy.subject_id AS ZYID, --专业ID
		zy.code AS ZYCDM, -- 专业长CODE
		zy.standard_code AS ZYDM_OLD, -- 专业CODE
		zy.name AS ZYNAME, -- 专业名称
		km.subject_id AS KMID, -- 科目ID
		km.code AS KMCDM, -- 科目长CODE
		km.standard_code AS KMDM_OLD, -- 科目CODE
		km.name AS KMNAME, --科目名称
        pas.ISHISTORY TG, -- 是否通过 0是一次通过 1 两次通过 null 是不通过
		p.totalscore AS MF, -- 试卷原始满分（通常满分百分）
		CAST(NULL AS VARCHAR2(50)) AS JB, -- 级别
		CAST(NULL AS VARCHAR2(50)) AS ZYDM, -- 专业CODE
		CAST(NULL AS VARCHAR2(50)) AS KMDM, -- 科目短CODE
		sc.ADJUST_SCORE	as KSDF, -- 考生个人调整前的原始分数
		jb.CODE AS JBCDM -- 报考级别长code
		
   FROM
        examinee e,
        seatinfo s,
        score sc,
        paper p,
        SUBJECT_PAPER_REL sp,
        subject zy,
        subject km ,
        subject jb ,
        PASSEDEXAMINEE pas
    WHERE
        e.EXAMINEENO = s.EXAMINEENO 
        and e.EXAMINEENO = pas.EXAMINEENO(+)
        AND e.EXAMINEENO = sc.EXAMINEENO 
        AND sc.PAPER_ID = p.PAPER_ID 
        AND p.PAPER_ID = sp.PAPER_ID 
        AND e.SUBJECT_ID = zy.SUBJECT_ID 
        AND sp.SUBJECT_ID = km.SUBJECT_ID 
        AND zy.SUBJECT_ID = km.PARENT_ID 
        AND s.SUB_ZY_ID = zy.SUBJECT_ID 
        AND s.SUB_KM_ID = km.SUBJECT_ID 
        AND s.TIMES = sp.TIMES 
        and zy.PARENT_ID = jb.SUBJECT_ID
        AND sc.isvalid = '1' 
        AND sc.ishistory = '0'"
    echo '------------抽取一人一卷得分数据表------------'
    #抽取一人一卷得分数据表
	hive -e "alter table $hive_db.dw_pf_yryj_socre_t drop if exists partition(ymonth='$ymonth');"

	
    sqoop import --connect jdbc:oracle:thin:@$pf_ocl_ip:$pf_ocl_port:$pf_ocl_db \
    --username $pf_ocl_user --password $pf_ocl_pw --fields-terminated-by '\t' \
    --query "SELECT * from dw_yryf_t where    \$CONDITIONS " \
    --hcatalog-database $hive_db --hcatalog-table dw_pf_yryj_socre_t --hcatalog-storage-stanza "STORED AS parquet" \
    --mapreduce-job-name sqoop_parquet --hive-partition-key 'ymonth' --hive-partition-value $ymonth   --m 1
}


#################
#依据成绩库数据group 维度抽取题库专项数据
#################
function dw_tk_transform(){

    sqoop eval --connect jdbc:oracle:thin:@$pf_ocl_ip:$pf_ocl_port:$pf_ocl_db --username $pf_ocl_user --password $pf_ocl_pw \
    -e "drop table tk_sxxmb_t"
    
    echo '------------生成双向细目表------------'
    #双向细目表生成
    sqoop eval --connect jdbc:oracle:thin:@$pf_ocl_ip:$pf_ocl_port:$pf_ocl_db --username $pf_ocl_user --password $pf_ocl_pw \
    -e "create table tk_sxxmb_t as 
    WITH zy_km_sj_data AS (
        --  获取专业、科目、试卷、标答、满得分点、题号、题型
        SELECT DISTINCT
            JB_OLD ,
            JBNAME,
            SJID ,
            SJDM ,-- 试卷code
            SJNAME ,-- 试卷名称
            ZYID ,--专业id
            ZYDM_OLD ,-- 专业code
            ZYNAME ,-- 专业名称
            KMID ,-- 科目id
            KMDM_OLD , -- 科业code
            KMNAME  -- 科目名称
        FROM
            dw_yryf_t 
        ), 
    d_QUESTION AS (
        SELECT
            a.QUESTION_ID pj_QUESTION_ID,
            a.code,  -- 题目code 关联 题库QUESTION表  QUESTION_id
            a.PAPER_ID, 
            a.PARENT_ID, 
            a.QUESTIONTYPE,-- 提型 
            a.DISPLAY_CODE,-- 题号（含大题）
            a.DISPLAY_order,--题目排序
            a.SANSWER,-- 标答
            a.FULLPOINT, -- 满得分点、分值
            b.SPECIALITY_ID,
            b.KEY_POINT_ID,
            c.name zyname,-- 专业名称
            d.name zsdname,-- 知识点名称
            d.JBMK jbfl,-- 疾病分类
            d.ZSMK zsmk, -- 知识模块
			z.name ZSMKNAME,-- 知识模块name
			j.name JBFLNAME -- 疾病分类name
        FROM
            QUESTION a
            LEFT JOIN $tk_ocl_user.QUESTION b ON a.code = b.QUESTION_ID 
            LEFT JOIN $tk_ocl_user.OUTLINE c ON b.SPECIALITY_ID = c.OUTLINE_id
            LEFT JOIN $tk_ocl_user.OUTLINE d ON b.KEY_POINT_ID = d.OUTLINE_id
			LEFT JOIN $tk_ocl_user.ZSMK z ON d.zsmk=z.code
			LEFT JOIN $tk_ocl_user.JBMK j ON d.jbmk=j.code

        WHERE
            a.PARENT_ID IS NULL 
    ),
    all_QUESTION as (
        SELECT
            a.QUESTION_ID pj_QUESTION_ID,
            a.code,  -- 题目code 关联 题库QUESTION表  QUESTION_id
            a.PAPER_ID, 
            a.PARENT_ID, 
            a.QUESTIONTYPE,-- 提型
            a.DISPLAY_CODE,-- 题号（含大题）
            a.DISPLAY_order,--题目排序
            a.SANSWER,-- 标答
            a.FULLPOINT, -- 满得分点、分值
            b.SPECIALITY_ID,
            b.KEY_POINT_ID,
            b.zyname,-- 专业名称
            b.zsdname,-- 知识点名称
            b.jbfl,-- 疾病分类
            b.zsmk, -- 知识模块
			b.ZSMKNAME ZSMKNAME,-- 知识模块name
			b.JBFLNAME JBFLNAME -- 疾病分类name
        FROM
            QUESTION a
            LEFT JOIN d_QUESTION b ON a.PARENT_ID = b.pj_QUESTION_ID 
        WHERE
             a.PARENT_ID IS NOT NULL  
     UNION all 
        select * from d_QUESTION
    )
    select 
		a.JB_OLD, -- 报考级别
		a.JBNAME, -- 报考级别名称
		a.SJID, -- 试卷ID
		a.SJDM, -- 试卷CODE
		a.SJNAME, -- 试卷名称
		a.ZYID, -- 专业ID
		a.ZYDM_OLD, -- 专业CODE
		a.ZYNAME, -- 专业名称
		a.KMID, -- 科目ID
		a.KMDM_OLD, -- 科目编号
		a.KMNAME, -- 科目名称
		b.pj_question_id AS QUESTIONS_ID, -- 评卷表QUESTION_ID 
		b.code AS CODE, -- 题目CODE 关联 题库QUESTION表-QUESTION_ID
		b.parent_id AS PARENT_ID, -- 父级ID
		b.questiontype AS QUESTIONTYPE, -- 提型
		b.display_code AS DISPLAY_CODE, -- 题号（含大题）
		b.display_order AS DISPLAY_ORDER, -- 题目排序
		b.sanswer AS SANSWER, -- 标答
		b.fullpoint AS MDFD, -- 满得分点、分值
		b.speciality_id AS SPECIALITY_ID, -- 专业名称ID
		b.key_point_id AS ZSDID, -- 知识点ID
		b.zyname AS TKZYNAME, -- 专业名称
		b.zsdname AS ZSD, -- 知识点名称
		b.jbfl AS JBFL, -- 疾病分类
		b.zsmk AS ZSMK, -- 知识模块
		CAST(NULL AS VARCHAR2(50)) AS ZYDM, -- 专业CODE
		CAST(NULL AS VARCHAR2(50)) AS KMDM, -- 科目编号
		CAST(NULL AS VARCHAR2(50)) AS JB, -- 级别
		b.ZSMKNAME ZSMKNAME,-- 知识模块name
		b.JBFLNAME JBFLNAME -- 疾病分类name
    FROM
        zy_km_sj_data a,
        all_QUESTION b 
    WHERE
        a.SJID = b.paper_id  " 
        
    echo '------------抽取双向细目表------------'
	
	hive -e "alter table $hive_db.dw_tk_sxxmb_t drop if exists partition(ymonth='$ymonth');"

    sqoop import --connect jdbc:oracle:thin:@$pf_ocl_ip:$pf_ocl_port:$pf_ocl_db --username $pf_ocl_user --password $pf_ocl_pw \
    --fields-terminated-by '\t' --query "SELECT * from tk_sxxmb_t where    \$CONDITIONS " \
    --hcatalog-database $hive_db  --hcatalog-table dw_tk_sxxmb_t --hcatalog-storage-stanza "STORED AS parquet" \
    --mapreduce-job-name sqoop_parquet --hive-partition-key 'ymonth' --hive-partition-value $ymonth  --m 1
}
 
 
#################
#获取试卷id
#################
function dw_getPaper_transform(){ 
    echo '------------生成试paper——id数据表------------' 
    sqoop eval \
    --connect jdbc:oracle:thin:@$pf_ocl_ip:$pf_ocl_port:$pf_ocl_db  \
    --username $pf_ocl_user \
    --password $pf_ocl_pw  \
    -e "create table tmp_paper_t as SELECT DISTINCT  SJID from  dw_yryf_t"
    
    echo '------------抽取paper——id数据表------------' 
    sqoop import --connect jdbc:oracle:thin:@$pf_ocl_ip:$pf_ocl_port:$pf_ocl_db \
    --username $pf_ocl_user --password $pf_ocl_pw --fields-terminated-by '\t' \
    --query "SELECT SJID from tmp_paper_t where    \$CONDITIONS " \
    --hcatalog-database $hive_db --hcatalog-table ods_pf_tmp_paper_t --hcatalog-storage-stanza "STORED AS parquet" \
    --mapreduce-job-name sqoop_parquet --hive-partition-key 'ymonth' --hive-partition-value $ymonth   --m 1
}

##启动方法
function main(){ 
    echo '------------入参校验通过，本次清洗开始------------'
    echo '------------数据导入开始------------'
    #load
    echo '------------考务专项数据转化开始------------'
    dw_kw_transform    
    echo '------------评分专项数据转化开始------------'
    dw_pf_transform
    echo '------------题库数据导出开始------------'
    dw_tk_transform
    echo '------------本次清洗完毕------------'
}

 
#################
#根据入参json动态赋值变量 
#################
echo "this param value is $1"
json=$1
for n in kw_ocl_ip kw_ocl_port kw_ocl_db kw_ocl_user kw_ocl_pw  pf_ocl_ip pf_ocl_port pf_ocl_db pf_ocl_user pf_ocl_pw tk_ocl_ip tk_ocl_port tk_ocl_db tk_ocl_user tk_ocl_pw  hive_db ymonth
do
    var_name=$n
    declare $var_name=$(echo $json | jq -r '.'$n)
    if [ "null" != "${!var_name}" ]; then
      echo "变量有值,$var_name=${!var_name}"
    else
      echo "error : 变量$var_name为空, 此为异常，人工处理！！！"
      exit 1
    fi
    #echo $var_name      # 取变量名
    #echo ${!var_name}   # 取变量值
done


#################
#开始调度
#################
# 首次执行先跑建表语句
#hive -f ./hql-create-table.sql
main
 






