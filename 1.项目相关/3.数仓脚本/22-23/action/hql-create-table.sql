
 
drop database if exists wjw_hk cascade;
create database wjw_hk ;
use wjw_hk;
 
-- 1. sys_code 表

create table ods_kw_sys_code_t (
  sys_code_id bigint comment '系统代码表流水号',
  project_id bigint comment '项目流水号',
  type_name string comment '类别名称',
  type_code string comment '类别编码',
  name string comment '名称',
  code string comment '编码',
  serial_no int comment '顺序号',
  app_name string comment '应用名称'
)
partitioned by (
  ymonth string  
)
stored as parquet
tblproperties ('parquet.compress'='snappy');

-- 2. candidate 表
create table ods_kw_candidate_t (
  candidate_id bigint comment '基本信息流水号',
  project_id bigint comment '项目流水号',
  photo_id bigint comment '照片表流水号',
  archiveno string comment '档案号',
  name string comment '姓名',
  cardtype string comment '证件类型',
  cardno string comment '证件编号',
  nation string comment '民族',
  gender string comment '性别',
  yearofqualify int comment '现有技术资格年限',
  birthdate string comment '出生日期',
  orgname string comment '单位名称',
  orgproperty string comment '单位性质',
  org_belong string comment '单位所属',
  yearofwork int comment '工作年限',
  school bigint comment '在学/毕业学校',
  edulevel string comment '最高学历',
  byzy string comment '毕业专业',
  certtime string comment '毕业时间',
  degree string comment '学位',
  school_remark string comment '学校备注',
  postcode string comment '邮政编码',
  address string comment '地址',
  mobile string comment '手机',
  tel string comment '固定电话',
  email string comment 'email',
  qualify string comment '现有技术资格',
  abode string comment '居住地',
  zzqk string comment '在职情况',
  xl string comment '在学/已有学历',
  major string comment '所学专业',
  work_time string comment '参加工作时间',
  now_qualify string comment '现有职称（资格）',
  now_qualify_date string comment '取得现有职称（资格）时间',
  history_sign string comment '历史考生标识:0表示新生，1表示历史考生',
  name_english string comment '英文名',
  name_used string comment '曾用名',
  nationality string comment '国籍',
  district_id bigint comment '行政区划',
  edu_cert_no string comment '学历证书编号'
)
partitioned by (
  ymonth string
  
)
stored as parquet
tblproperties ('parquet.compress'='snappy');

-- 3. enrollment 表
create table ods_kw_enrollment_t (
  enrollment_id bigint comment '报名记录流水号',
  project_id bigint comment '项目流水号',
  candidate_id bigint comment '基本信息流水号',
  compno bigint comment '报名顺序号',
  compdate string comment '报名时间',
  sub_zy_id bigint comment '报考专业',
  sub_jb_id bigint comment '报考级别',
  org_check_id bigint comment '资格审核机构',
  org_check_level string comment '审核机构级别',
  check_state string comment '资格审核状态',
  org_bmd_id bigint comment '所属报名点id',
  org_shiji_id bigint comment '所属市级机构号',
  org_shengji_id bigint comment '所属省级机构号',
  compmode string comment '报名方式',
  org_shijiseat_id bigint comment '考试市级机构号',
  testcardno string comment '准考证号',
  examinee_type string comment '考生类型'
)
partitioned by (
  ymonth string
  
)
stored as parquet
tblproperties ('parquet.compress'='snappy');

-- 4. subject 表
create table ods_kw_subject_t (
  subject_id bigint comment '科目流水号',
  subject_name string comment '科目名称',
  subject_code string comment '科目编码',
  subject_standard_code string comment '科目标准编码',
  parent_id bigint comment '父流水号',
  sub_level string comment '级别',
  exam_type string comment '考试类型（默认）'
)
partitioned by (
  ymonth string
  
)
stored as parquet
tblproperties ('parquet.compress'='snappy');

-- 5. register 表
create table ods_kw_register_t (
  register_id bigint comment '考生报考科目流水号',
  sub_jb_id bigint comment '报考级别',
  sub_zy_id bigint comment '报考专业',
  sub_km_id bigint comment '科目流水号',
  enrollment_id bigint comment '报名记录流水号',
  avoid_sign string comment '免试标识',
  exam_type string comment '考试类型'
)
partitioned by (
  ymonth string
  
)
stored as parquet
tblproperties ('parquet.compress'='snappy');

-- 6. organization 表
create table ods_kw_organization_t (
  org_id bigint comment '机构流水号',
  org_name string comment '机构名称',
  org_code string comment '机构编码',
  org_standard_code string comment '标准编码',
  org_level string comment '机构级别',
  parent_id bigint comment '父机构流水号'
)
partitioned by (
  ymonth string
  
)
stored as parquet
tblproperties ('parquet.compress'='snappy');


-- 7. examtimes 表
create table ods_kw_examtimes_t (
  examtimes_id bigint comment '场次流水号',
  project_id bigint comment '项目流水号',
  times int comment '场次',
  exam_starttime string comment '场次开始时间',
  exam_endtime string comment '场次结束时间',
  exam_type string comment '考试类型',
  exambatch int comment '考试批次号'
)
partitioned by (
  ymonth string
  
)
stored as parquet
tblproperties ('parquet.compress'='snappy');

-- 8. examfld 表
create table ods_kw_examfld_t (
  examfld_id bigint comment '考场信息流水号',
  org_id bigint comment '机构流水号',
  project_id bigint comment '项目流水号',
  examfld_code string comment '考场编码',
  examfld_name string comment '考场名称',
  examfld_address string comment '考场地址',
  exam_type string comment '标志是机考还是纸考'
)
partitioned by (
  ymonth string
  
)
stored as parquet
tblproperties ('parquet.compress'='snappy');

-- 9. examroom 表
create table ods_kw_examroom_t (
  examroom_id bigint comment '试室信息流水号',
  project_id bigint comment '项目流水号',
  examfld_id bigint comment '所属考场号',
  examroom_name string comment '试室名称',
  examroom_code string comment '试室编码',
  seatnum int comment '座位数',
  condition string comment '试室类别（初级还是中级）',
  exam_type string comment '考试类型',
  org_shiji_id bigint comment '所属市级机构号',
  org_shengji_id bigint comment '所属省级机构号'
)
partitioned by (
  ymonth string
  
)
stored as parquet
tblproperties ('parquet.compress'='snappy');

-- 10. seatinfo 表
create table ods_kw_seatinfo_t (
  seatinfo_id bigint comment '座位表流水号',
  project_id bigint comment '项目流水号',
  examfld_name string comment '考试地点名称',
  examfld_address string comment '考试地点地址',
  examroom_name string comment '试室名称',
  examroom_id bigint comment '试室信息流水号',
  seatno int comment '座位号',
  register_id bigint comment '考生报考科目流水号',
  examtimes_id bigint comment '场次流水号',
  sub_zy_id bigint comment '报考专业',
  name string comment '姓名',
  cardtype string comment '证件类型',
  cardno string comment '证件编号',
  testcardno string comment '准考证号',
  archiveno string comment '档案号',
  exam_starttime string comment '考试开始时间',
  exam_endtime string comment '考试结束时间',
  exam_type string comment '考试类型',
  gender string comment '性别',
  orgname string comment '单位名称',
  candidate_id bigint comment '基本信息流水号'
)
partitioned by (
  ymonth string
  
)
stored as parquet
tblproperties ('parquet.compress'='snappy');

-- 11. kwext_exam 表（卫考表）
create table ods_kw_kwext_exam_t (
  candidate_id bigint comment '基本信息流水号',
  health_condition string comment '健康状况',
  edu_year string comment '学制',
  edu_history string comment '专业学习经历',
  working_sign string comment '是否在岗',
  byzy_remark string comment '毕业专业备注',
  certify_type string comment '执业类别',
  print_allow_sign string comment '准考证允许打印标识',
  nationality_remark string comment '国籍备注',
  primary_health string comment '基层卫生',
  expiry_date string comment '证件有效期的终止日期（格式为：yyyy-mm-dd）'
)
partitioned by (
  ymonth string
  
)
stored as parquet
tblproperties ('parquet.compress'='snappy');

-- 12. kwext_cnepm 表（护考表）
create table ods_kw_kwext_cnepm_t (
  candidate_id bigint comment '基本信息流水号',
  health_condition string comment '健康状况',
  edu_year string comment '学制',
  edu_history string comment '专业学习经历',
  working_sign string comment '是否在岗',
  print_allow_sign string comment '准考证允许打印标识',
  practice string comment '实习单位',
  nationality_remark string comment '国籍备注',
  expiry_date string comment '证件有效期的终止日期（格式为：yyyy-mm-dd）'
)
partitioned by (
  ymonth string
  
)
stored as parquet
tblproperties ('parquet.compress'='snappy');


 
-- 1. 考生表 (examinee)

create table ods_pf_examinee_t (
  examinee_id string comment '流水号',
  archive_id string comment '档案号',
  examineeno string comment '准考证号',
  name string comment '姓名',
  cardno string comment '证件编号'
)
partitioned by (
  ymonth string
  
)
stored as parquet
tblproperties ('parquet.compress'='snappy');

-- 2. 试卷 (paper)
create table ods_pf_paper_t (
  paper_id string comment '试卷id',
  papercode string comment '试卷编号(对应题库)',
  papername string comment '试卷名称',
  papertype string comment '试卷类型:1机考,2纸考',
  project_id bigint comment '项目流水号',
  totalscore decimal(7,2) comment '试卷满分'
)
partitioned by (
  ymonth string
  
)
stored as parquet
tblproperties ('parquet.compress'='snappy');

-- 3. 试题表 (question)
create table ods_pf_question_t (
  question_id string comment '试题id',
  paper_id string comment '试卷编号',
  code string comment '试题编码,对应题库',
  display_code string comment '显示题号',
  display_order int comment '试题顺序号',
  questiontype string comment '题型',
  parent_id string comment '父题型id',
  answerxml string comment '评分规则xml',
  sanswer string comment '正确答案',
  project_id bigint comment '项目流水号',
  fullpoint decimal(7,2) comment '题目满得分点'
)
partitioned by (
  ymonth string
  
)
stored as parquet
tblproperties ('parquet.compress'='snappy');

-- 4. 科目试卷关系 (subject_paper_rel)
create table ods_pf_subject_paper_rel_t (
  subject_paper_rel_id string comment '科目试卷关系id',
  project_id bigint comment '项目流水号',
  subject_id string comment '科目id',
  paper_id string comment '试卷id',
  papercode string comment '试卷code',
  times string comment '场次'
)
partitioned by (
  ymonth string
  
)
stored as parquet
tblproperties ('parquet.compress'='snappy');

-- 5. 一人一科成绩 (score)
create table ods_pf_score_t (
  score_id string comment 'id',
  paper_id string comment '试卷id',
  project_id bigint comment '项目流水号',
  answer_id string comment '答案id答题记录',
  examineeno string comment '准考证号',
  total_point decimal(7,2) comment '考生总得分点',
  full_point decimal(7,2) comment '考生试卷满分得分点',
  final_score decimal(7,2) comment '最终发布分 考生得分',
  isvalid string comment '是否有效(只识别为1的记录)',
  ishistory string comment '是否历史记录(只识别为0的记录)',
  examrecord_id string comment '考场记录id'
)
partitioned by (
  ymonth string
  
)
stored as parquet
tblproperties ('parquet.compress'='snappy');


-- 6. 一人一题得分 (answerscore)
create table ods_pf_answerscore_t (
  answerscore_id string comment 'id',
  examineeno string comment '准考证号',
  paper_id string comment '试卷编号',
  questions_id string comment '试题编号',
  answer_id string comment '答案编号',
  questionpoint decimal(7,2) comment '得分信息考生该题得分点',
  score decimal(7,2) comment '该题得分值',
  selectinfo string comment '答题信息考生选项内容',
  project_id bigint comment '项目流水号',
  addt string comment '操作时间'
)
partitioned by (
  ymonth string
  
)
stored as parquet
tblproperties ('parquet.compress'='snappy');

-- 7. 座位表 (seatinfo)
create table ods_pf_seatinfo_t (
  times string comment '场次',
  sub_zy_id string comment '报考专业',
  examineeno string comment '准考证号',
  project_id bigint comment '项目流水号',
  sub_km_id string comment '报考科目id',
  isvalid string comment '是否有效,0或1',
  examtype string comment '考试类似(1,机考 2.纸考)'
)
partitioned by (
  ymonth string
  
)
stored as parquet
tblproperties ('parquet.compress'='snappy');

-- 8. 通过考生 (passedexaminee)
create table ods_pf_passedexaminee_t (
  passedexaminee_id string comment '通过考生id',
  project_id bigint comment '项目流水号',
  examineeno string comment '准考证号',
  ishistory string comment '是否历史滚动通过(0 一次性通过 1回滚通过)'
)
partitioned by (
  ymonth string
  
)
stored as parquet
tblproperties ('parquet.compress'='snappy');

-- 9. 考场记录 (examrecord)
create table ods_pf_examrecord_t (
  examrecord_id string comment '考场记录id',
  project_id bigint comment '项目流水号',
  examineeno string comment '准考证号',
  examrecordtype_id string comment '考场记录类型id',
  remark string comment '说明备注',
  isvalid string comment '是否有效(只识别为1的记录)',
  sub_zy_id string comment '专业id',
  sub_km_id string comment '科目id',
  reason string comment '违纪事实记录原因'
)
partitioned by (
  ymonth string
  
)
stored as parquet
tblproperties ('parquet.compress'='snappy');

-- 10. 考场记录类型 (examrecordtype)
create table ods_pf_examrecordtype_t (
  examrecordtype_id string comment '考场记录类型id',
  project_id bigint comment '项目流水号',
  code string comment '编码',
  name string comment '名称',
  type string comment '类型'
)
partitioned by (
  ymonth string
  
)
stored as parquet
tblproperties ('parquet.compress'='snappy');

-- 11. 专业科目 (subject)
create table ods_pf_subject_t (
  subject_id string comment '专业科目id',
  project_id bigint comment '项目流水号',
  code string comment '编码(对应考务)',
  standard_code string comment '标准编码(对应考务)',
  name string comment '名称',
  olevel string comment '级别层级',
  parent_id string comment '父级id',
  wmp_subject_id string comment '考务系统中的subject_id(对应考务)'
)
partitioned by (
  ymonth string
  
)
stored as parquet
tblproperties ('parquet.compress'='snappy');





-- 3.ods_tiku.hql
-- 1. 大纲表 (outline)
create table ods_tk_outline_t (
  outline_id string comment '流水号',
  name string comment '名称',
  code string comment '编码',
  olevel int comment '级别',
  parent_id string comment '父id',
  type string comment '类型',
  zsmk string comment '知识模块',
  jbmk string comment '疾病模块'
)
partitioned by (
  ymonth string
  
)
stored as parquet
tblproperties ('parquet.compress'='snappy');

-- 2. 试题表 (question)
create table ods_tk_question_t (
  question_id string comment '试题id',
  question_type_code string comment '题型',
  sub_num int comment '小题数量',
  speciality_id string comment '专业id',
  key_point_id string comment '知识点id'
)
partitioned by (
  ymonth string
  
)
stored as parquet
tblproperties ('parquet.compress'='snappy');

-- 3. 试卷表 (paper)
create table ods_tk_paper_t (
  paper_id string comment '试卷id',
  name string comment '试卷名称'
)
partitioned by (
  ymonth string
  
)
stored as parquet
tblproperties ('parquet.compress'='snappy');

-- 4. 试卷版次 (paper_edition)
create table ods_tk_paper_edition_t (
  paper_edition_id string comment '版次id',
  paper_id string comment '试卷id',
  name int comment '版次名称'
)
partitioned by (
  ymonth string
  
)
stored as parquet
tblproperties ('parquet.compress'='snappy');

-- 5. 版次试题关系 (paper_edition_question)
create table ods_tk_paper_edition_question_t (
  paper_edition_question_id string comment '流水号',
  paper_edition_id string comment '版次id',
  question_id string comment '试题id',
  order_num int comment '题顺序号'
)
partitioned by (
  ymonth string
  
)
stored as parquet
tblproperties ('parquet.compress'='snappy');

-- 6. 数据字典 (sys_code)
create table ods_tk_sys_code_t (
  sys_code_id string comment '流水号',
  type_name string comment '类型名称',
  type_code string comment '类型编码',
  name string comment '名称',
  code string comment '编码'
)
partitioned by (
  ymonth string
  
)
stored as parquet
tblproperties ('parquet.compress'='snappy');


-- 1报名库
CREATE  TABLE  DW_KW_BMK_T( 
KSID STRING COMMENT '考生流水号',
NAME STRING COMMENT '姓名',
DAH STRING COMMENT '档案号', 
XB_OLD STRING COMMENT ' 性别',
MZ_OLD STRING COMMENT '民族',
XL_OLD STRING COMMENT '最高学历',
XW_OLD STRING COMMENT '学位',
BYZY_OLD STRING COMMENT '毕业专业',
SR_OLD STRING COMMENT ' 生日',
XZQY_OLD STRING COMMENT '行政区划', 
SSDM_OLD  STRING COMMENT '省份',
SQDM_OLD  STRING COMMENT '市区CODE',
QXDM_OLD  STRING COMMENT '区县CODE',
DWMC_OLD STRING COMMENT '单位名称',
DWSS_OLD STRING COMMENT '单位所属',
DWXZ_OLD STRING COMMENT '单位性质',
GZNX STRING COMMENT '工作年限',
KSH STRING COMMENT '考生考试编号',
ZJLX_OLD STRING COMMENT ' 考生证件类型',
ZJH_ STRING COMMENT '考生证件号码',
XYJSZG_OLD STRING COMMENT '现有技术资格',
KSLX_OLD STRING COMMENT '考生类型',
JGJB_OLD  STRING COMMENT '机构级别',
XB STRING COMMENT ' 性别',
MZ STRING COMMENT '民族',
XL STRING COMMENT '最高学历',
XW STRING COMMENT '学位',
BYZY STRING COMMENT '毕业专业', 
XZQY STRING COMMENT '行政区划', 
SSDM  STRING COMMENT '省份',
SQDM  STRING COMMENT '市区CODE',
QXDM  STRING COMMENT '区县CODE',
DWMC STRING COMMENT '单位名称',
DWSS STRING COMMENT '单位所属',
DWXZ STRING COMMENT '单位性质',
ZJLX STRING COMMENT ' 考生证件类型', 
XYJSZG STRING COMMENT '现有技术资格',
KSLX STRING COMMENT '考生类型',
JGJB  STRING COMMENT '机构级别'
)
PARTITIONED BY ( YMONTH STRING )ROW FORMAT DELIMITED FIELDS TERMINATED BY '\T' STORED AS PARQUET;

-- 2一人一卷得分表
CREATE  TABLE  DW_PF_YRYJ_SOCRE_T( 
KSH STRING COMMENT '考生号' ,
KSDFD STRING COMMENT '考生实际得分点', 
MDFD STRING COMMENT '满得分点', 
KSDF STRING COMMENT '考生得分',
ANSWER_ID STRING COMMENT '答案ID (一人一套卷一个ID)',
QK STRING COMMENT '缺考标志(WJQXCJ-违纪 QK-缺考)',
SJID STRING COMMENT '试卷ID',
SJDM STRING COMMENT '试卷CODE',
SJNAME STRING COMMENT '试卷名称',
JB_OLD STRING COMMENT '报考级别',
JBNAME STRING COMMENT '报考级别名称',
ZYID STRING COMMENT '专业ID', 
ZYCDM STRING COMMENT '专业长CODE', 
ZYDM_OLD STRING COMMENT '专业CODE', 
ZYNAME STRING COMMENT '专业名称', 
KMID STRING COMMENT '科目ID', 
KMCDM STRING COMMENT '科目长CODE', 
KMDM_OLD STRING COMMENT '科目CODE', 
KMNAME STRING COMMENT '科目名称', 
TG STRING  COMMENT '是否通过 0是一次通过 1 两次通过 NULL 是不通过',
MF STRING  COMMENT '满分',
JB STRING  COMMENT '级别',
ZYDM STRING  COMMENT '专业CODE',
KMDM STRING  COMMENT '科目短CODE'
)
PARTITIONED BY ( YMONTH STRING )ROW FORMAT DELIMITED FIELDS TERMINATED BY '\T' STORED AS PARQUET;




-- 3 双向细目表分区表
CREATE  TABLE  DW_TK_SXXMB_T( 
JB_OLD STRING COMMENT '报考级别',
JBNAME STRING COMMENT '报考级别名称',
SJID STRING COMMENT '',
SJDM STRING COMMENT '试卷CODE',
SJNAME STRING COMMENT '试卷名称',
ZYID STRING COMMENT '专业ID',  
ZYDM_OLD STRING COMMENT '专业CODE', 
ZYNAME STRING COMMENT '专业名称', 
KMID STRING COMMENT '科目ID',  
KMDM_OLD STRING COMMENT '科目编号', 
KMNAME STRING COMMENT '科目名称',  
QUESTIONS_ID STRING COMMENT '评卷表QUESTION_ID',  
CODE STRING COMMENT '题目CODE 关联 题库QUESTION表-QUESTION_ID',  
PARENT_ID STRING COMMENT '父级ID',  
QUESTIONTYPE STRING COMMENT '提型',  
DISPLAY_CODE STRING COMMENT '题号（含大题）',  
DISPLAY_ORDER STRING COMMENT '题目排序',  
SANSWER STRING COMMENT '标答',  
MDFD STRING COMMENT '满得分点、分值',  
SPECIALITY_ID STRING COMMENT '专业名称ID',  
ZSDID STRING COMMENT '知识点ID',  
TKZYNAME STRING COMMENT '专业名称',  
ZSD STRING COMMENT '知识点名称',  
JBFL STRING COMMENT '疾病分类',  
ZSMK STRING COMMENT '知识模块' ,
ZYDM STRING COMMENT '专业CODE', 
KMDM STRING COMMENT '科目编号',
JB STRING  COMMENT '级别'
)
PARTITIONED BY ( YMONTH STRING )ROW FORMAT DELIMITED FIELDS TERMINATED BY '\T' STORED AS PARQUET;



-- 4. 一人一题得分 (answerscore)
create table ods_pf_answerscore_t (
  answerscore_id string comment 'id',
  examineeno string comment '准考证号',
  paper_id string comment '试卷编号',
  questions_id string comment '试题编号',
  answer_id string comment '答案编号',
  questionpoint decimal(7,2) comment '得分信息考生该题得分点',
  score decimal(7,2) comment '该题得分值',
  selectinfo string comment '答题信息考生选项内容',
  project_id bigint comment '项目流水号',
  addt string comment '操作时间'
)
partitioned by (
  ymonth string
  
)
stored as parquet
tblproperties ('parquet.compress'='snappy');





-- 5.维度编码表
CREATE TABLE M_DIMENSION_TYPE_T
(
    NAME STRING COMMENT '维度类型名称'
    CODE STRING COMMENT '维度类型编码',
) ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t' STORED AS PARQUET;


-- 6.维度表
CREATE TABLE M_DIMENSION_T
(
    CODE_TYPE     STRING COMMENT '维度类型',
    NAME          STRING COMMENT '维度名称',
    CODE          STRING COMMENT '维度编码',
    LONG_CODE     STRING COMMENT '维度长编码',
    NEW_NAME      STRING COMMENT '维度新名称',
    NEW_CODE      STRING COMMENT '维度新编码',
    NEW_LONG_CODE STRING COMMENT '维度新长编码',
    SORT          INT COMMENT '排序',
    PARENT_CODE   STRING COMMENT '父编码'
) PARTITIONED BY (                                                             
   YMONTH STRING                                                              
 )                                                                            
 ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t'   
 STORED AS PARQUET ;
