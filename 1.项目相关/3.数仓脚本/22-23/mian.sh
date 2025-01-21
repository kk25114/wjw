#!/bin/bash

bash ./action/etl_sh_new.sh '{"kw_ocl_ip":"192.168.9.105","kw_ocl_port":"3306","kw_ocl_db":"hhrdc_signup_manage","kw_ocl_user":"root","kw_ocl_pw":"123456","pf_ocl_ip":"192.168.9.100","pf_ocl_port":"1521","pf_ocl_db":"orcl","pf_ocl_user":"sms_exam2022","pf_ocl_pw":"sms_exam2022","tk_ocl_ip":"192.168.9.100","tk_ocl_port":"1521","tk_ocl_db":"orcl","tk_ocl_user":"eqbms_czj_hyt","tk_ocl_pw":"eqbms_czj_hyt","hive_db":"wjw_wk","ymonth":"2022-05","exam_id":"131"}'  > ./log/wjw_wk2022-05.log
echo "----启动2022年卫考----"

bash ./action/etl_sh_new.sh '{"kw_ocl_ip":"192.168.9.105","kw_ocl_port":"3306","kw_ocl_db":"hhrdc_signup_manage","kw_ocl_user":"root","kw_ocl_pw":"123456","pf_ocl_ip":"192.168.9.100","pf_ocl_port":"1521","pf_ocl_db":"orcl","pf_ocl_user":"sms_exam2023","pf_ocl_pw":"sms_exam2023","tk_ocl_ip":"192.168.9.100","tk_ocl_port":"1521","tk_ocl_db":"orcl","tk_ocl_user":"eqbms_czj_hyt","tk_ocl_pw":"eqbms_czj_hyt","hive_db":"wjw_wk","ymonth":"2023-05","exam_id":"144"}'  > ./log/wjw_wk2023-05.log
echo "----启动2023年卫考----"

bash ./action/etl_sh_new.sh '{"kw_ocl_ip":"192.168.9.105","kw_ocl_port":"3306","kw_ocl_db":"hhrdc_signup_manage","kw_ocl_user":"root","kw_ocl_pw":"123456","pf_ocl_ip":"192.168.9.100","pf_ocl_port":"1521","pf_ocl_db":"orcl","pf_ocl_user":"sms_cnepm2022","pf_ocl_pw":"sms_cnepm2022","tk_ocl_ip":"192.168.9.100","tk_ocl_port":"1521","tk_ocl_db":"orcl","tk_ocl_user":"eqbms_cnepm_hyt","tk_ocl_pw":"eqbms_cnepm_hyt","hive_db":"wjw_hk","ymonth":"2022-05","exam_id":"135"}'  > ./log/wjw_hk2022-05.log
echo "----启动2022年护考----"

bash ./action/etl_sh_new.sh '{"kw_ocl_ip":"192.168.9.105","kw_ocl_port":"3306","kw_ocl_db":"hhrdc_signup_manage","kw_ocl_user":"root","kw_ocl_pw":"123456","pf_ocl_ip":"192.168.9.100","pf_ocl_port":"1521","pf_ocl_db":"orcl","pf_ocl_user":"sms_cnepm2023","pf_ocl_pw":"sms_cnepm2023","tk_ocl_ip":"192.168.9.100","tk_ocl_port":"1521","tk_ocl_db":"orcl","tk_ocl_user":"eqbms_cnepm_hyt","tk_ocl_pw":"eqbms_cnepm_hyt","hive_db":"wjw_hk","ymonth":"2023-05","exam_id":"143"}'  > ./log/wjw_hk2023-05.log
echo "----启动2023年护考----"


echo "----启动2022年 卫考考延考  考务新系统的考务 ----"
bash ./action/etl_sh_new.sh '{"kw_ocl_ip":"192.168.9.105","kw_ocl_port":"3306","kw_ocl_db":"hhrdc_signup_manage","kw_ocl_user":"root","kw_ocl_pw":"123456","pf_ocl_ip":"192.168.9.100","pf_ocl_port":"1521","pf_ocl_db":"orcl","pf_ocl_user":"sms_exam2022yk","pf_ocl_pw":"sms_exam2022yk","tk_ocl_ip":"192.168.9.100","tk_ocl_port":"1521","tk_ocl_db":"orcl","tk_ocl_user":"eqbms_czj_hyt","tk_ocl_pw":"eqbms_czj_hyt","hive_db":"wjw_wk","ymonth":"2022-06"}'  > ./log/wjw_hk2022-06.log

echo "----启动2022年 卫考考延考  考务新系统的考务 ----"
bash ./action/etl_sh_new.sh '{"kw_ocl_ip":"192.168.9.105","kw_ocl_port":"3306","kw_ocl_db":"hhrdc_signup_manage","kw_ocl_user":"root","kw_ocl_pw":"123456","pf_ocl_ip":"192.168.9.100","pf_ocl_port":"1521","pf_ocl_db":"orcl","pf_ocl_user":"sms_cnepm2022yk","pf_ocl_pw":"sms_cnepm2022yk","tk_ocl_ip":"192.168.9.100","tk_ocl_port":"1521","tk_ocl_db":"orcl","tk_ocl_user":"eqbms_cnepm_hyt","tk_ocl_pw":"eqbms_cnepm_hyt","hive_db":"wjw_hk","ymonth":"2022-06"}'  > ./log/wjw_hk2022-06.log
