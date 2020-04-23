/*
 Navicat Premium Data Transfer

 Source Server         : mytxPostgres
 Source Server Type    : PostgreSQL
 Source Server Version : 110007
 Source Host           : 129.211.23.185:5432
 Source Catalog        : employee
 Source Schema         : public

 Target Server Type    : PostgreSQL
 Target Server Version : 110007
 File Encoding         : 65001

 Date: 23/04/2020 09:26:39
*/


-- ----------------------------
-- Sequence structure for sys_log_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."sys_log_id_seq";
CREATE SEQUENCE "public"."sys_log_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 2147483647
START 1
CACHE 1;

-- ----------------------------
-- Table structure for employee_again_entry
-- ----------------------------
DROP TABLE IF EXISTS "public"."employee_again_entry";
CREATE TABLE "public"."employee_again_entry" (
  "again_id" varchar(32) COLLATE "pg_catalog"."default" NOT NULL,
  "base_id" varchar(32) COLLATE "pg_catalog"."default",
  "base_no" varchar(20) COLLATE "pg_catalog"."default",
  "name" varchar(50) COLLATE "pg_catalog"."default",
  "gender" int4,
  "age" int4,
  "education" varchar(10) COLLATE "pg_catalog"."default",
  "id_card" varchar(20) COLLATE "pg_catalog"."default",
  "original_unit" varchar(50) COLLATE "pg_catalog"."default",
  "now_unit" varchar(50) COLLATE "pg_catalog"."default",
  "entry_time" date,
  "original_org_id" varchar(32) COLLATE "pg_catalog"."default",
  "create_time" timestamp(0),
  "update_time" timestamp(0),
  "department" varchar(255) COLLATE "pg_catalog"."default",
  "state" int4 DEFAULT 0
)
;
COMMENT ON COLUMN "public"."employee_again_entry"."again_id" IS '主键Id';
COMMENT ON COLUMN "public"."employee_again_entry"."base_id" IS '基本信息表Id';
COMMENT ON COLUMN "public"."employee_again_entry"."base_no" IS '编号';
COMMENT ON COLUMN "public"."employee_again_entry"."name" IS '姓名';
COMMENT ON COLUMN "public"."employee_again_entry"."gender" IS '性别';
COMMENT ON COLUMN "public"."employee_again_entry"."age" IS '年龄';
COMMENT ON COLUMN "public"."employee_again_entry"."education" IS '学历';
COMMENT ON COLUMN "public"."employee_again_entry"."id_card" IS '身份证号';
COMMENT ON COLUMN "public"."employee_again_entry"."original_unit" IS '原单位';
COMMENT ON COLUMN "public"."employee_again_entry"."now_unit" IS '现单位';
COMMENT ON COLUMN "public"."employee_again_entry"."entry_time" IS '入职时间';
COMMENT ON COLUMN "public"."employee_again_entry"."original_org_id" IS '原单位codeId';
COMMENT ON COLUMN "public"."employee_again_entry"."create_time" IS '创建时间';
COMMENT ON COLUMN "public"."employee_again_entry"."update_time" IS '更新时间';
COMMENT ON COLUMN "public"."employee_again_entry"."department" IS '部门';
COMMENT ON COLUMN "public"."employee_again_entry"."state" IS '状态：用于删除，0:正常，1删除';
COMMENT ON TABLE "public"."employee_again_entry" IS '再次入职';

-- ----------------------------
-- Table structure for employee_assess_record
-- ----------------------------
DROP TABLE IF EXISTS "public"."employee_assess_record";
CREATE TABLE "public"."employee_assess_record" (
  "assess_id" varchar(32) COLLATE "pg_catalog"."default" NOT NULL,
  "base_id" varchar(32) COLLATE "pg_catalog"."default",
  "type" varchar(15) COLLATE "pg_catalog"."default",
  "assess_time" date,
  "assess_name" varchar(50) COLLATE "pg_catalog"."default",
  "result" varchar(15) COLLATE "pg_catalog"."default",
  "remark" varchar(255) COLLATE "pg_catalog"."default",
  "create_time" timestamp(0),
  "update_time" timestamp(0),
  "assess_content" varchar(50) COLLATE "pg_catalog"."default",
  "assess_unit" varchar(50) COLLATE "pg_catalog"."default",
  "evaluate" varchar(255) COLLATE "pg_catalog"."default",
  "end_time" date,
  "ass_name" varchar(50) COLLATE "pg_catalog"."default",
  "url" varchar(500) COLLATE "pg_catalog"."default"
)
;
COMMENT ON COLUMN "public"."employee_assess_record"."assess_id" IS '主键Id';
COMMENT ON COLUMN "public"."employee_assess_record"."base_id" IS '外键Id(基础信息表Id)';
COMMENT ON COLUMN "public"."employee_assess_record"."type" IS '考核类型（1:年度考核，2:季度考核）';
COMMENT ON COLUMN "public"."employee_assess_record"."assess_time" IS '考核时间';
COMMENT ON COLUMN "public"."employee_assess_record"."assess_name" IS '考核人';
COMMENT ON COLUMN "public"."employee_assess_record"."result" IS '考核结果';
COMMENT ON COLUMN "public"."employee_assess_record"."remark" IS '备注';
COMMENT ON COLUMN "public"."employee_assess_record"."create_time" IS '创建时间';
COMMENT ON COLUMN "public"."employee_assess_record"."update_time" IS '更新时间';
COMMENT ON COLUMN "public"."employee_assess_record"."assess_content" IS '考核内容';
COMMENT ON COLUMN "public"."employee_assess_record"."assess_unit" IS '考核单位';
COMMENT ON COLUMN "public"."employee_assess_record"."evaluate" IS '考核评价';
COMMENT ON COLUMN "public"."employee_assess_record"."end_time" IS '考核结束时间';
COMMENT ON COLUMN "public"."employee_assess_record"."ass_name" IS '考核名称';
COMMENT ON TABLE "public"."employee_assess_record" IS '考核信息记录表';

-- ----------------------------
-- Table structure for employee_base_info
-- ----------------------------
DROP TABLE IF EXISTS "public"."employee_base_info";
CREATE TABLE "public"."employee_base_info" (
  "base_id" varchar(32) COLLATE "pg_catalog"."default" NOT NULL,
  "create_time" timestamp(0),
  "update_time" timestamp(0),
  "name" varchar(50) COLLATE "pg_catalog"."default",
  "gender" int4,
  "birthday" date,
  "id_card" varchar(20) COLLATE "pg_catalog"."default",
  "marriage_state" int4,
  "politics_state" int4,
  "home_address" varchar(100) COLLATE "pg_catalog"."default",
  "photo_path" varchar(255) COLLATE "pg_catalog"."default",
  "comm_address" varchar(255) COLLATE "pg_catalog"."default",
  "post_code" varchar(15) COLLATE "pg_catalog"."default",
  "phone" varchar(11) COLLATE "pg_catalog"."default",
  "email" varchar(50) COLLATE "pg_catalog"."default",
  "resume" text COLLATE "pg_catalog"."default",
  "speciality" varchar(255) COLLATE "pg_catalog"."default",
  "court_id" varchar(32) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
  "base_no" varchar(25) COLLATE "pg_catalog"."default",
  "education" varchar(10) COLLATE "pg_catalog"."default",
  "work_unit" varchar(50) COLLATE "pg_catalog"."default",
  "department" varchar(50) COLLATE "pg_catalog"."default",
  "entry_time" date,
  "level" int4,
  "status" int4,
  "former_name" varchar(32) COLLATE "pg_catalog"."default",
  "position" varchar(32) COLLATE "pg_catalog"."default",
  "nation" int4,
  "native_place" varchar(32) COLLATE "pg_catalog"."default",
  "positive_time" date,
  "employment_form" varchar(32) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
  "domicile_place" varchar(255) COLLATE "pg_catalog"."default",
  "qq_number" varchar(32) COLLATE "pg_catalog"."default",
  "wechat_number" varchar(32) COLLATE "pg_catalog"."default",
  "salary_card" varchar(32) COLLATE "pg_catalog"."default",
  "issuing_bank" varchar(50) COLLATE "pg_catalog"."default",
  "stature" varchar(10) COLLATE "pg_catalog"."default",
  "blood_type" varchar(10) COLLATE "pg_catalog"."default",
  "weight" varchar(10) COLLATE "pg_catalog"."default",
  "religion" varchar(50) COLLATE "pg_catalog"."default",
  "foreign_languages" varchar(50) COLLATE "pg_catalog"."default",
  "foreign_languages_level" varchar(50) COLLATE "pg_catalog"."default",
  "computer_level" varchar(50) COLLATE "pg_catalog"."default",
  "hobbies" varchar(255) COLLATE "pg_catalog"."default",
  "remark" varchar(255) COLLATE "pg_catalog"."default",
  "age" int4,
  "org_id" varchar(32) COLLATE "pg_catalog"."default",
  "url" varchar(500) COLLATE "pg_catalog"."default",
  "dimission_time" date,
  "state" int4 DEFAULT 0,
  "specialty" int4
)
;
COMMENT ON COLUMN "public"."employee_base_info"."base_id" IS '主键';
COMMENT ON COLUMN "public"."employee_base_info"."create_time" IS '创建时间';
COMMENT ON COLUMN "public"."employee_base_info"."update_time" IS '更新时间';
COMMENT ON COLUMN "public"."employee_base_info"."name" IS '姓名';
COMMENT ON COLUMN "public"."employee_base_info"."gender" IS '性别';
COMMENT ON COLUMN "public"."employee_base_info"."birthday" IS '生日/出生日期';
COMMENT ON COLUMN "public"."employee_base_info"."id_card" IS '身份证号';
COMMENT ON COLUMN "public"."employee_base_info"."marriage_state" IS '婚姻状态';
COMMENT ON COLUMN "public"."employee_base_info"."politics_state" IS '政治状态';
COMMENT ON COLUMN "public"."employee_base_info"."home_address" IS '家庭住址-辅助信息';
COMMENT ON COLUMN "public"."employee_base_info"."photo_path" IS '照片地址';
COMMENT ON COLUMN "public"."employee_base_info"."comm_address" IS '通信地址_辅助信息';
COMMENT ON COLUMN "public"."employee_base_info"."post_code" IS '邮政编码_辅助信息';
COMMENT ON COLUMN "public"."employee_base_info"."phone" IS '联系电话';
COMMENT ON COLUMN "public"."employee_base_info"."email" IS '电子邮箱_辅助信息';
COMMENT ON COLUMN "public"."employee_base_info"."resume" IS '简历_工作简历';
COMMENT ON COLUMN "public"."employee_base_info"."speciality" IS '技能特长-辅助信息';
COMMENT ON COLUMN "public"."employee_base_info"."court_id" IS 'sys_user_admin的主键';
COMMENT ON COLUMN "public"."employee_base_info"."base_no" IS 'ID编号';
COMMENT ON COLUMN "public"."employee_base_info"."education" IS '学历';
COMMENT ON COLUMN "public"."employee_base_info"."work_unit" IS '工作单位';
COMMENT ON COLUMN "public"."employee_base_info"."department" IS '部门';
COMMENT ON COLUMN "public"."employee_base_info"."entry_time" IS '入职时间';
COMMENT ON COLUMN "public"."employee_base_info"."level" IS '级别';
COMMENT ON COLUMN "public"."employee_base_info"."status" IS '0:在职，1：离职';
COMMENT ON COLUMN "public"."employee_base_info"."former_name" IS '曾用名';
COMMENT ON COLUMN "public"."employee_base_info"."position" IS '所任职务';
COMMENT ON COLUMN "public"."employee_base_info"."nation" IS '民族';
COMMENT ON COLUMN "public"."employee_base_info"."native_place" IS '籍贯';
COMMENT ON COLUMN "public"."employee_base_info"."positive_time" IS '转正时间';
COMMENT ON COLUMN "public"."employee_base_info"."employment_form" IS '用工形式';
COMMENT ON COLUMN "public"."employee_base_info"."domicile_place" IS '户口所在地-辅助信息';
COMMENT ON COLUMN "public"."employee_base_info"."qq_number" IS 'qq号码-辅助信息';
COMMENT ON COLUMN "public"."employee_base_info"."wechat_number" IS '微信号码-辅助信息';
COMMENT ON COLUMN "public"."employee_base_info"."salary_card" IS '工资卡号-辅助信息';
COMMENT ON COLUMN "public"."employee_base_info"."issuing_bank" IS '工资卡发卡银行-辅助信息';
COMMENT ON COLUMN "public"."employee_base_info"."stature" IS '身高-辅助信息';
COMMENT ON COLUMN "public"."employee_base_info"."blood_type" IS '血型-辅助信息';
COMMENT ON COLUMN "public"."employee_base_info"."weight" IS '体重-辅助信息';
COMMENT ON COLUMN "public"."employee_base_info"."religion" IS '宗教信仰-辅助信息';
COMMENT ON COLUMN "public"."employee_base_info"."foreign_languages" IS '外语语种-辅助信息';
COMMENT ON COLUMN "public"."employee_base_info"."foreign_languages_level" IS '外语水平-辅助信息';
COMMENT ON COLUMN "public"."employee_base_info"."computer_level" IS '电脑水平-辅助信息';
COMMENT ON COLUMN "public"."employee_base_info"."hobbies" IS '兴趣爱好-辅助信息';
COMMENT ON COLUMN "public"."employee_base_info"."remark" IS '备注-辅助信息';
COMMENT ON COLUMN "public"."employee_base_info"."age" IS '年龄';
COMMENT ON COLUMN "public"."employee_base_info"."org_id" IS '单位Code';
COMMENT ON COLUMN "public"."employee_base_info"."dimission_time" IS '离职时间';
COMMENT ON COLUMN "public"."employee_base_info"."state" IS '状态：用于删除，0:正常，1删除';
COMMENT ON COLUMN "public"."employee_base_info"."specialty" IS '专业';
COMMENT ON TABLE "public"."employee_base_info" IS '书记员基本信息表；包含基本信息，辅助信息，工作简历，技术及特长';

-- ----------------------------
-- Table structure for employee_call_record
-- ----------------------------
DROP TABLE IF EXISTS "public"."employee_call_record";
CREATE TABLE "public"."employee_call_record" (
  "call_id" varchar(32) COLLATE "pg_catalog"."default" NOT NULL,
  "base_id" varchar(32) COLLATE "pg_catalog"."default",
  "transfer_before_unit" varchar(50) COLLATE "pg_catalog"."default",
  "transfer_after_unit" varchar(50) COLLATE "pg_catalog"."default",
  "reason" varchar(255) COLLATE "pg_catalog"."default",
  "remark" varchar(255) COLLATE "pg_catalog"."default",
  "create_time" timestamp(0),
  "update_time" timestamp(0),
  "transfer_time" date,
  "approver_dept" varchar(50) COLLATE "pg_catalog"."default",
  "approver_time" date,
  "transfer_after_duty" varchar(50) COLLATE "pg_catalog"."default",
  "transfer_before_duty" varchar(50) COLLATE "pg_catalog"."default"
)
;
COMMENT ON COLUMN "public"."employee_call_record"."call_id" IS '主键ID';
COMMENT ON COLUMN "public"."employee_call_record"."base_id" IS '外键Id(基础信息表Id)';
COMMENT ON COLUMN "public"."employee_call_record"."transfer_before_unit" IS '调动前单位';
COMMENT ON COLUMN "public"."employee_call_record"."transfer_after_unit" IS '调动后单位';
COMMENT ON COLUMN "public"."employee_call_record"."reason" IS '调动工作的缘由(原因)';
COMMENT ON COLUMN "public"."employee_call_record"."remark" IS '备注';
COMMENT ON COLUMN "public"."employee_call_record"."create_time" IS '创建时间';
COMMENT ON COLUMN "public"."employee_call_record"."update_time" IS '更新时间';
COMMENT ON COLUMN "public"."employee_call_record"."transfer_time" IS '调动日期';
COMMENT ON COLUMN "public"."employee_call_record"."approver_dept" IS '批准单位（部门）';
COMMENT ON COLUMN "public"."employee_call_record"."approver_time" IS '批准时间';
COMMENT ON COLUMN "public"."employee_call_record"."transfer_after_duty" IS '调动后职务';
COMMENT ON COLUMN "public"."employee_call_record"."transfer_before_duty" IS '调动前职务';
COMMENT ON TABLE "public"."employee_call_record" IS '调用记录表';

-- ----------------------------
-- Table structure for employee_dimission_record
-- ----------------------------
DROP TABLE IF EXISTS "public"."employee_dimission_record";
CREATE TABLE "public"."employee_dimission_record" (
  "dimission_id" varchar(32) COLLATE "pg_catalog"."default" NOT NULL,
  "base_id" varchar(32) COLLATE "pg_catalog"."default",
  "dimission_time" date,
  "dimission_reason" varchar(255) COLLATE "pg_catalog"."default",
  "leave_to" varchar(255) COLLATE "pg_catalog"."default",
  "reentry_record" varchar(255) COLLATE "pg_catalog"."default",
  "create_time" timestamp(0),
  "update_time" timestamp(0),
  "name" varchar(50) COLLATE "pg_catalog"."default",
  "gender" int4,
  "age" int4,
  "education" varchar(255) COLLATE "pg_catalog"."default",
  "politics_state" int4,
  "id_card" varchar(20) COLLATE "pg_catalog"."default",
  "work_unit" varchar(50) COLLATE "pg_catalog"."default",
  "department" varchar(50) COLLATE "pg_catalog"."default",
  "base_no" varchar(20) COLLATE "pg_catalog"."default",
  "org_id" varchar(32) COLLATE "pg_catalog"."default",
  "url" varchar(500) COLLATE "pg_catalog"."default"
)
;
COMMENT ON COLUMN "public"."employee_dimission_record"."dimission_id" IS '主键ID';
COMMENT ON COLUMN "public"."employee_dimission_record"."base_id" IS '外键Id(基础信息表id)';
COMMENT ON COLUMN "public"."employee_dimission_record"."dimission_time" IS '离职时间';
COMMENT ON COLUMN "public"."employee_dimission_record"."dimission_reason" IS '离职原因';
COMMENT ON COLUMN "public"."employee_dimission_record"."leave_to" IS '离职去向';
COMMENT ON COLUMN "public"."employee_dimission_record"."reentry_record" IS '再次入职记录';
COMMENT ON COLUMN "public"."employee_dimission_record"."create_time" IS '创建时间';
COMMENT ON COLUMN "public"."employee_dimission_record"."update_time" IS '更新时间';
COMMENT ON COLUMN "public"."employee_dimission_record"."name" IS '姓名';
COMMENT ON COLUMN "public"."employee_dimission_record"."gender" IS '性别';
COMMENT ON COLUMN "public"."employee_dimission_record"."age" IS '年龄';
COMMENT ON COLUMN "public"."employee_dimission_record"."education" IS '学历';
COMMENT ON COLUMN "public"."employee_dimission_record"."politics_state" IS '政治面貌';
COMMENT ON COLUMN "public"."employee_dimission_record"."id_card" IS '身份证号';
COMMENT ON COLUMN "public"."employee_dimission_record"."work_unit" IS '原单位';
COMMENT ON COLUMN "public"."employee_dimission_record"."department" IS '原部门';
COMMENT ON COLUMN "public"."employee_dimission_record"."base_no" IS '编号';
COMMENT ON COLUMN "public"."employee_dimission_record"."org_id" IS '单位Code';
COMMENT ON TABLE "public"."employee_dimission_record" IS '离职记录表';

-- ----------------------------
-- Table structure for employee_edu_info
-- ----------------------------
DROP TABLE IF EXISTS "public"."employee_edu_info";
CREATE TABLE "public"."employee_edu_info" (
  "edu_id" varchar(32) COLLATE "pg_catalog"."default" NOT NULL,
  "base_id" varchar(32) COLLATE "pg_catalog"."default" NOT NULL,
  "learning_schools" varchar(50) COLLATE "pg_catalog"."default",
  "specialty" varchar(50) COLLATE "pg_catalog"."default",
  "remark" varchar(255) COLLATE "pg_catalog"."default",
  "begin_time" date,
  "end_time" date,
  "crate_time" timestamp(0),
  "update_time" timestamp(0),
  "education" int4,
  "degree" int4,
  "license_number" varchar(32) COLLATE "pg_catalog"."default",
  "license_name" varchar(50) COLLATE "pg_catalog"."default",
  "certifying_authority" varchar(50) COLLATE "pg_catalog"."default",
  "certificate_time" date,
  "failure_time" date,
  "license_url" text COLLATE "pg_catalog"."default"
)
;
COMMENT ON COLUMN "public"."employee_edu_info"."edu_id" IS '主键Id';
COMMENT ON COLUMN "public"."employee_edu_info"."base_id" IS '外键(基础信息表ID)';
COMMENT ON COLUMN "public"."employee_edu_info"."learning_schools" IS '校院名称';
COMMENT ON COLUMN "public"."employee_edu_info"."specialty" IS '所学专业';
COMMENT ON COLUMN "public"."employee_edu_info"."remark" IS '备注';
COMMENT ON COLUMN "public"."employee_edu_info"."begin_time" IS '开始时间';
COMMENT ON COLUMN "public"."employee_edu_info"."end_time" IS '结束时间';
COMMENT ON COLUMN "public"."employee_edu_info"."crate_time" IS '创建时间';
COMMENT ON COLUMN "public"."employee_edu_info"."update_time" IS '更新时间';
COMMENT ON COLUMN "public"."employee_edu_info"."education" IS '学历状况';
COMMENT ON COLUMN "public"."employee_edu_info"."degree" IS '学位状况';
COMMENT ON COLUMN "public"."employee_edu_info"."license_number" IS '证照编号';
COMMENT ON COLUMN "public"."employee_edu_info"."license_name" IS '证照名称';
COMMENT ON COLUMN "public"."employee_edu_info"."certifying_authority" IS '发证机构';
COMMENT ON COLUMN "public"."employee_edu_info"."certificate_time" IS '发证时间';
COMMENT ON COLUMN "public"."employee_edu_info"."failure_time" IS '证书失效时间';
COMMENT ON COLUMN "public"."employee_edu_info"."license_url" IS '证照附件';
COMMENT ON TABLE "public"."employee_edu_info" IS '教育信息记录表';

-- ----------------------------
-- Table structure for employee_equip_record
-- ----------------------------
DROP TABLE IF EXISTS "public"."employee_equip_record";
CREATE TABLE "public"."employee_equip_record" (
  "employee_equip_id" varchar(32) COLLATE "pg_catalog"."default" NOT NULL,
  "base_id" varchar(32) COLLATE "pg_catalog"."default",
  "equip_id" varchar(32) COLLATE "pg_catalog"."default",
  "name" varchar(50) COLLATE "pg_catalog"."default",
  "number" varchar(15) COLLATE "pg_catalog"."default",
  "equip_reason" varchar(255) COLLATE "pg_catalog"."default",
  "get_time" date,
  "cancel_time" date,
  "remark" varchar(255) COLLATE "pg_catalog"."default",
  "create_time" timestamp(0),
  "update_time" timestamp(0),
  "equip_type" varchar(50) COLLATE "pg_catalog"."default",
  "model" varchar(50) COLLATE "pg_catalog"."default",
  "specification" varchar(50) COLLATE "pg_catalog"."default",
  "state" varchar(20) COLLATE "pg_catalog"."default",
  "undertaker" varchar(40) COLLATE "pg_catalog"."default",
  "return_time" date,
  "url" varchar(500) COLLATE "pg_catalog"."default"
)
;
COMMENT ON COLUMN "public"."employee_equip_record"."employee_equip_id" IS '主键Id';
COMMENT ON COLUMN "public"."employee_equip_record"."base_id" IS '外键Id(基础信息表Id)';
COMMENT ON COLUMN "public"."employee_equip_record"."equip_id" IS '外键Id(装备管理表Id)';
COMMENT ON COLUMN "public"."employee_equip_record"."name" IS '装备名称';
COMMENT ON COLUMN "public"."employee_equip_record"."number" IS '装备编号';
COMMENT ON COLUMN "public"."employee_equip_record"."equip_reason" IS '配备缘由';
COMMENT ON COLUMN "public"."employee_equip_record"."get_time" IS '领取日期';
COMMENT ON COLUMN "public"."employee_equip_record"."cancel_time" IS '注销日期';
COMMENT ON COLUMN "public"."employee_equip_record"."remark" IS '备注';
COMMENT ON COLUMN "public"."employee_equip_record"."create_time" IS '创建时间';
COMMENT ON COLUMN "public"."employee_equip_record"."update_time" IS '更新时间';
COMMENT ON COLUMN "public"."employee_equip_record"."equip_type" IS '装备类型';
COMMENT ON COLUMN "public"."employee_equip_record"."model" IS '型号';
COMMENT ON COLUMN "public"."employee_equip_record"."specification" IS '规格';
COMMENT ON COLUMN "public"."employee_equip_record"."state" IS '状态(1:未归还，2：已归还)';
COMMENT ON COLUMN "public"."employee_equip_record"."undertaker" IS '承办人';
COMMENT ON COLUMN "public"."employee_equip_record"."return_time" IS '归还时间';
COMMENT ON TABLE "public"."employee_equip_record" IS '书记员装备信息管理记录表';

-- ----------------------------
-- Table structure for employee_labor_contract
-- ----------------------------
DROP TABLE IF EXISTS "public"."employee_labor_contract";
CREATE TABLE "public"."employee_labor_contract" (
  "contract_id" varchar(32) COLLATE "pg_catalog"."default" NOT NULL,
  "base_id" varchar(32) COLLATE "pg_catalog"."default",
  "number" varchar(50) COLLATE "pg_catalog"."default",
  "type" varchar(50) COLLATE "pg_catalog"."default",
  "contract_time" varchar(50) COLLATE "pg_catalog"."default",
  "sign_contract_time" date,
  "take_effect_time" date,
  "lose_efficacy_time" date,
  "dispatch_dept" varchar(50) COLLATE "pg_catalog"."default",
  "social_security_condition" varchar(255) COLLATE "pg_catalog"."default",
  "remark" varchar(255) COLLATE "pg_catalog"."default",
  "create_time" timestamp(0),
  "update_time" timestamp(0),
  "contract_name" varchar(50) COLLATE "pg_catalog"."default",
  "job_wage" varchar(10) COLLATE "pg_catalog"."default",
  "job_subsidies" varchar(10) COLLATE "pg_catalog"."default",
  "merit_pay" varchar(10) COLLATE "pg_catalog"."default",
  "endowment_insurance_time" date,
  "endowment_insurance_account" varchar(20) COLLATE "pg_catalog"."default",
  "medical_insurance_time" date,
  "medical_insurance_account" varchar(20) COLLATE "pg_catalog"."default",
  "unemployment_insurance_time" date,
  "unemployment_insurance_account" varchar(20) COLLATE "pg_catalog"."default",
  "ei_insurance_time" date,
  "ei_insurance_account" varchar(20) COLLATE "pg_catalog"."default",
  "maternity_insurance_time" date,
  "maternity_insurance_account" varchar(20) COLLATE "pg_catalog"."default",
  "provident_fund_time" date,
  "provident_fund_account" varchar(20) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
  "url" text COLLATE "pg_catalog"."default",
  "pay_param" varchar(20) COLLATE "pg_catalog"."default",
  "state" varchar(20) COLLATE "pg_catalog"."default"
)
;
COMMENT ON COLUMN "public"."employee_labor_contract"."contract_id" IS '主键Id';
COMMENT ON COLUMN "public"."employee_labor_contract"."base_id" IS '外键Id(基础信息表Id)';
COMMENT ON COLUMN "public"."employee_labor_contract"."number" IS '合同编号';
COMMENT ON COLUMN "public"."employee_labor_contract"."type" IS '合同类型';
COMMENT ON COLUMN "public"."employee_labor_contract"."contract_time" IS '合同期限';
COMMENT ON COLUMN "public"."employee_labor_contract"."sign_contract_time" IS '签订合同日期';
COMMENT ON COLUMN "public"."employee_labor_contract"."take_effect_time" IS '合同生效日期';
COMMENT ON COLUMN "public"."employee_labor_contract"."lose_efficacy_time" IS '合同失效日期';
COMMENT ON COLUMN "public"."employee_labor_contract"."dispatch_dept" IS '派遣单位（签订单位）';
COMMENT ON COLUMN "public"."employee_labor_contract"."social_security_condition" IS '“五险一金”社会保障待遇的落实情况';
COMMENT ON COLUMN "public"."employee_labor_contract"."remark" IS '备注';
COMMENT ON COLUMN "public"."employee_labor_contract"."create_time" IS '创建时间';
COMMENT ON COLUMN "public"."employee_labor_contract"."update_time" IS '更新时间';
COMMENT ON COLUMN "public"."employee_labor_contract"."contract_name" IS '合同名称';
COMMENT ON COLUMN "public"."employee_labor_contract"."job_wage" IS '职务工资';
COMMENT ON COLUMN "public"."employee_labor_contract"."job_subsidies" IS '岗位津贴（元/月）';
COMMENT ON COLUMN "public"."employee_labor_contract"."merit_pay" IS '绩效工资（元/年）';
COMMENT ON COLUMN "public"."employee_labor_contract"."endowment_insurance_time" IS '养老保险时间';
COMMENT ON COLUMN "public"."employee_labor_contract"."endowment_insurance_account" IS '养老保险账号';
COMMENT ON COLUMN "public"."employee_labor_contract"."medical_insurance_time" IS '医疗保险时间';
COMMENT ON COLUMN "public"."employee_labor_contract"."medical_insurance_account" IS '医疗保险账号';
COMMENT ON COLUMN "public"."employee_labor_contract"."unemployment_insurance_time" IS '失业保险时间';
COMMENT ON COLUMN "public"."employee_labor_contract"."unemployment_insurance_account" IS '失业保险账号';
COMMENT ON COLUMN "public"."employee_labor_contract"."ei_insurance_time" IS '工商保险时间';
COMMENT ON COLUMN "public"."employee_labor_contract"."ei_insurance_account" IS '工商保险账号';
COMMENT ON COLUMN "public"."employee_labor_contract"."maternity_insurance_time" IS '生育保险时间';
COMMENT ON COLUMN "public"."employee_labor_contract"."maternity_insurance_account" IS '生育保险账号';
COMMENT ON COLUMN "public"."employee_labor_contract"."provident_fund_time" IS '参加公积金时间';
COMMENT ON COLUMN "public"."employee_labor_contract"."provident_fund_account" IS '公积金账号';
COMMENT ON COLUMN "public"."employee_labor_contract"."url" IS '附件扫描件地址';
COMMENT ON COLUMN "public"."employee_labor_contract"."pay_param" IS '保险缴纳参数（80%）';
COMMENT ON COLUMN "public"."employee_labor_contract"."state" IS '状态';
COMMENT ON TABLE "public"."employee_labor_contract" IS '劳动合同信息记录表';

-- ----------------------------
-- Table structure for employee_leave_record
-- ----------------------------
DROP TABLE IF EXISTS "public"."employee_leave_record";
CREATE TABLE "public"."employee_leave_record" (
  "leave_id" varchar(32) COLLATE "pg_catalog"."default" NOT NULL,
  "base_id" varchar(32) COLLATE "pg_catalog"."default",
  "reasons" varchar(255) COLLATE "pg_catalog"."default",
  "begin_leave_time" date,
  "ratify_day" varchar(32) COLLATE "pg_catalog"."default",
  "approval_dept" varchar(50) COLLATE "pg_catalog"."default",
  "approval_time" date,
  "remark" varchar(255) COLLATE "pg_catalog"."default",
  "create_time" timestamp(0),
  "update_time" timestamp(0),
  "type" varchar(20) COLLATE "pg_catalog"."default",
  "end_leave_time" date,
  "url" varchar(500) COLLATE "pg_catalog"."default"
)
;
COMMENT ON COLUMN "public"."employee_leave_record"."leave_id" IS '主键Id';
COMMENT ON COLUMN "public"."employee_leave_record"."base_id" IS '外键Id(基础信息表Id)';
COMMENT ON COLUMN "public"."employee_leave_record"."reasons" IS '请假事由';
COMMENT ON COLUMN "public"."employee_leave_record"."begin_leave_time" IS '请假开始日期';
COMMENT ON COLUMN "public"."employee_leave_record"."ratify_day" IS '请假时长（天）';
COMMENT ON COLUMN "public"."employee_leave_record"."approval_dept" IS '审批部门（批准单位）';
COMMENT ON COLUMN "public"."employee_leave_record"."approval_time" IS '审批日期 （批准日期）';
COMMENT ON COLUMN "public"."employee_leave_record"."remark" IS '备注';
COMMENT ON COLUMN "public"."employee_leave_record"."create_time" IS '创建时间';
COMMENT ON COLUMN "public"."employee_leave_record"."update_time" IS '更新时间';
COMMENT ON COLUMN "public"."employee_leave_record"."type" IS '请假类型';
COMMENT ON COLUMN "public"."employee_leave_record"."end_leave_time" IS '请假结束日期';
COMMENT ON TABLE "public"."employee_leave_record" IS '请假记录信息表';

-- ----------------------------
-- Records of employee_leave_record
-- ----------------------------
INSERT INTO "public"."employee_leave_record" VALUES ('3fe820099f8f17815df4bfb689173660', 'fd689de0a52afa6e5f61cc0599d6cae6', NULL, NULL, '', '', NULL, NULL, '2020-04-01 17:31:18', '2020-04-01 17:31:18', '', NULL, 'eba5a80e9cadb9e9c45f810e7de13027,2d0b38ee6c816429b95487e3ab6a136e,3c57a2928be2091071213209a28d1364,e4eb4d153b6aefdfd175fb957e7fed19,3caf975d4a0c9a3b551d46d64c6304ff,ac046d40439d26b6928bd97eab3ecc6f');
INSERT INTO "public"."employee_leave_record" VALUES ('226a43a8a9eff83841e0d30a8dc51f36', '32f210ab2db15b051f8ecd0ee66c6b45', NULL, NULL, '', '', NULL, NULL, '2020-04-02 08:48:03', '2020-04-02 08:48:03', '', NULL, 'eba5a80e9cadb9e9c45f810e7de13027,2d0b38ee6c816429b95487e3ab6a136e,3c57a2928be2091071213209a28d1364,e4eb4d153b6aefdfd175fb957e7fed19,3caf975d4a0c9a3b551d46d64c6304ff,ac046d40439d26b6928bd97eab3ecc6f');
INSERT INTO "public"."employee_leave_record" VALUES ('c8f233df2ffb6d44f7758e1c5170e931', NULL, NULL, NULL, '', '', NULL, NULL, NULL, NULL, '', NULL, '');
INSERT INTO "public"."employee_leave_record" VALUES ('5e45e6edaa823a2dc76235b0cadf24e2', '919caa35067de74509db9129f5a0e211', NULL, '2020-03-04', '9', '组织人事处', '2020-03-03', NULL, '2020-04-02 08:22:58', '2020-04-02 08:22:58', '1', '2020-03-12', '50f824172e445be574c04cf1e96efbd1,c757650699564a99dffbdb9ddf67ee7a,51f6da8efb84df80e818433fceef4ff5');

-- ----------------------------
-- Table structure for employee_license_record
-- ----------------------------
DROP TABLE IF EXISTS "public"."employee_license_record";
CREATE TABLE "public"."employee_license_record" (
  "license_id" varchar(32) COLLATE "pg_catalog"."default" NOT NULL,
  "base_id" varchar(32) COLLATE "pg_catalog"."default",
  "type" varchar(15) COLLATE "pg_catalog"."default",
  "expire_time" date,
  "remark" varchar(255) COLLATE "pg_catalog"."default",
  "url" varchar(255) COLLATE "pg_catalog"."default",
  "other_info" varchar(255) COLLATE "pg_catalog"."default",
  "create_time" timestamp(0),
  "update_time" timestamp(0),
  "number" varchar(20) COLLATE "pg_catalog"."default",
  "invalid_time" date,
  "issuing_authority" varchar(50) COLLATE "pg_catalog"."default",
  "recycle_time" date,
  "state" varchar(20) COLLATE "pg_catalog"."default",
  "undertaker" varchar(40) COLLATE "pg_catalog"."default",
  "issue_time" date,
  "license_name" varchar(25) COLLATE "pg_catalog"."default"
)
;
COMMENT ON COLUMN "public"."employee_license_record"."license_id" IS '主键Id';
COMMENT ON COLUMN "public"."employee_license_record"."base_id" IS '外键Id(基础信息表id)';
COMMENT ON COLUMN "public"."employee_license_record"."type" IS '证照类型';
COMMENT ON COLUMN "public"."employee_license_record"."expire_time" IS '证照到期时间';
COMMENT ON COLUMN "public"."employee_license_record"."remark" IS '备注';
COMMENT ON COLUMN "public"."employee_license_record"."url" IS '图片地址';
COMMENT ON COLUMN "public"."employee_license_record"."other_info" IS '其他信息';
COMMENT ON COLUMN "public"."employee_license_record"."create_time" IS '创建时间';
COMMENT ON COLUMN "public"."employee_license_record"."update_time" IS '更新时间';
COMMENT ON COLUMN "public"."employee_license_record"."number" IS '证件编号';
COMMENT ON COLUMN "public"."employee_license_record"."invalid_time" IS '失效时间';
COMMENT ON COLUMN "public"."employee_license_record"."issuing_authority" IS '发证部门';
COMMENT ON COLUMN "public"."employee_license_record"."recycle_time" IS '回收时间';
COMMENT ON COLUMN "public"."employee_license_record"."state" IS '状态';
COMMENT ON COLUMN "public"."employee_license_record"."undertaker" IS '承办人员';
COMMENT ON COLUMN "public"."employee_license_record"."issue_time" IS '发证日期';
COMMENT ON COLUMN "public"."employee_license_record"."license_name" IS '证照名称';
COMMENT ON TABLE "public"."employee_license_record" IS '证照记录及其他信息记录表';

-- ----------------------------
-- Table structure for employee_rankmanage_record
-- ----------------------------
DROP TABLE IF EXISTS "public"."employee_rankmanage_record";
CREATE TABLE "public"."employee_rankmanage_record" (
  "rank_id" varchar(32) COLLATE "pg_catalog"."default" NOT NULL,
  "base_id" varchar(32) COLLATE "pg_catalog"."default",
  "approval_number" varchar(32) COLLATE "pg_catalog"."default",
  "approval_rank" varchar(10) COLLATE "pg_catalog"."default",
  "approval_unit" varchar(50) COLLATE "pg_catalog"."default",
  "approval_time" date,
  "promote_number" varchar(32) COLLATE "pg_catalog"."default",
  "promote_rank" varchar(10) COLLATE "pg_catalog"."default",
  "promote_cause" varchar(255) COLLATE "pg_catalog"."default",
  "papproval_time" date,
  "papproval_unit" varchar(50) COLLATE "pg_catalog"."default",
  "url" text COLLATE "pg_catalog"."default",
  "create_time" timestamp(0),
  "update_time" timestamp(6),
  "remark" varchar(255) COLLATE "pg_catalog"."default"
)
;
COMMENT ON COLUMN "public"."employee_rankmanage_record"."rank_id" IS '主键';
COMMENT ON COLUMN "public"."employee_rankmanage_record"."base_id" IS '基本信息表id(外键)';
COMMENT ON COLUMN "public"."employee_rankmanage_record"."approval_number" IS '批准文号';
COMMENT ON COLUMN "public"."employee_rankmanage_record"."approval_rank" IS '批准职级';
COMMENT ON COLUMN "public"."employee_rankmanage_record"."approval_unit" IS '批准单位';
COMMENT ON COLUMN "public"."employee_rankmanage_record"."approval_time" IS '批准时间';
COMMENT ON COLUMN "public"."employee_rankmanage_record"."promote_number" IS '晋升文号';
COMMENT ON COLUMN "public"."employee_rankmanage_record"."promote_rank" IS '晋升职级';
COMMENT ON COLUMN "public"."employee_rankmanage_record"."promote_cause" IS '晋升原因';
COMMENT ON COLUMN "public"."employee_rankmanage_record"."papproval_time" IS '晋升 批准时间';
COMMENT ON COLUMN "public"."employee_rankmanage_record"."papproval_unit" IS '晋升 批准单位';
COMMENT ON COLUMN "public"."employee_rankmanage_record"."url" IS '附件地址';
COMMENT ON COLUMN "public"."employee_rankmanage_record"."create_time" IS '创建时间';
COMMENT ON COLUMN "public"."employee_rankmanage_record"."update_time" IS '修改时间';
COMMENT ON COLUMN "public"."employee_rankmanage_record"."remark" IS '备注';
COMMENT ON TABLE "public"."employee_rankmanage_record" IS '职级管理记录';

-- ----------------------------
-- Table structure for employee_rew_pun_record
-- ----------------------------
DROP TABLE IF EXISTS "public"."employee_rew_pun_record";
CREATE TABLE "public"."employee_rew_pun_record" (
  "rew_pun_id" varchar(32) COLLATE "pg_catalog"."default" NOT NULL,
  "base_id" varchar(32) COLLATE "pg_catalog"."default",
  "rew_pun_details" varchar(255) COLLATE "pg_catalog"."default",
  "rew_pun_type" varchar(50) COLLATE "pg_catalog"."default",
  "rew_pun_time" date,
  "revocation_time" date,
  "revocation_reason" varchar(255) COLLATE "pg_catalog"."default",
  "remark" varchar(255) COLLATE "pg_catalog"."default",
  "create_time" timestamp(0),
  "update_time" timestamp(0),
  "rew_pun_reason" varchar(255) COLLATE "pg_catalog"."default",
  "approval_dept" varchar(50) COLLATE "pg_catalog"."default",
  "issue_date" date,
  "effect_date" date,
  "money" varchar(10) COLLATE "pg_catalog"."default",
  "url" varchar(500) COLLATE "pg_catalog"."default"
)
;
COMMENT ON COLUMN "public"."employee_rew_pun_record"."rew_pun_id" IS '主键id';
COMMENT ON COLUMN "public"."employee_rew_pun_record"."base_id" IS '外键Id(基础信息表Id)';
COMMENT ON COLUMN "public"."employee_rew_pun_record"."rew_pun_details" IS '奖惩内容';
COMMENT ON COLUMN "public"."employee_rew_pun_record"."rew_pun_type" IS '奖惩种类';
COMMENT ON COLUMN "public"."employee_rew_pun_record"."rew_pun_time" IS '奖惩日期';
COMMENT ON COLUMN "public"."employee_rew_pun_record"."revocation_time" IS '撤销奖惩的日期';
COMMENT ON COLUMN "public"."employee_rew_pun_record"."revocation_reason" IS '撤销奖惩的缘由';
COMMENT ON COLUMN "public"."employee_rew_pun_record"."remark" IS '备注';
COMMENT ON COLUMN "public"."employee_rew_pun_record"."create_time" IS '创建时间';
COMMENT ON COLUMN "public"."employee_rew_pun_record"."update_time" IS '更新时间';
COMMENT ON COLUMN "public"."employee_rew_pun_record"."rew_pun_reason" IS '奖惩缘由';
COMMENT ON COLUMN "public"."employee_rew_pun_record"."approval_dept" IS '批准部门（批准单位）';
COMMENT ON COLUMN "public"."employee_rew_pun_record"."issue_date" IS '签发日期';
COMMENT ON COLUMN "public"."employee_rew_pun_record"."effect_date" IS '生效日期';
COMMENT ON COLUMN "public"."employee_rew_pun_record"."money" IS '奖惩金额';
COMMENT ON TABLE "public"."employee_rew_pun_record" IS '奖惩信息记录表';

-- ----------------------------
-- Records of employee_rew_pun_record
-- ----------------------------
INSERT INTO "public"."employee_rew_pun_record" VALUES ('1622e5e22e503e5005555e91ec61d3ba', NULL, '', NULL, NULL, NULL, NULL, '', NULL, NULL, '', '', NULL, NULL, NULL, '');
INSERT INTO "public"."employee_rew_pun_record" VALUES ('5a164022c8e55636155c3d3b533217c1', NULL, '', NULL, NULL, NULL, NULL, '', NULL, NULL, '', '', NULL, NULL, NULL, '');
INSERT INTO "public"."employee_rew_pun_record" VALUES ('8eeb27e85004c91c3ef666352626190b', 'fd689de0a52afa6e5f61cc0599d6cae6', '2', NULL, '2020-03-26', NULL, NULL, '2', '2020-04-01 17:31:18', '2020-04-01 17:31:18', '我', '2', NULL, NULL, NULL, '77fa2a71173c3d69ae5f18aad10eff28,eeae2001f62e5c1b2dc5bb8cc7504802,42a853103dac66067da548d9cd8ce873,d4ff376fd70f92c08d5056549b66f8d8,4ed30b65aa267692995d96ab3e0c172b');
INSERT INTO "public"."employee_rew_pun_record" VALUES ('ce2fd499e48c5132e6d4575be564c949', 'fd689de0a52afa6e5f61cc0599d6cae6', 'zx', NULL, '2020-03-26', NULL, NULL, 'zx', '2020-04-01 17:31:18', '2020-04-01 17:31:18', 'zx', 'zx', NULL, NULL, NULL, '');
INSERT INTO "public"."employee_rew_pun_record" VALUES ('211d60f1c6eecf06a9806b89a4ade382', 'fd689de0a52afa6e5f61cc0599d6cae6', 'as', NULL, '2020-03-25', NULL, NULL, 'as', '2020-04-01 17:31:18', '2020-04-01 17:31:18', 'as', 'as', NULL, NULL, NULL, '');
INSERT INTO "public"."employee_rew_pun_record" VALUES ('3f4a6f28e06eb31e0ce8e96e5714dd42', 'fd689de0a52afa6e5f61cc0599d6cae6', 'as', NULL, '2020-03-24', NULL, NULL, 'as', '2020-04-01 17:31:18', '2020-04-01 17:31:18', 'as', 'as', NULL, NULL, NULL, '');
INSERT INTO "public"."employee_rew_pun_record" VALUES ('364117726ec294b8f03c9032ab890b8e', 'fd689de0a52afa6e5f61cc0599d6cae6', 'sd', NULL, '2020-03-24', NULL, NULL, 'sd', '2020-04-01 17:31:18', '2020-04-01 17:31:18', 'sd', 'sd', NULL, NULL, NULL, '');
INSERT INTO "public"."employee_rew_pun_record" VALUES ('7ddd5b4ac2f324e034c79df89efece70', 'fd689de0a52afa6e5f61cc0599d6cae6', 'sd', NULL, '2020-03-27', NULL, NULL, 'sd', '2020-04-01 17:31:18', '2020-04-01 17:31:18', 'sd', 'sd', NULL, NULL, NULL, '');
INSERT INTO "public"."employee_rew_pun_record" VALUES ('9bc196d908945191fd2e00910da2f78c', '919caa35067de74509db9129f5a0e211', '嘉奖', NULL, '2020-04-03', NULL, NULL, '', '2020-04-02 08:22:58', '2020-04-02 08:22:58', '工作任务完成出色', '人事处', NULL, NULL, NULL, '2ae1f8c4ab467d343c0ae990c575f758,15e097a367dba51a8eabd8ec17ac86f6');
INSERT INTO "public"."employee_rew_pun_record" VALUES ('e18d4d6b94805d67d45709c0f7be4524', '32f210ab2db15b051f8ecd0ee66c6b45', '2', NULL, '2020-03-26', NULL, NULL, '2', '2020-04-02 08:48:03', '2020-04-02 08:48:03', '我', '2', NULL, NULL, NULL, '77fa2a71173c3d69ae5f18aad10eff28,eeae2001f62e5c1b2dc5bb8cc7504802,42a853103dac66067da548d9cd8ce873,d4ff376fd70f92c08d5056549b66f8d8,4ed30b65aa267692995d96ab3e0c172b');
INSERT INTO "public"."employee_rew_pun_record" VALUES ('262e14bb065bba21049c428b6a13307f', '32f210ab2db15b051f8ecd0ee66c6b45', 'zx', NULL, '2020-03-26', NULL, NULL, 'zx', '2020-04-02 08:48:03', '2020-04-02 08:48:03', 'zx', 'zx', NULL, NULL, NULL, '');
INSERT INTO "public"."employee_rew_pun_record" VALUES ('b38384d27128c63ceba964ae97bffe03', '32f210ab2db15b051f8ecd0ee66c6b45', 'as', NULL, '2020-03-25', NULL, NULL, 'as', '2020-04-02 08:48:03', '2020-04-02 08:48:03', 'as', 'as', NULL, NULL, NULL, '');
INSERT INTO "public"."employee_rew_pun_record" VALUES ('6daa87fdb9d43c6e363402f55d064afd', '32f210ab2db15b051f8ecd0ee66c6b45', 'as', NULL, '2020-03-24', NULL, NULL, 'as', '2020-04-02 08:48:03', '2020-04-02 08:48:03', 'as', 'as', NULL, NULL, NULL, '');
INSERT INTO "public"."employee_rew_pun_record" VALUES ('1c397ce137c78966a0f36c1d0c215ead', '32f210ab2db15b051f8ecd0ee66c6b45', 'sd', NULL, '2020-03-24', NULL, NULL, 'sd', '2020-04-02 08:48:03', '2020-04-02 08:48:03', 'sd', 'sd', NULL, NULL, NULL, '');
INSERT INTO "public"."employee_rew_pun_record" VALUES ('a0c6f477bd350ae585eb36ad6ccecdde', '32f210ab2db15b051f8ecd0ee66c6b45', 'sd', NULL, '2020-03-27', NULL, NULL, 'sd', '2020-04-02 08:48:03', '2020-04-02 08:48:03', 'sd', 'sd', NULL, NULL, NULL, '');

-- ----------------------------
-- Table structure for employee_social_relation
-- ----------------------------
DROP TABLE IF EXISTS "public"."employee_social_relation";
CREATE TABLE "public"."employee_social_relation" (
  "soc_id" varchar(32) COLLATE "pg_catalog"."default" NOT NULL,
  "base_id" varchar(32) COLLATE "pg_catalog"."default",
  "relation_name" varchar(50) COLLATE "pg_catalog"."default",
  "reation" varchar(50) COLLATE "pg_catalog"."default",
  "work_unit" varchar(50) COLLATE "pg_catalog"."default",
  "position" varchar(50) COLLATE "pg_catalog"."default",
  "politics_status" varchar(10) COLLATE "pg_catalog"."default",
  "phone" varchar(25) COLLATE "pg_catalog"."default",
  "credit" varchar(50) COLLATE "pg_catalog"."default",
  "criminal_record" varchar(5) COLLATE "pg_catalog"."default",
  "remark" varchar(255) COLLATE "pg_catalog"."default",
  "create_time" timestamp(0),
  "update_time" timestamp(0),
  "gender" int4,
  "nation" int4,
  "education" int4,
  "address" varchar(255) COLLATE "pg_catalog"."default"
)
;
COMMENT ON COLUMN "public"."employee_social_relation"."soc_id" IS '主键Id';
COMMENT ON COLUMN "public"."employee_social_relation"."base_id" IS '外键Id（基础信息表Id）';
COMMENT ON COLUMN "public"."employee_social_relation"."relation_name" IS '关系人姓名';
COMMENT ON COLUMN "public"."employee_social_relation"."reation" IS '与之关系';
COMMENT ON COLUMN "public"."employee_social_relation"."work_unit" IS '工作单位';
COMMENT ON COLUMN "public"."employee_social_relation"."position" IS '所在职位';
COMMENT ON COLUMN "public"."employee_social_relation"."politics_status" IS '政治面貌';
COMMENT ON COLUMN "public"."employee_social_relation"."phone" IS '联系电话';
COMMENT ON COLUMN "public"."employee_social_relation"."credit" IS '社会征信';
COMMENT ON COLUMN "public"."employee_social_relation"."criminal_record" IS '犯罪记录';
COMMENT ON COLUMN "public"."employee_social_relation"."remark" IS '备注';
COMMENT ON COLUMN "public"."employee_social_relation"."create_time" IS '创建时间';
COMMENT ON COLUMN "public"."employee_social_relation"."update_time" IS '更新时间';
COMMENT ON COLUMN "public"."employee_social_relation"."gender" IS '性别';
COMMENT ON COLUMN "public"."employee_social_relation"."nation" IS '民族';
COMMENT ON COLUMN "public"."employee_social_relation"."education" IS '学历';
COMMENT ON COLUMN "public"."employee_social_relation"."address" IS '通信地址';
COMMENT ON TABLE "public"."employee_social_relation" IS '社会关系记录表表';

-- ----------------------------
-- Table structure for employee_train_record
-- ----------------------------
DROP TABLE IF EXISTS "public"."employee_train_record";
CREATE TABLE "public"."employee_train_record" (
  "train_id" varchar(32) COLLATE "pg_catalog"."default" NOT NULL,
  "base_id" varchar(32) COLLATE "pg_catalog"."default",
  "train_details" varchar(255) COLLATE "pg_catalog"."default",
  "train_organization" varchar(50) COLLATE "pg_catalog"."default",
  "begin_time" date,
  "end_time" date,
  "train_complete" varchar(255) COLLATE "pg_catalog"."default",
  "remark" varchar(255) COLLATE "pg_catalog"."default",
  "create_time" timestamp(0),
  "update_time" timestamp(0),
  "train_name" varchar(30) COLLATE "pg_catalog"."default",
  "train_cost" varchar(20) COLLATE "pg_catalog"."default"
)
;
COMMENT ON COLUMN "public"."employee_train_record"."train_id" IS '主键Id';
COMMENT ON COLUMN "public"."employee_train_record"."base_id" IS '外键Id(基础信息表Id)';
COMMENT ON COLUMN "public"."employee_train_record"."train_details" IS '培训内容';
COMMENT ON COLUMN "public"."employee_train_record"."train_organization" IS '培训机构（单位/院校）';
COMMENT ON COLUMN "public"."employee_train_record"."begin_time" IS '培训开始时间';
COMMENT ON COLUMN "public"."employee_train_record"."end_time" IS '培训结束时间';
COMMENT ON COLUMN "public"."employee_train_record"."train_complete" IS '培训结业情况（结果）';
COMMENT ON COLUMN "public"."employee_train_record"."remark" IS '备注';
COMMENT ON COLUMN "public"."employee_train_record"."create_time" IS '创建时间';
COMMENT ON COLUMN "public"."employee_train_record"."update_time" IS '更新时间';
COMMENT ON COLUMN "public"."employee_train_record"."train_name" IS '培训名称';
COMMENT ON COLUMN "public"."employee_train_record"."train_cost" IS '培训费用';
COMMENT ON TABLE "public"."employee_train_record" IS '培训记录表';

-- ----------------------------
-- Table structure for employee_work_exp
-- ----------------------------
DROP TABLE IF EXISTS "public"."employee_work_exp";
CREATE TABLE "public"."employee_work_exp" (
  "exp_id" varchar(32) COLLATE "pg_catalog"."default" NOT NULL,
  "base_id" varchar(32) COLLATE "pg_catalog"."default" NOT NULL,
  "work_unit" varchar(100) COLLATE "pg_catalog"."default",
  "dept" varchar(50) COLLATE "pg_catalog"."default",
  "position" varchar(50) COLLATE "pg_catalog"."default",
  "remarks" varchar(255) COLLATE "pg_catalog"."default",
  "create_time" timestamp(0),
  "update_time" timestamp(0),
  "begin_time" date,
  "end_time" date,
  "post" varchar(32) COLLATE "pg_catalog"."default",
  "certifier" varchar(50) COLLATE "pg_catalog"."default",
  "phone" varchar(25) COLLATE "pg_catalog"."default"
)
;
COMMENT ON COLUMN "public"."employee_work_exp"."exp_id" IS '主键Id';
COMMENT ON COLUMN "public"."employee_work_exp"."base_id" IS '外键Id(基础信息表Id)';
COMMENT ON COLUMN "public"."employee_work_exp"."work_unit" IS '所在单位';
COMMENT ON COLUMN "public"."employee_work_exp"."dept" IS '所在部门';
COMMENT ON COLUMN "public"."employee_work_exp"."position" IS '任职情况';
COMMENT ON COLUMN "public"."employee_work_exp"."remarks" IS '备注';
COMMENT ON COLUMN "public"."employee_work_exp"."create_time" IS '创建时间';
COMMENT ON COLUMN "public"."employee_work_exp"."update_time" IS '变更时间';
COMMENT ON COLUMN "public"."employee_work_exp"."begin_time" IS '开始时间';
COMMENT ON COLUMN "public"."employee_work_exp"."end_time" IS '结束时间';
COMMENT ON COLUMN "public"."employee_work_exp"."post" IS '担任职务';
COMMENT ON COLUMN "public"."employee_work_exp"."certifier" IS '证明人';
COMMENT ON COLUMN "public"."employee_work_exp"."phone" IS '联系电话';
COMMENT ON TABLE "public"."employee_work_exp" IS '工作经历记录表';

-- ----------------------------
-- Table structure for sys_captcha
-- ----------------------------
DROP TABLE IF EXISTS "public"."sys_captcha";
CREATE TABLE "public"."sys_captcha" (
  "uuid" varchar(254) COLLATE "pg_catalog"."default" NOT NULL,
  "code" varchar(254) COLLATE "pg_catalog"."default",
  "expire_time" timestamp(0)
)
;
COMMENT ON COLUMN "public"."sys_captcha"."uuid" IS 'uuid';
COMMENT ON COLUMN "public"."sys_captcha"."code" IS '验证码';
COMMENT ON COLUMN "public"."sys_captcha"."expire_time" IS '过期时间';
COMMENT ON TABLE "public"."sys_captcha" IS '系统验证码';

-- ----------------------------
-- Records of sys_captcha
-- ----------------------------
INSERT INTO "public"."sys_captcha" VALUES ('ca76b038-7e3d-4be4-8964-f71fccbc07f8', 'xc844', '2019-11-20 09:08:08');
INSERT INTO "public"."sys_captcha" VALUES ('a584d9bc-1191-4cb8-8fcc-a5aa87b85e3d', 'xncyd', '2019-11-21 16:54:44');
INSERT INTO "public"."sys_captcha" VALUES ('f9fdba9d-ce4e-442c-8e0f-2053a987049a', 'bng8c', '2019-11-12 15:27:29');
INSERT INTO "public"."sys_captcha" VALUES ('7b1d961b-7b06-4cff-8e5a-55257b29406e', '8yg73', '2019-11-20 09:09:04');
INSERT INTO "public"."sys_captcha" VALUES ('59e4c33f-ee5e-43c5-83da-5289564f0210', '43ppa', '2019-11-20 09:09:18');
INSERT INTO "public"."sys_captcha" VALUES ('c75303a8-ff7b-4549-86c6-ed61822a9f2c', 'm82c2', '2019-11-20 09:18:09');
INSERT INTO "public"."sys_captcha" VALUES ('8bb43582-196d-4288-8d3b-ac4e4db27137', 'mb668', '2019-11-18 16:51:21');
INSERT INTO "public"."sys_captcha" VALUES ('597a820b-fbde-409e-831c-82e5b082d755', 'w2dnx', '2019-11-20 09:25:48');
INSERT INTO "public"."sys_captcha" VALUES ('8c5e79c5-be32-43c8-80ee-ba0654e10e3f', 'panap', '2019-11-25 18:20:14');
INSERT INTO "public"."sys_captcha" VALUES ('4fdd6580-50fa-4e17-8492-66cb2f5252d6', 'mp3e5', '2019-11-14 10:56:33');
INSERT INTO "public"."sys_captcha" VALUES ('09da5d3e-10b2-4865-8919-12a53c235cb1', 'eeb5f', '2019-11-14 11:13:21');
INSERT INTO "public"."sys_captcha" VALUES ('675d8ad7-128b-496b-86b0-5ceb23fffeae', '7g4xn', '2019-11-21 17:50:48');
INSERT INTO "public"."sys_captcha" VALUES ('29cde9de-1c27-4a80-8e09-cd49991d6f1a', '32pyn', '2019-11-13 09:31:55');
INSERT INTO "public"."sys_captcha" VALUES ('93090ff3-794b-4866-8ccd-2518632c71e0', '6amp6', '2019-11-20 16:05:24');
INSERT INTO "public"."sys_captcha" VALUES ('656379e9-edbd-4214-81c8-b19004714aa5', 'xwawy', '2019-11-19 09:16:17');
INSERT INTO "public"."sys_captcha" VALUES ('72d437c5-bbe4-4458-8937-ccf70d7f237d', 'cfdax', '2019-11-19 09:39:57');
INSERT INTO "public"."sys_captcha" VALUES ('79cdfff0-9858-468b-879d-33cd89528504', 'ef856', '2019-11-21 17:51:05');
INSERT INTO "public"."sys_captcha" VALUES ('f0d37566-efb9-4874-81f7-eaad9491d385', 'cbnx5', '2019-11-21 17:52:32');
INSERT INTO "public"."sys_captcha" VALUES ('2866b328-4203-4d39-815e-942153f7f407', '5g36m', '2019-11-14 14:37:46');
INSERT INTO "public"."sys_captcha" VALUES ('6ce4f649-9c2c-4a80-8dcf-eb56082bc432', '58pee', '2019-11-21 17:52:51');
INSERT INTO "public"."sys_captcha" VALUES ('ac6b7488-5242-4042-82e6-65bf14533aff', '6b78g', '2019-11-19 10:26:46');
INSERT INTO "public"."sys_captcha" VALUES ('1bece133-b9d2-4580-8741-5de61074159f', '4xgf5', '2019-11-26 11:30:37');
INSERT INTO "public"."sys_captcha" VALUES ('b50b387f-546f-49a9-81df-911bf622e10e', 'n25wm', '2019-11-26 16:33:15');
INSERT INTO "public"."sys_captcha" VALUES ('226c17c4-2d85-4444-8189-0667af0baf07', '2fadc', '2019-11-14 15:18:57');
INSERT INTO "public"."sys_captcha" VALUES ('994e628d-1491-401b-8480-a64a7b8e5df6', 'f223y', '2019-11-26 16:33:54');
INSERT INTO "public"."sys_captcha" VALUES ('42fcb4d4-1f3f-4804-8729-42536c7a4e16', 'nnf65', '2019-11-22 09:06:56');
INSERT INTO "public"."sys_captcha" VALUES ('87423120-491f-470c-8914-73ccc2f46c2a', 'w4nxp', '2019-11-19 14:01:10');
INSERT INTO "public"."sys_captcha" VALUES ('97c80c88-2d65-4d5b-89b2-1c59d5549e1c', '36xcw', '2019-11-14 15:51:06');
INSERT INTO "public"."sys_captcha" VALUES ('5e46ea7d-b97f-4ca4-838e-69c2b693ad7b', '2m7b6', '2019-11-14 16:51:32');
INSERT INTO "public"."sys_captcha" VALUES ('65e7ac32-b3e4-4234-8bec-15b1bf7855f6', '3pc7a', '2019-11-26 17:05:15');
INSERT INTO "public"."sys_captcha" VALUES ('437a135a-b85d-457b-8e7e-52b977c0fb1a', 'gynbp', '2019-11-22 09:19:57');
INSERT INTO "public"."sys_captcha" VALUES ('62577693-cc31-4450-8b84-fae54470e5cf', 'f7an4', '2019-11-19 14:06:33');
INSERT INTO "public"."sys_captcha" VALUES ('5cfdfae0-bed4-417e-82d2-554c45bfe055', 'b7ye2', '2019-11-22 09:19:57');
INSERT INTO "public"."sys_captcha" VALUES ('8a1b0956-1b30-460c-8e7a-5cac37e07f20', 'gnww6', '2019-11-15 15:49:24');
INSERT INTO "public"."sys_captcha" VALUES ('5c5cea7d-03d5-419a-8e27-f31102bdf596', '8wnf5', '2019-11-22 09:24:55');
INSERT INTO "public"."sys_captcha" VALUES ('2bb8eb07-9776-49e3-8f0d-246bee017621', 'wn6fy', '2019-11-20 17:15:01');
INSERT INTO "public"."sys_captcha" VALUES ('f866e354-5177-4892-8a0d-88a66aa9ac3c', 'e56gy', '2019-11-19 14:50:25');
INSERT INTO "public"."sys_captcha" VALUES ('bc0924ae-2718-41f9-80ce-af95d48c7675', '33f52', '2019-11-22 09:25:04');
INSERT INTO "public"."sys_captcha" VALUES ('57b692e3-af29-4694-8565-62513e168c8a', '8epgc', '2019-11-22 09:25:07');
INSERT INTO "public"."sys_captcha" VALUES ('aed9eb46-1cf0-4254-86fa-b1ec436345e2', 'n2gf2', '2019-11-27 16:35:39');
INSERT INTO "public"."sys_captcha" VALUES ('d6cc6c5b-6dc5-40a5-80b8-c295204416eb', 'xp3nb', '2019-11-22 09:26:41');
INSERT INTO "public"."sys_captcha" VALUES ('612a42d2-518d-47a6-892c-25017258a37c', '5e5y8', '2019-11-22 09:29:06');
INSERT INTO "public"."sys_captcha" VALUES ('36bcd9b0-1f62-4606-8552-10e952278660', '75c4n', '2019-11-13 16:10:41');
INSERT INTO "public"."sys_captcha" VALUES ('b7ccac49-166c-48d9-8f9a-86ae6ec80e27', 'c22xg', '2019-11-18 10:27:25');
INSERT INTO "public"."sys_captcha" VALUES ('3693f883-37b2-40c6-8ba2-9eef83891933', 'd5em6', '2019-11-13 18:12:16');
INSERT INTO "public"."sys_captcha" VALUES ('c13b7a17-4862-4434-812f-4f5fa65d6b80', '2ye47', '2019-11-19 15:51:50');
INSERT INTO "public"."sys_captcha" VALUES ('61c695f1-d9e6-4143-85ff-378c88ba91f8', 'a38pa', '2019-11-13 19:44:25');
INSERT INTO "public"."sys_captcha" VALUES ('05d1c939-6670-44f5-8e01-9bcbc9b07075', 'wgpaa', '2019-11-27 16:38:57');
INSERT INTO "public"."sys_captcha" VALUES ('93653098-8544-4daf-8395-6abaf8714a5f', 'bpnwx', '2019-11-19 16:26:15');
INSERT INTO "public"."sys_captcha" VALUES ('4b21ded9-c572-47aa-8f33-45a29cea22a3', 'c4857', '2019-11-19 16:57:43');
INSERT INTO "public"."sys_captcha" VALUES ('477b546a-43ce-4771-87d1-86d2d89b4b8a', 'g6f2a', '2019-11-19 17:02:33');
INSERT INTO "public"."sys_captcha" VALUES ('e12f4e47-1bdb-4352-8961-80d5e87d9384', '2nmp8', '2019-11-18 11:37:41');
INSERT INTO "public"."sys_captcha" VALUES ('6f2f2a96-5d00-4bf7-8d83-5b096eeb08a4', 'xyfnw', '2019-11-22 09:31:06');
INSERT INTO "public"."sys_captcha" VALUES ('5d210e97-68ef-4977-8654-f34dd886a7a6', 'ffxcd', '2019-11-18 13:56:54');
INSERT INTO "public"."sys_captcha" VALUES ('6d146802-150a-4b88-86f6-363e0fc7c849', 'wxgyn', '2019-11-22 09:31:56');
INSERT INTO "public"."sys_captcha" VALUES ('3e317889-fde7-421f-8c81-5481e3e848ec', 'bny8c', '2019-11-19 17:16:36');
INSERT INTO "public"."sys_captcha" VALUES ('46e8db0d-760e-4a4f-859d-faab8ec7ad4e', 'nwgda', '2019-11-19 17:17:02');
INSERT INTO "public"."sys_captcha" VALUES ('e7a82ec1-d881-4960-82ad-fa0482426e97', '3d82e', '2019-11-27 16:42:11');
INSERT INTO "public"."sys_captcha" VALUES ('c4fc8bbd-45a4-4947-8c50-995c4b4b01db', 'f7cfa', '2019-11-19 17:51:05');
INSERT INTO "public"."sys_captcha" VALUES ('2aa32ff8-dfb3-4f7b-8ae2-12b27b0c31d0', 'gpg7a', '2019-11-22 09:41:00');
INSERT INTO "public"."sys_captcha" VALUES ('95e32d46-7280-4dce-83fb-dc5f3b0574e3', 'm5edn', '2019-11-22 09:43:36');
INSERT INTO "public"."sys_captcha" VALUES ('c166fdd3-799c-4112-8a8b-cd22a3634549', 'dy5nd', '2019-11-22 09:43:37');
INSERT INTO "public"."sys_captcha" VALUES ('8139f515-4127-4386-8d8f-c9087d7510ed', '373fw', '2019-11-21 10:05:54');
INSERT INTO "public"."sys_captcha" VALUES ('e3cbda12-bb43-4614-8d86-7d55cfeb22d2', '8dw57', '2019-11-22 09:43:39');
INSERT INTO "public"."sys_captcha" VALUES ('c6897843-620f-4b9f-8f35-a9d21377940f', 'c2833', '2019-11-22 09:43:41');
INSERT INTO "public"."sys_captcha" VALUES ('586479bd-2a6f-48ea-808a-562909f5f492', 'f67xa', '2019-11-20 08:52:53');
INSERT INTO "public"."sys_captcha" VALUES ('1cd0b3d4-f03a-4de7-827e-6fe3cb417f36', 'g728w', '2019-11-22 09:43:59');
INSERT INTO "public"."sys_captcha" VALUES ('ac46f437-1ceb-4062-80ab-8126da848b9a', '4dnen', '2019-11-22 09:44:04');
INSERT INTO "public"."sys_captcha" VALUES ('1903c634-bed0-40c6-8a04-e349098b751d', '7banm', '2019-11-22 09:46:17');
INSERT INTO "public"."sys_captcha" VALUES ('51eb3843-6707-4cd8-8f6c-0cf7e108ac58', '44gwg', '2019-11-22 09:48:20');
INSERT INTO "public"."sys_captcha" VALUES ('6dbe866f-7283-4770-885a-8eb3677c6e4e', '6284p', '2019-11-20 08:55:21');
INSERT INTO "public"."sys_captcha" VALUES ('2814bf59-40bc-4e3f-8cd0-d0f0efe6a8b7', 'd8wmw', '2019-11-20 08:57:10');
INSERT INTO "public"."sys_captcha" VALUES ('cc29f20e-0cd2-4cfc-8550-4dfc971322ae', '26md2', '2019-11-22 09:48:20');
INSERT INTO "public"."sys_captcha" VALUES ('f09f0375-bb34-4f49-89bf-d295f2a7d052', 'dmnm7', '2019-11-22 09:48:20');
INSERT INTO "public"."sys_captcha" VALUES ('f60d4e90-3fcf-439f-8883-aae3c117b7fc', 'agb88', '2019-11-20 09:00:21');
INSERT INTO "public"."sys_captcha" VALUES ('baeab331-f0e3-49ac-89f6-62dfc9d96c03', '5mbn2', '2019-11-20 09:01:23');
INSERT INTO "public"."sys_captcha" VALUES ('9f689194-33eb-4f1b-8e3b-bbcea96feb6d', 'ap2b6', '2019-11-22 09:48:20');
INSERT INTO "public"."sys_captcha" VALUES ('5a522dc4-291f-4270-8cd1-ecdff9715db3', 'gmp3a', '2019-11-22 09:48:20');
INSERT INTO "public"."sys_captcha" VALUES ('c67eb1ac-9d4b-4a33-8fb0-52786ba67645', 'wap55', '2019-11-22 09:48:20');
INSERT INTO "public"."sys_captcha" VALUES ('44e3e661-4fbf-4e6f-820d-3d29f7ed28b0', 'dxn8d', '2019-11-21 14:31:38');
INSERT INTO "public"."sys_captcha" VALUES ('2a6715dd-c3a7-45a7-8043-3d9faece8d49', 'nn44g', '2019-11-22 09:48:20');
INSERT INTO "public"."sys_captcha" VALUES ('cd3bab87-0e14-442f-8966-47c4d73f2905', 'bwnn6', '2019-11-21 14:32:44');
INSERT INTO "public"."sys_captcha" VALUES ('4849ec99-3990-4ad0-82d8-efb73b0f4e7d', 'p86fe', '2019-11-22 09:48:20');
INSERT INTO "public"."sys_captcha" VALUES ('3f7209d0-6141-48ed-8c4f-831b0b6a59d6', '53y7e', '2019-11-22 09:48:48');
INSERT INTO "public"."sys_captcha" VALUES ('da9f9b44-e4af-4e6f-8ac6-050456dd7196', 'bef5f', '2019-11-21 14:32:57');
INSERT INTO "public"."sys_captcha" VALUES ('1e572616-036c-48c3-88d5-d71c4d3ea2a3', 'amyce', '2019-11-28 09:31:39');
INSERT INTO "public"."sys_captcha" VALUES ('9d0190ef-8ecd-40d7-86d9-ee8f2261ab3c', '8acdx', '2019-11-21 15:48:28');
INSERT INTO "public"."sys_captcha" VALUES ('d6ae5fef-6fbe-4afb-8ba8-166ada3993b7', 'g4pec', '2019-11-28 11:01:22');
INSERT INTO "public"."sys_captcha" VALUES ('2933c83d-6a9e-443d-826c-e201bff001ab', '7pxm3', '2019-11-28 11:50:38');
INSERT INTO "public"."sys_captcha" VALUES ('5e0bfba7-4c78-40e2-8ca7-b9b009b4e03a', 'ndmy8', '2019-11-21 16:50:12');
INSERT INTO "public"."sys_captcha" VALUES ('a786a1b4-46a9-48ea-850d-bef4cc6a90da', 'wbpxx', '2019-11-28 13:52:45');
INSERT INTO "public"."sys_captcha" VALUES ('674145e5-eb9b-4e83-8bf6-b9ea3f6e3b9b', '7affn', '2019-11-28 14:28:36');
INSERT INTO "public"."sys_captcha" VALUES ('55a1f610-7d69-4a7c-84ae-3f13305797bd', 'p5d84', '2019-11-28 14:29:03');
INSERT INTO "public"."sys_captcha" VALUES ('3ad73a8a-b2d0-444b-865a-0945dfa62aff', '5fc3f', '2019-11-28 19:54:02');
INSERT INTO "public"."sys_captcha" VALUES ('145e06a0-2b56-4a7d-84f4-8f1df8a9a1cc', 'xnef4', '2019-11-29 11:34:55');
INSERT INTO "public"."sys_captcha" VALUES ('914e7905-5b26-4f6e-88e6-b780307f8a0b', 'babac', '2019-11-29 11:36:27');
INSERT INTO "public"."sys_captcha" VALUES ('7af03b84-fcfd-40be-84e5-4d9b35764801', 'n3nf8', '2019-11-22 09:50:41');
INSERT INTO "public"."sys_captcha" VALUES ('c493dc9f-bfb5-41f8-83b3-a7e9eefef023', '74b56', '2019-11-22 09:50:41');
INSERT INTO "public"."sys_captcha" VALUES ('cdb1f5ca-0d00-4b56-8948-e3b6768aa543', 'adcdg', '2019-11-22 09:50:44');
INSERT INTO "public"."sys_captcha" VALUES ('65d5dcbd-79ca-489b-8dc9-b9a71c3f0423', 'ay36a', '2019-11-22 09:52:28');
INSERT INTO "public"."sys_captcha" VALUES ('3996e531-24f7-496f-8a5e-d925d07334d8', 'w8b3p', '2019-11-22 09:52:28');
INSERT INTO "public"."sys_captcha" VALUES ('6a992f2b-2c00-4d8d-8038-31fbd2652512', '2aeye', '2019-11-22 09:59:10');
INSERT INTO "public"."sys_captcha" VALUES ('c7235fac-2576-4c6b-818e-629e258c769d', 'f7bbe', '2019-11-22 09:59:10');
INSERT INTO "public"."sys_captcha" VALUES ('d29dc8df-e6b7-45eb-8d98-06eb5580f255', 'n5gyd', '2019-11-22 09:59:18');
INSERT INTO "public"."sys_captcha" VALUES ('fdf5a516-625c-4e4f-836a-32262c47ac1f', '52bwc', '2019-11-22 09:59:18');
INSERT INTO "public"."sys_captcha" VALUES ('4ca4ddb2-e776-49d4-8448-aced673d33fe', '8ccdx', '2019-11-22 09:59:34');
INSERT INTO "public"."sys_captcha" VALUES ('a592d937-33eb-4e09-8bc9-0ccd0180b3cd', 'dgxad', '2019-11-22 09:59:42');
INSERT INTO "public"."sys_captcha" VALUES ('7d5621bf-eff1-4c34-8460-9eaf41166d56', 'xp663', '2019-11-22 09:59:55');
INSERT INTO "public"."sys_captcha" VALUES ('453e353b-4d92-4e7b-86a0-2700c8708fc4', 'n8c4e', '2019-11-22 10:00:36');
INSERT INTO "public"."sys_captcha" VALUES ('19d2f904-2d7a-482c-86fc-f4c68a11e0d0', '7n8c8', '2019-11-22 10:01:51');
INSERT INTO "public"."sys_captcha" VALUES ('31be39e3-b1f1-49bf-86f6-43426094389e', 'ygeax', '2019-11-22 10:01:53');
INSERT INTO "public"."sys_captcha" VALUES ('ff1b625a-1286-464c-8add-665799ab5366', '8na7b', '2019-11-22 10:01:57');
INSERT INTO "public"."sys_captcha" VALUES ('c40d61cb-394b-4f94-8aa8-081bb5e2878a', 'mybnw', '2019-11-22 10:01:57');
INSERT INTO "public"."sys_captcha" VALUES ('defe6dd1-4aee-4c38-8ee9-8e71bd5b313f', 'xadaw', '2019-11-22 10:01:57');
INSERT INTO "public"."sys_captcha" VALUES ('5c7b551c-0f19-4736-8de6-96f504dda3d2', 'c38pn', '2019-11-22 10:01:57');
INSERT INTO "public"."sys_captcha" VALUES ('bb526abf-6147-44dc-86c7-f8efbf3605f2', 'xd523', '2019-11-22 10:02:28');
INSERT INTO "public"."sys_captcha" VALUES ('80282b3f-546e-4510-847b-358c3cb59b48', '55npn', '2019-11-22 10:02:32');
INSERT INTO "public"."sys_captcha" VALUES ('9eb188cf-59e6-4587-8b88-663b6dda472c', '86276', '2019-11-22 10:02:39');
INSERT INTO "public"."sys_captcha" VALUES ('83af337f-0cc8-40f0-8c38-fa4de2099edc', 'wbf8n', '2019-11-22 10:02:50');
INSERT INTO "public"."sys_captcha" VALUES ('5b51e71d-790c-440a-8e6f-9847236d0c3b', '6af8c', '2019-11-22 10:03:05');
INSERT INTO "public"."sys_captcha" VALUES ('58250abc-121a-4574-8adb-408d498d8ab1', '7xew4', '2019-11-22 10:03:29');
INSERT INTO "public"."sys_captcha" VALUES ('09227ba4-3481-4da2-86c1-a80d70705556', '6n547', '2019-11-22 10:03:54');
INSERT INTO "public"."sys_captcha" VALUES ('db41c81f-a355-4bea-848e-fbcbc8bb8fda', '6yfgd', '2019-11-22 10:04:11');
INSERT INTO "public"."sys_captcha" VALUES ('7d453ac6-0dc7-466a-8f76-1715f71dfa1c', 'c4c7w', '2019-11-22 10:04:14');
INSERT INTO "public"."sys_captcha" VALUES ('e43b2370-cd62-4b73-8460-e154e0254ba7', 'f8n3n', '2019-11-22 10:04:17');
INSERT INTO "public"."sys_captcha" VALUES ('d5593b81-99fc-425a-85f8-16ec3521efe4', '2ay5c', '2019-11-22 10:04:49');
INSERT INTO "public"."sys_captcha" VALUES ('547ce975-b957-4323-89c2-3aea6dd49ad4', '45f3b', '2019-11-22 10:04:54');
INSERT INTO "public"."sys_captcha" VALUES ('a8af0aaf-7854-4f2c-801d-883e0b798649', 'bypax', '2019-11-22 10:04:59');
INSERT INTO "public"."sys_captcha" VALUES ('75ed3a7c-fe51-44f2-8150-cb937693666b', 'nwxwm', '2019-11-22 10:05:03');
INSERT INTO "public"."sys_captcha" VALUES ('da383abe-77b1-40bd-8f05-48b1598063d1', 'x7fyw', '2019-11-22 10:05:28');
INSERT INTO "public"."sys_captcha" VALUES ('450b0851-afc7-472a-8aeb-dc910a55dded', 'g4pa2', '2019-11-22 10:05:36');
INSERT INTO "public"."sys_captcha" VALUES ('de938cae-21c8-4cc1-8f55-b949825c3e4b', 'xnnm4', '2019-11-22 10:05:39');
INSERT INTO "public"."sys_captcha" VALUES ('a151a4a6-13c6-4062-8763-357012d93512', '2fenn', '2019-11-22 10:05:48');
INSERT INTO "public"."sys_captcha" VALUES ('af1a0a3c-fa2e-45b2-8f5b-37e67df5847a', 'yn56n', '2019-11-22 10:06:04');
INSERT INTO "public"."sys_captcha" VALUES ('10b6d408-0ffa-41b4-873c-d940672686d3', 'y57ab', '2019-11-22 10:07:13');
INSERT INTO "public"."sys_captcha" VALUES ('e967f0cc-4458-4400-818b-2431032b3fde', 'web6m', '2019-11-22 10:07:19');
INSERT INTO "public"."sys_captcha" VALUES ('87d8eb66-b373-441b-804f-ded9218e4c96', '8dnm8', '2019-11-22 10:07:28');
INSERT INTO "public"."sys_captcha" VALUES ('87a4bfa5-2a56-4aac-8ccc-d5f8cd09c7e7', 'myc8f', '2019-11-22 10:07:34');
INSERT INTO "public"."sys_captcha" VALUES ('a6edb3e9-ec3d-44d3-87f4-a7b1586dc6c8', '6g4fg', '2019-11-22 10:08:20');
INSERT INTO "public"."sys_captcha" VALUES ('9208f5c6-205c-45ec-809e-e917be6411b1', 'dncm8', '2019-11-22 10:08:47');
INSERT INTO "public"."sys_captcha" VALUES ('d44164ae-a42b-418a-8586-8fe880087c36', 'mnc88', '2019-11-22 10:08:51');
INSERT INTO "public"."sys_captcha" VALUES ('ca40ada4-19e8-4930-8492-b681a372162b', '76egn', '2019-11-22 10:08:58');
INSERT INTO "public"."sys_captcha" VALUES ('c0d75620-afa6-4202-801e-e6a50316805c', '5np3m', '2019-11-22 10:10:13');
INSERT INTO "public"."sys_captcha" VALUES ('e43c3735-0b8e-40d5-84ed-1d7c49724de9', 'xn68g', '2019-11-22 10:10:20');
INSERT INTO "public"."sys_captcha" VALUES ('72746126-dc32-40e1-80dc-95cb9d58e3de', 'fgxw6', '2019-11-22 10:11:46');
INSERT INTO "public"."sys_captcha" VALUES ('cc7b8270-adba-4dc6-883b-4646fde6cd2f', 'nwpa6', '2019-11-22 10:11:50');
INSERT INTO "public"."sys_captcha" VALUES ('e0dcd054-8333-4ba4-81eb-85187f43f546', '877gx', '2019-11-22 10:11:52');
INSERT INTO "public"."sys_captcha" VALUES ('c7fe4bc1-c4f2-47a1-851e-a1888aae5be2', 'gdcmn', '2019-11-22 10:12:08');
INSERT INTO "public"."sys_captcha" VALUES ('a6ed8226-7071-4230-85b5-ec11af648b2b', 'nf827', '2019-11-22 10:12:10');
INSERT INTO "public"."sys_captcha" VALUES ('854bcba2-0471-41f9-8e40-d3bda1978edc', 'pc8g5', '2019-11-22 10:12:19');
INSERT INTO "public"."sys_captcha" VALUES ('25778ce6-c82a-4a1f-8c2d-312390a0c22a', 'nefp5', '2019-11-22 10:12:22');
INSERT INTO "public"."sys_captcha" VALUES ('37dcbfad-8be1-4062-817a-80e8809d310c', 'pbab7', '2019-11-22 10:12:24');
INSERT INTO "public"."sys_captcha" VALUES ('d8161423-94e8-4ba9-88c9-0270a46201cf', 'x46be', '2019-11-22 10:13:00');
INSERT INTO "public"."sys_captcha" VALUES ('6db13068-f075-44f9-8ff1-02d89b99b0aa', 'nmw36', '2019-11-22 10:13:06');
INSERT INTO "public"."sys_captcha" VALUES ('caf5f503-ea52-446b-856d-5674389298a7', 'xefnf', '2019-11-22 10:16:43');
INSERT INTO "public"."sys_captcha" VALUES ('c949cf7a-10b5-4681-8ccd-a0e6d2931e3e', 'fbwa2', '2019-11-22 10:20:19');
INSERT INTO "public"."sys_captcha" VALUES ('1c865360-21b7-4d5c-811b-19b52a76833b', 'mgx35', '2019-11-22 10:20:23');
INSERT INTO "public"."sys_captcha" VALUES ('8a240c70-4930-4ccf-8a06-93bd1c75e0f0', 'ycggc', '2019-11-22 10:22:40');
INSERT INTO "public"."sys_captcha" VALUES ('37bcbc65-a859-4ade-8686-72486648309c', 'ppny3', '2019-11-22 10:22:46');
INSERT INTO "public"."sys_captcha" VALUES ('0d1920d9-56c9-4d93-82ee-669198b78196', 'gn7nw', '2019-11-22 10:23:04');
INSERT INTO "public"."sys_captcha" VALUES ('5032e82b-65a7-4c6f-8edb-86a578187f4a', 'mcmew', '2019-11-22 10:24:22');
INSERT INTO "public"."sys_captcha" VALUES ('aabb7b8c-5465-4a90-8b85-c058a30f5031', 'n6gaw', '2019-11-22 10:25:02');
INSERT INTO "public"."sys_captcha" VALUES ('4568b00f-4274-4384-8aac-878aabff6de5', 'cfmnw', '2019-11-22 10:27:38');
INSERT INTO "public"."sys_captcha" VALUES ('f747ce6e-0f42-4b7e-86de-01617469080d', 'pbx2c', '2019-11-22 10:29:16');
INSERT INTO "public"."sys_captcha" VALUES ('984a08d4-dfd1-4356-80f8-d1de2d36689c', 'm3ynf', '2019-11-22 10:29:20');
INSERT INTO "public"."sys_captcha" VALUES ('863f353c-e67a-47f9-86b5-8c875f7531ad', 'pb6pe', '2019-11-22 10:29:23');
INSERT INTO "public"."sys_captcha" VALUES ('6f3246db-bfc8-4ad2-8204-9a67b1edc480', 'gd74y', '2019-11-22 10:29:28');
INSERT INTO "public"."sys_captcha" VALUES ('61a2f0f2-fd3f-474c-86bf-c1b5ed278f40', 'p647y', '2019-11-22 10:29:32');
INSERT INTO "public"."sys_captcha" VALUES ('3deb655e-7116-444c-841e-5452eb36924d', 'ap5b6', '2019-11-22 10:29:33');
INSERT INTO "public"."sys_captcha" VALUES ('f49e574f-7ba6-45c8-85e0-818c4ad5ec7d', 'p4p2g', '2019-11-22 10:30:22');
INSERT INTO "public"."sys_captcha" VALUES ('bd42203d-fb6b-4dd9-8d09-e9cf86310305', 'n7ney', '2019-11-22 10:30:56');
INSERT INTO "public"."sys_captcha" VALUES ('d491ba79-cbca-4fa3-8595-67cf1aa53806', '6new6', '2019-11-22 10:47:10');
INSERT INTO "public"."sys_captcha" VALUES ('b7289b85-8174-400e-8fcf-a94c2d6bd3d7', 'pbay6', '2019-11-22 10:49:56');
INSERT INTO "public"."sys_captcha" VALUES ('f2c5cf74-e8c7-4a3d-8393-653541457898', 'e5dwd', '2019-11-22 10:51:36');
INSERT INTO "public"."sys_captcha" VALUES ('00fb799a-472c-4f84-895b-d13ef9df7a93', '3p7p4', '2019-11-22 10:54:01');
INSERT INTO "public"."sys_captcha" VALUES ('39f5efd4-b93b-43f6-8d4b-dcef1dad210b', '83xe7', '2019-11-22 10:55:37');
INSERT INTO "public"."sys_captcha" VALUES ('c87bb2ce-03ac-41ef-8069-408d9edebcae', 'n3n4c', '2019-11-22 10:55:44');
INSERT INTO "public"."sys_captcha" VALUES ('185a241b-35dc-4aa2-8064-58a81042f12b', '35nfe', '2019-11-22 10:57:37');
INSERT INTO "public"."sys_captcha" VALUES ('d4468ba5-7df3-4e20-8e52-ddd3a5863722', 'n3d6w', '2019-11-22 10:58:08');
INSERT INTO "public"."sys_captcha" VALUES ('2db953dc-c73e-4c50-82cc-fa50427c1987', 'nfgy6', '2019-11-22 10:58:11');
INSERT INTO "public"."sys_captcha" VALUES ('103028a3-9323-47e8-814c-9ac957d2308a', 'ynx5a', '2019-11-22 10:58:18');
INSERT INTO "public"."sys_captcha" VALUES ('083f9c54-e3d3-445e-8d64-844de8f1b2fe', '6xn7n', '2019-11-22 10:58:41');
INSERT INTO "public"."sys_captcha" VALUES ('2fb1f9cf-35f6-4e9d-8944-f9fa3124e0cb', 'yn2pc', '2019-11-22 10:58:41');
INSERT INTO "public"."sys_captcha" VALUES ('62163561-4cd3-46bb-8b4f-a7b2c805cfd6', 'na7e8', '2019-11-22 10:59:05');
INSERT INTO "public"."sys_captcha" VALUES ('18a0c480-20dc-4cee-85fe-821134beaceb', 'wpdbw', '2019-11-22 10:59:05');
INSERT INTO "public"."sys_captcha" VALUES ('838a50f0-ee35-459c-87cb-8a0eec1cc920', 'g46n2', '2019-11-22 10:59:07');
INSERT INTO "public"."sys_captcha" VALUES ('45577768-00d5-4d4e-8340-a449e15132de', '75e4w', '2019-11-22 11:04:22');
INSERT INTO "public"."sys_captcha" VALUES ('7a132d56-550b-430a-8af1-3992ea5ff187', 'n4nx7', '2019-11-22 11:04:22');
INSERT INTO "public"."sys_captcha" VALUES ('2427dad0-e3a1-4cb9-8b69-7c54fdc2355a', '84pbx', '2019-11-22 11:05:51');
INSERT INTO "public"."sys_captcha" VALUES ('42dff52a-7dcd-4da0-8765-5e5eb64f820e', 'yw467', '2019-11-22 11:06:54');
INSERT INTO "public"."sys_captcha" VALUES ('46c0b53a-a97c-43a4-87ca-3f4fd0ad1d0d', '5bd5g', '2019-11-22 11:08:36');
INSERT INTO "public"."sys_captcha" VALUES ('5f7324ce-2d32-4858-8641-c361d69b4d53', 'n6gd2', '2019-11-22 11:08:36');
INSERT INTO "public"."sys_captcha" VALUES ('e0bc0324-846c-43cb-86fd-612fb522f9a8', 'ycpb7', '2019-11-22 11:08:36');
INSERT INTO "public"."sys_captcha" VALUES ('fe8e0f03-e29c-42c6-89c7-20f1c3a8a317', 'm6x52', '2019-11-22 11:08:36');
INSERT INTO "public"."sys_captcha" VALUES ('7fa6d72c-a30e-4c89-8fe9-d22eab018198', 'd674c', '2019-11-22 11:08:36');
INSERT INTO "public"."sys_captcha" VALUES ('c9abe82d-dffb-4392-8b49-8e15cd088c1c', '44bec', '2019-11-22 11:08:36');
INSERT INTO "public"."sys_captcha" VALUES ('9da8ec06-f3cc-4426-86a0-501ff3ebd4a6', '7dy36', '2019-11-22 11:08:36');
INSERT INTO "public"."sys_captcha" VALUES ('82aa0fb0-affc-4e91-831c-2c93f53a8ff6', '8mnfp', '2019-11-22 11:08:36');
INSERT INTO "public"."sys_captcha" VALUES ('cb887777-84f6-4dda-83d7-3a0294629a70', 'xnnnc', '2019-11-25 18:02:16');
INSERT INTO "public"."sys_captcha" VALUES ('771ed024-be9b-42e3-88ca-f60ac9ddac7e', '772dx', '2019-11-30 17:17:09');
INSERT INTO "public"."sys_captcha" VALUES ('ac338fb9-4529-4852-8482-d7d277081bbe', '8n32e', '2019-11-25 18:25:50');
INSERT INTO "public"."sys_captcha" VALUES ('aa54f530-a442-4158-8bac-88203385199f', 'c7g7b', '2019-12-02 08:38:59');
INSERT INTO "public"."sys_captcha" VALUES ('2eb9f005-cdf7-41d7-8d40-12f7fb5a2312', '456nn', '2019-11-25 18:49:52');
INSERT INTO "public"."sys_captcha" VALUES ('c6c2d5d4-cc8e-4d4e-80b1-5d1ca326a41b', '5yn46', '2019-11-26 10:46:33');
INSERT INTO "public"."sys_captcha" VALUES ('fcd98c69-6595-4887-886a-dd189da175fd', '5ndna', '2019-11-26 10:49:53');
INSERT INTO "public"."sys_captcha" VALUES ('3e0ac59e-1fc4-43e2-8558-003fd1ca7cd8', 'bw252', '2019-11-26 11:34:44');
INSERT INTO "public"."sys_captcha" VALUES ('a73a4e43-b5f8-4dd3-85e0-f74cebf88fdd', '667am', '2019-11-26 11:44:43');
INSERT INTO "public"."sys_captcha" VALUES ('f3ef8b29-3516-497d-8b08-bdb8934a10dd', 'gnn82', '2019-11-26 16:16:16');
INSERT INTO "public"."sys_captcha" VALUES ('54d20813-9285-4578-8a3f-07ee53a0e5b0', 'c54d4', '2019-12-02 09:30:53');
INSERT INTO "public"."sys_captcha" VALUES ('14eaa2f5-dacc-42c1-86cc-28dea9ccf6f8', 'nb68p', '2019-11-27 16:37:25');
INSERT INTO "public"."sys_captcha" VALUES ('582854b0-290d-432a-8e67-eb741bac8f06', '4paa8', '2019-12-02 09:40:56');
INSERT INTO "public"."sys_captcha" VALUES ('83438302-c905-4a9e-82f6-088641099000', 'enmff', '2019-12-02 09:48:14');
INSERT INTO "public"."sys_captcha" VALUES ('5847c4b5-8680-4de7-8968-9a1e718fada4', '56pen', '2019-11-27 17:45:26');
INSERT INTO "public"."sys_captcha" VALUES ('eb8f3724-09bc-4316-824b-27c75e9ce9b9', '3peyn', '2019-12-02 09:49:23');
INSERT INTO "public"."sys_captcha" VALUES ('06ab542f-7538-41c5-8908-8b22c628f08c', 'ccbff', '2019-11-28 09:05:38');
INSERT INTO "public"."sys_captcha" VALUES ('7215a051-c23b-4c59-8360-69eecf515d70', '5np5w', '2019-11-28 10:36:46');
INSERT INTO "public"."sys_captcha" VALUES ('ef8ed5a5-ff3f-44a6-834d-e580e70d91d0', 'dgxfc', '2019-12-02 09:51:01');
INSERT INTO "public"."sys_captcha" VALUES ('6fe476cf-6a4a-423f-8466-806166e5cc32', 'wg8ne', '2019-11-28 11:11:37');
INSERT INTO "public"."sys_captcha" VALUES ('12f0660f-6d33-4022-8019-050fda75326f', '6g3f7', '2019-12-02 09:51:41');
INSERT INTO "public"."sys_captcha" VALUES ('5f6a759a-9fa1-434b-8d8c-0f64a8a771ff', '6pbpw', '2019-11-28 14:37:46');
INSERT INTO "public"."sys_captcha" VALUES ('9ac62150-49b3-4908-885a-ac37e9454ca3', 'w7x3n', '2019-12-02 09:53:20');
INSERT INTO "public"."sys_captcha" VALUES ('44bef814-ee8b-4408-8f90-a5bf581d3306', 'fgybc', '2019-11-28 14:41:00');
INSERT INTO "public"."sys_captcha" VALUES ('bf019690-9272-477b-85f1-7d9088cef15f', 'f5cnf', '2019-11-28 14:41:38');
INSERT INTO "public"."sys_captcha" VALUES ('97eee8a2-0b13-4b58-8eda-9943253d38c3', '8mdeg', '2019-12-02 09:55:23');
INSERT INTO "public"."sys_captcha" VALUES ('d191a0ff-fc8d-4a05-8d09-790775597d6d', '7y2b3', '2019-11-29 11:35:33');
INSERT INTO "public"."sys_captcha" VALUES ('2486c6c3-f78d-4d32-8032-3fbdc9ba1149', 'bf4x7', '2019-11-29 11:40:04');
INSERT INTO "public"."sys_captcha" VALUES ('1cb89730-9b98-4414-8bde-0a4814589746', 'nbfem', '2019-11-29 11:40:34');
INSERT INTO "public"."sys_captcha" VALUES ('72cd8202-11bf-4c64-8b19-c0d7fb5886fd', 'dan5c', '2019-11-29 14:15:27');
INSERT INTO "public"."sys_captcha" VALUES ('77908f69-7202-4351-8265-02542e2d1cc5', '6376f', '2019-11-29 15:41:09');
INSERT INTO "public"."sys_captcha" VALUES ('4ff90b81-06cf-46fc-895a-5828276458f1', 'bdnx3', '2019-11-29 15:49:56');
INSERT INTO "public"."sys_captcha" VALUES ('c5234948-9f13-45dd-8dfa-9e5ac847be03', 'ydm27', '2019-11-29 16:46:46');
INSERT INTO "public"."sys_captcha" VALUES ('2c1ff037-0ea2-4033-8ab3-c600dc1824eb', 'xybp8', '2019-11-29 16:49:24');
INSERT INTO "public"."sys_captcha" VALUES ('03358530-7753-41d8-80ae-b914c7659a80', 'acn7d', '2019-11-29 17:43:24');
INSERT INTO "public"."sys_captcha" VALUES ('1b80610a-80e9-4a87-867a-711c2bc7a547', 'ap57g', '2019-11-25 18:19:02');
INSERT INTO "public"."sys_captcha" VALUES ('3da02803-7333-4c52-8afc-02c2d66084c2', 'bac6w', '2019-11-30 17:59:37');
INSERT INTO "public"."sys_captcha" VALUES ('abbdb2ed-30d9-4fd0-89de-4e63f8111f2e', '64p5n', '2019-11-22 11:09:38');
INSERT INTO "public"."sys_captcha" VALUES ('8f9ceadb-7f98-4922-860f-df3ddabe23b1', 'e6exn', '2019-11-22 11:22:08');
INSERT INTO "public"."sys_captcha" VALUES ('df5283a2-f7a1-4fda-85b1-5cf2d4138802', 'bf2p5', '2019-11-22 11:30:28');
INSERT INTO "public"."sys_captcha" VALUES ('d9ec2199-02b7-403d-8e2a-cbf7bff879cf', 'p8y8m', '2019-11-26 11:08:18');
INSERT INTO "public"."sys_captcha" VALUES ('d2686229-d4e3-4ed4-8e45-d8ef8d684e6d', 'wwgyp', '2019-11-22 14:49:55');
INSERT INTO "public"."sys_captcha" VALUES ('f767f353-345a-4da0-868a-b0565f9fbd1c', 'nb3g2', '2019-11-22 14:56:12');
INSERT INTO "public"."sys_captcha" VALUES ('75113def-be2e-4330-8f5c-446250fcc0aa', 'en8be', '2019-11-22 14:57:17');
INSERT INTO "public"."sys_captcha" VALUES ('a1414b36-f105-4e34-8f5d-ce4d89c333cf', '2ppd2', '2019-11-22 14:59:01');
INSERT INTO "public"."sys_captcha" VALUES ('e40150e3-894d-4311-88f5-9df027c41ebb', 'wmf2n', '2019-11-22 14:59:56');
INSERT INTO "public"."sys_captcha" VALUES ('b1fb1c78-4d15-4736-8e3b-8dd605789249', 'gf7bn', '2019-11-26 11:10:59');
INSERT INTO "public"."sys_captcha" VALUES ('64950126-43e7-440f-872c-54364fda2532', 'mnnyf', '2019-11-22 15:55:50');
INSERT INTO "public"."sys_captcha" VALUES ('1dab0b0e-aa26-4a52-8247-69d988056f7d', 'wfpap', '2019-11-22 15:57:39');
INSERT INTO "public"."sys_captcha" VALUES ('69aaca50-3a5e-4278-8983-249fc663e2b0', '2ef7g', '2019-11-22 15:57:58');
INSERT INTO "public"."sys_captcha" VALUES ('4bafdd77-7389-41da-85d2-7197de0741cf', 'pwb8p', '2019-11-26 11:11:14');
INSERT INTO "public"."sys_captcha" VALUES ('42165bad-eea3-44d5-8e4d-064044a9b4c6', 'pn8pn', '2019-11-22 16:20:17');
INSERT INTO "public"."sys_captcha" VALUES ('8368ece7-8b8a-44ca-8f9f-a50d76210f96', 'g25yx', '2019-11-26 17:01:02');
INSERT INTO "public"."sys_captcha" VALUES ('35459670-2c39-4335-899d-3866e443babc', '66ene', '2019-11-22 17:11:55');
INSERT INTO "public"."sys_captcha" VALUES ('a9bfce95-593c-43e1-82db-2b75a7baa1cb', 'a3fpf', '2019-11-27 11:46:21');
INSERT INTO "public"."sys_captcha" VALUES ('8216e213-516e-41e0-8002-5000c68cf0f8', 'fwd35', '2019-11-22 17:13:16');
INSERT INTO "public"."sys_captcha" VALUES ('5c6055b7-29c8-4307-8465-8544c592cdd4', '2m6m5', '2019-11-22 17:42:07');
INSERT INTO "public"."sys_captcha" VALUES ('9f509cfc-5677-400c-8fc3-d963759fb3f8', '3enyd', '2019-11-22 17:43:32');
INSERT INTO "public"."sys_captcha" VALUES ('5fa6cd1b-4dc5-4a96-8395-8dffb489657b', 'ya33y', '2019-11-27 16:40:43');
INSERT INTO "public"."sys_captcha" VALUES ('808e3716-5375-4083-8064-cfa6728e0c71', 'ab8xg', '2019-11-22 17:49:02');
INSERT INTO "public"."sys_captcha" VALUES ('c6717d4b-382d-4c32-8c50-5b1eb3da7837', '5wm5n', '2019-11-28 09:04:08');
INSERT INTO "public"."sys_captcha" VALUES ('c51e5cae-5800-485b-8b02-ddc1dc3935b3', 'd4fgp', '2019-11-22 17:57:27');
INSERT INTO "public"."sys_captcha" VALUES ('c603ce59-0b63-4461-866d-9648a837ed11', 'b3xnm', '2019-11-28 09:15:16');
INSERT INTO "public"."sys_captcha" VALUES ('4855e9f0-1211-4e69-867f-be8f60ff2de1', 'fg62p', '2019-11-23 10:01:28');
INSERT INTO "public"."sys_captcha" VALUES ('0e3a59b0-6249-4cf8-8f64-fcd440ede5ca', 'wa66a', '2019-11-23 10:38:10');
INSERT INTO "public"."sys_captcha" VALUES ('9597bf10-3c57-4035-8dd9-898790834b87', '5y244', '2019-11-28 09:17:53');
INSERT INTO "public"."sys_captcha" VALUES ('bf4a38d0-a90f-4fd3-89c8-8c7851832b89', 'bncxm', '2019-11-23 13:50:50');
INSERT INTO "public"."sys_captcha" VALUES ('8dd62a34-49d6-4a6b-8bcf-1127534a88de', '23f5m', '2019-11-23 13:51:36');
INSERT INTO "public"."sys_captcha" VALUES ('67667ca0-6796-4d7a-85e8-d831316489a7', '4nne5', '2019-11-23 13:51:41');
INSERT INTO "public"."sys_captcha" VALUES ('1f693db0-92df-439d-8a44-1597c763064a', 'm8y26', '2019-11-23 13:59:40');
INSERT INTO "public"."sys_captcha" VALUES ('a72f67ab-9923-41f0-812e-a1d03b3dc62f', '253yg', '2019-11-28 13:52:15');
INSERT INTO "public"."sys_captcha" VALUES ('0fe4d58f-8e27-4750-8005-e6fb668c78e2', '666gw', '2019-11-23 14:00:19');
INSERT INTO "public"."sys_captcha" VALUES ('a3100032-8762-49f8-8695-9919bd216bc7', 'b6n7w', '2019-11-23 14:42:57');
INSERT INTO "public"."sys_captcha" VALUES ('689ebd82-a9a1-4444-8e8b-874254bd7eef', 'xfg2a', '2019-11-28 13:54:39');
INSERT INTO "public"."sys_captcha" VALUES ('aa097203-3161-4b93-8c99-8e80c927e0a2', 'ampgm', '2019-11-23 15:10:55');
INSERT INTO "public"."sys_captcha" VALUES ('3d102137-4417-49ae-8562-727080606a74', 'mnmdn', '2019-11-28 14:40:28');
INSERT INTO "public"."sys_captcha" VALUES ('d800d5d3-5bf6-457d-8355-3b42d4d3b34e', '7ggcf', '2019-11-23 15:24:58');
INSERT INTO "public"."sys_captcha" VALUES ('4f6db018-6c25-4c8d-8136-4cfa6c119ab0', 'yddea', '2019-11-23 15:33:49');
INSERT INTO "public"."sys_captcha" VALUES ('402fd224-72fd-442d-8844-8483859e569f', 'ga5b6', '2019-11-23 15:45:02');
INSERT INTO "public"."sys_captcha" VALUES ('3b25c955-e445-4da9-8859-f66f46a6f4cf', 'dfpwd', '2019-11-23 16:14:09');
INSERT INTO "public"."sys_captcha" VALUES ('b9d87516-3741-40c8-8aec-80ed138bea2d', 'naapf', '2019-11-28 15:35:01');
INSERT INTO "public"."sys_captcha" VALUES ('dbff56b6-a3e9-45d7-805d-33edc8a6b0f3', 'pafp5', '2019-11-23 16:19:28');
INSERT INTO "public"."sys_captcha" VALUES ('3ad4596d-f4d5-4f0a-83c6-c604ba589529', 'pa88e', '2019-11-28 18:56:40');
INSERT INTO "public"."sys_captcha" VALUES ('4d9ab023-0286-496d-80a2-fc1c2bf24989', 'm83bx', '2019-11-29 11:36:11');
INSERT INTO "public"."sys_captcha" VALUES ('bcfdb1a7-872e-4895-8b33-edf1f234ca44', 'e5bbm', '2019-11-23 16:24:00');
INSERT INTO "public"."sys_captcha" VALUES ('9a428d4d-dc96-46b6-8ac2-1eaadf97942e', 'yygnn', '2019-11-29 11:36:11');
INSERT INTO "public"."sys_captcha" VALUES ('9bd0f0d7-7c8a-458d-83ef-710711b5511b', '64c36', '2019-11-29 11:36:17');
INSERT INTO "public"."sys_captcha" VALUES ('8469d83e-e7cb-4a21-8818-b82f5489f3b6', 'p7dny', '2019-11-23 16:26:44');
INSERT INTO "public"."sys_captcha" VALUES ('164343c8-e892-4c04-830b-10415de27921', '8ynwa', '2019-11-23 16:28:58');
INSERT INTO "public"."sys_captcha" VALUES ('17cda2d4-4667-45f2-8704-83ad48bcc5f7', '26n2n', '2019-11-29 11:38:14');
INSERT INTO "public"."sys_captcha" VALUES ('af073af8-4dab-4d9f-851c-6b95dadad519', 'xgfmw', '2019-11-25 10:01:39');
INSERT INTO "public"."sys_captcha" VALUES ('8f9aecc7-8744-49b6-8ca1-0346c512046b', 'xb8ay', '2019-11-29 11:42:17');
INSERT INTO "public"."sys_captcha" VALUES ('44df75d7-9054-4063-82d1-a751e5b569b1', 'bpg6g', '2019-11-25 13:54:48');
INSERT INTO "public"."sys_captcha" VALUES ('85128fb9-2130-4980-8f79-26f5e8a5dcd2', '2cafp', '2019-11-25 13:54:48');
INSERT INTO "public"."sys_captcha" VALUES ('18d91f69-fc4a-4e3a-829a-093940e15578', 'bp26b', '2019-11-25 13:56:54');
INSERT INTO "public"."sys_captcha" VALUES ('ed4dbeeb-1e13-4101-8c88-0457be49d67d', 'pndb6', '2019-11-29 13:48:37');
INSERT INTO "public"."sys_captcha" VALUES ('0aca022e-4ce9-45e6-8ed8-641c5351fe06', 'n6ppe', '2019-11-25 14:51:12');
INSERT INTO "public"."sys_captcha" VALUES ('0a7363e7-7a23-40c3-8504-5abab09fbd6d', 'yw2n5', '2019-11-29 15:41:40');
INSERT INTO "public"."sys_captcha" VALUES ('80803cac-4623-47e5-89c3-516eb3d714e8', '58pgm', '2019-11-25 15:02:34');
INSERT INTO "public"."sys_captcha" VALUES ('cc979de7-ca59-45d8-859f-a1692c7a71b2', '57pnx', '2019-11-29 15:47:09');
INSERT INTO "public"."sys_captcha" VALUES ('138406f8-fe90-45a0-8907-770eb547e3e0', 'p827n', '2019-11-25 15:02:47');
INSERT INTO "public"."sys_captcha" VALUES ('37be43c5-e808-4319-88e5-51401a4959fb', '5b4p4', '2019-11-25 17:23:09');
INSERT INTO "public"."sys_captcha" VALUES ('50a517ac-a8e0-466a-897e-d2e823359c5e', 'dfp7n', '2019-11-25 17:29:09');
INSERT INTO "public"."sys_captcha" VALUES ('1df8d998-dd9c-4a13-84c7-d8f665cea1d3', 'p8cc2', '2019-11-25 17:29:10');
INSERT INTO "public"."sys_captcha" VALUES ('87511c82-e355-498b-8e44-15b9b138ceb7', 'ax445', '2019-11-25 17:31:57');
INSERT INTO "public"."sys_captcha" VALUES ('5e94be33-1e05-4d6e-8977-6710312125ed', 'pf2b7', '2019-11-25 17:34:58');
INSERT INTO "public"."sys_captcha" VALUES ('0a17c391-7e89-4c33-81ac-c0f19c1d307d', '7ybpx', '2019-11-25 17:34:58');
INSERT INTO "public"."sys_captcha" VALUES ('cb26aa04-47a4-4d70-87be-204300dd6ea0', '32ynx', '2019-11-25 17:34:58');
INSERT INTO "public"."sys_captcha" VALUES ('5d9fc006-6556-4cdc-8022-3d2a7a6bb8bd', 'xpm6d', '2019-11-25 17:34:58');
INSERT INTO "public"."sys_captcha" VALUES ('7964d4c8-d45d-4ab0-8712-0a89ef86e53b', '32e2c', '2019-11-25 17:34:58');
INSERT INTO "public"."sys_captcha" VALUES ('e72a1fb0-9f9a-418e-8cf2-cf0a2fe85bdc', '55e8e', '2019-11-25 17:34:58');
INSERT INTO "public"."sys_captcha" VALUES ('716c2928-e322-424d-8cb8-7f7d8c453944', 'an7xg', '2019-11-25 17:34:58');
INSERT INTO "public"."sys_captcha" VALUES ('6ec64a21-ee95-4a6e-8dad-cb81469e5a1d', '8g524', '2019-11-25 17:35:04');
INSERT INTO "public"."sys_captcha" VALUES ('f9692e3f-335c-4be4-8468-07dac57f1af7', '268m6', '2019-11-25 17:35:06');
INSERT INTO "public"."sys_captcha" VALUES ('45eee3ae-9de0-46f0-8189-85e43249404e', 'a8pnw', '2019-11-25 17:35:06');
INSERT INTO "public"."sys_captcha" VALUES ('4cd8bff4-c7ee-4e32-8f53-2729dfacfa0b', 'c2xwf', '2019-11-25 17:35:27');
INSERT INTO "public"."sys_captcha" VALUES ('1f4494da-1fb3-48d3-8e66-59424739a3f5', '226ap', '2019-11-25 17:35:36');
INSERT INTO "public"."sys_captcha" VALUES ('6d9e4a78-28b7-4a1c-8faf-e656eef9e3e7', 'gnefm', '2019-11-25 17:35:46');
INSERT INTO "public"."sys_captcha" VALUES ('c311a3cf-ce7a-42b7-85ca-c926b9d15ac6', 'bawyg', '2019-11-25 17:36:06');
INSERT INTO "public"."sys_captcha" VALUES ('3e8a6ea1-222f-4cf0-81e0-970f7e8c9493', 'g8xfg', '2019-11-25 17:36:33');
INSERT INTO "public"."sys_captcha" VALUES ('8a336128-1a6e-4e32-8eed-5a224ed324a4', 'f73xy', '2019-11-25 17:37:44');
INSERT INTO "public"."sys_captcha" VALUES ('b80d03ac-d58e-4728-8dc9-65cea093b742', 'p8xnd', '2019-11-25 17:37:46');
INSERT INTO "public"."sys_captcha" VALUES ('24f2567e-3168-4d57-8dac-99223f7d208e', 'n7dby', '2019-11-25 17:38:17');
INSERT INTO "public"."sys_captcha" VALUES ('cbb9b5a4-de64-4361-8b61-4f7835833946', '8m4d2', '2019-11-25 17:38:21');
INSERT INTO "public"."sys_captcha" VALUES ('87bd09a6-4561-4aed-82c3-163d8acf0a8e', 'cmb7m', '2019-11-25 17:38:38');
INSERT INTO "public"."sys_captcha" VALUES ('1972981b-bda2-44fa-8972-b9089a61ca77', 'x2ap4', '2019-11-25 17:41:28');
INSERT INTO "public"."sys_captcha" VALUES ('2dd6b076-a672-4ca6-832d-586dd65c79c7', 'efydy', '2019-11-25 17:41:30');
INSERT INTO "public"."sys_captcha" VALUES ('3c876442-6d90-4004-88eb-76702cb8882c', '4c844', '2019-11-25 17:46:57');
INSERT INTO "public"."sys_captcha" VALUES ('1b0c595c-7ef1-4f0b-8319-7f19364e6a95', 'fn6d2', '2019-11-25 17:46:59');
INSERT INTO "public"."sys_captcha" VALUES ('6056afe6-ce1f-485d-8179-50a8cd2d78d0', '254bd', '2020-01-07 16:42:47');
INSERT INTO "public"."sys_captcha" VALUES ('8c9dfbe0-4619-445a-8b5a-86f9749cbe71', '8wenb', '2019-12-02 15:04:13');
INSERT INTO "public"."sys_captcha" VALUES ('5f23c309-6994-453d-8fa8-9cdc68933a41', 'cwgny', '2019-12-02 15:11:45');
INSERT INTO "public"."sys_captcha" VALUES ('fe698c20-5acd-4413-88b3-3d737b2a87a2', 'd8n6a', '2019-12-03 00:16:42');
INSERT INTO "public"."sys_captcha" VALUES ('2fa9ef80-eff9-4ff3-8a1e-6c1216a53456', '5cn4b', '2019-12-03 10:55:23');
INSERT INTO "public"."sys_captcha" VALUES ('bc4b5d2f-a871-49ef-84b9-75b74fb064c4', 'x5wn3', '2019-12-04 13:05:27');
INSERT INTO "public"."sys_captcha" VALUES ('641fe9e6-d086-4e9b-8687-ec63a5a16ddd', '4gc82', '2019-12-04 13:05:35');
INSERT INTO "public"."sys_captcha" VALUES ('05f6a419-51d5-4d7f-8de6-9dc9400c7f49', 'y3anw', '2019-12-04 13:06:14');
INSERT INTO "public"."sys_captcha" VALUES ('a758b025-c3bc-45db-8807-cdc8196067f1', '5yfgp', '2019-12-04 13:07:04');
INSERT INTO "public"."sys_captcha" VALUES ('01b180a3-5a8d-48e0-849f-11e4a8657461', 'fmc7b', '2019-12-04 13:07:21');
INSERT INTO "public"."sys_captcha" VALUES ('0f4d9d7c-811c-43cd-8c28-ca4fbd4e0150', 'bcy5y', '2019-12-04 13:07:45');
INSERT INTO "public"."sys_captcha" VALUES ('e3adaf91-87c4-4dc5-80dc-606f8fac6fb6', 'cc6yb', '2019-12-04 13:44:08');
INSERT INTO "public"."sys_captcha" VALUES ('9871bc32-465b-404b-804d-80f5e9b77b7c', '5w34a', '2019-12-04 16:13:35');
INSERT INTO "public"."sys_captcha" VALUES ('9cb3a0e2-e9e4-49ef-8a03-42e2ec6d1e0e', '5cd4n', '2019-12-05 13:05:04');
INSERT INTO "public"."sys_captcha" VALUES ('e48ad39e-cc9e-457b-8303-636f5e1c0167', '2cndg', '2019-12-05 13:27:32');
INSERT INTO "public"."sys_captcha" VALUES ('4110d995-905a-40bb-897d-842bd1dccd0f', 'e867w', '2019-12-05 13:35:57');
INSERT INTO "public"."sys_captcha" VALUES ('74d396c3-a33f-432d-886d-833fa83850b0', '6ngxe', '2019-12-05 13:38:19');
INSERT INTO "public"."sys_captcha" VALUES ('b5a57882-a244-4a63-8287-763f50799b05', 'xbnxc', '2019-12-05 13:38:21');
INSERT INTO "public"."sys_captcha" VALUES ('a763a61c-a1a8-45a0-8014-d6aed09f8383', '8845m', '2019-12-05 13:38:45');
INSERT INTO "public"."sys_captcha" VALUES ('c8dea1a2-e951-4f84-8fc3-94225216af3d', 'n7ypg', '2019-12-05 13:39:20');
INSERT INTO "public"."sys_captcha" VALUES ('b69f3950-e330-468b-8a05-fd58f47bb169', 'nnp8f', '2019-12-05 14:04:44');
INSERT INTO "public"."sys_captcha" VALUES ('2fef6631-d83c-4192-8677-a95037fec1e3', '64nn2', '2019-12-05 14:06:02');
INSERT INTO "public"."sys_captcha" VALUES ('38ad1ed8-31a4-4b60-8a97-92c126a8b5cd', 'pwndn', '2019-12-05 14:06:22');
INSERT INTO "public"."sys_captcha" VALUES ('b2058d13-b3f7-4d2f-8e0e-c4f54e6936c5', 'xdb36', '2019-12-05 14:07:26');
INSERT INTO "public"."sys_captcha" VALUES ('775279a8-3c22-475e-8b4a-6f9c5bd0bb14', 'ppeea', '2019-12-05 14:08:05');
INSERT INTO "public"."sys_captcha" VALUES ('82c6ca5d-3ad5-4219-87aa-83e2c6d53f1a', '6yeba', '2019-12-05 14:09:39');
INSERT INTO "public"."sys_captcha" VALUES ('22a60198-ac3a-4ae3-83cd-b896fc5cba7a', '6ne75', '2019-12-05 14:09:56');
INSERT INTO "public"."sys_captcha" VALUES ('5dfab25e-6d32-4102-8072-a01bbf25f71d', 'nbe57', '2019-12-05 14:11:25');
INSERT INTO "public"."sys_captcha" VALUES ('d3abc489-f255-4320-8d42-96aa0110e96d', 'ynx86', '2019-12-05 14:11:51');
INSERT INTO "public"."sys_captcha" VALUES ('a1911775-c5ad-4138-892a-02fc19d7a1f6', '57we2', '2019-12-05 14:13:01');
INSERT INTO "public"."sys_captcha" VALUES ('f63d6dcd-e606-4693-8a90-dc57a004b72d', 'adpf6', '2019-12-05 15:18:28');
INSERT INTO "public"."sys_captcha" VALUES ('b1e20a3d-f4a2-4ab6-8f2e-233826c2a0e1', 'fcnde', '2019-12-05 16:35:37');
INSERT INTO "public"."sys_captcha" VALUES ('974b19f6-378c-4608-81fe-8f78d7561589', '37w3g', '2019-12-05 17:30:31');
INSERT INTO "public"."sys_captcha" VALUES ('daa91182-1217-4e09-8191-84078e55f08b', '26cd8', '2019-12-05 17:30:55');
INSERT INTO "public"."sys_captcha" VALUES ('d7b57b88-70f6-4726-82b7-1f86876f79c2', 'nxx5p', '2019-12-05 18:17:38');
INSERT INTO "public"."sys_captcha" VALUES ('b10bf8d0-0da7-4bd8-8b6d-a52b7b914eb3', '5575y', '2019-12-05 18:18:16');
INSERT INTO "public"."sys_captcha" VALUES ('29463374-5f4b-4dad-8efd-b61002dcd5e4', '5e8gf', '2019-12-05 18:18:33');
INSERT INTO "public"."sys_captcha" VALUES ('fa65d25a-c2f9-44ea-8346-42d75ad26dcb', '3yfaw', '2019-12-06 00:36:38');
INSERT INTO "public"."sys_captcha" VALUES ('60c6dbde-8c86-41a6-8916-2e2f5c335e56', '2fd58', '2019-12-06 09:28:42');
INSERT INTO "public"."sys_captcha" VALUES ('981ecd82-0c32-466c-8500-07fac86386bd', '8pmgn', '2019-12-06 10:09:24');
INSERT INTO "public"."sys_captcha" VALUES ('7eafd26f-685f-4695-893a-d0d780de8925', 'nm7aa', '2019-12-06 10:33:50');
INSERT INTO "public"."sys_captcha" VALUES ('07925be4-8f9f-4965-884e-f7c200fcd6a0', 'xa55e', '2019-12-06 10:45:54');
INSERT INTO "public"."sys_captcha" VALUES ('5f858401-591c-43b0-8614-fbef35c329fb', 'nbg4n', '2019-12-06 11:21:00');
INSERT INTO "public"."sys_captcha" VALUES ('b4df1d80-ec1d-427c-818e-f888666c3ef4', 'cd43f', '2019-12-06 14:47:06');
INSERT INTO "public"."sys_captcha" VALUES ('98946acc-38e5-456a-843c-27b034d40049', 'x7fdf', '2019-12-06 16:03:57');
INSERT INTO "public"."sys_captcha" VALUES ('edc63f62-7380-495a-8724-ad09c198552a', 'd8pgx', '2019-12-06 16:18:19');
INSERT INTO "public"."sys_captcha" VALUES ('5a8434af-6117-4892-89ee-da1d0dfb838f', '4nnne', '2019-12-06 23:00:25');
INSERT INTO "public"."sys_captcha" VALUES ('8c71d9f2-d303-4690-8cc3-e3819ef86542', '6a5b8', '2019-12-06 23:00:38');
INSERT INTO "public"."sys_captcha" VALUES ('719b4200-3d41-433d-8b9a-d313557f6c42', 'mf6xn', '2019-12-07 09:30:39');
INSERT INTO "public"."sys_captcha" VALUES ('21fbb48a-447f-4d08-8e35-c6f95456ad48', 'bewnf', '2019-12-07 09:33:18');
INSERT INTO "public"."sys_captcha" VALUES ('f7184f30-2e05-41f2-8e3f-1bc9f488b698', 'xp44m', '2019-12-07 09:45:59');
INSERT INTO "public"."sys_captcha" VALUES ('bb141462-4a92-4f0d-838f-d44e83885a2b', 'ax8yd', '2019-12-07 10:21:11');
INSERT INTO "public"."sys_captcha" VALUES ('8305911b-b1f0-4879-8b82-057b526ce73f', 'bfwgb', '2019-12-07 14:08:42');
INSERT INTO "public"."sys_captcha" VALUES ('0d6d86bb-a4e0-4145-8a77-7449b969c3b2', 'abmdx', '2019-12-07 15:36:06');
INSERT INTO "public"."sys_captcha" VALUES ('010b8a21-88aa-4020-8fe1-7ea62fcbf79c', 'xdnn6', '2019-12-08 22:56:54');
INSERT INTO "public"."sys_captcha" VALUES ('d63c58be-423b-4d2d-8dbd-43a0be97508a', 'p5yfw', '2019-12-08 22:56:55');
INSERT INTO "public"."sys_captcha" VALUES ('b244204b-2466-4cd5-84b3-7b6d214c2374', 'nnd47', '2019-12-19 10:29:37');
INSERT INTO "public"."sys_captcha" VALUES ('1dcf6239-9e4c-4905-8f92-5a9d576146c6', 'npcx4', '2019-12-09 09:54:27');
INSERT INTO "public"."sys_captcha" VALUES ('33a7835b-0d46-4c0d-8919-fe2ea6c05528', 'ex6a5', '2019-12-10 09:37:51');
INSERT INTO "public"."sys_captcha" VALUES ('89072ee2-e1a3-4ff1-8a48-9dee766ef494', 'g4wd4', '2019-12-10 09:48:31');
INSERT INTO "public"."sys_captcha" VALUES ('0c73c67f-1be1-4850-8f8c-4f4b4e09d194', 'nw5n2', '2019-12-09 09:59:59');
INSERT INTO "public"."sys_captcha" VALUES ('ef73c5e4-a82c-45d5-852f-50a24ef1c5b4', '42xgn', '2019-12-09 10:00:52');
INSERT INTO "public"."sys_captcha" VALUES ('5d886310-bab2-4101-8c46-4702e40e72b3', '6n8fx', '2019-12-09 10:26:47');
INSERT INTO "public"."sys_captcha" VALUES ('60e274aa-df1a-4cce-8cb8-4ab9bcb4505e', 'c53n7', '2019-12-09 10:45:14');
INSERT INTO "public"."sys_captcha" VALUES ('f69b9179-996e-43a9-824c-c18240dc1cb3', 'p6n64', '2019-12-09 11:00:42');
INSERT INTO "public"."sys_captcha" VALUES ('ee5c14aa-61ca-4733-8dea-5045d31343ab', '8p8fn', '2019-12-09 11:01:25');
INSERT INTO "public"."sys_captcha" VALUES ('019215ce-6919-4c63-8eb3-3c88c4cff28d', 'fx5ex', '2019-12-09 11:01:27');
INSERT INTO "public"."sys_captcha" VALUES ('74c29a56-4c64-4698-8585-27e83f0aebad', 'gww33', '2019-12-09 11:03:27');
INSERT INTO "public"."sys_captcha" VALUES ('7861a913-5dfe-4981-877c-84828d8fd7f1', 'fnyec', '2019-12-10 10:18:14');
INSERT INTO "public"."sys_captcha" VALUES ('550e6bb1-3179-4ebc-8f41-909ac7706816', 'p7bpp', '2019-12-09 11:35:17');
INSERT INTO "public"."sys_captcha" VALUES ('1aef3976-899b-4a75-85d7-eaaa6feb62d9', 'a37pn', '2019-12-09 11:54:05');
INSERT INTO "public"."sys_captcha" VALUES ('2b34b014-d2b1-46bb-89a0-fbfc069fec51', 'wpaxd', '2019-12-09 13:01:08');
INSERT INTO "public"."sys_captcha" VALUES ('138ca64b-8e77-46c2-8b04-4a5af6ef7214', 'xpc3n', '2019-12-09 13:01:14');
INSERT INTO "public"."sys_captcha" VALUES ('8f6f3d45-8603-4b4c-800c-983edddf2708', 'afn34', '2019-12-09 14:18:55');
INSERT INTO "public"."sys_captcha" VALUES ('8edbdb55-2128-41a4-81c9-037e0c51260f', 'bn88n', '2019-12-09 17:50:28');
INSERT INTO "public"."sys_captcha" VALUES ('0d4aa67f-e96b-407b-8f2c-e455aacc2c02', 'gcgnd', '2019-12-09 18:19:23');
INSERT INTO "public"."sys_captcha" VALUES ('aeb9766e-d083-48c6-8e14-f99312b383dd', 'wx83w', '2019-12-10 15:51:51');
INSERT INTO "public"."sys_captcha" VALUES ('422c1b10-4e51-44e3-8dae-6ab754c6521d', 'mgmxp', '2019-12-10 09:23:47');
INSERT INTO "public"."sys_captcha" VALUES ('621ee29c-8f32-4140-83d4-afe4a379a035', '8ed43', '2019-12-10 17:01:12');
INSERT INTO "public"."sys_captcha" VALUES ('5041b923-d70b-4583-8909-657648deeffb', 'nd54f', '2019-12-10 18:00:44');
INSERT INTO "public"."sys_captcha" VALUES ('ac846533-ef3c-4e2b-8f5f-70759bd7975c', 'wpxen', '2019-12-10 18:02:38');
INSERT INTO "public"."sys_captcha" VALUES ('88369193-e00b-470f-8e09-12e3eac0d65b', '2anen', '2019-12-10 18:02:39');
INSERT INTO "public"."sys_captcha" VALUES ('8b17cf92-b338-4c38-8b06-6a5d5e2adb04', '528nm', '2019-12-10 18:04:50');
INSERT INTO "public"."sys_captcha" VALUES ('d17be17b-b296-4b3b-8f9f-f9e48533c73d', '7wwdm', '2019-12-11 08:42:21');
INSERT INTO "public"."sys_captcha" VALUES ('185f5f93-6492-4a1a-8d69-3f0a8e212c9e', '37wa5', '2019-12-11 08:58:42');
INSERT INTO "public"."sys_captcha" VALUES ('bd444ea0-6f63-466c-8f91-64eaff010de7', '2eb5w', '2019-12-11 08:58:57');
INSERT INTO "public"."sys_captcha" VALUES ('54034bd1-c873-4394-89fb-12b83e9ead63', '3w68p', '2019-12-11 08:59:24');
INSERT INTO "public"."sys_captcha" VALUES ('75255eb0-de35-48b7-882e-b372fef624a0', 'm2nnp', '2019-12-11 10:25:22');
INSERT INTO "public"."sys_captcha" VALUES ('2bbf59e5-3ac6-49e6-8580-c6963abbe415', 'mnm66', '2019-12-11 13:09:15');
INSERT INTO "public"."sys_captcha" VALUES ('0e1e3460-0a61-4636-80f8-2bdf7a085b3a', 'xayne', '2019-12-11 13:12:21');
INSERT INTO "public"."sys_captcha" VALUES ('f9e3e1fa-28b4-4366-8efe-b2279a4521ba', '26fpy', '2019-12-11 13:12:21');
INSERT INTO "public"."sys_captcha" VALUES ('da4fbde8-63ea-4d8f-8d6e-9eb3a33ce623', 'yx8a3', '2019-12-11 14:45:29');
INSERT INTO "public"."sys_captcha" VALUES ('872f22b8-d86e-47ba-85c1-57822d390ecd', '3nne4', '2019-12-11 16:39:07');
INSERT INTO "public"."sys_captcha" VALUES ('e98092ed-ed1e-43c2-8b00-8a4f540f8247', 'nbcc3', '2019-12-11 16:39:07');
INSERT INTO "public"."sys_captcha" VALUES ('4ccf5318-be2b-440c-83a9-be55f61a0853', 'y4y6y', '2019-12-11 16:43:38');
INSERT INTO "public"."sys_captcha" VALUES ('a563dae6-ef61-4ba7-8975-9e1682ab5684', 'cxfce', '2019-12-11 16:44:30');
INSERT INTO "public"."sys_captcha" VALUES ('f9db94ca-f2c9-470a-8683-22d39c1e1dae', 'nyfc3', '2019-12-11 16:51:03');
INSERT INTO "public"."sys_captcha" VALUES ('a057da3a-c0dd-4a83-8d23-2cd836ffa528', 'np28w', '2019-12-11 16:53:06');
INSERT INTO "public"."sys_captcha" VALUES ('e1a623ee-99aa-4bab-894c-4307142d6356', 'dn74a', '2019-12-11 16:53:42');
INSERT INTO "public"."sys_captcha" VALUES ('c71642a9-3372-4da5-839e-fe6b6e422494', 'yawwx', '2019-12-11 16:54:49');
INSERT INTO "public"."sys_captcha" VALUES ('7314acba-210f-4e8b-8887-abeb5f36b7f2', 'edyp4', '2019-12-11 17:23:37');
INSERT INTO "public"."sys_captcha" VALUES ('ce039954-ed8f-4512-8e8f-759a0bf6e90d', 'anndb', '2019-12-11 17:23:39');
INSERT INTO "public"."sys_captcha" VALUES ('c2f3e56d-2db9-4295-82ca-c4753b56fb0f', 'fenan', '2019-12-11 17:23:40');
INSERT INTO "public"."sys_captcha" VALUES ('ddc7aa27-2449-4871-8067-e5efc304adf4', 'febb3', '2019-12-11 17:23:54');
INSERT INTO "public"."sys_captcha" VALUES ('6202a2da-a932-4419-85ce-84f50540498a', '83p5y', '2019-12-11 17:31:39');
INSERT INTO "public"."sys_captcha" VALUES ('1f3668c1-2228-4b06-8851-d4b27df46099', 'wydee', '2019-12-11 17:32:00');
INSERT INTO "public"."sys_captcha" VALUES ('c38bf516-afee-42df-88d1-28ea03e65a25', 'dpf45', '2019-12-11 17:40:16');
INSERT INTO "public"."sys_captcha" VALUES ('cd8dd1f0-07b1-451e-84f7-62e835b38769', '7d5a7', '2019-12-11 17:42:50');
INSERT INTO "public"."sys_captcha" VALUES ('1d8a6851-f3d7-4b1a-88d8-a944312a259d', 'n44cc', '2019-12-11 17:47:00');
INSERT INTO "public"."sys_captcha" VALUES ('c800be2b-0590-406c-8a47-ece13f27c675', 'p2a2m', '2019-12-11 18:03:20');
INSERT INTO "public"."sys_captcha" VALUES ('a762ea54-d511-4bf9-8daf-93cf386ca19e', '8n675', '2019-12-11 18:03:22');
INSERT INTO "public"."sys_captcha" VALUES ('815b0683-0449-43bf-84ca-51cf20f1aeff', '6dw5p', '2019-12-11 18:23:52');
INSERT INTO "public"."sys_captcha" VALUES ('ecade389-4f5a-4291-8dc7-6318136c99b0', 'aagme', '2019-12-11 18:36:31');
INSERT INTO "public"."sys_captcha" VALUES ('e9f1b6b4-4b5d-434e-8514-800f7cf6e43a', 'x5278', '2019-12-11 18:37:14');
INSERT INTO "public"."sys_captcha" VALUES ('8be5abd9-5151-4def-8b0e-f70de7fda558', 'x2mn3', '2019-12-11 18:42:20');
INSERT INTO "public"."sys_captcha" VALUES ('c7a6ce38-6603-40c4-8938-3eae6926c552', '2mc4m', '2019-12-11 18:44:57');
INSERT INTO "public"."sys_captcha" VALUES ('45481d46-8755-45c9-8163-b427e8b74e98', 'a2nya', '2019-12-11 19:23:14');
INSERT INTO "public"."sys_captcha" VALUES ('076cb647-1861-4e47-84fb-89937da7fad8', 'bgwg6', '2019-12-11 19:39:18');
INSERT INTO "public"."sys_captcha" VALUES ('8ea3d2ff-ae0b-4154-8c93-e88a54e36d3a', 'exw6c', '2019-12-11 19:40:08');
INSERT INTO "public"."sys_captcha" VALUES ('d02d4896-fc06-4485-81da-e96ecb81ba65', 'gnf5p', '2019-12-11 19:40:48');
INSERT INTO "public"."sys_captcha" VALUES ('2aba6452-5c25-45f6-866e-3fd6b478fb45', 'wn5nn', '2019-12-11 19:41:22');
INSERT INTO "public"."sys_captcha" VALUES ('fb424f73-0af5-4468-8978-069917b4788a', '3nc7x', '2019-12-11 19:42:20');
INSERT INTO "public"."sys_captcha" VALUES ('e57d73b8-5ec0-4c10-8d03-554557ee5bdf', '64wy4', '2019-12-11 19:46:35');
INSERT INTO "public"."sys_captcha" VALUES ('aee4561d-6cad-4de2-87cb-99137f0c0382', 'gf85f', '2019-12-11 20:04:38');
INSERT INTO "public"."sys_captcha" VALUES ('4a35f909-8b3c-45ce-8c4a-207b87d851f5', 'nc3y3', '2019-12-11 20:12:47');
INSERT INTO "public"."sys_captcha" VALUES ('ad4d820a-3687-47b8-888f-bb7bbee7de3f', '7aayn', '2019-12-11 20:15:36');
INSERT INTO "public"."sys_captcha" VALUES ('25295304-65f3-4bce-834e-f55e5a22e437', 'pc4db', '2019-12-11 21:03:52');
INSERT INTO "public"."sys_captcha" VALUES ('ef202aea-da87-4c76-885e-3d514f731e2c', 'ce623', '2019-12-11 21:06:03');
INSERT INTO "public"."sys_captcha" VALUES ('54af28ac-f2a8-4dcc-84e7-b243ea943146', 'e2535', '2019-12-11 21:06:49');
INSERT INTO "public"."sys_captcha" VALUES ('7dbf3603-8a2c-4363-88f2-f0516828a238', '488am', '2019-12-11 21:08:55');
INSERT INTO "public"."sys_captcha" VALUES ('1c4fc008-dfd8-4c7a-8051-e325d2c1eab3', 'c47en', '2019-12-11 21:09:20');
INSERT INTO "public"."sys_captcha" VALUES ('50e86b6c-0c98-4413-8f3a-adb0e303e65f', 'w2mcg', '2019-12-11 21:10:30');
INSERT INTO "public"."sys_captcha" VALUES ('d492da9a-2248-4c7f-8a98-48fd02d721e3', '67gyn', '2019-12-11 21:11:22');
INSERT INTO "public"."sys_captcha" VALUES ('8f75ad36-27e1-472f-89a6-13df819d9f53', '3fann', '2019-12-11 21:13:26');
INSERT INTO "public"."sys_captcha" VALUES ('1febf4fb-a107-45ce-8bdd-bc4c14f3d350', '4dn4e', '2019-12-11 21:13:46');
INSERT INTO "public"."sys_captcha" VALUES ('ee6731f9-3e5b-496e-8480-7bc87abde998', 'n56xf', '2019-12-11 21:15:29');
INSERT INTO "public"."sys_captcha" VALUES ('edc4b6cd-d2af-4c24-8f9d-cb607132bc71', 'c867b', '2019-12-12 09:16:27');
INSERT INTO "public"."sys_captcha" VALUES ('00c763a5-ac03-412b-87a5-549ca8b725b5', 'pm3fy', '2019-12-12 11:01:32');
INSERT INTO "public"."sys_captcha" VALUES ('faac49a1-6e02-44fc-8216-aef62127c691', 'b7pnn', '2019-12-12 11:04:24');
INSERT INTO "public"."sys_captcha" VALUES ('46433975-25cf-49d5-85c8-cf61909bc815', '4wa78', '2019-12-12 13:41:29');
INSERT INTO "public"."sys_captcha" VALUES ('9d2ac1c3-f7c8-4dfc-8908-528e58b73d77', '2nyp4', '2019-12-12 13:43:42');
INSERT INTO "public"."sys_captcha" VALUES ('4f24f8cf-7fae-432b-882d-efc1d4aa61a5', '2xccc', '2019-12-12 14:54:54');
INSERT INTO "public"."sys_captcha" VALUES ('a8b419d1-5bdf-4e01-8db7-70ab4c639a7a', 'ewp6e', '2019-12-12 17:36:51');
INSERT INTO "public"."sys_captcha" VALUES ('db047ec2-2a80-409c-83b0-09e55e042e19', '76cxa', '2019-12-12 17:38:07');
INSERT INTO "public"."sys_captcha" VALUES ('9df94b13-f5b7-4f33-8a74-46c7f1419c6b', 'w667c', '2019-12-12 17:38:08');
INSERT INTO "public"."sys_captcha" VALUES ('2eb0a404-0fd0-4cde-8f54-a20921f8f334', 'nacpy', '2019-12-13 00:00:46');
INSERT INTO "public"."sys_captcha" VALUES ('d6b74539-c966-4813-89ab-f2930b8bad75', '3y55g', '2019-12-19 10:31:43');
INSERT INTO "public"."sys_captcha" VALUES ('1373eb4c-0014-46c3-85f6-4c34280051b8', 'axexm', '2019-12-19 10:31:43');
INSERT INTO "public"."sys_captcha" VALUES ('72acbfe5-a232-4805-850f-ff033d8ce714', '7m6na', '2019-12-13 11:15:55');
INSERT INTO "public"."sys_captcha" VALUES ('534380da-e52b-4906-898f-2a774f213de9', 'nnxfb', '2019-12-13 11:21:12');
INSERT INTO "public"."sys_captcha" VALUES ('b4b58f14-bd05-447b-82e7-92e36195e6cb', 'c3eyf', '2019-12-13 09:30:44');
INSERT INTO "public"."sys_captcha" VALUES ('748176d4-eca2-402a-8691-807cdef56143', 'fc6mn', '2019-12-21 10:53:13');
INSERT INTO "public"."sys_captcha" VALUES ('040bf76b-0191-4208-8ae0-c2dc07f8e8fe', '7b78n', '2019-12-13 09:32:07');
INSERT INTO "public"."sys_captcha" VALUES ('43bb04f0-9b60-4d12-8a7c-7a07ec9c6bda', '6w6n8', '2019-12-19 10:39:40');
INSERT INTO "public"."sys_captcha" VALUES ('77f84803-570e-4191-88c4-a817979e343f', 'cx6n3', '2019-12-13 11:41:05');
INSERT INTO "public"."sys_captcha" VALUES ('5983a3fe-0d61-4266-80af-6affff0720e1', 'xd6ef', '2019-12-13 11:47:43');
INSERT INTO "public"."sys_captcha" VALUES ('97e685c6-5a2d-4a65-8b56-4634b434631c', '5nfg3', '2019-12-19 13:59:03');
INSERT INTO "public"."sys_captcha" VALUES ('1eef98d4-a870-4848-8f8b-37f39f2f7bc6', 'ec2a7', '2019-12-13 11:49:01');
INSERT INTO "public"."sys_captcha" VALUES ('dfa539a1-e636-4c97-80f8-d90757e99588', '5npbc', '2019-12-19 13:59:29');
INSERT INTO "public"."sys_captcha" VALUES ('9fb0ce76-8851-4274-856d-6db1fd0a253a', 'm78e8', '2019-12-19 13:59:48');
INSERT INTO "public"."sys_captcha" VALUES ('342b2910-24ff-48d8-8d4b-76e3b6917952', 'm4cgb', '2019-12-13 11:51:18');
INSERT INTO "public"."sys_captcha" VALUES ('bff3b040-f345-4b60-8fc3-efa091f35c46', '4a7pb', '2019-12-13 11:51:31');
INSERT INTO "public"."sys_captcha" VALUES ('f4a8d40d-4e12-4058-8f54-819fced84053', 'wd8bp', '2019-12-19 14:04:40');
INSERT INTO "public"."sys_captcha" VALUES ('bdd16212-0fe2-4e60-85c5-15786a8e7210', 'bx446', '2019-12-19 14:07:15');
INSERT INTO "public"."sys_captcha" VALUES ('f449e641-e582-438d-862d-cdc3dc914694', 'p6neb', '2019-12-19 14:07:16');
INSERT INTO "public"."sys_captcha" VALUES ('68d81238-1978-4ce8-8315-bc1a756eb9fe', 'awnn2', '2019-12-19 14:07:52');
INSERT INTO "public"."sys_captcha" VALUES ('73c5185e-3218-488d-805b-438ef6068e18', 'm5by8', '2019-12-19 14:08:17');
INSERT INTO "public"."sys_captcha" VALUES ('d89c8d32-778b-4acb-8506-9a939e70f765', '5gnpn', '2019-12-19 14:08:28');
INSERT INTO "public"."sys_captcha" VALUES ('9b98fe4b-ec07-4b3d-8cdc-3bb862cf4c72', 'cp5ap', '2019-12-13 15:57:48');
INSERT INTO "public"."sys_captcha" VALUES ('f18314b9-0226-4574-8f04-65b79d139136', '7bn4a', '2019-12-19 14:08:35');
INSERT INTO "public"."sys_captcha" VALUES ('198d70b4-3f77-4256-8ef6-fc09e2a20453', 'dw3yn', '2019-12-19 14:08:39');
INSERT INTO "public"."sys_captcha" VALUES ('75828687-4cb1-4d10-861e-5b5b379efbb8', 'xn52f', '2019-12-13 16:03:02');
INSERT INTO "public"."sys_captcha" VALUES ('936a26f2-d416-4630-8997-9d8214217a41', '2cxye', '2019-12-13 16:30:37');
INSERT INTO "public"."sys_captcha" VALUES ('8bbed4b3-8735-46ea-8ca2-e8a2ad6a1bbd', '6nmnm', '2019-12-13 17:51:59');
INSERT INTO "public"."sys_captcha" VALUES ('549df9cf-c935-4d3c-8d9d-88e07e7e6740', 'bf7pn', '2019-12-19 14:12:52');
INSERT INTO "public"."sys_captcha" VALUES ('640b118e-b130-4a5e-8c08-2e3277330800', '67nny', '2019-12-19 14:15:25');
INSERT INTO "public"."sys_captcha" VALUES ('4aa58a01-209f-4770-85a8-235c4f908ab7', 'nnnc5', '2019-12-16 09:48:15');
INSERT INTO "public"."sys_captcha" VALUES ('9c9a41fe-3f18-45e7-8112-d93740c3587c', 'weefd', '2019-12-19 14:15:26');
INSERT INTO "public"."sys_captcha" VALUES ('733c903b-38f5-48c6-8ce0-ace2fabcbe38', '4gwmp', '2019-12-19 14:15:28');
INSERT INTO "public"."sys_captcha" VALUES ('2cbb97f0-52d1-4ce1-81d3-9cce501adc2f', 'd2ynn', '2019-12-19 14:15:32');
INSERT INTO "public"."sys_captcha" VALUES ('d116a41f-ffe1-4c8b-8082-d6a63620109d', 'd4x78', '2019-12-16 16:50:16');
INSERT INTO "public"."sys_captcha" VALUES ('ddb8caf5-160a-4607-850e-fa1c16284403', 'x8gyd', '2019-12-19 14:17:17');
INSERT INTO "public"."sys_captcha" VALUES ('7ea06954-e325-4e99-8171-7d0844956a9d', '2ncfb', '2019-12-19 14:23:32');
INSERT INTO "public"."sys_captcha" VALUES ('d74d144e-2490-400f-8ef0-25cfca28c131', '78fpx', '2019-12-19 14:23:36');
INSERT INTO "public"."sys_captcha" VALUES ('ce335ecf-e6da-4b17-8e88-5844e6fe4233', 'n3ngw', '2019-12-19 14:23:37');
INSERT INTO "public"."sys_captcha" VALUES ('c7705ff2-1185-4074-8c00-a608c01f1005', '2ydxe', '2019-12-19 14:28:46');
INSERT INTO "public"."sys_captcha" VALUES ('3b474679-b1d7-45db-87ea-43d76b3bdb8a', 'yx767', '2019-12-19 14:28:48');
INSERT INTO "public"."sys_captcha" VALUES ('27b997f2-596f-4d64-853e-4607f8e7bd20', 'pf4f3', '2019-12-19 14:29:01');
INSERT INTO "public"."sys_captcha" VALUES ('d97a42ee-db04-472e-8afe-5c490d7d6f04', 'xd6ec', '2019-12-17 10:18:45');
INSERT INTO "public"."sys_captcha" VALUES ('f8d5dd86-5fd5-48b9-8dc9-7a500715a0b4', 'b6xwg', '2019-12-19 14:30:36');
INSERT INTO "public"."sys_captcha" VALUES ('14a9d038-0d87-4a0f-8085-5b83a9ab0ddd', 'ndxnd', '2019-12-17 11:15:35');
INSERT INTO "public"."sys_captcha" VALUES ('9a26a483-ee34-4dd0-8696-ad83dac124d3', 'ff32f', '2019-12-17 11:48:54');
INSERT INTO "public"."sys_captcha" VALUES ('25b89252-2f4d-4ef7-80c3-22d2149fc77d', 'mnnnm', '2019-12-19 14:37:08');
INSERT INTO "public"."sys_captcha" VALUES ('ef346c70-1080-4cd5-81a5-8fa94b311b80', 'dmn4b', '2019-12-19 14:37:08');
INSERT INTO "public"."sys_captcha" VALUES ('80f9d1c2-3b44-49ab-8752-659e38da9e59', 'mm84w', '2019-12-19 14:44:55');
INSERT INTO "public"."sys_captcha" VALUES ('48ad9f52-eec4-4872-80e8-ef18be8e66e4', '7p5n7', '2019-12-17 14:31:53');
INSERT INTO "public"."sys_captcha" VALUES ('4341256c-3f25-4774-816a-11d226dd55ca', '3d3ge', '2019-12-17 14:34:02');
INSERT INTO "public"."sys_captcha" VALUES ('c2dd4256-5ada-4dd3-817c-a5f2a10bff62', 'wcf67', '2019-12-17 14:38:19');
INSERT INTO "public"."sys_captcha" VALUES ('db4055f0-886d-4f64-83f1-6009efdf2f0a', 'pbw7n', '2019-12-17 17:10:48');
INSERT INTO "public"."sys_captcha" VALUES ('9bd2fb81-d0d8-45d2-849f-ae9b5964c528', 'm5c3n', '2019-12-17 19:46:11');
INSERT INTO "public"."sys_captcha" VALUES ('e9201a5c-c9a4-4949-8b8e-8fb90d66b78c', 'wxnnc', '2019-12-18 09:03:53');
INSERT INTO "public"."sys_captcha" VALUES ('126707cb-e227-46d7-8f03-52f67a289458', 'pcaxb', '2019-12-18 09:43:13');
INSERT INTO "public"."sys_captcha" VALUES ('6f2579fe-1009-455e-813b-1121f3de6cd8', 'p5fb2', '2019-12-18 09:43:52');
INSERT INTO "public"."sys_captcha" VALUES ('ac0a6a47-61fc-48f2-88ab-28c55eb8c8c3', 'ccwx4', '2019-12-18 09:48:59');
INSERT INTO "public"."sys_captcha" VALUES ('18c1a7d5-033c-4365-8d61-285c77f16034', '38g6n', '2019-12-18 09:56:56');
INSERT INTO "public"."sys_captcha" VALUES ('7df66f4f-c5e9-4509-8680-e443f53adcd6', '3pb87', '2019-12-18 10:27:05');
INSERT INTO "public"."sys_captcha" VALUES ('e03ff3fd-d8c1-46bb-8fe7-a84fa8f4b234', '84w6f', '2019-12-18 10:38:20');
INSERT INTO "public"."sys_captcha" VALUES ('da28ca5d-4aec-4718-8db2-35d565a9f262', '3ye4g', '2019-12-18 11:32:03');
INSERT INTO "public"."sys_captcha" VALUES ('00d0425d-e9e0-477a-87ff-d91612ec75af', '5dy55', '2019-12-18 17:21:07');
INSERT INTO "public"."sys_captcha" VALUES ('de1f54ab-9319-4ac6-82ee-1aca64779e3a', 'ey5bb', '2019-12-18 17:41:38');
INSERT INTO "public"."sys_captcha" VALUES ('f8f22627-4b1b-4ad1-809c-ac8d91db182b', 'femcx', '2019-12-18 17:45:28');
INSERT INTO "public"."sys_captcha" VALUES ('78d24330-0c13-4037-80bb-385418c53199', 'n7cxa', '2019-12-18 17:47:31');
INSERT INTO "public"."sys_captcha" VALUES ('b277091c-c25a-4b01-8767-2ec7ae82a7e6', '5yp4g', '2019-12-18 17:48:55');
INSERT INTO "public"."sys_captcha" VALUES ('762d3d1d-ed5d-4c41-8cc8-62850c12d22e', '4e36e', '2019-12-18 17:49:57');
INSERT INTO "public"."sys_captcha" VALUES ('5175db20-310a-417b-80ff-3351c184fc1b', 'gx6a4', '2019-12-18 17:50:39');
INSERT INTO "public"."sys_captcha" VALUES ('36fbb28f-f998-4205-8771-8b28095037b4', '46bxy', '2019-12-18 17:50:03');
INSERT INTO "public"."sys_captcha" VALUES ('d617a35b-33fb-46e2-8950-17e1540817c7', '4n52x', '2019-12-18 17:50:05');
INSERT INTO "public"."sys_captcha" VALUES ('8e5ac4cf-bf6e-45ee-82d1-da9c2222ca89', '43b6n', '2019-12-18 17:52:17');
INSERT INTO "public"."sys_captcha" VALUES ('f5cf423a-99ef-4bb1-8aee-423eba2f5a71', 'w6e7c', '2019-12-18 17:53:07');
INSERT INTO "public"."sys_captcha" VALUES ('7c6e85c6-4128-4831-8bf6-754dd5b72f30', 'xand6', '2019-12-18 17:57:07');
INSERT INTO "public"."sys_captcha" VALUES ('94300d39-fc6e-4390-8957-a293eb5c804f', 'c3my3', '2019-12-18 17:57:08');
INSERT INTO "public"."sys_captcha" VALUES ('6edf97e1-4eeb-411b-8984-444ba460186c', 'mxw2w', '2019-12-18 18:01:41');
INSERT INTO "public"."sys_captcha" VALUES ('c742a9c9-64b9-45c1-8381-1199df2a53d1', 'xcpc6', '2019-12-18 18:04:55');
INSERT INTO "public"."sys_captcha" VALUES ('b602e7e0-398a-4b47-85f4-70c2b4876715', '7f34n', '2019-12-18 18:06:42');
INSERT INTO "public"."sys_captcha" VALUES ('d9bd2fca-d013-42ed-8fe0-0c340f064918', 'c7f6m', '2019-12-18 19:17:24');
INSERT INTO "public"."sys_captcha" VALUES ('39ad2c68-e633-4ecf-88fe-9c8b03694f97', 'pm84f', '2019-12-18 19:25:35');
INSERT INTO "public"."sys_captcha" VALUES ('ca02be73-4803-4ace-82e0-0d2c93dffbbe', 'n5n28', '2019-12-18 19:25:37');
INSERT INTO "public"."sys_captcha" VALUES ('012c0343-0cac-4f21-8de0-0dae74b18640', 'm66x2', '2019-12-18 19:25:49');
INSERT INTO "public"."sys_captcha" VALUES ('74012036-8190-4159-82aa-dd0176388fcc', 'mpy87', '2019-12-18 20:40:32');
INSERT INTO "public"."sys_captcha" VALUES ('1ec132ef-bab7-4893-8f72-77871b77cc17', '2cdnd', '2019-12-18 20:49:56');
INSERT INTO "public"."sys_captcha" VALUES ('b5b14ed3-e0af-4410-8f19-58c88b368c90', 'b2n4e', '2019-12-18 20:52:29');
INSERT INTO "public"."sys_captcha" VALUES ('f7d17f72-e756-4b32-8e75-a09a02019835', 'd77gw', '2019-12-18 20:53:43');
INSERT INTO "public"."sys_captcha" VALUES ('62e5eb02-cc58-4abe-8f8f-cd1d50946af6', 'wp342', '2019-12-19 09:28:34');
INSERT INTO "public"."sys_captcha" VALUES ('ab0b38a6-d46f-4bc3-80e1-b3d2f1203d33', '7neyf', '2019-12-19 10:10:43');
INSERT INTO "public"."sys_captcha" VALUES ('f7d63103-a5c1-4601-8b0f-526249073e8d', '5m78p', '2019-12-19 10:17:14');
INSERT INTO "public"."sys_captcha" VALUES ('b92cde4a-94db-452e-869c-b56ac208df25', 'bxpmb', '2019-12-19 10:17:15');
INSERT INTO "public"."sys_captcha" VALUES ('df24b092-ec23-40e6-86b6-b434687c76f1', 'wx8c6', '2019-12-19 10:18:20');
INSERT INTO "public"."sys_captcha" VALUES ('06fab1dc-fbde-4ae0-8574-bdb604c4afbc', 'g77ay', '2019-12-26 13:54:12');
INSERT INTO "public"."sys_captcha" VALUES ('5096f152-cea6-4ef9-8b79-74f6c65f33b5', 'x7b74', '2019-12-21 11:35:40');
INSERT INTO "public"."sys_captcha" VALUES ('231fe02c-32df-4ab3-863d-17f25168638f', '3npnw', '2019-12-19 14:42:43');
INSERT INTO "public"."sys_captcha" VALUES ('9b3e51e8-9151-421d-866c-ea76067943af', 'agf3b', '2019-12-19 14:42:44');
INSERT INTO "public"."sys_captcha" VALUES ('3d1a9f83-27e5-45c7-8d89-f37bb58f07b5', '382ng', '2019-12-19 14:42:46');
INSERT INTO "public"."sys_captcha" VALUES ('6289d606-3631-45ba-8a7b-0c00a649cdc8', 'e4337', '2019-12-21 11:35:41');
INSERT INTO "public"."sys_captcha" VALUES ('cda18db5-b0f1-41b7-8bb3-5f102d2adffe', 'c5be6', '2019-12-21 11:36:02');
INSERT INTO "public"."sys_captcha" VALUES ('3bf957df-b54f-4f53-8332-2c19090d27d3', 'ccdng', '2019-12-19 14:48:22');
INSERT INTO "public"."sys_captcha" VALUES ('0bfb11c9-d343-493b-81b6-2798bdb184ec', 'xb6w5', '2019-12-19 14:49:25');
INSERT INTO "public"."sys_captcha" VALUES ('eadf47e2-f6c6-4187-8797-f51236986ba0', 'ddxnp', '2019-12-19 14:50:00');
INSERT INTO "public"."sys_captcha" VALUES ('ec144382-609b-4485-8503-79cf59dd3a88', 'p8cwd', '2019-12-19 14:50:16');
INSERT INTO "public"."sys_captcha" VALUES ('a7540d2c-aa27-4634-89ea-64c2d4829478', 'xw78x', '2019-12-19 14:50:36');
INSERT INTO "public"."sys_captcha" VALUES ('d3ea0401-5549-48e6-83f5-6dbe03b8f459', 'xnncw', '2019-12-19 14:50:39');
INSERT INTO "public"."sys_captcha" VALUES ('d4d0fc1a-130c-4719-836b-babfc93a8ca3', 'bannb', '2019-12-19 14:51:21');
INSERT INTO "public"."sys_captcha" VALUES ('f2b36e7e-0940-4a6d-863a-62ba8eaac934', 'n3cx6', '2019-12-19 14:54:16');
INSERT INTO "public"."sys_captcha" VALUES ('6da100c5-90c8-4237-8db3-fad0fa189c1d', 'ex843', '2019-12-19 14:55:14');
INSERT INTO "public"."sys_captcha" VALUES ('494da938-9c8f-4786-8df6-43a5288ed6e7', 'ad5gn', '2019-12-19 14:55:22');
INSERT INTO "public"."sys_captcha" VALUES ('a962af60-e0d5-4cb1-86b9-6ff154866517', 'agcm6', '2019-12-19 14:55:34');
INSERT INTO "public"."sys_captcha" VALUES ('6fc3d8aa-3a39-47ef-8782-f0b9a89bc61c', 'g2bgf', '2019-12-19 14:55:39');
INSERT INTO "public"."sys_captcha" VALUES ('94f54eef-91d1-438b-8006-4e0250c756c3', 'fya5d', '2019-12-19 14:55:42');
INSERT INTO "public"."sys_captcha" VALUES ('c7d9270d-4742-438a-8823-64cd139e2512', 'a88dd', '2019-12-19 14:55:54');
INSERT INTO "public"."sys_captcha" VALUES ('941499e7-e985-4fcf-8021-e4a5eba9ab05', '25bcy', '2019-12-19 14:56:06');
INSERT INTO "public"."sys_captcha" VALUES ('30c37048-e641-40bb-88c3-e8c32aadc367', 'mymdx', '2019-12-19 14:56:17');
INSERT INTO "public"."sys_captcha" VALUES ('bd3a5bc9-8065-4217-8932-5f0f677adaf2', '4nfw5', '2019-12-19 14:56:32');
INSERT INTO "public"."sys_captcha" VALUES ('c157cfa7-1fb3-4eb2-8795-31f8d8e5751f', 'ben58', '2019-12-19 14:56:48');
INSERT INTO "public"."sys_captcha" VALUES ('4613cb18-8056-4aff-888d-20fdbe680d93', '4y77w', '2019-12-19 15:02:21');
INSERT INTO "public"."sys_captcha" VALUES ('f32dc3d7-a63c-4d36-8ec4-16c2798c8380', 'm5wy8', '2019-12-21 13:47:30');
INSERT INTO "public"."sys_captcha" VALUES ('2340e5fa-646c-48f3-8b6d-1543cdcfd4bf', 'bd62n', '2019-12-19 16:46:06');
INSERT INTO "public"."sys_captcha" VALUES ('9ff6c1b2-d3b4-4f7a-8861-227b969c367e', 'd7c86', '2019-12-21 13:47:32');
INSERT INTO "public"."sys_captcha" VALUES ('29c3d241-c27d-4e74-84b8-29d3e194801c', 'ncab5', '2019-12-22 10:46:21');
INSERT INTO "public"."sys_captcha" VALUES ('c06703b6-b7e6-465b-83a7-9bfd4624b2bb', 'yafyf', '2019-12-22 11:48:30');
INSERT INTO "public"."sys_captcha" VALUES ('c5595961-4322-4dba-8692-9f5c72645549', '8ww3d', '2019-12-22 17:29:46');
INSERT INTO "public"."sys_captcha" VALUES ('dc7a37a2-494f-4aa7-826e-b4cd8d65c29d', 'p6dnx', '2019-12-22 17:30:22');
INSERT INTO "public"."sys_captcha" VALUES ('622693b6-c9b6-4828-8d4f-f8b8af2c38bc', 'gd2nd', '2019-12-22 19:55:58');
INSERT INTO "public"."sys_captcha" VALUES ('1ed5d941-c279-4b62-89dc-ae69505a7aab', 'ygmxw', '2019-12-22 20:01:22');
INSERT INTO "public"."sys_captcha" VALUES ('5c09eabf-5b89-424a-82b1-895631a3c714', 'c4nc6', '2019-12-22 20:01:30');
INSERT INTO "public"."sys_captcha" VALUES ('8d964524-e277-40c4-86df-9465b1449891', '4wp3f', '2019-12-23 08:54:15');
INSERT INTO "public"."sys_captcha" VALUES ('89705918-e306-4440-88f7-2b660196b122', 'x668x', '2019-12-23 09:45:01');
INSERT INTO "public"."sys_captcha" VALUES ('011689f4-98dc-40d8-8424-68c4a2612759', 'gc4a2', '2019-12-23 09:46:49');
INSERT INTO "public"."sys_captcha" VALUES ('5ca103f8-6dd4-4d42-81a9-2a18c0f76182', 'wpwe8', '2019-12-23 09:47:34');
INSERT INTO "public"."sys_captcha" VALUES ('14e7566e-8705-4319-8cba-ca69532d2180', 'aefxp', '2019-12-23 10:29:09');
INSERT INTO "public"."sys_captcha" VALUES ('ab57779a-bfe8-4e10-81a6-dd42679f6301', '66b33', '2019-12-23 13:54:56');
INSERT INTO "public"."sys_captcha" VALUES ('dfa3ed36-d936-4acf-8be4-bf76a773ffe7', 'gadcc', '2019-12-23 13:56:01');
INSERT INTO "public"."sys_captcha" VALUES ('efaed838-3272-4094-8d2b-abd885cfb591', 'ya3a7', '2019-12-23 13:58:05');
INSERT INTO "public"."sys_captcha" VALUES ('3c375edf-07dc-4314-8385-8ee5ddd813f6', '75nm8', '2019-12-23 14:20:41');
INSERT INTO "public"."sys_captcha" VALUES ('052603a5-7021-41c6-809d-47c9f9412888', '3mc23', '2019-12-23 14:44:58');
INSERT INTO "public"."sys_captcha" VALUES ('4eea7094-3bf4-47b3-8776-62a190a69213', 'g8gx6', '2019-12-23 15:17:24');
INSERT INTO "public"."sys_captcha" VALUES ('ad895111-4450-444e-89da-8c88b2d59fa6', '65d2d', '2019-12-23 15:38:17');
INSERT INTO "public"."sys_captcha" VALUES ('6f9afdce-d3f1-4bad-8ed9-17246bf3fac5', '786nb', '2019-12-23 16:22:47');
INSERT INTO "public"."sys_captcha" VALUES ('b8c5bb80-681f-4cf2-8729-46e135ff2b51', 'yneay', '2019-12-23 16:23:30');
INSERT INTO "public"."sys_captcha" VALUES ('a8ea9636-de30-497e-8845-f1a2eeaaf061', '4w3pe', '2019-12-23 16:25:42');
INSERT INTO "public"."sys_captcha" VALUES ('0c5f1272-5dd8-44d0-8e81-996c6d5418a1', '2d8dc', '2019-12-23 16:27:21');
INSERT INTO "public"."sys_captcha" VALUES ('6f06bc9e-8419-45e6-82fb-0bdf5d254683', 'g2nwn', '2019-12-23 16:41:14');
INSERT INTO "public"."sys_captcha" VALUES ('27ab8e5b-4adb-4fc0-8aa7-4e43ce43ade3', '4m7ex', '2019-12-23 16:42:44');
INSERT INTO "public"."sys_captcha" VALUES ('18cf61ab-883d-4338-8f9c-dfdea2949f2a', 'ee7pm', '2019-12-23 16:43:04');
INSERT INTO "public"."sys_captcha" VALUES ('57a38786-e592-48c3-8290-1a421ccb927d', 'cn6nf', '2019-12-23 16:42:52');
INSERT INTO "public"."sys_captcha" VALUES ('110188d5-8e50-410b-85d2-9700abfb888b', 'we48a', '2019-12-23 16:43:49');
INSERT INTO "public"."sys_captcha" VALUES ('f97dd5dc-cc12-4bd9-820c-2ea14192a653', '5e3xp', '2019-12-23 16:45:12');
INSERT INTO "public"."sys_captcha" VALUES ('2d5e7b5a-8f02-4b9b-80b6-6d42bacf1012', 'ca8yd', '2019-12-23 16:46:00');
INSERT INTO "public"."sys_captcha" VALUES ('31372aef-1eff-47b3-8cab-8584774175f4', 'aampf', '2019-12-23 17:59:15');
INSERT INTO "public"."sys_captcha" VALUES ('c3a37ea8-a591-43fc-8f78-732059861088', 'xaafy', '2019-12-23 18:07:29');
INSERT INTO "public"."sys_captcha" VALUES ('f179df52-8289-441c-8e14-1bbb8a58e28c', '3cx8m', '2019-12-24 15:50:47');
INSERT INTO "public"."sys_captcha" VALUES ('4abf52d0-3753-4155-81fd-aea9d321d556', '85ppf', '2019-12-24 15:55:14');
INSERT INTO "public"."sys_captcha" VALUES ('9b4e56a3-7979-4d1f-8769-5325c1a06d79', 'a4xgx', '2019-12-24 15:56:37');
INSERT INTO "public"."sys_captcha" VALUES ('cc24b213-a9d7-4f02-8308-cfd4fe279072', 'xdffm', '2019-12-24 17:33:10');
INSERT INTO "public"."sys_captcha" VALUES ('a18fedba-c442-4fd3-86db-7f87b8d3d7ce', 'w5b5f', '2019-12-25 08:44:50');
INSERT INTO "public"."sys_captcha" VALUES ('ccd3832d-1815-4774-8115-2bacf39ba4e2', '5y24b', '2019-12-25 09:06:01');
INSERT INTO "public"."sys_captcha" VALUES ('59061697-ba00-4494-8458-36125b51ee4f', 'n6xny', '2019-12-25 09:23:15');
INSERT INTO "public"."sys_captcha" VALUES ('3d4a0b6c-72f2-42aa-8e47-876f26ebf9bb', 'dwdec', '2019-12-25 09:41:55');
INSERT INTO "public"."sys_captcha" VALUES ('0880039e-eddc-4d65-8c13-2ad43ad050ea', 'npmyp', '2019-12-25 09:41:56');
INSERT INTO "public"."sys_captcha" VALUES ('50669e90-b986-4db1-8194-331c140a2ac9', 'x3we5', '2019-12-25 10:03:25');
INSERT INTO "public"."sys_captcha" VALUES ('3c1dfb1f-efeb-43d8-8839-f34b4e44f65e', 'c22x2', '2019-12-25 10:05:21');
INSERT INTO "public"."sys_captcha" VALUES ('6619d40d-c716-48e3-8176-38189bd8bea9', 'y4cg8', '2019-12-25 11:16:52');
INSERT INTO "public"."sys_captcha" VALUES ('3fefa9d7-b192-4346-8003-87af2e92431c', 'm3gme', '2019-12-25 11:16:52');
INSERT INTO "public"."sys_captcha" VALUES ('4e3687cb-e7e3-470b-87bf-38accc862ce3', '8ng3m', '2019-12-25 11:16:54');
INSERT INTO "public"."sys_captcha" VALUES ('8d995f52-a828-4dcf-8a09-3fba03c0b164', '7m666', '2019-12-25 11:56:20');
INSERT INTO "public"."sys_captcha" VALUES ('910af8dd-26d1-4e0b-8316-d5f003cf2e05', '42gc4', '2019-12-25 13:31:00');
INSERT INTO "public"."sys_captcha" VALUES ('5a9fc77d-a6bb-4db2-8e81-7cd89f37da97', 'fmy7b', '2019-12-25 13:35:55');
INSERT INTO "public"."sys_captcha" VALUES ('78dbef0a-ae27-49ca-865d-0323a70fefdd', 'me7mn', '2019-12-25 13:36:55');
INSERT INTO "public"."sys_captcha" VALUES ('7e410e4b-a9e8-4885-817f-278e99183ae0', '8af3d', '2019-12-25 13:38:13');
INSERT INTO "public"."sys_captcha" VALUES ('67cad990-fce5-4938-84e4-9906394728d9', 'ccdcm', '2019-12-25 13:42:43');
INSERT INTO "public"."sys_captcha" VALUES ('4ac477f1-7434-4a08-82dd-f2554e96254b', '6w3fg', '2019-12-25 13:42:28');
INSERT INTO "public"."sys_captcha" VALUES ('fb082e30-9546-4577-8220-2a9511a9665f', '84bnp', '2019-12-25 13:49:23');
INSERT INTO "public"."sys_captcha" VALUES ('9e233199-1a5a-4006-80ed-0df1dc52df08', '8nn3p', '2019-12-25 13:48:45');
INSERT INTO "public"."sys_captcha" VALUES ('b7f1cd46-219c-489a-871a-df7dffd4287a', '5c7g5', '2019-12-25 13:48:51');
INSERT INTO "public"."sys_captcha" VALUES ('c8cfbc69-e33b-44da-8631-f9e3ac4b5701', 'wgn85', '2019-12-25 14:01:35');
INSERT INTO "public"."sys_captcha" VALUES ('90f430e9-132a-4028-8412-205f325a3428', '7a68x', '2019-12-25 14:02:04');
INSERT INTO "public"."sys_captcha" VALUES ('90ea137b-db57-4d88-811c-fe94f33999d3', 'n6ncd', '2019-12-25 14:11:07');
INSERT INTO "public"."sys_captcha" VALUES ('187eda82-6986-47d1-8013-659a3223c74d', 'dnp3n', '2019-12-25 14:11:30');
INSERT INTO "public"."sys_captcha" VALUES ('55c37fe1-dbb4-4ad5-84c4-4574d24f927b', 'dnwpc', '2019-12-25 14:17:29');
INSERT INTO "public"."sys_captcha" VALUES ('443cbde3-7749-4131-8cf3-040770003950', '7mxyn', '2019-12-25 14:51:12');
INSERT INTO "public"."sys_captcha" VALUES ('8b08dce9-4a27-49c6-8a80-7aab2d65766b', '723m5', '2019-12-21 11:32:37');
INSERT INTO "public"."sys_captcha" VALUES ('0b221d48-b027-4963-8017-f922dca47cfa', 'dg8nm', '2019-12-19 14:58:36');
INSERT INTO "public"."sys_captcha" VALUES ('8567b1e1-eab8-459f-8060-c47ad2d4226c', 'a7exx', '2019-12-19 14:58:37');
INSERT INTO "public"."sys_captcha" VALUES ('886dcb53-fde9-44a5-8304-0b0697b184dc', 'nm8ep', '2020-01-07 16:42:52');
INSERT INTO "public"."sys_captcha" VALUES ('95ab878e-cfb1-4efe-80e4-78d85a98f005', 'ecpn8', '2019-12-19 14:59:18');
INSERT INTO "public"."sys_captcha" VALUES ('2c6e3a6a-395e-4339-827b-c7e7a910dbb7', 'g46g3', '2019-12-21 11:36:02');
INSERT INTO "public"."sys_captcha" VALUES ('e4defa77-4d3e-4cf0-848d-2ec356a3739c', 'pccdw', '2019-12-19 15:03:43');
INSERT INTO "public"."sys_captcha" VALUES ('817af803-dd31-4a4c-853c-b9f738fc2a47', '25wbc', '2019-12-21 11:37:39');
INSERT INTO "public"."sys_captcha" VALUES ('0f87dad6-13cf-4b5a-8b77-89fb8d6f7fc0', 'dacdf', '2019-12-21 11:37:56');
INSERT INTO "public"."sys_captcha" VALUES ('8079e350-64af-48b2-8fec-e0135008a355', 'n774a', '2019-12-21 11:39:13');
INSERT INTO "public"."sys_captcha" VALUES ('f986c4d7-0ad9-4bf6-8572-406660e40e19', '4gfxx', '2019-12-19 15:12:19');
INSERT INTO "public"."sys_captcha" VALUES ('07fa8c62-d259-4b39-897e-1f42a0a7b446', 'nn3xw', '2019-12-21 11:39:32');
INSERT INTO "public"."sys_captcha" VALUES ('b39ee2de-317e-45f6-8dd9-ef8ee08447fb', 'w2pw2', '2019-12-21 11:39:34');
INSERT INTO "public"."sys_captcha" VALUES ('02c4ae1e-3218-42a8-86a9-d769b11983ba', '333pc', '2019-12-21 11:39:49');
INSERT INTO "public"."sys_captcha" VALUES ('811ab05b-9606-4ec5-81ac-df048168aca3', '6acmy', '2019-12-21 11:40:07');
INSERT INTO "public"."sys_captcha" VALUES ('9c60b062-a133-4e5b-822f-fcdfaba13c24', 'wcadb', '2019-12-21 11:42:30');
INSERT INTO "public"."sys_captcha" VALUES ('a41981ce-ab58-41cb-8470-1fc5915b3722', 'nb2mg', '2019-12-19 16:36:39');
INSERT INTO "public"."sys_captcha" VALUES ('fd67241c-0548-429a-8c06-a14ef139741c', '76nmw', '2019-12-21 11:42:39');
INSERT INTO "public"."sys_captcha" VALUES ('fb633815-cc99-4c66-8ac9-05b1164102a4', '53fb7', '2019-12-21 11:43:41');
INSERT INTO "public"."sys_captcha" VALUES ('4cb15a9a-e57e-49ad-8442-a1d9711e6730', 'de48p', '2019-12-21 11:44:10');
INSERT INTO "public"."sys_captcha" VALUES ('b6d95760-7fe2-49dc-80be-3fcbbb0ebb08', '6xmf5', '2019-12-21 11:45:14');
INSERT INTO "public"."sys_captcha" VALUES ('3c7854ee-3721-4d08-8051-f42edd5dc1b9', '8e4ny', '2019-12-21 11:45:39');
INSERT INTO "public"."sys_captcha" VALUES ('c46b580c-495c-4fe1-8862-e280c8a22959', '2mebn', '2019-12-19 16:59:57');
INSERT INTO "public"."sys_captcha" VALUES ('14974bcf-967b-43cd-8c30-49dd63a79c09', 'g5ncp', '2019-12-21 11:45:50');
INSERT INTO "public"."sys_captcha" VALUES ('bb211a52-23cc-4276-8b40-66d22191b98f', 'fgmpy', '2019-12-19 17:00:58');
INSERT INTO "public"."sys_captcha" VALUES ('9a552f78-13b2-41e5-8268-b78b345c8f5e', '7byd8', '2019-12-21 11:46:02');
INSERT INTO "public"."sys_captcha" VALUES ('5577c533-82f9-48fd-8076-1b58f59f2a33', 'g5aw8', '2019-12-21 11:51:58');
INSERT INTO "public"."sys_captcha" VALUES ('e63e0235-3fe3-4794-84a7-52e535bec81f', '5wanw', '2019-12-21 13:48:56');
INSERT INTO "public"."sys_captcha" VALUES ('fe62848e-5a4b-4558-84e8-b2ca68f2dc77', 'ne6wa', '2019-12-19 17:14:16');
INSERT INTO "public"."sys_captcha" VALUES ('0bf2bee8-0385-4b8a-8f81-3638b74edccb', '3cmnx', '2019-12-19 17:14:18');
INSERT INTO "public"."sys_captcha" VALUES ('bd04f321-091d-4e82-800e-df5939686a08', 'yx7ng', '2019-12-19 17:19:25');
INSERT INTO "public"."sys_captcha" VALUES ('8d4d8668-5ad2-4fd6-876d-b1c5800cb732', 'bc6mx', '2019-12-19 17:26:48');
INSERT INTO "public"."sys_captcha" VALUES ('caa70226-153d-4124-86b6-2e8afee8e7a6', '6mb2d', '2019-12-21 14:06:47');
INSERT INTO "public"."sys_captcha" VALUES ('fda2d16e-9307-4771-8577-55a523f5100d', 'ap2np', '2019-12-19 17:28:55');
INSERT INTO "public"."sys_captcha" VALUES ('41fe2e17-9d18-40a1-8e2e-bd39c8014299', 'nxyey', '2019-12-19 18:03:50');
INSERT INTO "public"."sys_captcha" VALUES ('371cb8d5-33fe-4026-8b43-854a6d2a33ab', 'bngng', '2019-12-19 18:04:50');
INSERT INTO "public"."sys_captcha" VALUES ('8d6a684a-5292-44a9-8ccb-37b9894604fb', '86wba', '2019-12-19 18:06:32');
INSERT INTO "public"."sys_captcha" VALUES ('0c9f8bc6-787e-46ec-8d51-de056d8289d5', 'xe7yn', '2019-12-19 18:08:13');
INSERT INTO "public"."sys_captcha" VALUES ('18706428-d6e3-428d-8b96-067d0ad03d9d', 'ace2f', '2019-12-19 18:11:28');
INSERT INTO "public"."sys_captcha" VALUES ('1e65898f-60a1-49a8-8819-e7c2408afd58', 'fxn56', '2019-12-19 18:12:29');
INSERT INTO "public"."sys_captcha" VALUES ('c48facb8-d927-47dc-8af4-e07cb98a34bb', '4pegf', '2019-12-19 19:09:54');
INSERT INTO "public"."sys_captcha" VALUES ('8f37ceb6-d278-4bdc-882c-03579f7de0e4', '2b2y7', '2019-12-19 19:18:18');
INSERT INTO "public"."sys_captcha" VALUES ('fd9dcd3b-f803-46df-8e70-8362abbdab40', 'ep84g', '2019-12-19 19:34:03');
INSERT INTO "public"."sys_captcha" VALUES ('8b1c940a-3757-4241-8a99-6b5ccd704779', '827n7', '2019-12-19 19:34:42');
INSERT INTO "public"."sys_captcha" VALUES ('7fe4ca59-9e79-426a-8f54-90abe658c03c', 'n2p86', '2019-12-19 20:16:31');
INSERT INTO "public"."sys_captcha" VALUES ('bb55f998-4c74-439e-8236-ee713560de04', 'mfxa3', '2019-12-19 20:31:19');
INSERT INTO "public"."sys_captcha" VALUES ('cdd72ee1-8a81-4e92-8b9a-6f48abd3539a', '24emf', '2019-12-19 20:49:12');
INSERT INTO "public"."sys_captcha" VALUES ('c88d6bc5-491c-4b4a-8db3-67634d0a0fe4', 'n388x', '2019-12-19 21:00:01');
INSERT INTO "public"."sys_captcha" VALUES ('ad8f3c47-c2d8-470e-86ba-ed018969468f', 'megb2', '2019-12-19 21:16:45');
INSERT INTO "public"."sys_captcha" VALUES ('a6fa9492-5fd6-4f83-84f3-a8fe37d5d4c8', 'x68wf', '2019-12-19 21:16:49');
INSERT INTO "public"."sys_captcha" VALUES ('32c2ba48-1409-4d0a-83d8-011fdda12334', 'eenwm', '2019-12-19 21:16:58');
INSERT INTO "public"."sys_captcha" VALUES ('f805fe30-854c-45e9-8b77-cc3f99c292fc', 'a2yn8', '2019-12-19 21:30:05');
INSERT INTO "public"."sys_captcha" VALUES ('d7116ed8-7f8e-466d-88be-f6606c246437', '35dwe', '2019-12-19 21:40:05');
INSERT INTO "public"."sys_captcha" VALUES ('4ce63d5d-d9bd-4867-8f34-4732f21f0cb8', 'gae6n', '2019-12-19 21:40:07');
INSERT INTO "public"."sys_captcha" VALUES ('35dc8719-b2c2-4815-898e-a16f2b6caa61', '8xyxy', '2019-12-19 21:40:08');
INSERT INTO "public"."sys_captcha" VALUES ('7d2577f1-4355-4b11-8b0e-f758f570c855', 'ab4cn', '2019-12-19 21:49:12');
INSERT INTO "public"."sys_captcha" VALUES ('dbcc5607-34e0-4a3c-81b3-3178250b809f', 'bwggf', '2019-12-19 23:18:57');
INSERT INTO "public"."sys_captcha" VALUES ('fdb2ee7d-bbb1-47f4-86d7-4cc32d2ace22', 'd254f', '2019-12-19 23:19:04');
INSERT INTO "public"."sys_captcha" VALUES ('eea2a8e1-764b-4873-8494-5a63dcd1174f', 'eaaec', '2019-12-19 23:24:51');
INSERT INTO "public"."sys_captcha" VALUES ('edd7f411-f67d-4ac8-827f-1f102b794f1a', '5cew7', '2019-12-19 23:36:50');
INSERT INTO "public"."sys_captcha" VALUES ('2f45c348-18d9-4933-807f-7ddea482ddd0', 'cp7wy', '2019-12-19 23:45:26');
INSERT INTO "public"."sys_captcha" VALUES ('9a44a8a0-5d7c-4402-8b6f-bb0d2b51ea5c', 'e54bp', '2019-12-19 23:58:58');
INSERT INTO "public"."sys_captcha" VALUES ('bd8b2f8d-98f6-44e1-864e-b0a95255f1e4', 'awdpd', '2019-12-20 00:04:15');
INSERT INTO "public"."sys_captcha" VALUES ('3d5e3733-8488-4281-8353-bd3389a1b3cc', '3nn68', '2019-12-20 00:06:54');
INSERT INTO "public"."sys_captcha" VALUES ('03146b05-334b-425e-835a-31e1e118ab8c', 'n85pm', '2019-12-20 00:20:53');
INSERT INTO "public"."sys_captcha" VALUES ('b7f1927f-2bc1-4e0f-8002-c491f5d5755f', '7pf56', '2019-12-20 00:26:14');
INSERT INTO "public"."sys_captcha" VALUES ('bbb0ae54-775a-4a2a-89ef-d40fdcdad80e', 'g7xm8', '2019-12-20 00:56:10');
INSERT INTO "public"."sys_captcha" VALUES ('0b30b413-0b1d-464c-85a4-7e5b60d9aff4', '2wxnb', '2019-12-20 00:56:54');
INSERT INTO "public"."sys_captcha" VALUES ('8667ab77-0614-45f4-8496-cab4a2f30cfe', '4cg3a', '2019-12-20 01:00:22');
INSERT INTO "public"."sys_captcha" VALUES ('8b272f32-2df3-47e7-8ea7-2500b66f0f45', '2yn6n', '2019-12-20 01:08:58');
INSERT INTO "public"."sys_captcha" VALUES ('e4378798-f603-4c89-8ec7-6cfa7cb4099f', 'p6yng', '2019-12-20 01:50:58');
INSERT INTO "public"."sys_captcha" VALUES ('e2a7c565-b083-489f-8266-968dec2ff6cc', 'yx4mf', '2019-12-20 01:51:34');
INSERT INTO "public"."sys_captcha" VALUES ('abc8714c-380d-4fd6-827d-82294c587808', 'fxmc8', '2019-12-20 01:59:26');
INSERT INTO "public"."sys_captcha" VALUES ('4edb975f-ffe3-453b-8e0d-95e86db0954a', 'e22n3', '2019-12-20 02:02:57');
INSERT INTO "public"."sys_captcha" VALUES ('ad81ffbe-f49e-48b1-85ef-7c06a1a9069d', 'ga46y', '2019-12-20 02:03:19');
INSERT INTO "public"."sys_captcha" VALUES ('27e6544c-f638-4f1c-8c05-f5d7e728045a', '67n2g', '2019-12-20 07:25:33');
INSERT INTO "public"."sys_captcha" VALUES ('822cd70a-1175-4345-82a2-0ae71659f04b', 'p5nn4', '2019-12-20 10:07:36');
INSERT INTO "public"."sys_captcha" VALUES ('4e8253d7-5880-4c48-8c81-56aba050302a', '454f8', '2019-12-20 11:05:33');
INSERT INTO "public"."sys_captcha" VALUES ('edb6639b-fd1e-48f4-885e-cec41a3d86e1', 'ey5fy', '2019-12-20 11:38:56');
INSERT INTO "public"."sys_captcha" VALUES ('003952b1-2a48-4882-87f1-dd061c920673', 'ec3pc', '2019-12-20 14:21:52');
INSERT INTO "public"."sys_captcha" VALUES ('15d88a33-f46b-455a-8519-1a8e8c92e65f', '8gggc', '2019-12-20 14:22:07');
INSERT INTO "public"."sys_captcha" VALUES ('f7a96254-c8e5-46fe-8867-2d634f214bdd', 'x87fx', '2019-12-20 14:28:49');
INSERT INTO "public"."sys_captcha" VALUES ('09812bba-6bfc-4acd-8ab3-6da02276b6ba', 'mn7yn', '2019-12-20 14:38:31');
INSERT INTO "public"."sys_captcha" VALUES ('e45ac455-3693-48f6-8c9e-417076d3720b', 'fxb5c', '2019-12-20 14:40:33');
INSERT INTO "public"."sys_captcha" VALUES ('3c5e2d67-8c1f-4be8-8358-ba3406d07344', '4xgex', '2019-12-20 15:04:30');
INSERT INTO "public"."sys_captcha" VALUES ('e2e2076c-e12c-490a-8ac2-18b16943d70f', 'acbd2', '2019-12-20 15:22:30');
INSERT INTO "public"."sys_captcha" VALUES ('f9b906a3-595a-4c31-80d9-07519a41fafc', 'n8yee', '2019-12-21 09:37:01');
INSERT INTO "public"."sys_captcha" VALUES ('3cfb54bf-2215-4681-8a11-df89873387d1', 'fw73w', '2019-12-21 09:38:03');
INSERT INTO "public"."sys_captcha" VALUES ('dafecb37-1383-4a6f-83ef-dbd04a01a214', 'aac35', '2019-12-21 09:43:48');
INSERT INTO "public"."sys_captcha" VALUES ('89125878-ec92-48cc-89a0-978f05a3211d', '8n2a8', '2019-12-21 09:44:11');
INSERT INTO "public"."sys_captcha" VALUES ('48a6cdf5-590a-4234-8936-15957c183d09', '5y4y7', '2019-12-21 09:55:13');
INSERT INTO "public"."sys_captcha" VALUES ('efd3f4cf-dd66-485e-86a9-ee6a33575341', '6bbec', '2019-12-26 13:56:29');
INSERT INTO "public"."sys_captcha" VALUES ('4d471357-8376-489d-8e52-930aa991e34c', 'myfwx', '2020-01-08 09:08:25');
INSERT INTO "public"."sys_captcha" VALUES ('1f5a7de3-42ad-4f99-8ab5-0d9435b187c2', 'w86c3', '2020-01-08 10:00:01');
INSERT INTO "public"."sys_captcha" VALUES ('6f51a90d-11fc-4309-8f7c-7b75919993c2', '6ed2w', '2020-01-20 16:56:28');
INSERT INTO "public"."sys_captcha" VALUES ('9edbed3b-41e5-4937-827e-05a46ec42c3e', '2ypxn', '2020-01-08 10:24:04');
INSERT INTO "public"."sys_captcha" VALUES ('98947296-bfcc-4038-8bee-cc53aa3224ac', '2a8x8', '2020-01-20 17:28:25');
INSERT INTO "public"."sys_captcha" VALUES ('09cb2cde-240b-4f96-87de-55287ddb957d', '5m8e5', '2019-12-27 13:15:05');
INSERT INTO "public"."sys_captcha" VALUES ('1f8bbd97-3c36-4a29-895d-c8071990c69b', 'e44ax', '2019-12-27 13:48:42');
INSERT INTO "public"."sys_captcha" VALUES ('d8f77cb2-d67d-43c1-8d5d-0f6bd9cfe766', 'e8n4f', '2019-12-27 13:51:18');
INSERT INTO "public"."sys_captcha" VALUES ('b1eeb43d-dcdd-40cf-8b77-82c0f6307518', 'a82dx', '2019-12-27 13:51:20');
INSERT INTO "public"."sys_captcha" VALUES ('4af2af7c-9cca-48da-8bb1-fe366e53fdcd', 'gwcpx', '2020-01-08 11:23:00');
INSERT INTO "public"."sys_captcha" VALUES ('d63baedf-55a6-407e-883b-e1af4c6b3a5d', 'x34mp', '2019-12-27 15:02:29');
INSERT INTO "public"."sys_captcha" VALUES ('bc0b44dd-a833-4a10-8eab-6fb8dbdaf4f7', '4pnfy', '2020-01-20 17:28:26');
INSERT INTO "public"."sys_captcha" VALUES ('f40aaca0-0caf-4598-8757-606ef9f51599', 'c84b6', '2020-01-08 11:41:51');
INSERT INTO "public"."sys_captcha" VALUES ('03ead803-fc76-4687-8ff3-2f00c69e86f9', '2fd4e', '2020-01-20 17:31:20');
INSERT INTO "public"."sys_captcha" VALUES ('af256449-1c45-432e-8738-7d6710db2a05', 'f6pmc', '2020-01-20 17:53:26');
INSERT INTO "public"."sys_captcha" VALUES ('ab363169-c02f-45b3-8f04-e4774286a27e', 'ap28c', '2019-12-30 14:42:07');
INSERT INTO "public"."sys_captcha" VALUES ('24376b58-d7e9-41a9-8dee-7b6607cab37d', '7fgn6', '2020-01-08 16:12:38');
INSERT INTO "public"."sys_captcha" VALUES ('1dd8bdaf-7054-47a2-892d-88e9020fd74d', 'f8mbn', '2019-12-30 15:25:28');
INSERT INTO "public"."sys_captcha" VALUES ('caa8c04a-ee9d-4b50-85b4-c21cea29b27d', 'gc54n', '2019-12-30 15:25:47');
INSERT INTO "public"."sys_captcha" VALUES ('e6f226e0-a2ee-47c6-8794-73bb9a1951f6', 'bn54d', '2019-12-30 15:26:18');
INSERT INTO "public"."sys_captcha" VALUES ('cefc7282-3275-42ce-85f7-60942ee4e57c', '2e8d8', '2019-12-30 15:26:35');
INSERT INTO "public"."sys_captcha" VALUES ('d700ecb9-c5fb-479b-87e3-a692d15c2d99', '8c33p', '2019-12-30 15:27:42');
INSERT INTO "public"."sys_captcha" VALUES ('7ec84f88-53f1-41a7-8c51-3045a9c20cc5', '4c2y6', '2019-12-30 15:27:54');
INSERT INTO "public"."sys_captcha" VALUES ('58c6635b-6792-47f5-8b11-9d9a55bdc000', 'g3e6p', '2020-01-08 16:24:26');
INSERT INTO "public"."sys_captcha" VALUES ('d06ea852-891f-4ccf-80e4-8f6c30efdb73', 'dgdbx', '2019-12-30 16:38:42');
INSERT INTO "public"."sys_captcha" VALUES ('2a6e8ee8-374f-4240-8d79-d7e48d629349', '2fp3n', '2019-12-30 16:44:12');
INSERT INTO "public"."sys_captcha" VALUES ('57549747-9c18-4c94-8823-9fa55c7da01d', 'mc3wd', '2019-12-30 16:44:56');
INSERT INTO "public"."sys_captcha" VALUES ('e84b5c8b-9604-4e55-899a-7c19238811c9', 'acxbf', '2019-12-30 16:45:52');
INSERT INTO "public"."sys_captcha" VALUES ('f7933a55-1667-4c1e-8fb0-d829cdb1f40d', 'mwd6p', '2019-12-30 16:48:00');
INSERT INTO "public"."sys_captcha" VALUES ('9e7df619-f5ad-4e94-8117-f78c6e330554', 'xemnw', '2019-12-30 16:52:18');
INSERT INTO "public"."sys_captcha" VALUES ('0e8ff5e6-0cf2-473e-8077-3c5460b64463', 'wxn3w', '2019-12-31 10:37:48');
INSERT INTO "public"."sys_captcha" VALUES ('c051ff6d-a0f1-4252-8cbe-54c19cf9614e', 'm2n46', '2019-12-31 10:41:57');
INSERT INTO "public"."sys_captcha" VALUES ('77e37a35-260c-4e05-816e-8184b6888d77', 'w3byc', '2019-12-31 10:42:15');
INSERT INTO "public"."sys_captcha" VALUES ('f3ffefb7-d68f-4a64-8e57-7bebe5b51fbb', 'bbn6d', '2019-12-31 10:49:22');
INSERT INTO "public"."sys_captcha" VALUES ('51596fcd-315e-4b16-87ba-c957ead28fed', 'x84n5', '2020-01-09 14:01:55');
INSERT INTO "public"."sys_captcha" VALUES ('f7b5b802-cfe0-4cbf-8916-0a2ee528e2e9', '3gcn8', '2019-12-31 11:19:48');
INSERT INTO "public"."sys_captcha" VALUES ('7a2675ab-6daa-43d1-8635-8c05a64ba413', 'a8bfp', '2019-12-31 11:20:16');
INSERT INTO "public"."sys_captcha" VALUES ('0a084ad7-f8c3-4dc5-89f4-25c254147fcb', 'nx8pd', '2020-01-10 10:09:18');
INSERT INTO "public"."sys_captcha" VALUES ('2dda2606-83a4-4a38-87d9-f4df9ee7321e', 'ay56a', '2020-01-02 08:50:08');
INSERT INTO "public"."sys_captcha" VALUES ('1ab11983-3c58-4f69-8a93-a60fcc2c259d', '7dbwn', '2020-01-02 09:45:08');
INSERT INTO "public"."sys_captcha" VALUES ('10aa2d1a-2410-43b2-8be3-5b08da7afe10', 'bfyp7', '2020-01-02 15:45:30');
INSERT INTO "public"."sys_captcha" VALUES ('56c044d4-10ee-43dc-8080-179ae69863c3', '28xpa', '2020-01-10 10:16:42');
INSERT INTO "public"."sys_captcha" VALUES ('b9110b77-02a2-4d2e-8a78-75e352ab0bef', 'xm2dm', '2020-01-02 16:23:02');
INSERT INTO "public"."sys_captcha" VALUES ('af5229ed-faac-44f6-83c5-e068c5eaf7b3', 'fmymg', '2020-01-03 11:19:13');
INSERT INTO "public"."sys_captcha" VALUES ('0e7484e2-3bb9-4c14-8862-1389a9c18f6e', 'nef4g', '2020-01-03 15:47:14');
INSERT INTO "public"."sys_captcha" VALUES ('987cb9c8-7f51-4558-8218-e48b3e4d3b16', 'npfd7', '2020-01-10 10:59:28');
INSERT INTO "public"."sys_captcha" VALUES ('f6b64450-eff6-4b0a-86d5-914ee16af3e7', '6cpxg', '2020-01-10 11:00:53');
INSERT INTO "public"."sys_captcha" VALUES ('bfeb048b-1e69-479c-8611-5f2cb6982794', 'eeam3', '2020-01-04 11:20:29');
INSERT INTO "public"."sys_captcha" VALUES ('0c906207-7469-4f7a-8e35-bb9ce0684e7c', 'nnadg', '2020-01-10 11:31:46');
INSERT INTO "public"."sys_captcha" VALUES ('63e3167d-48cd-4b7c-8d9b-528213ca2bf2', 'cncxb', '2020-01-07 09:56:23');
INSERT INTO "public"."sys_captcha" VALUES ('f907fe82-0d66-41f8-82e1-483f19e22cc6', 'nyxfn', '2020-01-13 09:28:52');
INSERT INTO "public"."sys_captcha" VALUES ('0fb577c5-ad21-4d1a-868a-0611147075e6', '3mnxb', '2020-01-07 10:16:30');
INSERT INTO "public"."sys_captcha" VALUES ('53289954-2ca9-411e-8e2c-1fa38d0c5070', '8wmca', '2020-01-07 10:28:46');
INSERT INTO "public"."sys_captcha" VALUES ('fbafb1d2-17e9-4085-8164-acccabc1045f', 'emxp6', '2020-01-07 15:33:00');
INSERT INTO "public"."sys_captcha" VALUES ('03aa4009-2ad0-4c12-89a4-e5753def2dab', '873cb', '2020-01-07 16:22:09');
INSERT INTO "public"."sys_captcha" VALUES ('30f0b4b0-bddd-498d-8da7-75b773deb978', '26ynn', '2020-01-07 16:29:48');
INSERT INTO "public"."sys_captcha" VALUES ('59c872e7-54b9-4aca-8420-0a2627c1d792', '58765', '2020-01-07 16:30:19');
INSERT INTO "public"."sys_captcha" VALUES ('b89a5a3a-c0b6-4c79-8aca-836c2b0fed44', 'mm63n', '2020-01-13 16:03:26');
INSERT INTO "public"."sys_captcha" VALUES ('d4c8d959-df2c-490c-8008-7430d98069be', 'ybfng', '2020-01-07 16:31:57');
INSERT INTO "public"."sys_captcha" VALUES ('20b16119-8313-478e-8412-ce171536138b', 'acec2', '2020-01-07 16:36:42');
INSERT INTO "public"."sys_captcha" VALUES ('7ec541a0-24e3-41b8-8f95-40de4ae70be0', '2f2fx', '2020-01-13 16:03:52');
INSERT INTO "public"."sys_captcha" VALUES ('8ab86795-d9dd-4b38-84ef-c81315bbb4ec', '873n5', '2020-01-14 09:51:13');
INSERT INTO "public"."sys_captcha" VALUES ('0772e4d9-7ef0-4889-8071-13cac87562eb', '3b846', '2020-01-14 10:13:41');
INSERT INTO "public"."sys_captcha" VALUES ('ea5686cf-4786-46f9-8d9a-8baa6281144b', 'c5n6w', '2020-01-14 10:52:43');
INSERT INTO "public"."sys_captcha" VALUES ('1adba753-2865-4bab-8774-5837019aa965', 'wy74w', '2020-01-14 11:01:42');
INSERT INTO "public"."sys_captcha" VALUES ('36cccc55-43e7-4300-8395-a78043fbe17c', '27acn', '2020-01-14 13:42:16');
INSERT INTO "public"."sys_captcha" VALUES ('1db9822a-9268-4981-8d29-290f0f96befb', 'dbw53', '2020-01-14 13:42:17');
INSERT INTO "public"."sys_captcha" VALUES ('ba9649a2-ebe0-4001-8253-5ddc771b8272', '8f2a4', '2020-01-14 14:02:45');
INSERT INTO "public"."sys_captcha" VALUES ('a9f6436f-aa0a-4048-84b8-f488184eedc3', 'cwn78', '2020-01-15 09:21:28');
INSERT INTO "public"."sys_captcha" VALUES ('7cbb9f20-90e4-462b-8fb1-932ab5eb73c5', 'dg6nd', '2020-01-15 09:21:42');
INSERT INTO "public"."sys_captcha" VALUES ('12f14ae3-e9c8-4555-81fb-46e9b60daac7', 'f28yg', '2020-01-15 11:19:27');
INSERT INTO "public"."sys_captcha" VALUES ('c19ae636-edc9-4635-8feb-e5b15822ee99', '4w8bn', '2020-01-15 13:55:09');
INSERT INTO "public"."sys_captcha" VALUES ('8911ada8-b3bb-40cc-80a1-f06141a9d1cc', 'ng844', '2020-01-15 17:45:26');
INSERT INTO "public"."sys_captcha" VALUES ('0952f4a4-361d-4811-896b-031f6da116c0', 'n868w', '2020-01-16 13:18:17');
INSERT INTO "public"."sys_captcha" VALUES ('e71e4691-731e-4acf-825b-b347489c635c', 'p785y', '2020-01-16 13:46:21');
INSERT INTO "public"."sys_captcha" VALUES ('e88ece3c-58b0-4205-813e-25fc00390ad4', '2nncn', '2020-01-16 14:11:52');
INSERT INTO "public"."sys_captcha" VALUES ('f4618157-0545-4bcf-8158-28f4ea762cca', 'pmefa', '2020-01-16 14:12:09');
INSERT INTO "public"."sys_captcha" VALUES ('5baf863f-0a05-4a1d-8739-4b5b744e9817', '6fnn2', '2020-01-18 14:10:26');
INSERT INTO "public"."sys_captcha" VALUES ('e1fdbbed-9b5c-4284-84d8-a57d19b0f34a', '7fnbb', '2020-01-18 14:10:26');
INSERT INTO "public"."sys_captcha" VALUES ('5084973c-5fab-49ed-870d-9271e3d8bd08', 'y6e5d', '2020-01-19 10:48:42');
INSERT INTO "public"."sys_captcha" VALUES ('63f5645e-42b3-4bc2-8ee6-2f2ef5318e6a', '48243', '2020-01-19 15:22:54');
INSERT INTO "public"."sys_captcha" VALUES ('6abe30fb-0e03-4c72-806b-3560786a9638', 'gwm8b', '2020-01-19 15:23:22');
INSERT INTO "public"."sys_captcha" VALUES ('b378b5b5-a29c-4b87-886c-dedd23ccbae6', 'en352', '2020-01-19 15:24:38');
INSERT INTO "public"."sys_captcha" VALUES ('bd91a667-48ce-465c-81f6-c68659963389', '5a5nd', '2020-01-19 15:58:01');
INSERT INTO "public"."sys_captcha" VALUES ('0fad9846-c216-486f-8fa1-62e7b742d968', 'ecxaw', '2020-01-19 15:59:28');
INSERT INTO "public"."sys_captcha" VALUES ('a704691e-600a-4b8b-8e25-81a3489be6d1', 'ebdg6', '2020-01-19 16:14:45');
INSERT INTO "public"."sys_captcha" VALUES ('fc06f1ff-c25d-4f7d-848d-6e05a2f662b2', 'fm366', '2020-01-19 16:25:02');
INSERT INTO "public"."sys_captcha" VALUES ('7c8bb91a-9ae2-4d43-89f3-14ddb05f6221', 'x8ywb', '2020-01-19 16:26:28');
INSERT INTO "public"."sys_captcha" VALUES ('567d57b0-3302-4a4a-8eca-b4a8d30ae59f', 'e55ny', '2020-01-19 17:47:54');
INSERT INTO "public"."sys_captcha" VALUES ('9aa8fd58-dd8e-49ed-87cd-1c556c94428e', 'egwyy', '2020-01-20 09:56:53');
INSERT INTO "public"."sys_captcha" VALUES ('93413154-a970-4842-850b-617eabe6a8aa', 'cd55n', '2019-12-25 14:21:13');
INSERT INTO "public"."sys_captcha" VALUES ('084f5f3e-344e-497a-8ee3-2b81249cf8fd', '3a7db', '2019-12-26 14:17:56');
INSERT INTO "public"."sys_captcha" VALUES ('c9dfb3ef-653e-41ef-8450-12cbc2154f48', 'xagxa', '2019-12-25 14:22:53');
INSERT INTO "public"."sys_captcha" VALUES ('f75ada69-3b3f-4324-801d-a8fbf5aef446', 'y55af', '2019-12-26 16:44:36');
INSERT INTO "public"."sys_captcha" VALUES ('38e9e2a2-6103-4e9d-830d-4a4e8aeef820', '6wnb4', '2020-01-07 16:52:39');
INSERT INTO "public"."sys_captcha" VALUES ('e18d7ddd-0edd-45ca-8d77-cf97280d16d9', 'a5enp', '2019-12-25 14:40:27');
INSERT INTO "public"."sys_captcha" VALUES ('5afcf3ad-6261-4b6a-8b12-d02ad358f872', 'p4ane', '2019-12-27 11:36:13');
INSERT INTO "public"."sys_captcha" VALUES ('a5066b1f-deb7-4716-83cd-0303826308a9', 'w7p8a', '2019-12-27 11:43:20');
INSERT INTO "public"."sys_captcha" VALUES ('f8ba7ece-6ebf-433e-87d9-8cd25c44ad55', 'nmafn', '2019-12-25 15:15:00');
INSERT INTO "public"."sys_captcha" VALUES ('d3de2fe3-d336-4441-891c-7dfbf7a2f3b1', 'g47by', '2019-12-27 11:44:28');
INSERT INTO "public"."sys_captcha" VALUES ('d29f4a0f-5079-49af-8e65-5ad8409586d5', '65n3n', '2019-12-27 11:45:11');
INSERT INTO "public"."sys_captcha" VALUES ('dc1b1e2c-45d8-4ba0-8a1f-6638cd3ec7f3', 'edn33', '2019-12-27 11:52:37');
INSERT INTO "public"."sys_captcha" VALUES ('98b98f24-c695-4a82-89ed-5414bea7bf3c', 'aeyp6', '2019-12-25 15:16:54');
INSERT INTO "public"."sys_captcha" VALUES ('e6e1c455-f295-4e93-8ec9-894294384211', '46wn2', '2019-12-27 11:54:14');
INSERT INTO "public"."sys_captcha" VALUES ('a2a153f1-91bf-4cf4-81fe-6ff78cd6f556', '64d3w', '2019-12-25 15:17:23');
INSERT INTO "public"."sys_captcha" VALUES ('36df1fa2-e23e-4ed3-8abc-8714a69dd853', 'gnxf8', '2019-12-27 12:05:58');
INSERT INTO "public"."sys_captcha" VALUES ('63ba14c5-63a2-40f3-8f31-8bdd1c53e9ce', 'an2gx', '2019-12-27 13:24:03');
INSERT INTO "public"."sys_captcha" VALUES ('bd3fdae5-16dc-42a7-8a70-ba135b9520e4', 'edew4', '2019-12-27 13:36:03');
INSERT INTO "public"."sys_captcha" VALUES ('f96fc386-fadd-4e09-8091-f791c9d85eab', 'dxcc4', '2019-12-27 13:51:26');
INSERT INTO "public"."sys_captcha" VALUES ('fdd285b9-f957-4182-8428-16f6fe562c7c', 'nbpmn', '2020-01-08 11:23:25');
INSERT INTO "public"."sys_captcha" VALUES ('782f85ea-94b1-40a0-8a61-985467011fb2', 'bmd7b', '2019-12-27 17:56:43');
INSERT INTO "public"."sys_captcha" VALUES ('2dacb9e8-eb7c-478f-87eb-a2ca16aa6b6e', 'egwnx', '2019-12-30 09:25:15');
INSERT INTO "public"."sys_captcha" VALUES ('e1083400-7080-470e-8cd9-3cb60d5e3c98', 'xnxc5', '2019-12-30 09:38:26');
INSERT INTO "public"."sys_captcha" VALUES ('baae6161-aae2-422b-856f-c77c41a60134', 'gcm23', '2019-12-30 09:44:04');
INSERT INTO "public"."sys_captcha" VALUES ('0ba11ded-489c-45ad-8e99-555e1e693710', 'dg4na', '2020-01-08 14:49:59');
INSERT INTO "public"."sys_captcha" VALUES ('e3e75bc9-ec86-4e93-8f7c-984fccc70916', 'gppn5', '2019-12-30 09:46:09');
INSERT INTO "public"."sys_captcha" VALUES ('dc31a195-6c61-478c-8c5d-2e68364d718d', 'xa2y3', '2019-12-30 09:53:19');
INSERT INTO "public"."sys_captcha" VALUES ('161c69fd-962b-4a7d-8ef2-2fec896d6a1a', 'wcn73', '2019-12-30 10:05:56');
INSERT INTO "public"."sys_captcha" VALUES ('f30fe1f4-7747-4cc7-8e98-8bb79dd0271c', 'cp8wd', '2019-12-30 10:10:09');
INSERT INTO "public"."sys_captcha" VALUES ('33d86021-9188-4e7f-8ad0-60a3e6d308c0', 'nycpw', '2019-12-30 10:16:24');
INSERT INTO "public"."sys_captcha" VALUES ('859f61ea-734c-49ff-81f2-035cc450b032', 'nwyn8', '2019-12-30 10:19:31');
INSERT INTO "public"."sys_captcha" VALUES ('7f44ce0a-0ea4-41a3-889c-146b7408293d', '2435e', '2019-12-30 10:51:43');
INSERT INTO "public"."sys_captcha" VALUES ('89f8611e-b6ed-4d85-8dd0-09901a481f25', 'cdwcm', '2019-12-30 11:21:41');
INSERT INTO "public"."sys_captcha" VALUES ('c3451435-15a7-4002-884f-34c57c393931', '2638f', '2019-12-30 14:35:05');
INSERT INTO "public"."sys_captcha" VALUES ('c1d75c00-2be1-46b9-8dd8-57daf959b09a', 'xn884', '2019-12-30 14:46:17');
INSERT INTO "public"."sys_captcha" VALUES ('95df77ca-b3bb-48a2-8c17-d6ddddc8b816', '6gc3m', '2019-12-30 14:56:13');
INSERT INTO "public"."sys_captcha" VALUES ('1e76a3cc-2ac0-4b6a-8487-dd40a6fed1b1', 'gnmn5', '2019-12-30 15:28:24');
INSERT INTO "public"."sys_captcha" VALUES ('080b4251-7d78-489a-801b-15bf897b7222', '638ab', '2019-12-30 15:28:32');
INSERT INTO "public"."sys_captcha" VALUES ('5a84e805-5535-433d-8146-113c545bc47d', '78bax', '2019-12-30 15:29:10');
INSERT INTO "public"."sys_captcha" VALUES ('3d9e4d2f-9bc1-4de5-874c-45cf8b42985c', 'nmbmf', '2019-12-30 15:30:25');
INSERT INTO "public"."sys_captcha" VALUES ('50b1f789-bc3b-403c-8708-85f9defe49bf', '8n22n', '2019-12-30 15:30:35');
INSERT INTO "public"."sys_captcha" VALUES ('4896215d-7465-4735-81a0-717198ef9180', 'w32ny', '2019-12-30 15:31:16');
INSERT INTO "public"."sys_captcha" VALUES ('3cf76894-9c2d-4d13-8de6-5956d4ab9f7f', 'gcay3', '2019-12-30 15:34:57');
INSERT INTO "public"."sys_captcha" VALUES ('d83c80f5-a502-47d0-89b4-15d7c7ef4e3b', 'gwnab', '2019-12-30 15:35:50');
INSERT INTO "public"."sys_captcha" VALUES ('e1876669-d074-4f15-8868-27cd25eba991', 'm4nae', '2019-12-30 15:36:32');
INSERT INTO "public"."sys_captcha" VALUES ('e6a48553-0f5f-4e7d-81b0-67b312c48c2b', 'xaax3', '2019-12-30 15:38:56');
INSERT INTO "public"."sys_captcha" VALUES ('5e1d97c4-be99-43b2-833b-624a09a5e4ca', '3nbww', '2019-12-30 15:39:32');
INSERT INTO "public"."sys_captcha" VALUES ('2e742892-f8bd-4ea9-8b98-d4bb6c5ae371', '6axe3', '2019-12-30 15:39:47');
INSERT INTO "public"."sys_captcha" VALUES ('f1e16ee7-5391-4780-85b8-b9f7692fc2cb', 'nwg4x', '2019-12-30 15:40:54');
INSERT INTO "public"."sys_captcha" VALUES ('48679b6c-8f16-44f7-87dc-869a45218f92', '2xe74', '2019-12-30 15:46:13');
INSERT INTO "public"."sys_captcha" VALUES ('b80c6066-84a5-413d-8006-0a5bd7b536a5', '32ppp', '2019-12-30 15:46:19');
INSERT INTO "public"."sys_captcha" VALUES ('f7f4d494-322b-4de9-8f57-d4ed2a12f2c2', '5475f', '2019-12-30 15:46:24');
INSERT INTO "public"."sys_captcha" VALUES ('020bcde3-5c39-4b01-8412-ed07621c2bbb', '7n833', '2019-12-30 15:46:29');
INSERT INTO "public"."sys_captcha" VALUES ('7f8dacdf-c2e9-4f4b-8283-b56082a8c950', '5bw2m', '2019-12-30 15:46:35');
INSERT INTO "public"."sys_captcha" VALUES ('6f1337b9-92a9-4326-85a1-51f371a271f9', 'awcgx', '2019-12-30 15:48:49');
INSERT INTO "public"."sys_captcha" VALUES ('be587bd8-7e9d-4355-8e2f-17dd115b0069', 'n4n3d', '2019-12-30 15:49:03');
INSERT INTO "public"."sys_captcha" VALUES ('b16d04fb-b42d-48e7-8d1c-474697cec82b', '4fdgd', '2019-12-30 15:49:13');
INSERT INTO "public"."sys_captcha" VALUES ('cec93afd-1561-44f5-8abf-a1f6d7c3c2d4', '2p7gd', '2019-12-30 15:49:18');
INSERT INTO "public"."sys_captcha" VALUES ('6dd13298-0f85-422d-8506-30ac85cc2297', '82643', '2019-12-30 15:49:24');
INSERT INTO "public"."sys_captcha" VALUES ('784e260d-c94c-4244-89a7-f548aa917258', '3pg48', '2019-12-30 15:49:30');
INSERT INTO "public"."sys_captcha" VALUES ('61336bc1-32bc-429d-8ea8-080ebda4a38c', 'w75dc', '2019-12-30 16:41:06');
INSERT INTO "public"."sys_captcha" VALUES ('8bd96b26-2e6f-4d16-874a-0b8820e33d90', '88a8p', '2020-01-09 09:24:16');
INSERT INTO "public"."sys_captcha" VALUES ('3c700dce-5c2e-41eb-8e8e-2c9c3f1cb1e6', 'wp7ce', '2020-01-09 09:43:34');
INSERT INTO "public"."sys_captcha" VALUES ('7cb2a133-3425-447a-8573-f9f9f5e63919', '22cna', '2020-01-02 09:48:08');
INSERT INTO "public"."sys_captcha" VALUES ('b00adab1-d525-43a6-8dbe-0195119400a7', 'aaf5p', '2020-01-02 15:51:47');
INSERT INTO "public"."sys_captcha" VALUES ('dd54e558-0f12-4f60-8356-c85e2a96843c', 'xeg5c', '2020-01-02 17:08:30');
INSERT INTO "public"."sys_captcha" VALUES ('c8737f3e-9092-425f-88db-e01210dc8a86', 'n2p3a', '2020-01-02 17:10:59');
INSERT INTO "public"."sys_captcha" VALUES ('bda8eac4-a8e7-4f15-8728-c13070667320', 'n5xnx', '2020-01-03 14:06:25');
INSERT INTO "public"."sys_captcha" VALUES ('ecb3deed-a7e1-4307-8f7d-390e79cc5f4a', 'byd8c', '2020-01-03 14:39:59');
INSERT INTO "public"."sys_captcha" VALUES ('4eb3884a-eaef-4556-89ef-36a629d2da2a', '6be6e', '2020-01-09 14:02:43');
INSERT INTO "public"."sys_captcha" VALUES ('0d677128-17fd-4ac0-8bf5-2dad3b24bc4b', 'nb3ne', '2020-01-10 10:26:32');
INSERT INTO "public"."sys_captcha" VALUES ('26585b87-1a0a-49e0-85ff-0b6012904472', '3xm7y', '2020-01-04 16:17:25');
INSERT INTO "public"."sys_captcha" VALUES ('014509c5-7947-457a-8e30-737fb9dc09f0', 'bw28e', '2020-01-04 16:17:27');
INSERT INTO "public"."sys_captcha" VALUES ('0723079b-b122-4393-8462-eff52e42e270', 'ncnmp', '2020-01-06 09:23:46');
INSERT INTO "public"."sys_captcha" VALUES ('5fefd850-ab1f-41d2-8b19-8f9e940a2c33', 'de7xx', '2020-01-10 10:28:46');
INSERT INTO "public"."sys_captcha" VALUES ('5bd16359-8982-4022-8ead-b07231876953', 'wdngg', '2020-01-07 10:11:22');
INSERT INTO "public"."sys_captcha" VALUES ('1b13610b-e0eb-4624-866d-afcee7a3c111', 'p28pp', '2020-01-07 10:15:28');
INSERT INTO "public"."sys_captcha" VALUES ('514611ec-dfef-4a25-8306-dfc5fbcb8381', 'bgnm6', '2020-01-07 10:15:29');
INSERT INTO "public"."sys_captcha" VALUES ('43f0b518-55d7-4695-88e6-43b6e765fe48', '3edc3', '2020-01-07 15:09:07');
INSERT INTO "public"."sys_captcha" VALUES ('7c9318f6-0327-4892-80f2-7076d97515df', 'bgagb', '2020-01-07 15:18:32');
INSERT INTO "public"."sys_captcha" VALUES ('4cfce2bc-3c49-4bcc-8e5e-8265af53d2db', '426bc', '2020-01-07 16:26:23');
INSERT INTO "public"."sys_captcha" VALUES ('c8d4c061-37c2-4fb9-8d6e-613406edfa0a', 'mxnxw', '2020-01-07 16:27:05');
INSERT INTO "public"."sys_captcha" VALUES ('d3f40b5c-48b5-49f8-8609-bfd721f28864', '6x823', '2020-01-13 14:06:00');
INSERT INTO "public"."sys_captcha" VALUES ('e4278fb2-9918-4321-8625-6345c8ef5840', 'c4g4d', '2020-01-07 16:27:57');
INSERT INTO "public"."sys_captcha" VALUES ('3e0345d6-2486-4f59-8d0b-c1dd0a693b29', 'm8dy2', '2020-01-07 16:28:32');
INSERT INTO "public"."sys_captcha" VALUES ('4269997d-0137-45e8-8057-1c7c5f9a3255', '78gnb', '2020-01-07 16:33:53');
INSERT INTO "public"."sys_captcha" VALUES ('c10cd767-fbc5-4eba-85a7-6b9dfa75ad73', 'wpc5n', '2020-01-13 15:08:15');
INSERT INTO "public"."sys_captcha" VALUES ('e11f1f61-0d5a-4c9c-85bd-4e3e1d90709d', '6p27e', '2020-01-07 16:34:58');
INSERT INTO "public"."sys_captcha" VALUES ('33d62d06-97c0-45ee-8204-d465b38073ed', 'fg4cm', '2020-01-07 16:35:53');
INSERT INTO "public"."sys_captcha" VALUES ('f3ae2ecf-f8b2-4ee6-88d6-3f8d49b2147a', '643ap', '2020-01-14 08:46:32');
INSERT INTO "public"."sys_captcha" VALUES ('fa8aed18-6745-4a85-8ce8-ad9a536b3a88', 'e5gp5', '2020-01-14 10:10:08');
INSERT INTO "public"."sys_captcha" VALUES ('b08b2bd1-d49f-4043-8000-d93cef93d790', 'bdnnf', '2020-01-14 10:10:32');
INSERT INTO "public"."sys_captcha" VALUES ('14dc8a7c-d541-4e48-8219-81e7159034cc', 'f5n2n', '2020-01-14 10:43:23');
INSERT INTO "public"."sys_captcha" VALUES ('6fd4e010-745e-4aaa-862b-ddae538c3732', 'ng4m6', '2019-12-25 14:28:01');
INSERT INTO "public"."sys_captcha" VALUES ('5c2d43f0-f130-43ff-8491-9a11f53c0d32', '7n5g4', '2020-01-07 17:03:43');
INSERT INTO "public"."sys_captcha" VALUES ('9f57f967-ca7c-48cf-84cf-618566e0064c', 'yxmb8', '2019-12-26 16:44:41');
INSERT INTO "public"."sys_captcha" VALUES ('6a9a357a-eec0-4301-8c25-8a3eb888a37a', '5mc4g', '2019-12-25 14:39:11');
INSERT INTO "public"."sys_captcha" VALUES ('f8ca5b7b-f0e5-415a-8020-4ffa7a0fff6d', 'wndym', '2019-12-25 14:47:14');
INSERT INTO "public"."sys_captcha" VALUES ('c458193e-207f-42d4-8403-2d854e8aabdd', 'ed7p3', '2019-12-27 09:50:13');
INSERT INTO "public"."sys_captcha" VALUES ('ff5b95ac-59d7-4ca6-8f8e-837ad2c8dcb0', '2c2nc', '2020-01-08 10:01:38');
INSERT INTO "public"."sys_captcha" VALUES ('d3bfb508-be48-4763-8f0a-a6bdc13af595', '8wc5w', '2019-12-27 12:45:26');
INSERT INTO "public"."sys_captcha" VALUES ('0ca388b6-44b4-4801-87a0-7ceb8a2d8a1c', 'gcyw3', '2020-01-08 10:22:10');
INSERT INTO "public"."sys_captcha" VALUES ('c607b74c-02fe-46e4-8568-0a646e54c789', 'm5fy2', '2020-01-08 10:25:15');
INSERT INTO "public"."sys_captcha" VALUES ('edb2ff05-759f-4936-84df-93bd3dd44b16', 'pygen', '2019-12-27 13:41:56');
INSERT INTO "public"."sys_captcha" VALUES ('108083b8-17eb-4cf2-87fb-49108f537960', '46bpp', '2020-01-08 10:29:58');
INSERT INTO "public"."sys_captcha" VALUES ('8faa31d5-232e-47c0-84da-e35d135b5beb', 'xe37x', '2019-12-27 13:53:12');
INSERT INTO "public"."sys_captcha" VALUES ('ac154162-0022-436e-85f5-bfe258267c2a', '72wx2', '2019-12-27 13:53:12');
INSERT INTO "public"."sys_captcha" VALUES ('ddecc38e-04dc-4714-8353-7e4561e564d8', 'dw6nx', '2019-12-27 13:58:40');
INSERT INTO "public"."sys_captcha" VALUES ('b4bf577e-7d78-497a-8050-9016672b9648', 'wbnxf', '2019-12-27 13:58:46');
INSERT INTO "public"."sys_captcha" VALUES ('9fff6ae0-fa24-41ce-8c7a-af4bdf95b1c5', '8p5wf', '2020-01-08 11:13:44');
INSERT INTO "public"."sys_captcha" VALUES ('e5f41bce-1357-48b4-8394-2bb24aae7201', 'cyab3', '2019-12-27 14:45:31');
INSERT INTO "public"."sys_captcha" VALUES ('cc22c667-55c3-4358-868c-a6eb0d41f3ea', '3nxn4', '2019-12-27 18:05:12');
INSERT INTO "public"."sys_captcha" VALUES ('fbd7266f-132f-47bd-8bfd-9adb0388b5f7', 'e36nb', '2019-12-27 18:06:06');
INSERT INTO "public"."sys_captcha" VALUES ('04afc1e0-0bc5-482b-8404-b3cc742e834e', 'eabpc', '2019-12-28 18:33:32');
INSERT INTO "public"."sys_captcha" VALUES ('0c7f3dbc-b7fe-4571-835b-6b80f9e9a921', 'cyp5d', '2019-12-28 18:34:04');
INSERT INTO "public"."sys_captcha" VALUES ('1005cdb7-0b20-41c8-8f41-4bf26d701ec3', 'p6afc', '2020-01-08 11:34:07');
INSERT INTO "public"."sys_captcha" VALUES ('468a4be1-560f-430a-84a1-df9a76269735', '4n4d6', '2019-12-30 09:41:09');
INSERT INTO "public"."sys_captcha" VALUES ('bb8cf8e1-fbf5-4347-8c4e-75f2b5156b55', 'ngxgw', '2019-12-30 09:55:29');
INSERT INTO "public"."sys_captcha" VALUES ('615eac09-d731-4b1e-83cf-a9392ecfa261', 'n552n', '2019-12-30 14:03:04');
INSERT INTO "public"."sys_captcha" VALUES ('21fab73e-fa5f-465a-8b51-9ac021d79e81', '2bbdg', '2020-01-08 13:49:14');
INSERT INTO "public"."sys_captcha" VALUES ('fc44f2ba-eaa2-4676-8d8c-8caf8fa8d2a6', '6cy33', '2019-12-30 15:14:22');
INSERT INTO "public"."sys_captcha" VALUES ('7fb2a767-196c-40f6-8d9f-9b37e7580f90', '23e5w', '2019-12-30 15:14:22');
INSERT INTO "public"."sys_captcha" VALUES ('aff76d8a-925a-4d4c-8f3b-8da699ea8b62', '7x3yd', '2019-12-30 15:18:57');
INSERT INTO "public"."sys_captcha" VALUES ('4ac9b5bd-fbe1-4c28-8d02-d1ee74a7dc2f', 'ce66w', '2019-12-30 15:23:19');
INSERT INTO "public"."sys_captcha" VALUES ('5b39ff88-8021-473d-85ce-e94b8d7b98e6', '6bgmc', '2020-01-08 15:23:12');
INSERT INTO "public"."sys_captcha" VALUES ('ce1a4ac9-71be-402d-81c6-0a9f361d560a', 'enxxg', '2019-12-31 17:11:21');
INSERT INTO "public"."sys_captcha" VALUES ('881a53ab-950c-4940-8141-d45a6c931e3d', 'e22na', '2020-01-08 15:49:44');
INSERT INTO "public"."sys_captcha" VALUES ('ae023120-60d5-49cf-8b54-440d96057b2b', 'n4mfy', '2020-01-02 09:07:56');
INSERT INTO "public"."sys_captcha" VALUES ('e69d7095-1a94-402e-8f58-5f14c54367b7', 'bfn33', '2020-01-08 15:53:27');
INSERT INTO "public"."sys_captcha" VALUES ('b82958b1-53c5-4239-8c96-8c6a30162878', '3bndn', '2020-01-03 09:48:48');
INSERT INTO "public"."sys_captcha" VALUES ('ec258c5d-3155-4ef2-80cc-5691983179ae', '54pmb', '2020-01-03 09:48:54');
INSERT INTO "public"."sys_captcha" VALUES ('7b71d8fe-086d-4f53-8e3f-4612f4561934', '42cng', '2020-01-03 09:49:01');
INSERT INTO "public"."sys_captcha" VALUES ('dd525114-eb6e-4381-83db-818e002e35e5', '42epg', '2020-01-09 09:49:51');
INSERT INTO "public"."sys_captcha" VALUES ('40d24dac-9891-43b6-83e5-121200941ad9', '7g4md', '2020-01-03 14:07:35');
INSERT INTO "public"."sys_captcha" VALUES ('0567588e-0da9-485b-8d45-ca6c6e3b7419', 'xfmw3', '2020-01-10 10:08:37');
INSERT INTO "public"."sys_captcha" VALUES ('6427b8ad-09fe-4541-8971-bc0974c22ff9', '56xpn', '2020-01-10 10:15:39');
INSERT INTO "public"."sys_captcha" VALUES ('28543b65-3a97-4efc-818c-ca3c0b3c8b80', 'nency', '2020-01-03 14:16:32');
INSERT INTO "public"."sys_captcha" VALUES ('0fd318d6-7c24-408e-8818-04460cae49d4', 'a844e', '2020-01-10 10:19:01');
INSERT INTO "public"."sys_captcha" VALUES ('ba8b2a24-e1aa-4f7e-8402-fc9ebe97c92c', 'afpnd', '2020-01-03 14:57:27');
INSERT INTO "public"."sys_captcha" VALUES ('23d588ce-9122-4540-89b9-976aded38130', 'p4m5d', '2020-01-10 10:50:37');
INSERT INTO "public"."sys_captcha" VALUES ('9aa54e11-b4c3-4eef-82d5-e6fb45eeb5ca', 'xenc6', '2020-01-03 15:12:00');
INSERT INTO "public"."sys_captcha" VALUES ('272a5323-3e62-46d7-840c-02821bdc315f', 'yx56a', '2020-01-10 11:08:00');
INSERT INTO "public"."sys_captcha" VALUES ('a1190dda-af86-4aa0-836f-caae5a6166f1', 'bf8nw', '2020-01-03 16:43:29');
INSERT INTO "public"."sys_captcha" VALUES ('3b73623f-fc4c-498f-8c5e-a8ca7a2e8159', '6c37a', '2020-01-03 16:45:09');
INSERT INTO "public"."sys_captcha" VALUES ('fcf0f9b4-3e37-434a-8dc1-eca5ea723b34', 'fp3fc', '2020-01-04 13:50:00');
INSERT INTO "public"."sys_captcha" VALUES ('54a4a756-f1ea-498a-8f1e-e1e27c173f4e', 'cdbap', '2020-01-06 09:08:32');
INSERT INTO "public"."sys_captcha" VALUES ('b97b72d9-028e-45af-8e0d-91123e81226b', 'y38xg', '2020-01-10 16:54:42');
INSERT INTO "public"."sys_captcha" VALUES ('4f704d6f-669d-4d82-8d6c-83b8256f82ed', 'nxeff', '2020-01-10 16:55:59');
INSERT INTO "public"."sys_captcha" VALUES ('2225f9e3-96dd-4cac-8d91-10fe6e7ba3c7', 'bx37a', '2020-01-13 09:56:59');
INSERT INTO "public"."sys_captcha" VALUES ('b78a376b-a5d3-4333-83a9-f121d92bcaf5', 'x6cn3', '2020-01-13 14:07:30');
INSERT INTO "public"."sys_captcha" VALUES ('ed4f5b97-554b-4178-860c-2e90f6d41fcc', 'ne62w', '2020-01-06 13:45:41');
INSERT INTO "public"."sys_captcha" VALUES ('1da48557-4558-4b25-8e02-834e96efbd31', 'bc7wn', '2020-01-13 15:06:41');
INSERT INTO "public"."sys_captcha" VALUES ('4600a804-755d-4cc3-8230-31ee86e4eed6', 'x2ba2', '2020-01-07 10:15:46');
INSERT INTO "public"."sys_captcha" VALUES ('04a7cf5d-df26-48f8-83ca-d76df7d3b415', 'gap43', '2020-01-07 10:16:48');
INSERT INTO "public"."sys_captcha" VALUES ('08be83a5-42f2-4e7d-8de5-8aeb874d423e', 'ppcw5', '2020-01-13 15:18:01');
INSERT INTO "public"."sys_captcha" VALUES ('edd63315-77ef-4e9f-8b1f-987b473eafef', 'ycd3b', '2020-01-07 14:34:47');
INSERT INTO "public"."sys_captcha" VALUES ('d0778ede-57e6-4e54-8b04-02f51ec5cc93', '238wm', '2020-01-13 15:19:05');
INSERT INTO "public"."sys_captcha" VALUES ('7e4788f3-6c15-4f56-8a19-d773ce11a918', '66dya', '2020-01-07 14:39:18');
INSERT INTO "public"."sys_captcha" VALUES ('03157458-7366-4bc8-8e6e-676324353969', 'bdwey', '2020-01-07 15:20:52');
INSERT INTO "public"."sys_captcha" VALUES ('14595584-d692-4283-85c7-1581b4dce273', 'gdfy4', '2020-01-13 15:21:09');
INSERT INTO "public"."sys_captcha" VALUES ('4bf1387a-3933-452a-8ff8-eddf51302127', 'nn7e4', '2020-01-07 15:41:06');
INSERT INTO "public"."sys_captcha" VALUES ('362b0414-5817-45d4-8a01-f0abe48534c3', 'x56by', '2020-01-13 15:34:49');
INSERT INTO "public"."sys_captcha" VALUES ('adafc976-c55c-4b22-882b-d21800246755', 'bxx6y', '2020-01-13 16:04:22');
INSERT INTO "public"."sys_captcha" VALUES ('093eff78-1d73-4add-83ee-21c7538228aa', 'c5352', '2020-01-13 16:05:01');
INSERT INTO "public"."sys_captcha" VALUES ('703b404b-8162-489a-8e78-76b492557381', 'pp582', '2020-01-14 10:30:20');
INSERT INTO "public"."sys_captcha" VALUES ('baf284d8-a7a7-4599-844f-2577945e91b4', 'mb57n', '2020-01-14 11:53:44');
INSERT INTO "public"."sys_captcha" VALUES ('564c6128-d767-45c3-8fe6-09656e5e7e2e', 'xe456', '2020-01-14 12:48:20');
INSERT INTO "public"."sys_captcha" VALUES ('9e910c14-e285-4999-8750-ffd108aeef8a', '6ddpn', '2020-01-14 13:42:37');
INSERT INTO "public"."sys_captcha" VALUES ('41e58fb5-c2c6-4129-8b7e-1ee1dc3d44b1', 'ny8fn', '2020-01-15 09:16:20');
INSERT INTO "public"."sys_captcha" VALUES ('f58c112c-8b48-4e81-80a3-fe612162a2c9', 'n3px3', '2020-01-15 11:38:20');
INSERT INTO "public"."sys_captcha" VALUES ('cd3909c0-d9f6-4ae4-83ba-f895fe2eb954', 'awy8f', '2020-01-15 14:37:08');
INSERT INTO "public"."sys_captcha" VALUES ('9ca1298d-21cb-4e9e-886e-70c9de382731', 'eypfn', '2020-01-15 14:52:47');
INSERT INTO "public"."sys_captcha" VALUES ('27da6c74-0e76-4c32-8145-97bdb1b39993', '57532', '2020-01-15 15:45:59');
INSERT INTO "public"."sys_captcha" VALUES ('3c821a92-7e2c-482c-8851-001c5ca8c84c', 'a3ggm', '2020-01-16 09:54:35');
INSERT INTO "public"."sys_captcha" VALUES ('bf214ddf-6cfa-4459-820f-9dfc431e5322', '6mbg4', '2020-01-16 10:03:05');
INSERT INTO "public"."sys_captcha" VALUES ('3978d923-31d0-45cb-8436-22d577f086f1', 'c7b46', '2020-01-16 10:03:06');
INSERT INTO "public"."sys_captcha" VALUES ('14124e60-7757-475b-8bbf-afdcc8b8108c', 'pbby5', '2020-01-16 13:48:19');
INSERT INTO "public"."sys_captcha" VALUES ('32044cf8-0d8a-453b-83b8-be37116ba857', '25e2d', '2020-01-16 16:27:11');
INSERT INTO "public"."sys_captcha" VALUES ('64b4bdd9-4a58-4948-88d3-abe69a4f1052', 'c7pfc', '2020-01-18 15:11:17');
INSERT INTO "public"."sys_captcha" VALUES ('7d0ef2f9-dbb5-433d-81fd-dba4a5d114b3', '2ydww', '2020-01-19 09:28:13');
INSERT INTO "public"."sys_captcha" VALUES ('6cc33d9d-52ff-4e72-8834-bb78ae892e35', 'bfpwn', '2020-01-19 09:28:55');
INSERT INTO "public"."sys_captcha" VALUES ('4523a24b-f7eb-4296-8f27-2ac8a1257c76', '27fyc', '2020-01-19 10:49:09');
INSERT INTO "public"."sys_captcha" VALUES ('571dbe6a-8ef4-4edd-82d6-61c79e629de6', '3fm44', '2020-01-19 14:13:59');
INSERT INTO "public"."sys_captcha" VALUES ('3f50cffe-ad2f-462c-8196-070fcb681f3c', '46acn', '2020-01-19 15:22:14');
INSERT INTO "public"."sys_captcha" VALUES ('47df0453-799c-4cef-8f9f-a525a03136e8', '26n7y', '2020-01-19 15:22:35');
INSERT INTO "public"."sys_captcha" VALUES ('3fd6ee0a-f38e-4ac7-8c4d-cdb99f6f90ba', '2dd23', '2020-01-19 16:27:31');
INSERT INTO "public"."sys_captcha" VALUES ('4bfdffca-ee0d-4e44-80ce-03797a71873f', '3fwmy', '2019-12-25 14:53:02');
INSERT INTO "public"."sys_captcha" VALUES ('e3f551fa-27b3-4a6d-8f81-bd80406d0cde', '8nxy7', '2019-12-26 16:44:46');
INSERT INTO "public"."sys_captcha" VALUES ('ee18fe74-73e3-4d83-8549-346c04fdc70e', 'e54ge', '2019-12-25 14:55:14');
INSERT INTO "public"."sys_captcha" VALUES ('afe2593b-5c5c-4c2a-84ca-07e02ca99054', '5a2ap', '2019-12-25 14:55:38');
INSERT INTO "public"."sys_captcha" VALUES ('fd116add-b8cb-41ae-8924-38cb2e63da8e', '5p357', '2019-12-25 14:56:02');
INSERT INTO "public"."sys_captcha" VALUES ('f38bb3ac-3397-4889-8058-c222663008d4', 'nm4fp', '2020-01-20 16:46:14');
INSERT INTO "public"."sys_captcha" VALUES ('4b7a0cb3-1478-431e-820d-04a0ab9f35fd', 'nna6c', '2020-01-08 11:35:10');
INSERT INTO "public"."sys_captcha" VALUES ('ef3ae7bf-3ffe-48e2-8e2b-37931a41ea6b', 'cw26e', '2020-01-20 17:15:45');
INSERT INTO "public"."sys_captcha" VALUES ('1ef4bbca-54dd-47bf-87a6-6e6be0dc79c7', 'eg2gw', '2019-12-27 13:43:02');
INSERT INTO "public"."sys_captcha" VALUES ('c3c3333c-866c-4356-8b6b-dc0059659193', 'bb3pn', '2019-12-27 13:55:40');
INSERT INTO "public"."sys_captcha" VALUES ('98000f63-55c4-47ed-82c5-2485b161c755', 'm2awf', '2019-12-27 14:40:43');
INSERT INTO "public"."sys_captcha" VALUES ('99798bba-fefc-4d40-8e01-c9b1954537ba', 'abxa2', '2019-12-27 14:52:31');
INSERT INTO "public"."sys_captcha" VALUES ('0f9c431a-f619-4e08-86a6-8b5f4c756d0e', 'x656g', '2019-12-27 14:54:14');
INSERT INTO "public"."sys_captcha" VALUES ('64323a58-3808-4efa-8ce7-003b5b773f6b', 'ng5nn', '2020-01-08 15:40:16');
INSERT INTO "public"."sys_captcha" VALUES ('d95deece-0a5f-47d6-889d-82dbc5743ce4', 'wna8a', '2020-01-08 16:00:20');
INSERT INTO "public"."sys_captcha" VALUES ('d07b4062-41e1-4da5-8749-5f5a9f340cab', '2yye5', '2019-12-28 18:55:31');
INSERT INTO "public"."sys_captcha" VALUES ('d7b272f3-1bc4-44ab-82fe-6c45244a57f9', 'agady', '2019-12-28 18:55:33');
INSERT INTO "public"."sys_captcha" VALUES ('860645be-cbad-43b9-833f-fa3d2db48fbf', 'py552', '2019-12-28 18:57:07');
INSERT INTO "public"."sys_captcha" VALUES ('c5c00a47-c276-41ff-89d5-6925b69c52d5', 'nw6x8', '2019-12-28 18:58:16');
INSERT INTO "public"."sys_captcha" VALUES ('1af7a0ce-4839-4297-87ef-f25f35fa224d', 'pfgc4', '2019-12-28 18:58:26');
INSERT INTO "public"."sys_captcha" VALUES ('81cc9d9c-fab3-4047-853b-009a46fbca56', 'nn7nn', '2020-01-20 17:26:32');
INSERT INTO "public"."sys_captcha" VALUES ('ca1832a3-fa15-478e-89ce-ba78a88315d6', '7x7en', '2019-12-30 14:20:52');
INSERT INTO "public"."sys_captcha" VALUES ('47818a85-0ed0-4de1-808a-42c1f6aba855', 'n6nyf', '2020-01-09 14:06:59');
INSERT INTO "public"."sys_captcha" VALUES ('95fe13b5-c833-46a2-8dec-96f9282b9af4', 'dpn27', '2019-12-30 14:40:11');
INSERT INTO "public"."sys_captcha" VALUES ('2f89c012-79a7-467f-8de3-81ab168a7aa6', 'n2m7c', '2019-12-30 16:18:14');
INSERT INTO "public"."sys_captcha" VALUES ('a88bafb6-ca4a-4efb-8c5d-eff31a10b6ec', 'ng4f5', '2019-12-30 16:23:19');
INSERT INTO "public"."sys_captcha" VALUES ('d899480e-3fbb-4ce7-8d35-716d9d0618d9', '88e43', '2019-12-30 16:24:00');
INSERT INTO "public"."sys_captcha" VALUES ('a68b9afa-d2f9-4075-82ed-401a94a040f9', 'd65xc', '2019-12-30 16:24:07');
INSERT INTO "public"."sys_captcha" VALUES ('6194ca1e-852d-43b8-8c89-a1538ae66293', '3b78x', '2019-12-30 16:25:05');
INSERT INTO "public"."sys_captcha" VALUES ('e0d6009c-99c4-4c4d-8563-0e770507eabc', 'f5bmx', '2019-12-30 16:25:10');
INSERT INTO "public"."sys_captcha" VALUES ('db3ace83-b6cb-4f67-8d22-75aa15db0eba', 'mypcb', '2019-12-30 16:30:26');
INSERT INTO "public"."sys_captcha" VALUES ('6877d8e4-d42f-4cf3-8ef6-2b0f01e76c28', 'cny3n', '2019-12-30 16:32:01');
INSERT INTO "public"."sys_captcha" VALUES ('c3c63ffe-267c-43a5-8796-db9d0d3e4857', 'cnbwg', '2019-12-30 16:32:30');
INSERT INTO "public"."sys_captcha" VALUES ('b2dba6f4-3165-44e5-872e-e9cba838f8bd', '2caf5', '2019-12-30 16:32:51');
INSERT INTO "public"."sys_captcha" VALUES ('e9869d43-0bea-4e55-8285-a80dc5e4b5bf', '3nx3e', '2019-12-31 08:44:13');
INSERT INTO "public"."sys_captcha" VALUES ('94d0c10d-2dce-4489-866b-40f39757914f', '3gb38', '2019-12-31 08:54:52');
INSERT INTO "public"."sys_captcha" VALUES ('4defe37a-41c0-4034-8e41-30b69110e15e', '2m8p8', '2019-12-31 09:38:04');
INSERT INTO "public"."sys_captcha" VALUES ('e048068a-2af1-481c-8768-6fadab17a64b', 'nbyay', '2019-12-31 09:38:09');
INSERT INTO "public"."sys_captcha" VALUES ('5cdebb15-bd57-44ad-8c5c-d502b2d19dd7', 'ye6g6', '2019-12-31 09:42:44');
INSERT INTO "public"."sys_captcha" VALUES ('837e5a1a-dcdf-4e41-8038-f913decf6273', '84en7', '2019-12-31 09:54:00');
INSERT INTO "public"."sys_captcha" VALUES ('589ce4dc-78b9-42ce-8362-bc425022aecd', 'fgcxd', '2019-12-31 09:54:55');
INSERT INTO "public"."sys_captcha" VALUES ('756fd12c-63b0-414a-8042-24ce749ba815', '7wdaa', '2019-12-31 10:03:58');
INSERT INTO "public"."sys_captcha" VALUES ('0bc378c2-a221-4d98-8a70-2a5219211f18', 'waf8d', '2019-12-31 10:10:44');
INSERT INTO "public"."sys_captcha" VALUES ('b2ab8429-6196-426a-8fc0-e3d34c234c95', 'fnfm4', '2019-12-31 10:19:48');
INSERT INTO "public"."sys_captcha" VALUES ('029b5ad3-1a3e-447e-803c-d413784cece0', 'xfbnx', '2019-12-31 10:22:04');
INSERT INTO "public"."sys_captcha" VALUES ('ceca7a9c-297c-4aa0-8eaf-b13e39adff02', 'm5283', '2019-12-31 10:25:23');
INSERT INTO "public"."sys_captcha" VALUES ('6b99ac2a-05bb-4bcd-85d1-d244fdd11e66', '5xppx', '2019-12-31 10:29:51');
INSERT INTO "public"."sys_captcha" VALUES ('3285b13c-6825-4423-8b85-d35ce4383ce9', 'xx8mm', '2019-12-31 10:32:56');
INSERT INTO "public"."sys_captcha" VALUES ('e3656c3e-9034-4f4f-8665-930e58f1440c', 'e7g8f', '2019-12-31 10:33:09');
INSERT INTO "public"."sys_captcha" VALUES ('8c89d139-7e46-47f7-87a7-75e1f6f8fc5b', 'yabyy', '2019-12-31 10:33:17');
INSERT INTO "public"."sys_captcha" VALUES ('145887ec-6ed5-4605-813f-4051ba29232b', '44bb6', '2020-01-13 08:52:30');
INSERT INTO "public"."sys_captcha" VALUES ('581235b8-5d4d-46b1-8fa1-04457dc3b7a5', 'ba8x3', '2019-12-31 13:48:35');
INSERT INTO "public"."sys_captcha" VALUES ('9dc17a70-6c28-4d66-8eb7-400e41a58f3d', 'n8e3y', '2019-12-31 15:35:21');
INSERT INTO "public"."sys_captcha" VALUES ('f44d595a-c9d8-40ec-834e-e4dca85c6fc5', '53acb', '2020-01-13 09:59:34');
INSERT INTO "public"."sys_captcha" VALUES ('b71eee69-d495-4f70-839e-ee0d43d296d6', 'bn6ng', '2019-12-31 17:13:24');
INSERT INTO "public"."sys_captcha" VALUES ('79e5e758-359e-4d69-8dab-b243c82bd234', '56nm5', '2019-12-31 17:14:07');
INSERT INTO "public"."sys_captcha" VALUES ('0967b2d4-2f62-43bd-8c63-7338345a2ca6', 'efxbc', '2019-12-31 17:14:26');
INSERT INTO "public"."sys_captcha" VALUES ('fcbf32b8-2615-4e5d-8e86-3073a3c24412', '6ggpn', '2020-01-02 09:30:14');
INSERT INTO "public"."sys_captcha" VALUES ('22e023ba-8db9-4c0a-86c6-3f9d3e06519d', 'n7xad', '2020-01-02 14:58:29');
INSERT INTO "public"."sys_captcha" VALUES ('b48c1966-92dd-4f04-8c93-3487a18b4cd2', '8575m', '2020-01-02 15:52:06');
INSERT INTO "public"."sys_captcha" VALUES ('1d759e73-4052-4a68-8acb-8707248f12a0', 'ewnan', '2020-01-13 14:11:06');
INSERT INTO "public"."sys_captcha" VALUES ('5090757d-ec6c-40ce-8ad2-fdd941bdadf6', '7a6ae', '2020-01-03 11:36:58');
INSERT INTO "public"."sys_captcha" VALUES ('5b2aa8be-50c8-4900-85df-586ccd251d72', 'd7f7w', '2020-01-13 14:22:23');
INSERT INTO "public"."sys_captcha" VALUES ('e677c018-094f-4828-8079-ad0b49581645', 'bxm8m', '2020-01-03 14:09:50');
INSERT INTO "public"."sys_captcha" VALUES ('6f61814b-4881-41d8-82d8-9210c2595115', 'ec5cb', '2020-01-04 13:50:10');
INSERT INTO "public"."sys_captcha" VALUES ('50980e02-54b4-46d8-82eb-b0d8ecc14eff', 'pdxeb', '2020-01-13 15:57:34');
INSERT INTO "public"."sys_captcha" VALUES ('ec49aeda-4d3c-49ab-8c5e-5a7dd357eead', '2mamy', '2020-01-13 16:02:46');
INSERT INTO "public"."sys_captcha" VALUES ('4f05c049-fba1-49aa-8d6a-8d11942e1a7b', 'd3354', '2020-01-06 09:18:53');
INSERT INTO "public"."sys_captcha" VALUES ('29462139-1a34-47cf-824a-39be9b8d4b99', 'y25w5', '2020-01-06 19:08:40');
INSERT INTO "public"."sys_captcha" VALUES ('c11bb303-dc09-4986-86b3-c8a9456610ba', 'nnpfp', '2020-01-13 16:16:05');
INSERT INTO "public"."sys_captcha" VALUES ('0069a3e6-1e86-43a6-83ef-1f82b4a6630a', '8ap23', '2020-01-07 10:19:36');
INSERT INTO "public"."sys_captcha" VALUES ('4cdc6319-f295-46c3-8362-a69805b65d6f', '4mea8', '2020-01-14 09:49:55');
INSERT INTO "public"."sys_captcha" VALUES ('62ed16e2-71ad-49ac-8231-69a1029df8a7', 'y7acc', '2020-01-14 10:52:30');
INSERT INTO "public"."sys_captcha" VALUES ('bbd6ef6a-9c82-47cf-8ab9-903d7d0d35be', 'nbnnd', '2020-01-07 11:13:09');
INSERT INTO "public"."sys_captcha" VALUES ('7da27119-eacb-4dc0-814b-e3c1c547a22c', 'wwae6', '2020-01-14 11:01:43');
INSERT INTO "public"."sys_captcha" VALUES ('f451b71c-621c-4314-8abe-780ce87fff6e', 'pd554', '2020-01-14 11:04:47');
INSERT INTO "public"."sys_captcha" VALUES ('0afdf08a-584b-43e0-8968-992a98525095', 'wbbfw', '2020-01-07 16:41:04');
INSERT INTO "public"."sys_captcha" VALUES ('ff2d3547-cca2-4a2d-880f-f87ccebd0933', '7ncgn', '2020-01-07 16:42:45');
INSERT INTO "public"."sys_captcha" VALUES ('56702ee3-aa14-4504-808a-3e107c7451ee', 'x4w6c', '2020-01-14 13:53:50');
INSERT INTO "public"."sys_captcha" VALUES ('b49fe64f-35cb-42a1-8eb5-477627aabac2', 'gc8b5', '2020-01-14 17:50:59');
INSERT INTO "public"."sys_captcha" VALUES ('722d6e2a-0af3-41d0-8de7-802919b94f31', 'ddg36', '2020-01-14 17:51:01');
INSERT INTO "public"."sys_captcha" VALUES ('9158bc92-a7d6-40f3-8896-33845fde5eb6', 'wcbbw', '2020-01-14 17:52:19');
INSERT INTO "public"."sys_captcha" VALUES ('3b534675-4e70-4d09-8eda-62ab4a9f328a', 'g57ea', '2020-01-14 23:17:57');
INSERT INTO "public"."sys_captcha" VALUES ('b754e6f5-dcb2-40f9-818d-03ac3365bcad', 'xw6x7', '2020-01-15 09:44:58');
INSERT INTO "public"."sys_captcha" VALUES ('1232e9d2-1d8e-4ccf-8b4b-5ceaaa6bc5bf', 'ggmef', '2020-01-15 09:45:01');
INSERT INTO "public"."sys_captcha" VALUES ('0310b9bf-68ba-4a9f-8816-1609a4b54b05', 'ndeag', '2020-01-15 15:43:19');
INSERT INTO "public"."sys_captcha" VALUES ('530809c4-b971-47b6-87fc-87ca8ab2483b', 'napn7', '2020-01-16 09:20:38');
INSERT INTO "public"."sys_captcha" VALUES ('67c9364a-7918-4739-87fd-9033777c24e5', 'ec4cn', '2020-01-16 11:10:07');
INSERT INTO "public"."sys_captcha" VALUES ('22773bd2-54cd-4235-8173-a3e743dc7b06', '4e7bg', '2020-01-16 14:11:05');
INSERT INTO "public"."sys_captcha" VALUES ('c00e7f51-c1ff-4b7f-87ff-9e2e575ea004', 'wpm34', '2020-01-18 16:35:28');
INSERT INTO "public"."sys_captcha" VALUES ('cddf97f9-5b56-43c0-8fa5-dd6248ff93f8', 'm22ad', '2020-01-20 10:00:24');
INSERT INTO "public"."sys_captcha" VALUES ('097378a8-7365-4d46-8a17-8225f9f7e28d', 'n333b', '2020-01-20 10:41:06');
INSERT INTO "public"."sys_captcha" VALUES ('cc5fc914-c2cc-4010-8419-44549d7a2b9a', 'x2gne', '2020-01-20 11:26:44');
INSERT INTO "public"."sys_captcha" VALUES ('dcec5d9e-2619-4672-8aeb-aa6b0428341e', 'ge8pp', '2019-12-25 14:56:35');
INSERT INTO "public"."sys_captcha" VALUES ('b6fcd3cd-2d1c-424c-8a2e-d11c85951608', 'abxcd', '2019-12-26 16:40:33');
INSERT INTO "public"."sys_captcha" VALUES ('b811f476-decb-45da-84e9-1f736848e4b7', 'fc2g2', '2020-01-20 16:43:54');
INSERT INTO "public"."sys_captcha" VALUES ('fde54e37-4558-466d-81c0-202f9ade5c04', '58e2m', '2019-12-25 15:10:55');
INSERT INTO "public"."sys_captcha" VALUES ('6e1cca5f-be51-41b0-8ed3-347b513deba2', 'pye8f', '2019-12-25 15:18:01');
INSERT INTO "public"."sys_captcha" VALUES ('b96ff510-a919-46d3-872a-14a00f72b9f1', 'n8nd4', '2019-12-27 13:46:43');
INSERT INTO "public"."sys_captcha" VALUES ('8a27f256-6c90-448d-814b-a4fb063d9ab8', 'ag54x', '2019-12-25 15:18:49');
INSERT INTO "public"."sys_captcha" VALUES ('96ff209b-67b3-40e9-8c68-cf85daf67c49', '5c77b', '2019-12-27 13:54:15');
INSERT INTO "public"."sys_captcha" VALUES ('02a10d4b-4cb3-4904-834a-6d963582529a', 'yn24a', '2019-12-25 15:19:16');
INSERT INTO "public"."sys_captcha" VALUES ('f375fd23-4276-4032-8b76-5bf3372af164', 'w66b2', '2019-12-27 14:27:14');
INSERT INTO "public"."sys_captcha" VALUES ('5c417d81-100f-42e3-892e-397bc5464f1d', 'a76xe', '2019-12-25 15:21:07');
INSERT INTO "public"."sys_captcha" VALUES ('6e8cb0ff-27be-4812-8015-2dbee2c80121', 'ygef5', '2019-12-25 15:27:47');
INSERT INTO "public"."sys_captcha" VALUES ('bd0b86c0-1313-4677-8e98-1331d80bad7a', 'gp83e', '2019-12-27 14:47:46');
INSERT INTO "public"."sys_captcha" VALUES ('48c17c17-d000-4694-8305-6c67696c6689', '26fne', '2019-12-25 15:33:52');
INSERT INTO "public"."sys_captcha" VALUES ('21e7ac3c-255c-4fba-85bd-ac44e6687a37', 'nmybf', '2019-12-29 12:58:31');
INSERT INTO "public"."sys_captcha" VALUES ('c701e1f2-53bd-45f7-8a17-3eb4e2d092db', 'yg6fd', '2019-12-25 15:49:09');
INSERT INTO "public"."sys_captcha" VALUES ('ca06c843-9982-4d81-8380-5326ba33a476', 'x72ga', '2019-12-29 12:59:02');
INSERT INTO "public"."sys_captcha" VALUES ('28f031b0-6f61-4f83-8b3e-8cf4ff757257', 'd28xg', '2019-12-25 15:51:05');
INSERT INTO "public"."sys_captcha" VALUES ('67d4c1b3-323a-4e70-8429-c1489ef610f7', '8b5d3', '2019-12-29 13:00:16');
INSERT INTO "public"."sys_captcha" VALUES ('3e2e1c68-e9a8-43b1-82f3-f768b24d7c63', '5n34m', '2019-12-25 15:51:33');
INSERT INTO "public"."sys_captcha" VALUES ('55564823-df2d-4e88-83eb-7a8ff2a34cf7', 'x24pe', '2019-12-29 13:00:20');
INSERT INTO "public"."sys_captcha" VALUES ('3a3a0ccc-3120-4570-89b5-7957b7659415', 'cwyaa', '2019-12-25 15:58:46');
INSERT INTO "public"."sys_captcha" VALUES ('55527368-fb78-42d6-8c45-5ccfd1f2cfa7', '35xce', '2019-12-25 15:58:46');
INSERT INTO "public"."sys_captcha" VALUES ('36b05c89-60fe-446f-81ed-41638e3e37b8', '8yexn', '2019-12-25 16:02:44');
INSERT INTO "public"."sys_captcha" VALUES ('61705224-a036-4c5f-8836-9466b012f8b5', 'cg62d', '2019-12-25 16:06:16');
INSERT INTO "public"."sys_captcha" VALUES ('d11f3d2f-d13a-4081-8077-83a573dede37', '8m24n', '2019-12-25 16:06:48');
INSERT INTO "public"."sys_captcha" VALUES ('66c273d1-9faa-4be8-8311-934ad098b46f', 'ngb37', '2019-12-25 16:08:17');
INSERT INTO "public"."sys_captcha" VALUES ('11c5b174-d3ec-4a60-83c6-2b71e460298c', '3n637', '2019-12-25 16:48:40');
INSERT INTO "public"."sys_captcha" VALUES ('f9f834c9-8a8d-498c-8207-5da4005b7dbd', 'ye7gm', '2019-12-25 16:49:11');
INSERT INTO "public"."sys_captcha" VALUES ('a50fc32f-63fb-4baa-8df1-54af9d1e03bd', 'ax58b', '2019-12-25 16:54:22');
INSERT INTO "public"."sys_captcha" VALUES ('a0969690-3a77-4292-8ec5-2848536b2c19', '5xndn', '2019-12-25 17:06:16');
INSERT INTO "public"."sys_captcha" VALUES ('cb89130b-0b7c-42ea-8c5b-4233fe1a1a34', 'g2awy', '2019-12-25 17:06:38');
INSERT INTO "public"."sys_captcha" VALUES ('680f6798-5554-452d-8627-4b21b65add1c', '45b38', '2019-12-25 17:07:49');
INSERT INTO "public"."sys_captcha" VALUES ('f6094a00-f898-4e4d-8dae-da0ff73dcbc0', 'yfm7x', '2019-12-25 17:08:59');
INSERT INTO "public"."sys_captcha" VALUES ('53a5f1a3-0578-44b0-8e62-f4790b9ad7c6', 'e2gfb', '2019-12-30 14:14:42');
INSERT INTO "public"."sys_captcha" VALUES ('0e254b34-29cd-4921-86ba-5f63d9995647', 'dnpn7', '2019-12-25 17:14:33');
INSERT INTO "public"."sys_captcha" VALUES ('8c899da8-7369-4560-8d48-f87a92903986', 'mdx6f', '2019-12-25 17:16:18');
INSERT INTO "public"."sys_captcha" VALUES ('56874aa5-6ca7-427d-8d30-77cd76b19721', '6e5xb', '2019-12-30 14:25:06');
INSERT INTO "public"."sys_captcha" VALUES ('1dcdff85-1bd6-41eb-8c0a-693ecd587400', '8p4fg', '2019-12-25 17:17:16');
INSERT INTO "public"."sys_captcha" VALUES ('dbabc1f8-5070-4536-8d25-eb3be20b3908', '5f6n5', '2019-12-25 17:17:50');
INSERT INTO "public"."sys_captcha" VALUES ('7749b29a-529e-481f-84d0-3f3078b4836c', '3mp7f', '2019-12-25 17:17:51');
INSERT INTO "public"."sys_captcha" VALUES ('fbb8e6ba-3e28-4825-83f9-22c4d7287e6d', 'nmfnm', '2019-12-30 14:28:35');
INSERT INTO "public"."sys_captcha" VALUES ('595aeb1c-fb4d-400a-81d7-cf4e5217582d', 'b4n2d', '2019-12-25 17:21:41');
INSERT INTO "public"."sys_captcha" VALUES ('a460909a-419c-4328-8647-077f289b7de7', 'b5eec', '2019-12-25 17:23:54');
INSERT INTO "public"."sys_captcha" VALUES ('27234b73-a366-4c29-81d9-f2045ec63d77', '5a683', '2019-12-25 17:25:22');
INSERT INTO "public"."sys_captcha" VALUES ('e1d83005-b3b1-4773-812a-f94ae6539abb', '348nn', '2019-12-25 17:26:53');
INSERT INTO "public"."sys_captcha" VALUES ('e03417bf-1113-4b90-82dd-5612744986f3', '4a24p', '2019-12-25 17:27:28');
INSERT INTO "public"."sys_captcha" VALUES ('00ec8fd7-b61e-4b94-8112-002fb3db0585', 'dybgx', '2019-12-25 17:30:40');
INSERT INTO "public"."sys_captcha" VALUES ('0d305b68-ebcd-4d66-8862-76aaef4ffc0d', 'dg5c4', '2019-12-25 17:48:22');
INSERT INTO "public"."sys_captcha" VALUES ('feac046a-60af-411f-84a4-167cd6d6001a', '5np5n', '2019-12-25 17:56:09');
INSERT INTO "public"."sys_captcha" VALUES ('c7184a03-6d20-4873-8b13-4b7856d0bb1e', 'wcdp4', '2019-12-25 18:01:19');
INSERT INTO "public"."sys_captcha" VALUES ('12721338-66d6-4f69-8944-dc3193244a35', 'pdax8', '2019-12-25 18:09:15');
INSERT INTO "public"."sys_captcha" VALUES ('81c4b41b-3bc0-461a-87cd-fad91b24c4d2', '3ef32', '2019-12-25 18:10:28');
INSERT INTO "public"."sys_captcha" VALUES ('4a812896-bd19-4c48-872e-aa7de9c0efda', '5c2na', '2019-12-25 18:13:55');
INSERT INTO "public"."sys_captcha" VALUES ('0021b6e1-885c-4761-8a4c-405932bb3374', '8nff3', '2019-12-26 08:34:54');
INSERT INTO "public"."sys_captcha" VALUES ('005910a8-a8d4-4ec7-89b1-47a53d14dce8', '4p7aw', '2019-12-30 14:40:56');
INSERT INTO "public"."sys_captcha" VALUES ('8c96b1aa-7520-4dd4-81f3-aa6a57c36953', 'w8p65', '2019-12-26 08:50:56');
INSERT INTO "public"."sys_captcha" VALUES ('c55b71e9-17ce-4ff3-8c03-428716237c75', 'gnb3b', '2019-12-30 16:41:16');
INSERT INTO "public"."sys_captcha" VALUES ('a6793fc5-2719-450e-80a1-17752b17c83a', 'g54g7', '2019-12-31 10:33:22');
INSERT INTO "public"."sys_captcha" VALUES ('ca8bb52a-c5e1-4f43-8bc8-d98945956549', 'npwmw', '2019-12-31 10:33:27');
INSERT INTO "public"."sys_captcha" VALUES ('f1fc4e78-25f3-4aa5-813a-16202636d614', 'nfmwn', '2019-12-31 10:33:31');
INSERT INTO "public"."sys_captcha" VALUES ('a44adddd-a666-49e2-8e93-21501f9a07ea', 'nmdge', '2019-12-26 09:12:45');
INSERT INTO "public"."sys_captcha" VALUES ('13cd2694-3f9a-4630-810c-6b69523561c5', 'b8ne6', '2019-12-26 09:15:00');
INSERT INTO "public"."sys_captcha" VALUES ('65541bf8-2f1c-48a8-8572-bbb92cbd6b22', '8y7pb', '2019-12-26 09:15:01');
INSERT INTO "public"."sys_captcha" VALUES ('fbdf9123-2c79-4f7d-89a9-b6637a40de40', 'np7x7', '2019-12-26 10:13:35');
INSERT INTO "public"."sys_captcha" VALUES ('71fb7577-53d1-4947-851f-02f02dc6b6ce', '8pbnf', '2019-12-26 10:21:02');
INSERT INTO "public"."sys_captcha" VALUES ('4e7cd246-7fe9-4bdc-8cf5-9f54b9a5e984', '754g5', '2019-12-26 10:41:30');
INSERT INTO "public"."sys_captcha" VALUES ('1787559b-e57c-4a67-8731-3f8d22c7e19e', 'n33fc', '2019-12-26 10:47:20');
INSERT INTO "public"."sys_captcha" VALUES ('b0f508ab-2f4a-4ec8-86a1-1ef90052d142', '5pfn3', '2019-12-31 17:49:08');
INSERT INTO "public"."sys_captcha" VALUES ('80d8cb1d-8f68-44b6-8fe9-096f03e83871', '227m3', '2019-12-31 17:58:22');
INSERT INTO "public"."sys_captcha" VALUES ('2391cc13-63ca-40d6-81f4-47b516371661', 'gf3bf', '2019-12-26 11:07:54');
INSERT INTO "public"."sys_captcha" VALUES ('20289ade-9d9d-4252-88a9-fb69353d1791', 'ywcyf', '2019-12-26 11:08:48');
INSERT INTO "public"."sys_captcha" VALUES ('eefea8c9-ac8d-40e1-8f03-ea5ae045d130', 'f8nnd', '2020-01-02 09:39:07');
INSERT INTO "public"."sys_captcha" VALUES ('3fa5a3ae-74ef-4339-8a02-045787cf1517', '36fp5', '2019-12-26 11:09:21');
INSERT INTO "public"."sys_captcha" VALUES ('c260d15f-aeb9-429f-83eb-10a8dba77010', '6f32a', '2020-01-02 15:21:00');
INSERT INTO "public"."sys_captcha" VALUES ('7c1b505f-30b5-44da-898d-973cd4a36e1e', 'wydf6', '2019-12-26 11:11:18');
INSERT INTO "public"."sys_captcha" VALUES ('39535fc4-9330-4151-8c46-1f2169c64dd3', 'fnnw4', '2019-12-26 11:12:07');
INSERT INTO "public"."sys_captcha" VALUES ('984e9871-28f0-4074-8acc-14b8588fabe2', '8y2yf', '2020-01-02 15:54:11');
INSERT INTO "public"."sys_captcha" VALUES ('7351bac7-1497-4a4d-8db2-89f86198babd', '3fgwd', '2019-12-26 11:13:03');
INSERT INTO "public"."sys_captcha" VALUES ('b14c5e42-cc34-4969-80c0-8d4fa1a1a1ca', 'mmw66', '2020-01-02 16:01:32');
INSERT INTO "public"."sys_captcha" VALUES ('9fa85020-dc09-45e2-8ff9-e1eb0280ce14', 'n5we8', '2019-12-26 11:13:49');
INSERT INTO "public"."sys_captcha" VALUES ('19aef715-01c9-47b4-886a-d89ee074f185', 'mfbnm', '2019-12-26 11:14:23');
INSERT INTO "public"."sys_captcha" VALUES ('28e5fe83-e07f-429b-897f-51b250691169', 'n8mw2', '2019-12-26 11:15:33');
INSERT INTO "public"."sys_captcha" VALUES ('ce36fca5-691b-47f9-8be5-c35f57b27219', '6254a', '2020-01-03 15:45:45');
INSERT INTO "public"."sys_captcha" VALUES ('0ba77232-dc70-44ff-827a-4aeb4193351f', 'a723n', '2020-01-03 17:37:36');
INSERT INTO "public"."sys_captcha" VALUES ('bd2fa1cd-4589-4932-8b8e-ebdf98b3c960', 'fmwy3', '2020-01-04 14:13:20');
INSERT INTO "public"."sys_captcha" VALUES ('6e2910a1-df3d-4933-80db-0c07d1e62900', 'a6722', '2020-01-07 10:44:40');
INSERT INTO "public"."sys_captcha" VALUES ('054d2b3f-7ec6-4cbc-8fd4-966bb69ca6f0', 'xbyy8', '2020-01-07 10:54:56');
INSERT INTO "public"."sys_captcha" VALUES ('78b88e20-8d4c-48e2-8204-4640c41c76e8', 'pmdea', '2020-01-07 14:38:35');
INSERT INTO "public"."sys_captcha" VALUES ('ad84f7b8-cf30-4bb1-8fd4-3fd2e90ed475', 'abne2', '2020-01-07 15:09:06');
INSERT INTO "public"."sys_captcha" VALUES ('0e6d8166-3817-4845-835f-9bb4d1ebd82e', '8bcf6', '2020-01-07 16:29:04');
INSERT INTO "public"."sys_captcha" VALUES ('75b00d42-1023-4d54-8a89-70a5eebaf7e8', 'b84np', '2020-01-07 16:32:29');
INSERT INTO "public"."sys_captcha" VALUES ('75f21f33-0f31-4bea-86f6-d138454a7fb2', 'n8wad', '2020-01-07 16:33:17');
INSERT INTO "public"."sys_captcha" VALUES ('4f531a17-319b-4415-84f7-a769dfdb6985', '3e88n', '2020-01-07 16:41:59');
INSERT INTO "public"."sys_captcha" VALUES ('131711cc-9b4e-4f7a-893c-39ce4d4f0f59', 'mfe3d', '2020-03-04 14:23:53');
INSERT INTO "public"."sys_captcha" VALUES ('ae9ee338-493e-4d6f-802a-19b433308788', 'na38f', '2020-03-04 14:23:56');
INSERT INTO "public"."sys_captcha" VALUES ('fed78f99-1e2b-491f-8ab8-3fe059f78d74', 'wdd3g', '2020-03-04 14:24:14');
INSERT INTO "public"."sys_captcha" VALUES ('a2052963-8256-4754-81d7-db464ac09a7c', 'w7n2x', '2020-03-04 14:24:24');
INSERT INTO "public"."sys_captcha" VALUES ('31053d04-db7c-4731-85a4-30a320bd926e', 'n5a8f', '2020-03-04 14:24:27');
INSERT INTO "public"."sys_captcha" VALUES ('12b6a4ff-eb74-4b45-8597-e39868def4e7', 'gcan3', '2020-03-04 14:25:11');
INSERT INTO "public"."sys_captcha" VALUES ('457927eb-aba2-4a67-8c58-7979566a7121', '5aa8y', '2020-03-04 14:25:29');
INSERT INTO "public"."sys_captcha" VALUES ('476814bf-5c69-49ac-8701-78cd545ea51f', '27f2d', '2020-03-04 14:30:08');
INSERT INTO "public"."sys_captcha" VALUES ('aae5f832-9d3e-44d8-86e2-2dd48ba0e037', '2a2nf', '2020-03-04 14:32:25');
INSERT INTO "public"."sys_captcha" VALUES ('8a2693c6-1c99-451e-8482-109ff5b67b71', 'gdpcw', '2020-03-04 14:44:22');
INSERT INTO "public"."sys_captcha" VALUES ('1871f8bc-2626-4b9f-8555-45ef8c847fcb', '84gmx', '2020-03-04 14:47:42');
INSERT INTO "public"."sys_captcha" VALUES ('866acd05-1130-4f93-8778-7d892c1597c0', 'd3252', '2020-03-04 14:50:55');
INSERT INTO "public"."sys_captcha" VALUES ('cd4161df-d457-4dbb-857d-c3b1d4bf4fb5', 'pc364', '2020-01-20 18:03:56');
INSERT INTO "public"."sys_captcha" VALUES ('004825c4-4e78-49a0-8f59-994fe9e378cc', 'gd7xc', '2020-03-04 16:09:22');
INSERT INTO "public"."sys_captcha" VALUES ('b66deb84-68ba-440d-8677-d35b57f08a37', '525ne', '2020-01-21 09:17:28');
INSERT INTO "public"."sys_captcha" VALUES ('ae13ebd6-caa8-4a53-8185-5abb6f777aad', 'ap8y2', '2020-01-21 09:19:02');
INSERT INTO "public"."sys_captcha" VALUES ('4703f2ab-cd29-41c5-8789-c4091ee16d8a', 'w2w37', '2020-01-21 09:29:33');
INSERT INTO "public"."sys_captcha" VALUES ('e4e31d52-5044-403c-8fee-ddf22fe7bf39', 'xn5ep', '2020-01-21 09:48:00');
INSERT INTO "public"."sys_captcha" VALUES ('74b746de-2d26-4760-8195-94c204c80228', 'fb6ea', '2020-01-21 10:08:38');
INSERT INTO "public"."sys_captcha" VALUES ('f9a96d0a-492a-4824-82e8-6548a994c1dd', '4gb8w', '2020-01-21 10:26:52');
INSERT INTO "public"."sys_captcha" VALUES ('1c41c339-c8c6-488c-8910-301f0b347fab', '6myy6', '2020-01-21 10:49:57');
INSERT INTO "public"."sys_captcha" VALUES ('6dba76da-a2ec-47d0-8c3d-091786235e54', 'ymmcp', '2020-01-21 10:50:52');
INSERT INTO "public"."sys_captcha" VALUES ('e3531462-478f-424b-8f13-640d6b8a2911', 'mfe6p', '2020-01-21 10:55:24');
INSERT INTO "public"."sys_captcha" VALUES ('1a768572-0233-4c68-8f5a-2ddd97fe3d42', 'f4bgd', '2020-01-21 11:33:15');
INSERT INTO "public"."sys_captcha" VALUES ('7a0274bb-7129-499c-82d8-9459632da4e5', '8we3w', '2020-01-21 14:04:18');
INSERT INTO "public"."sys_captcha" VALUES ('37c145ec-dbc0-4bc7-84fb-cf581e36a1d9', 'mcw6x', '2020-01-21 14:32:50');
INSERT INTO "public"."sys_captcha" VALUES ('bd4ba15e-5250-4020-82d5-e1f0aecdc6d6', 'enpbx', '2020-01-21 15:54:29');
INSERT INTO "public"."sys_captcha" VALUES ('dfb88dd7-d8b0-4f5d-8138-fd903354f97c', '46ydn', '2020-01-21 16:30:25');
INSERT INTO "public"."sys_captcha" VALUES ('e06e9f76-1f57-4971-8575-a29fe4a14627', 'dmm7e', '2020-01-21 16:47:35');
INSERT INTO "public"."sys_captcha" VALUES ('b8218612-e5dc-4d48-83ad-326ee81479ef', '5eex4', '2020-01-21 16:56:45');
INSERT INTO "public"."sys_captcha" VALUES ('9b8edeed-89c7-40b1-8ad5-7a8668613212', 'bdpyw', '2020-01-21 17:18:13');
INSERT INTO "public"."sys_captcha" VALUES ('a7214929-80c5-4f10-8094-ce175fc1961a', 'wcfd3', '2020-01-22 14:28:42');
INSERT INTO "public"."sys_captcha" VALUES ('a2d85707-bb22-489d-8d3d-8a09679f430a', 'nmagy', '2020-01-22 14:28:50');
INSERT INTO "public"."sys_captcha" VALUES ('82213c54-f696-4841-835c-c9b540f7e7bc', 'c2a5g', '2020-01-22 15:13:36');
INSERT INTO "public"."sys_captcha" VALUES ('22e1c658-a581-428b-8133-2d8d84f2e31e', 'cp2f5', '2020-01-22 18:13:02');
INSERT INTO "public"."sys_captcha" VALUES ('66598d04-3208-4d42-8a8a-6b5d08f5e489', 'p883d', '2020-01-22 18:14:43');
INSERT INTO "public"."sys_captcha" VALUES ('312249a5-6034-4825-845f-9eeb15a7252c', 'y7cbp', '2020-01-22 18:35:14');
INSERT INTO "public"."sys_captcha" VALUES ('99e92918-47e4-409d-8769-f0fc1576352f', 'b28na', '2020-01-23 14:45:41');
INSERT INTO "public"."sys_captcha" VALUES ('be9def6f-19cd-4234-8ced-e54c143421bc', '53p66', '2020-01-31 21:50:37');
INSERT INTO "public"."sys_captcha" VALUES ('dd356972-c26e-48b5-8ea3-9945a29aa874', 'nnp4a', '2020-01-31 21:52:39');
INSERT INTO "public"."sys_captcha" VALUES ('0f888df7-8695-42f6-8cb8-ce55edbd9421', 'gp2e3', '2020-01-31 21:53:23');
INSERT INTO "public"."sys_captcha" VALUES ('8a7accbe-7a8f-4600-8781-7912543824a6', 'c34y7', '2020-01-31 21:59:45');
INSERT INTO "public"."sys_captcha" VALUES ('84ef330d-4b9a-413a-8a40-2791da87ff50', 'f7n7a', '2020-01-31 22:03:01');
INSERT INTO "public"."sys_captcha" VALUES ('a8f104a9-0694-4892-8962-26762347f8e0', 'ww3f6', '2020-01-31 22:06:08');
INSERT INTO "public"."sys_captcha" VALUES ('a168df0c-8234-4cfa-865c-4ef464cb3069', 'faana', '2020-01-31 22:31:13');
INSERT INTO "public"."sys_captcha" VALUES ('8aa20714-c609-4be2-8672-8907dee4c08a', 'pbfya', '2020-01-31 22:31:14');
INSERT INTO "public"."sys_captcha" VALUES ('7927d670-bb42-4e48-8001-5ebd44723e05', '634fb', '2020-02-12 23:26:24');
INSERT INTO "public"."sys_captcha" VALUES ('429b33c9-faa0-48ae-80aa-bafc51a0667d', 'a7374', '2020-02-12 23:26:25');
INSERT INTO "public"."sys_captcha" VALUES ('ea67d4c1-0766-42d4-810a-09358d61fb28', 'n8bde', '2020-02-13 12:37:34');
INSERT INTO "public"."sys_captcha" VALUES ('1d61cfc7-6425-471f-8e43-1ea8ee83e9a3', 'bn24x', '2020-02-13 12:38:30');
INSERT INTO "public"."sys_captcha" VALUES ('f35a5172-8716-4d81-87ee-daf3aea4c8a5', '33fcb', '2020-02-13 13:45:54');
INSERT INTO "public"."sys_captcha" VALUES ('a69ff419-d21f-434b-80fe-8c1791cb8e92', '48nyx', '2020-02-13 14:06:17');
INSERT INTO "public"."sys_captcha" VALUES ('a5f18241-e698-4966-8fb5-5256eb70c331', 'n4m86', '2020-02-13 19:23:29');
INSERT INTO "public"."sys_captcha" VALUES ('9e8d6ba4-4a28-4fd4-8c12-d68e95dfd326', '58b23', '2020-02-14 10:37:19');
INSERT INTO "public"."sys_captcha" VALUES ('5c3910bc-8b82-498e-86ae-f42e5f4d5287', 'fpbb6', '2020-02-16 09:37:42');
INSERT INTO "public"."sys_captcha" VALUES ('b429be4d-2629-4c95-8e32-ae38001912e8', '422ac', '2020-02-16 09:45:15');
INSERT INTO "public"."sys_captcha" VALUES ('aca3570c-0bc5-49cf-8542-ded4eee03ec3', 'cnww2', '2020-02-16 09:45:15');
INSERT INTO "public"."sys_captcha" VALUES ('73b97d92-ddfa-49d3-81ca-0284b2e177ba', '4ee6a', '2020-02-16 10:28:31');
INSERT INTO "public"."sys_captcha" VALUES ('560ee8f0-acab-4f8a-81d0-4b0cef1e08b2', 'a5fef', '2020-02-16 10:28:36');
INSERT INTO "public"."sys_captcha" VALUES ('294e6afb-33eb-4442-82e5-895ab2085fea', 'wxwfc', '2020-02-16 10:29:54');
INSERT INTO "public"."sys_captcha" VALUES ('100bb058-ba6f-42fe-8b52-aeab5151a21e', 'bm67a', '2020-02-16 10:37:08');
INSERT INTO "public"."sys_captcha" VALUES ('4c030c59-90a1-4af0-880a-049509237861', '2aeyn', '2020-02-16 11:29:44');
INSERT INTO "public"."sys_captcha" VALUES ('4cba23ac-1ce4-42c5-83e5-96e916a6a301', 'd4n8f', '2020-02-16 15:25:06');
INSERT INTO "public"."sys_captcha" VALUES ('ebdd82ea-aa71-4019-83d5-79ec77e408ee', 'b22p6', '2020-02-16 18:53:48');
INSERT INTO "public"."sys_captcha" VALUES ('0bdb1187-76ab-4d0f-8d05-83cb87b74a8c', 'xd426', '2020-02-17 07:54:51');
INSERT INTO "public"."sys_captcha" VALUES ('9690ddf1-88ee-45e0-87f9-61d16320ce49', 'p3pmg', '2020-02-17 08:30:13');
INSERT INTO "public"."sys_captcha" VALUES ('ccb09fae-7a53-496a-8328-0465678643b2', 'p6y85', '2020-02-19 15:39:42');
INSERT INTO "public"."sys_captcha" VALUES ('9c7ae711-b7d9-4805-8710-9c4ad10b582d', '3xa88', '2020-02-19 15:39:49');
INSERT INTO "public"."sys_captcha" VALUES ('8fba5ae8-9f1c-4bcc-823f-0da344adb8e5', '7pcbn', '2020-02-19 15:43:10');
INSERT INTO "public"."sys_captcha" VALUES ('d2478503-d41b-4e40-81ed-a64598a1bcb2', 'an74w', '2020-02-19 15:43:25');
INSERT INTO "public"."sys_captcha" VALUES ('ff33233e-92ef-4878-8cf3-87e6609d157b', '4d28n', '2020-02-24 09:58:00');
INSERT INTO "public"."sys_captcha" VALUES ('a98f4e37-6e35-4631-8b07-a11c05a0044b', 'naaen', '2020-02-24 18:47:27');
INSERT INTO "public"."sys_captcha" VALUES ('ec050306-f0b7-471c-8a07-b191f64a8718', '88ng2', '2020-02-24 18:47:29');
INSERT INTO "public"."sys_captcha" VALUES ('ae20e2ba-90d7-41d7-8604-c70f70e12a83', 'ebncf', '2020-02-24 23:32:56');
INSERT INTO "public"."sys_captcha" VALUES ('76c39fd3-2468-431d-89c1-7572853c6437', '7y3nn', '2020-02-25 01:05:31');
INSERT INTO "public"."sys_captcha" VALUES ('d9f9caea-e6fd-4b9b-88cd-6d61a05196ee', 'y4wab', '2020-02-25 10:27:06');
INSERT INTO "public"."sys_captcha" VALUES ('f9d9281b-02a2-4a78-8ca5-1ca60a07cc54', 'a2dnb', '2020-02-25 10:36:07');
INSERT INTO "public"."sys_captcha" VALUES ('809279d9-cc73-4a5b-8362-b1eb18252ef1', 'n68nx', '2020-02-25 11:45:39');
INSERT INTO "public"."sys_captcha" VALUES ('acdd5ac1-e021-45ef-8098-7c58762450a8', 'dgmey', '2020-02-25 11:47:37');
INSERT INTO "public"."sys_captcha" VALUES ('8c73b8c4-7fd1-4479-8657-49f58b4654c2', 'm32bb', '2020-02-25 12:34:55');
INSERT INTO "public"."sys_captcha" VALUES ('bd541da3-e256-49bb-8c72-4fce8076f45c', 'p54m5', '2020-02-25 12:34:56');
INSERT INTO "public"."sys_captcha" VALUES ('25987410-8a6f-4869-8ab6-0296ddb8b919', 'nden8', '2020-02-25 12:34:56');
INSERT INTO "public"."sys_captcha" VALUES ('84f1cdfa-514f-4fa4-8600-f563cb60b36e', '4e2m6', '2020-02-25 18:34:18');
INSERT INTO "public"."sys_captcha" VALUES ('8ab570f0-31bc-49dc-8d35-dc7a5ca4082c', 'e4y73', '2020-02-25 18:40:55');
INSERT INTO "public"."sys_captcha" VALUES ('ab9745c3-232c-4190-8ff6-6813b24732c9', 'pw4nb', '2020-02-25 18:41:33');
INSERT INTO "public"."sys_captcha" VALUES ('bae5e1cb-0eb7-40fa-8ea4-db27e76a2888', 'xfgp3', '2020-02-28 16:52:53');
INSERT INTO "public"."sys_captcha" VALUES ('dfd7cb07-34db-485e-8754-db82fc5cb3b5', '67g26', '2020-03-04 14:23:49');
INSERT INTO "public"."sys_captcha" VALUES ('c2c69aeb-b343-4b80-800c-5fb8617c3064', 'y36wc', '2020-03-04 14:24:02');
INSERT INTO "public"."sys_captcha" VALUES ('47aa87d1-0adf-484d-800b-c11c07920bf5', 'ca786', '2020-02-28 17:24:33');
INSERT INTO "public"."sys_captcha" VALUES ('26ce7873-c3e6-45fa-8e17-51db66b7222b', 'xcama', '2020-03-04 14:24:08');
INSERT INTO "public"."sys_captcha" VALUES ('32355fbf-d1b3-4346-87c0-b02bafa91c0f', 'e2afx', '2020-03-04 14:24:41');
INSERT INTO "public"."sys_captcha" VALUES ('4d0d75b6-15c2-4330-858d-e991370798c1', '82fn7', '2020-02-28 17:46:27');
INSERT INTO "public"."sys_captcha" VALUES ('a527ae64-009d-45b7-8b7a-4c6cd6ea2e19', '6fxa2', '2020-03-04 14:24:43');
INSERT INTO "public"."sys_captcha" VALUES ('b226540e-b7ee-4a38-830f-492e93dc3921', 'fdn8b', '2020-03-04 14:24:47');
INSERT INTO "public"."sys_captcha" VALUES ('882ed506-8c52-45a8-8e4b-1e0111af5735', 'pfngn', '2020-02-28 17:48:49');
INSERT INTO "public"."sys_captcha" VALUES ('9e2997c9-6d43-4617-888c-0ca9fa2cc963', 'cbd2d', '2020-03-04 14:24:49');
INSERT INTO "public"."sys_captcha" VALUES ('e011162d-049f-4980-88b0-a070ec80fec2', '7f2nf', '2020-03-04 14:31:00');
INSERT INTO "public"."sys_captcha" VALUES ('53be2a19-4423-40ef-8f27-f2003ee760c1', 'xxgee', '2020-03-02 10:29:25');
INSERT INTO "public"."sys_captcha" VALUES ('5b91d126-6f35-4191-8ef6-78b88b41c6cb', 'pyfyw', '2020-03-04 14:48:39');
INSERT INTO "public"."sys_captcha" VALUES ('82b21fd2-4305-417b-8e90-7b9393281f1e', '7w8pd', '2020-03-04 15:18:28');
INSERT INTO "public"."sys_captcha" VALUES ('9dc06475-1b65-4368-8571-d022020a49c0', '33d2w', '2020-03-02 12:19:08');
INSERT INTO "public"."sys_captcha" VALUES ('2f2cf119-eb85-44be-856b-a857dbfbdcb2', 'pw4y3', '2020-03-04 15:31:16');
INSERT INTO "public"."sys_captcha" VALUES ('b8ddbd39-6a46-4ba9-84c6-76ce9c82bdd1', 'g556g', '2020-03-04 15:59:23');
INSERT INTO "public"."sys_captcha" VALUES ('94d2ad93-5650-43cd-80c0-d8fe9a7dd223', 'dnpdx', '2020-03-04 16:12:41');
INSERT INTO "public"."sys_captcha" VALUES ('ea3f2514-2a2d-46f6-8fa2-93f05e1b3bd9', '8ypy3', '2020-03-04 16:16:11');
INSERT INTO "public"."sys_captcha" VALUES ('59333cc9-4b0d-484c-86d3-a7dda089545f', 'caxx5', '2020-03-04 16:16:14');
INSERT INTO "public"."sys_captcha" VALUES ('11cbb93d-dda4-4586-8e4e-2799d8fe30e7', '6n5bb', '2020-03-02 13:49:24');
INSERT INTO "public"."sys_captcha" VALUES ('0e47af16-835e-4d2b-82c4-f0b08e7ab264', 'n4xd4', '2020-03-04 16:33:34');
INSERT INTO "public"."sys_captcha" VALUES ('1292cee2-a58d-46b2-8ff8-b9fc3a6f4b92', 'efw65', '2020-03-02 14:13:39');
INSERT INTO "public"."sys_captcha" VALUES ('92cfd737-e23e-440a-806d-49f570e4eff4', 'mxcn5', '2020-03-04 16:34:39');
INSERT INTO "public"."sys_captcha" VALUES ('04b4898e-2731-449b-8250-0e0c3c6b26eb', 'ce8ef', '2020-03-02 17:56:22');
INSERT INTO "public"."sys_captcha" VALUES ('596d4dfb-9430-4a7e-804e-83dc93413335', 'mcgmd', '2020-03-04 16:44:13');
INSERT INTO "public"."sys_captcha" VALUES ('9cc61ff2-5a81-44a8-869e-096612afd1e8', '72de2', '2020-03-04 16:44:24');
INSERT INTO "public"."sys_captcha" VALUES ('91aeb50b-54b9-4567-8f1a-49f63d01b177', 'mwp3m', '2020-03-04 16:45:35');
INSERT INTO "public"."sys_captcha" VALUES ('2e97353b-b247-49a2-8ef7-3a1bbda8f481', '2fen5', '2020-03-04 16:52:17');
INSERT INTO "public"."sys_captcha" VALUES ('15e8d744-5935-4765-8876-71ac9b52286d', 'd5cfm', '2020-03-04 16:54:02');
INSERT INTO "public"."sys_captcha" VALUES ('d206ee7d-94a7-4655-8716-e18504921773', 'em4dx', '2020-03-04 16:54:20');
INSERT INTO "public"."sys_captcha" VALUES ('6e3dbd04-5d99-4b24-85dc-9c27ebfd8122', 'gfnmy', '2020-03-04 17:00:29');
INSERT INTO "public"."sys_captcha" VALUES ('f7ac4f1f-56e5-473b-8c2a-380a4c830f6f', 'pn7e4', '2020-03-04 17:01:29');
INSERT INTO "public"."sys_captcha" VALUES ('edeeb499-d9e6-4b7e-8e91-eedd82816a1d', '53wpa', '2020-03-04 17:01:32');
INSERT INTO "public"."sys_captcha" VALUES ('970489ce-f431-4545-8790-5a9fc70b463a', 'ynpmn', '2020-03-04 17:01:55');
INSERT INTO "public"."sys_captcha" VALUES ('90010afa-c386-4744-86f0-4632085e7f7e', 'cnfxf', '2020-03-04 09:58:14');
INSERT INTO "public"."sys_captcha" VALUES ('689718e0-47c7-4971-8735-32d86fd7c833', 'nn3b6', '2020-03-04 17:02:11');
INSERT INTO "public"."sys_captcha" VALUES ('7790e88f-74eb-4ccb-81ca-507353342c74', 'mfebw', '2020-03-04 17:03:51');
INSERT INTO "public"."sys_captcha" VALUES ('b99dbf54-0acb-467e-8f8f-228d6b506207', 'w7xcx', '2020-03-04 10:27:38');
INSERT INTO "public"."sys_captcha" VALUES ('916dba31-792f-4e01-8d39-1e3f62490813', 'ynymf', '2020-03-04 17:09:49');
INSERT INTO "public"."sys_captcha" VALUES ('59d9fefe-b1e2-4446-8de3-3159268eada4', '34mfw', '2020-03-04 17:09:54');
INSERT INTO "public"."sys_captcha" VALUES ('faf07132-e56a-46e8-89b2-f0f89b46c277', 'ngd8p', '2020-03-04 17:10:00');
INSERT INTO "public"."sys_captcha" VALUES ('151ce7c8-4d47-4559-85ae-9aa7de90fdde', 'x5c5c', '2020-03-04 17:11:52');
INSERT INTO "public"."sys_captcha" VALUES ('97c9d612-9810-474a-8fd7-09ebf080efdc', 'yy7ye', '2020-03-04 17:13:20');
INSERT INTO "public"."sys_captcha" VALUES ('12464a4c-a1b9-4317-8dd8-d8d21b83132c', 'ffxn8', '2020-03-04 17:13:23');
INSERT INTO "public"."sys_captcha" VALUES ('e7bd26b8-fb4c-4b9f-81db-b08b25803353', 'p4gde', '2020-03-04 17:13:37');
INSERT INTO "public"."sys_captcha" VALUES ('40d136b0-8637-429f-8df2-74330cebd534', 'cxm5m', '2020-03-04 17:14:56');
INSERT INTO "public"."sys_captcha" VALUES ('05d9e36c-4c4d-4c58-85cb-64beeb060bf1', 'ca7p8', '2020-03-04 17:14:59');
INSERT INTO "public"."sys_captcha" VALUES ('b391d569-e66b-421b-8fd5-58a353dd8406', 'mcb5g', '2020-03-04 17:15:08');
INSERT INTO "public"."sys_captcha" VALUES ('1c5a6131-83f6-4cd0-8840-a15f365dcbda', 'ae4f4', '2020-03-04 17:15:14');
INSERT INTO "public"."sys_captcha" VALUES ('d19c2c9c-3669-4d69-8f26-f77428947450', 'xggnw', '2020-03-04 17:15:27');
INSERT INTO "public"."sys_captcha" VALUES ('e4536f8e-8fa2-443d-8c6c-412772a73370', 'gp6dg', '2020-03-04 17:15:29');
INSERT INTO "public"."sys_captcha" VALUES ('22d1af1f-678a-4f2f-8fca-e6b460cebf70', '4ww78', '2020-03-04 17:15:32');
INSERT INTO "public"."sys_captcha" VALUES ('9642f298-88f3-4bdd-8be6-7316141d82d9', 'bacd8', '2020-03-04 17:15:39');
INSERT INTO "public"."sys_captcha" VALUES ('059a56ca-0248-4b05-8d17-8131e27f3faa', 'wx2df', '2020-03-04 17:17:21');
INSERT INTO "public"."sys_captcha" VALUES ('d28c9888-6b9f-42ac-82aa-ba07a505c79b', 'wn8bn', '2020-03-04 17:19:18');
INSERT INTO "public"."sys_captcha" VALUES ('0cf45b9a-d433-4cae-85c2-d4597808ea79', 'b73nn', '2020-03-04 17:20:38');
INSERT INTO "public"."sys_captcha" VALUES ('66318fd6-ee32-4c5d-8af1-6c1c532c3cac', '5fw6p', '2020-03-04 17:21:10');
INSERT INTO "public"."sys_captcha" VALUES ('67c29cc6-f6e2-4518-8252-5fc8128366a0', 'gcbce', '2020-03-04 17:21:50');
INSERT INTO "public"."sys_captcha" VALUES ('2bed0cf8-295b-4dd1-8eee-e1f8783d8787', '57n4f', '2020-03-04 17:21:53');
INSERT INTO "public"."sys_captcha" VALUES ('4f20a355-6a3c-4623-8ba6-4f35de31e86b', '5w52m', '2020-03-04 13:44:29');
INSERT INTO "public"."sys_captcha" VALUES ('b88549d9-c0fe-415a-83ac-b2753d57535a', '34fa4', '2020-03-04 17:22:07');
INSERT INTO "public"."sys_captcha" VALUES ('39cda348-2355-43ad-8029-392b25c62077', '7n3e8', '2020-03-04 17:50:25');
INSERT INTO "public"."sys_captcha" VALUES ('05fd0692-21a9-40fb-8db3-a19d53f9c094', '56myw', '2020-03-04 17:54:42');
INSERT INTO "public"."sys_captcha" VALUES ('8a180ac2-6cee-427c-8fd6-f1d5ce885bee', 'e5cpa', '2020-03-04 18:00:25');
INSERT INTO "public"."sys_captcha" VALUES ('bbabd659-5f4c-4d0a-860e-b97393fea05d', 'a4365', '2020-03-05 08:52:00');
INSERT INTO "public"."sys_captcha" VALUES ('95f83686-7ec4-4878-8167-c79575ff94a9', 'g752n', '2020-03-05 09:28:15');
INSERT INTO "public"."sys_captcha" VALUES ('f2956589-c699-45fd-837e-29e32032083c', '6xb2c', '2020-03-06 11:12:11');
INSERT INTO "public"."sys_captcha" VALUES ('9486bafd-6c59-4380-8d37-5c99ffe2a9f1', 'nwgpd', '2020-03-07 09:12:41');
INSERT INTO "public"."sys_captcha" VALUES ('a867ffdf-0e7a-4e32-8d0f-5579e5fbf4ef', 'dnc55', '2020-03-07 09:13:29');
INSERT INTO "public"."sys_captcha" VALUES ('25bf9369-0f4a-4b83-8fbf-dc34d54d4220', 'nng7p', '2020-03-07 10:10:40');
INSERT INTO "public"."sys_captcha" VALUES ('a07d5d42-5e1f-4815-8902-58f113d3b0ee', 'm5335', '2020-03-07 10:11:39');
INSERT INTO "public"."sys_captcha" VALUES ('37311c3e-fc6b-4c58-81f3-037d30b728df', 'xd7x8', '2020-03-07 14:53:42');
INSERT INTO "public"."sys_captcha" VALUES ('4067f9be-39df-4548-8ed2-8e9e241a6ae5', 'n8g78', '2020-03-09 09:48:57');
INSERT INTO "public"."sys_captcha" VALUES ('377284f8-b254-48cf-88fe-0f7eca7b1529', '7f8ge', '2020-03-09 10:01:24');
INSERT INTO "public"."sys_captcha" VALUES ('53d9eb55-26bc-4d65-84c3-b53590cd3be3', 'ap82f', '2020-03-10 10:49:40');
INSERT INTO "public"."sys_captcha" VALUES ('0a4fec00-cf48-44e9-8488-d78c798229a1', 'b8pa6', '2020-03-10 10:54:22');
INSERT INTO "public"."sys_captcha" VALUES ('1dc9130e-3ea6-4fa4-8906-5ebe0fc3f774', 'gyn3m', '2020-03-12 17:29:45');
INSERT INTO "public"."sys_captcha" VALUES ('d21eeabd-1485-4603-8059-6b7e5719b677', 'bg3c2', '2020-03-13 16:56:48');
INSERT INTO "public"."sys_captcha" VALUES ('5ce7df43-02f3-4d0f-86b7-d3c4acaeba08', 'n5ape', '2020-03-13 17:56:07');
INSERT INTO "public"."sys_captcha" VALUES ('7eb54fd4-c3ee-4012-8eb0-8e2ba478eaa7', 'na6x6', '2020-03-14 13:54:12');
INSERT INTO "public"."sys_captcha" VALUES ('b8547b46-1e5b-4242-8534-c9d4259d5f15', 'd76ww', '2020-03-14 16:26:03');
INSERT INTO "public"."sys_captcha" VALUES ('44885f53-52ca-484f-85d2-57dbde0741b5', 'd7m56', '2020-03-14 16:32:12');
INSERT INTO "public"."sys_captcha" VALUES ('01ad8622-3d29-4b52-8324-8aa96d89771b', '3by5m', '2020-03-14 16:57:15');
INSERT INTO "public"."sys_captcha" VALUES ('29b0cf3f-ca04-4bbf-8c38-112f068db342', '8p682', '2020-03-14 16:58:07');
INSERT INTO "public"."sys_captcha" VALUES ('bf4abb0e-374d-4ec7-8845-8d16eb7e07ae', 'nm28a', '2020-03-14 16:59:50');
INSERT INTO "public"."sys_captcha" VALUES ('6081ef9d-7766-41c9-863c-2eabaec02962', 'xygd8', '2020-03-14 17:14:15');
INSERT INTO "public"."sys_captcha" VALUES ('b03994ce-e67d-4b00-810c-7a8aae9485d8', 'cy6nn', '2020-03-14 17:48:04');
INSERT INTO "public"."sys_captcha" VALUES ('32a60218-874c-4f42-8b67-dd2e8788ec05', 'mdy6x', '2020-03-14 17:54:42');
INSERT INTO "public"."sys_captcha" VALUES ('53d09ffe-ce00-4fa6-849f-db330c7f29dc', 'xnpeg', '2020-03-14 17:57:35');
INSERT INTO "public"."sys_captcha" VALUES ('6b4f9967-156c-4cd7-8d79-a82fc040e062', 'gedew', '2020-03-14 18:07:21');
INSERT INTO "public"."sys_captcha" VALUES ('001bcd09-5826-46e7-8868-dcc6e4762716', 'n4ddc', '2020-03-14 18:07:24');
INSERT INTO "public"."sys_captcha" VALUES ('85f41642-8047-4547-8945-5b51256bc588', 'gdedp', '2020-03-14 18:07:46');
INSERT INTO "public"."sys_captcha" VALUES ('dd776d3f-a34c-452e-85c4-c8f056ba4540', 'gabma', '2020-03-14 18:09:55');
INSERT INTO "public"."sys_captcha" VALUES ('80d2aee5-5aa9-47eb-899a-f993949ece2b', 'ym4ge', '2020-03-16 09:12:56');
INSERT INTO "public"."sys_captcha" VALUES ('32a707d1-1f57-42fd-8b5b-e0480732f85a', '3fcp8', '2020-03-16 09:22:53');
INSERT INTO "public"."sys_captcha" VALUES ('a7ea946f-0086-4851-85dd-7e536d63fb89', 'dyff4', '2020-03-16 09:28:53');
INSERT INTO "public"."sys_captcha" VALUES ('a094c3bc-24c6-45ba-8ea3-b7ad5a70dce0', '55ad2', '2020-03-16 10:15:40');
INSERT INTO "public"."sys_captcha" VALUES ('ba8e699c-3a10-4013-8265-50647a035f3a', 'd7833', '2020-03-16 10:25:07');
INSERT INTO "public"."sys_captcha" VALUES ('e87bc749-221d-43f0-80c2-686c2a3a1a31', 'fgye6', '2020-03-16 10:25:07');
INSERT INTO "public"."sys_captcha" VALUES ('91b6559e-a771-48f2-8d14-26e18861c1ab', '6ydn4', '2020-03-16 10:31:32');
INSERT INTO "public"."sys_captcha" VALUES ('44490083-363d-4178-8824-da87533b429f', 'bmn8y', '2020-03-16 10:34:49');
INSERT INTO "public"."sys_captcha" VALUES ('b9986e00-cf6d-4d46-8b64-0ed0334569b7', 'nxx8m', '2020-03-16 10:35:26');
INSERT INTO "public"."sys_captcha" VALUES ('2995799d-3edc-4430-89ca-839652748b68', 'd3xm3', '2020-03-16 10:37:12');
INSERT INTO "public"."sys_captcha" VALUES ('6ca765bf-2bef-479c-8bf4-a97f65886941', 'f4cy6', '2020-03-16 10:37:54');
INSERT INTO "public"."sys_captcha" VALUES ('0ecb8785-bc3c-4920-8468-c39c8f61172f', 'fxpx6', '2020-03-16 10:39:25');
INSERT INTO "public"."sys_captcha" VALUES ('7be9dd2b-c95f-4de1-8cd1-bf5c5eba125f', '8bnxd', '2020-03-16 10:40:04');
INSERT INTO "public"."sys_captcha" VALUES ('eb77ea0e-d67b-46da-8e27-8b924bf37936', '8pnae', '2020-03-16 10:40:28');
INSERT INTO "public"."sys_captcha" VALUES ('93333acb-70d7-4e9f-87e8-569bfa2a6c59', '7xaf5', '2020-03-16 10:40:35');
INSERT INTO "public"."sys_captcha" VALUES ('1cc2fb08-faf0-47f6-87f6-579ebcaf8ed4', '38bxd', '2020-03-16 10:40:50');
INSERT INTO "public"."sys_captcha" VALUES ('dba2b5d6-dd41-49a5-8c21-40a4271c5b2c', 'nwdxe', '2020-03-16 10:40:53');
INSERT INTO "public"."sys_captcha" VALUES ('af9be72a-ff4c-490d-8450-0dd491313bc5', 'cpd6p', '2020-03-16 10:41:05');
INSERT INTO "public"."sys_captcha" VALUES ('ad60223c-2c1c-4e71-8eae-f0e3989340df', '5n2a6', '2020-03-16 10:41:30');
INSERT INTO "public"."sys_captcha" VALUES ('e865b8eb-c229-4ed7-8029-6e743aede4b7', '7b83b', '2020-03-16 10:41:33');
INSERT INTO "public"."sys_captcha" VALUES ('d00cb1a5-2463-43f5-8686-10c8b51c9506', 'an3n8', '2020-03-16 10:42:52');
INSERT INTO "public"."sys_captcha" VALUES ('8f160abe-0af3-40a2-8371-719263f5740b', '6emnn', '2020-03-16 10:43:01');
INSERT INTO "public"."sys_captcha" VALUES ('65ea63d5-53eb-4e4c-886b-4c3eb0039881', 'xa4en', '2020-03-16 10:43:14');
INSERT INTO "public"."sys_captcha" VALUES ('406ef903-962b-47f0-8e1a-eda77b92e31c', 'bfnbg', '2020-03-16 10:43:21');
INSERT INTO "public"."sys_captcha" VALUES ('ddb0a47d-dcb9-4760-8a3b-50013cb2622e', 'bwcen', '2020-03-16 10:59:26');
INSERT INTO "public"."sys_captcha" VALUES ('6cb95ab3-3896-413e-8a5e-aa91c80193c8', 'enxn6', '2020-03-16 10:59:46');
INSERT INTO "public"."sys_captcha" VALUES ('cf382336-a5b8-4569-881d-ffe9c8e2844d', 'nwdwn', '2020-03-16 11:01:16');
INSERT INTO "public"."sys_captcha" VALUES ('bfd3e07f-9b94-47db-8ae7-b634a0a46a4a', 'g3a3b', '2020-03-16 11:05:14');
INSERT INTO "public"."sys_captcha" VALUES ('fef9c20b-3f1f-4e85-860f-3660d01e5958', 'e6m72', '2020-03-16 11:05:27');
INSERT INTO "public"."sys_captcha" VALUES ('f43bc097-d719-4834-8e26-9f3806119c0b', 'dapx4', '2020-03-16 11:48:15');
INSERT INTO "public"."sys_captcha" VALUES ('a092f117-d150-4b62-89fd-ba367a7aea69', '563af', '2020-03-16 11:50:12');
INSERT INTO "public"."sys_captcha" VALUES ('d9a1fd59-2f2e-4464-8417-c561a9af4da5', 'm46f5', '2020-03-16 11:57:04');
INSERT INTO "public"."sys_captcha" VALUES ('5a7f2fa7-6032-486c-847a-4f3b845f1da6', 'g76y5', '2020-03-16 11:59:55');
INSERT INTO "public"."sys_captcha" VALUES ('d36dadd8-6346-4297-86ba-49572535d947', 'w48w2', '2020-03-16 15:52:04');
INSERT INTO "public"."sys_captcha" VALUES ('554513e3-ca51-44ee-8853-0b575e858f32', 'gyyym', '2020-03-16 15:53:57');
INSERT INTO "public"."sys_captcha" VALUES ('a5bb65fc-85cd-47e7-8931-cca1f84295f5', 'wa773', '2020-03-16 16:18:53');
INSERT INTO "public"."sys_captcha" VALUES ('9a92f79a-fc97-403e-817a-03062d82a728', '3deb6', '2020-03-16 16:42:49');
INSERT INTO "public"."sys_captcha" VALUES ('1863d813-6bde-481c-8e74-02a73d3e41ae', 'mydfp', '2020-03-16 16:57:27');
INSERT INTO "public"."sys_captcha" VALUES ('582525c2-f6cf-4647-8c7e-b46dbb281ddc', 'pff3m', '2020-03-16 17:00:04');
INSERT INTO "public"."sys_captcha" VALUES ('7e39d412-2e9e-4d97-8ea7-48caf9226ee7', '72n5b', '2020-03-16 17:02:01');
INSERT INTO "public"."sys_captcha" VALUES ('5b978ff0-b419-4997-8991-3c94550c0898', 'gg8pf', '2020-03-16 17:13:00');
INSERT INTO "public"."sys_captcha" VALUES ('d5f6a44b-0a7e-4bd4-8d41-b4a041c2a55e', 'wanp5', '2020-03-16 17:28:43');
INSERT INTO "public"."sys_captcha" VALUES ('d5acc4bc-db6b-430c-858c-e93924a372db', 'm5n7f', '2020-03-16 17:51:40');
INSERT INTO "public"."sys_captcha" VALUES ('de9458ba-acf1-471d-825c-85d25f37e9fb', '587m4', '2020-03-16 17:59:07');
INSERT INTO "public"."sys_captcha" VALUES ('9487b015-fea3-4c20-8573-67ed039be6af', '43yn7', '2020-03-16 18:07:13');
INSERT INTO "public"."sys_captcha" VALUES ('d2f46d7c-bff2-4809-85a1-c44d3f0c7b62', 'w23xn', '2020-03-17 09:29:49');
INSERT INTO "public"."sys_captcha" VALUES ('b0e87659-91b0-4597-86e3-adf219461aa4', 'ewdpe', '2020-03-17 10:32:37');
INSERT INTO "public"."sys_captcha" VALUES ('a954b702-eeb6-4dfd-880a-964a5e46d9e2', 'e3wbn', '2020-03-17 10:32:40');
INSERT INTO "public"."sys_captcha" VALUES ('632a7e9a-92db-43e1-8a55-fc82c878f339', 'mdfec', '2020-03-17 10:32:52');
INSERT INTO "public"."sys_captcha" VALUES ('bbee6b28-df7d-499b-865c-878f3ca0631b', 'c3c6x', '2020-03-18 09:41:14');
INSERT INTO "public"."sys_captcha" VALUES ('d9aefc69-5f85-4a48-80e1-98eec1e27b9a', 'ndgbe', '2020-03-18 10:05:57');
INSERT INTO "public"."sys_captcha" VALUES ('f3865752-782a-455a-8fdc-77528cf5197f', 'nnwam', '2020-03-18 10:15:02');
INSERT INTO "public"."sys_captcha" VALUES ('de2626ee-6889-4313-8a7d-ac4bb01e19ce', '52mg7', '2020-03-18 11:02:37');
INSERT INTO "public"."sys_captcha" VALUES ('5e05b615-2c9f-466e-8b07-263188dae535', '7g367', '2020-03-19 09:51:21');
INSERT INTO "public"."sys_captcha" VALUES ('653e6dfc-47d3-4d49-8416-de4c11274550', 'e6mff', '2020-03-19 11:23:54');
INSERT INTO "public"."sys_captcha" VALUES ('4a08683d-b17e-4ee2-83e6-39f1615980a5', 'y2dfw', '2020-03-19 11:49:27');
INSERT INTO "public"."sys_captcha" VALUES ('44a2c88d-216b-4b50-8faa-4e3098957084', 'fpew7', '2020-03-19 15:08:05');
INSERT INTO "public"."sys_captcha" VALUES ('221dfa86-e970-4dad-8f26-b8ad4548d811', 'x2dw8', '2020-03-19 15:16:42');
INSERT INTO "public"."sys_captcha" VALUES ('4ec5661c-8f99-4d09-8d20-d0bfd3a35eba', 'wynfx', '2020-03-19 15:16:55');
INSERT INTO "public"."sys_captcha" VALUES ('98d73b01-2550-44b9-8c67-4ed0d94f8784', 'b3ffn', '2020-03-19 15:19:01');
INSERT INTO "public"."sys_captcha" VALUES ('52d741b7-acb3-4f8a-824b-d605bb46d9c6', 'f37xw', '2020-03-19 15:19:11');
INSERT INTO "public"."sys_captcha" VALUES ('f329bac5-99d2-495e-8925-79a71d9f93c9', '8aw23', '2020-03-19 15:22:22');
INSERT INTO "public"."sys_captcha" VALUES ('033886db-0f9e-47c3-8f57-3e56fc84ad6b', '7p725', '2020-03-19 15:24:09');
INSERT INTO "public"."sys_captcha" VALUES ('5c681ba3-b2ee-4ecb-8d52-fc7cdc65adfd', '8243a', '2020-03-19 15:40:20');
INSERT INTO "public"."sys_captcha" VALUES ('c1308425-adee-4d70-8ffe-53bbb03148c6', 'epby2', '2020-03-19 15:57:22');
INSERT INTO "public"."sys_captcha" VALUES ('a8be4a89-b2a3-42b3-810c-b8ba74981843', 'm8wy3', '2020-03-19 16:31:07');
INSERT INTO "public"."sys_captcha" VALUES ('ac0d2400-461a-48eb-8802-a68829a66f2e', 'b4b3b', '2020-03-19 17:17:23');
INSERT INTO "public"."sys_captcha" VALUES ('f23dcadb-3c4a-480f-869a-e67ef8e779ca', '5d5fn', '2020-03-20 10:00:58');
INSERT INTO "public"."sys_captcha" VALUES ('b0822598-c621-4654-8cbc-a6806edfc90a', '474xm', '2020-03-20 11:11:44');
INSERT INTO "public"."sys_captcha" VALUES ('8b1aeb39-b021-4c1d-8cb8-ed44ef25615b', '6n5d7', '2020-03-20 11:12:20');
INSERT INTO "public"."sys_captcha" VALUES ('5203e155-31c3-4808-89fb-47b687a11718', 'wfecc', '2020-03-20 14:06:27');
INSERT INTO "public"."sys_captcha" VALUES ('96bdebf7-a8b9-4fdd-8508-056e895489d6', 'cce3f', '2020-03-20 14:12:51');
INSERT INTO "public"."sys_captcha" VALUES ('108200b4-9909-4539-855d-8bc357cfb924', 'n53wg', '2020-03-20 14:19:25');
INSERT INTO "public"."sys_captcha" VALUES ('92d552a2-a64d-479e-8c07-65e6098615a9', 'yxd3b', '2020-03-20 14:49:40');
INSERT INTO "public"."sys_captcha" VALUES ('7db78acb-fdf5-4e4c-8606-ca675554a2f4', 'egac8', '2020-03-20 15:02:21');
INSERT INTO "public"."sys_captcha" VALUES ('d06f7a70-75d0-4410-8b61-cbbfe6969368', 'gpm56', '2020-03-20 15:10:42');
INSERT INTO "public"."sys_captcha" VALUES ('57a4b8f6-b041-40bb-893d-5a899fc1cd31', '2cnbp', '2020-03-20 15:49:27');
INSERT INTO "public"."sys_captcha" VALUES ('221cd3f2-e3b5-4561-8995-8de655bef507', 'b3w7f', '2020-03-20 16:24:12');
INSERT INTO "public"."sys_captcha" VALUES ('11a17173-88c3-4317-8e5c-9d9e0bdc34e5', '57xap', '2020-03-20 16:39:04');
INSERT INTO "public"."sys_captcha" VALUES ('80095e06-229c-495c-8127-c81158495d4f', 'a5pgd', '2020-03-20 16:53:05');
INSERT INTO "public"."sys_captcha" VALUES ('eb147671-b57c-4755-8cf8-86d9128b19a0', 'g3daf', '2020-03-20 16:56:10');
INSERT INTO "public"."sys_captcha" VALUES ('81002c74-9539-4291-8399-ce4e38100310', 'n8dem', '2020-03-20 17:11:55');
INSERT INTO "public"."sys_captcha" VALUES ('d68059d3-2e4d-4f38-8723-643e621af8ed', '34423', '2020-03-20 17:32:08');
INSERT INTO "public"."sys_captcha" VALUES ('1f28805c-a68c-4d15-8a9a-52f9dba4e789', 'fx4x4', '2020-03-21 16:30:26');
INSERT INTO "public"."sys_captcha" VALUES ('9540a6b6-2e41-459e-812c-0d652e347c2c', '7pdfx', '2020-03-21 16:40:23');
INSERT INTO "public"."sys_captcha" VALUES ('47bda049-e23e-4747-853c-8f82b87126f3', 'w4ndn', '2020-03-22 21:59:53');
INSERT INTO "public"."sys_captcha" VALUES ('a5916320-4fb7-4aee-8cee-3392508a3729', 'nnd33', '2020-03-22 22:07:43');
INSERT INTO "public"."sys_captcha" VALUES ('67d9669b-b527-4254-85cd-61b374207433', 'y7ymb', '2020-03-22 22:33:25');
INSERT INTO "public"."sys_captcha" VALUES ('6cf40327-543f-468c-81ab-8f5b1b0e2692', '7765c', '2020-03-22 23:38:34');
INSERT INTO "public"."sys_captcha" VALUES ('8bb1260d-9470-49ed-8698-d7116a95c24d', 'gd4xy', '2020-03-22 23:42:09');
INSERT INTO "public"."sys_captcha" VALUES ('7b56cb1b-86da-41e7-85d4-bfbc5cd3419d', '3gcmd', '2020-03-22 23:45:35');
INSERT INTO "public"."sys_captcha" VALUES ('ddc753d5-d01b-4f22-8f9e-4d9f889b4fe7', '6e4w4', '2020-03-23 00:05:15');
INSERT INTO "public"."sys_captcha" VALUES ('dce1f6b6-c919-4e85-8e06-911a8068c4e1', 'x6daf', '2020-03-23 09:59:02');
INSERT INTO "public"."sys_captcha" VALUES ('9cc6c58b-ab59-4370-8d21-27559d52b71a', 'yx7bc', '2020-03-23 10:01:27');
INSERT INTO "public"."sys_captcha" VALUES ('c68aac58-ddf6-43b4-86c8-991c8c3cf2d0', 'w3wmn', '2020-03-23 11:32:46');
INSERT INTO "public"."sys_captcha" VALUES ('fd76a4f5-a950-456a-88dc-38661f3ab36a', 'b6nw4', '2020-03-23 13:52:38');
INSERT INTO "public"."sys_captcha" VALUES ('9b1c0ec6-77d8-480a-814d-f058f1113f00', '77afd', '2020-03-23 14:53:52');
INSERT INTO "public"."sys_captcha" VALUES ('dd4246e5-708a-4ee3-8109-bbef743bc530', 'b7n2b', '2020-03-23 15:17:28');
INSERT INTO "public"."sys_captcha" VALUES ('bfc12072-ae40-4336-8718-a4cc22ec8cab', 'bgcn7', '2020-03-23 15:18:27');
INSERT INTO "public"."sys_captcha" VALUES ('08541c08-f8de-4129-8975-eacb25f20baa', 'f8765', '2020-03-31 14:50:24');
INSERT INTO "public"."sys_captcha" VALUES ('b2088aa9-9c39-4a78-82d1-760289d0743f', 'w5nx5', '2020-03-23 17:22:57');
INSERT INTO "public"."sys_captcha" VALUES ('80cb96cf-8e34-4ff9-8e3e-a4d4f0ebaa28', 'f53xc', '2020-03-23 17:49:43');
INSERT INTO "public"."sys_captcha" VALUES ('a1517f58-4b67-4708-86b2-904566082626', 'a2yn2', '2020-03-23 17:56:51');
INSERT INTO "public"."sys_captcha" VALUES ('43a6696d-01ed-4f3d-86af-03f3c67775e0', 'fx34x', '2020-03-23 17:56:55');
INSERT INTO "public"."sys_captcha" VALUES ('0cbc777f-5972-4ed4-8cbb-61fd90d976c5', 'nde8w', '2020-03-23 17:56:19');
INSERT INTO "public"."sys_captcha" VALUES ('2470bcab-fd37-4e80-8177-583b6e213f93', '2dyag', '2020-03-23 17:57:23');
INSERT INTO "public"."sys_captcha" VALUES ('38392a3b-c69f-4482-853f-8e65f9acb79b', 'w822b', '2020-03-23 18:07:34');
INSERT INTO "public"."sys_captcha" VALUES ('5fad3fa8-a60d-4ff2-81e6-28894d100e76', 'a2a6g', '2020-03-23 18:09:19');
INSERT INTO "public"."sys_captcha" VALUES ('2316695f-5388-459d-8841-7683ec07db5a', '3a7am', '2020-03-24 08:46:54');
INSERT INTO "public"."sys_captcha" VALUES ('7e74a382-fa7c-4d87-804b-ba90ac49f4b6', '8pn45', '2020-03-24 08:50:00');
INSERT INTO "public"."sys_captcha" VALUES ('623d08bf-564d-416d-87b8-cc566a5ba68c', 'ybppm', '2020-03-24 08:53:16');
INSERT INTO "public"."sys_captcha" VALUES ('0769eb2f-f100-416d-85dd-9ab93e4b364e', '6cmny', '2020-03-24 09:03:28');
INSERT INTO "public"."sys_captcha" VALUES ('403bb3b9-5b96-4a11-8080-bf537a56015d', '62y82', '2020-03-24 09:05:55');
INSERT INTO "public"."sys_captcha" VALUES ('1bc7c1bc-c1d7-423e-8ca4-fdd6a9e0495a', '3fa5y', '2020-03-24 09:11:45');
INSERT INTO "public"."sys_captcha" VALUES ('ef311126-e16c-42a0-8fcf-87e3e32e9b12', 'm6nx6', '2020-03-24 09:14:38');
INSERT INTO "public"."sys_captcha" VALUES ('6eb9bf32-5e7a-40ae-8428-4ef53ed86eb2', 'gpbc4', '2020-03-24 09:17:54');
INSERT INTO "public"."sys_captcha" VALUES ('4c27d140-2e51-45a6-856d-7b7ddadc466e', '7a47g', '2020-03-24 10:09:29');
INSERT INTO "public"."sys_captcha" VALUES ('24ac191c-de86-40e9-8150-69e4195ac87d', '83d4n', '2020-03-24 10:19:28');
INSERT INTO "public"."sys_captcha" VALUES ('94c16a97-dd20-4cb4-89f7-d0d91c1b39a5', 'ap7ym', '2020-03-24 10:57:10');
INSERT INTO "public"."sys_captcha" VALUES ('be1b9a8d-a548-45de-82df-f4aec35d740c', 'bp822', '2020-03-24 10:59:55');
INSERT INTO "public"."sys_captcha" VALUES ('2354b646-a259-449a-8ca8-69fccc86bbca', '6fbgn', '2020-03-24 11:02:18');
INSERT INTO "public"."sys_captcha" VALUES ('e77c0a7a-b5f6-450d-82c2-737da6ac8517', '3pe8n', '2020-03-24 11:02:50');
INSERT INTO "public"."sys_captcha" VALUES ('95669133-a135-4f47-834d-c1f56c13a4d3', '5penb', '2020-03-24 11:03:07');
INSERT INTO "public"."sys_captcha" VALUES ('ec132b45-0fe8-47a4-8729-71a8de1f2b10', 'n4de3', '2020-03-24 11:44:15');
INSERT INTO "public"."sys_captcha" VALUES ('d99341f9-f31e-47fb-8f25-7620587b2846', 'xp886', '2020-03-24 11:51:33');
INSERT INTO "public"."sys_captcha" VALUES ('8deb97a6-3646-4548-8d7e-64c7fa4f7c7b', 'b8yym', '2020-03-24 14:04:31');
INSERT INTO "public"."sys_captcha" VALUES ('f2fa7850-c617-4f23-88ff-d53679b63825', '86g8w', '2020-03-24 14:04:41');
INSERT INTO "public"."sys_captcha" VALUES ('a48447e4-d8c0-471c-890e-518d84f08df6', 'wnab3', '2020-03-24 14:05:09');
INSERT INTO "public"."sys_captcha" VALUES ('24054cbe-b4ba-4187-8236-b1c6f2bc023c', 'fd3x5', '2020-03-24 14:21:56');
INSERT INTO "public"."sys_captcha" VALUES ('cfca1fe2-426f-4619-83e9-d813d6d9b4e5', 'cdyfe', '2020-03-24 14:29:29');
INSERT INTO "public"."sys_captcha" VALUES ('54282cfb-0766-4b82-803b-53fa250fdf84', 'cxfc7', '2020-03-24 14:29:40');
INSERT INTO "public"."sys_captcha" VALUES ('59277e41-cd2e-4b38-85c7-c8fbb2e19d45', 'fbp4x', '2020-03-24 14:31:16');
INSERT INTO "public"."sys_captcha" VALUES ('4c28e76d-b1c7-4d70-87d1-c9385e895273', '2x22p', '2020-03-24 14:31:34');
INSERT INTO "public"."sys_captcha" VALUES ('d5c7c805-1e63-46a3-8032-2634cfe1b9fa', '6f568', '2020-03-24 15:00:38');
INSERT INTO "public"."sys_captcha" VALUES ('addf7f14-009e-4316-89f6-511213cd247c', '3fpa4', '2020-03-24 15:07:00');
INSERT INTO "public"."sys_captcha" VALUES ('82e2d400-9b69-450b-86c0-d5372409c79b', 'eany8', '2020-03-24 15:13:58');
INSERT INTO "public"."sys_captcha" VALUES ('35cdd912-41e5-4f90-8355-b0ac8c134618', 'w6bxg', '2020-03-24 15:15:49');
INSERT INTO "public"."sys_captcha" VALUES ('75969c0d-078e-4e6d-8d42-44c45a42990f', '7yd7e', '2020-03-24 15:16:44');
INSERT INTO "public"."sys_captcha" VALUES ('90178d36-aee3-448d-87bd-e278d2838fb4', 'wxnep', '2020-03-24 16:10:48');
INSERT INTO "public"."sys_captcha" VALUES ('bbc5b118-d8d9-4f69-8ec6-03cffcc16c02', '7npbw', '2020-03-24 17:39:37');
INSERT INTO "public"."sys_captcha" VALUES ('f69a03a1-caae-4f32-85d4-7f1772e95a0b', '5da2p', '2020-03-24 17:41:07');
INSERT INTO "public"."sys_captcha" VALUES ('95cbf2b5-33f9-4db3-82a0-2b1ea54c5b61', 'a74yc', '2020-03-24 17:52:43');
INSERT INTO "public"."sys_captcha" VALUES ('28a11b04-6ae1-4acc-840a-f2e896f9cf53', '7xyg5', '2020-03-24 18:08:25');
INSERT INTO "public"."sys_captcha" VALUES ('e3b9f10c-64ff-4adf-8981-c557b15537c8', 'pfmpc', '2020-03-24 18:21:27');
INSERT INTO "public"."sys_captcha" VALUES ('cdeb6e11-c8a2-4736-871e-40d4d700781b', 'xdm87', '2020-03-24 23:12:52');
INSERT INTO "public"."sys_captcha" VALUES ('2d525e73-1e4e-48dc-86e6-e2a405815054', 'gn8w3', '2020-03-25 09:20:04');
INSERT INTO "public"."sys_captcha" VALUES ('d109efbc-0ec5-4611-882d-8654419dcab2', '856bc', '2020-03-25 09:20:06');
INSERT INTO "public"."sys_captcha" VALUES ('bc1a56ee-2641-46e4-826a-7825d185c3e5', '6xace', '2020-03-25 09:34:09');
INSERT INTO "public"."sys_captcha" VALUES ('ff0bcd31-8fd7-46c9-8661-6b2465771ecc', '3fw7y', '2020-03-25 09:38:14');
INSERT INTO "public"."sys_captcha" VALUES ('f3ebbc1d-dc44-450c-8521-dd629c8c097b', 'yfgx7', '2020-03-25 09:38:52');
INSERT INTO "public"."sys_captcha" VALUES ('3b69c6a2-9bee-41e9-8241-52950d3a5243', '8nme6', '2020-03-25 10:10:39');
INSERT INTO "public"."sys_captcha" VALUES ('6e152f91-9f26-490b-885a-66fd54eeb174', 'ngpfy', '2020-03-25 10:12:43');
INSERT INTO "public"."sys_captcha" VALUES ('cb7429e9-2d1e-4c9f-8010-b42754317315', '7ad4a', '2020-03-25 10:13:40');
INSERT INTO "public"."sys_captcha" VALUES ('dfa47d8c-2863-4e38-84c4-9807eca3caf8', 'n6ggx', '2020-03-25 10:14:59');
INSERT INTO "public"."sys_captcha" VALUES ('08221f79-c804-4e89-80a8-4e5189f379d7', 'n4ym4', '2020-03-25 10:16:40');
INSERT INTO "public"."sys_captcha" VALUES ('7dc82b1e-031b-4279-8790-e161df7c0570', 'cmpfc', '2020-03-25 10:17:36');
INSERT INTO "public"."sys_captcha" VALUES ('a8975577-47ea-45df-89f7-52e1bd5e86fe', '7fmw8', '2020-03-25 10:18:38');
INSERT INTO "public"."sys_captcha" VALUES ('b8972981-8a38-4cc0-8428-a5efa99715db', 'c8cge', '2020-03-25 10:21:09');
INSERT INTO "public"."sys_captcha" VALUES ('7e3b2d89-2509-4312-842b-3e5c88a5a3ad', 'ym84b', '2020-03-25 12:23:25');
INSERT INTO "public"."sys_captcha" VALUES ('91161aa7-8110-404d-89ba-633e2196b998', 'ecyp6', '2020-03-25 13:16:28');
INSERT INTO "public"."sys_captcha" VALUES ('c5018db0-8c78-4ed9-811e-728564ad337b', 'yebng', '2020-03-25 15:36:50');
INSERT INTO "public"."sys_captcha" VALUES ('4163648a-25bc-4ce8-8925-9a1c1ef4f47a', '2dgyw', '2020-03-25 16:10:22');
INSERT INTO "public"."sys_captcha" VALUES ('fe472113-78b3-4824-8f1c-63d6b087f34d', 'm7n63', '2020-03-25 16:14:46');
INSERT INTO "public"."sys_captcha" VALUES ('3222998a-f0ab-4ae0-83d5-ef992e5d9e03', 'xd3b5', '2020-03-25 16:51:53');
INSERT INTO "public"."sys_captcha" VALUES ('85e729fa-21fc-4a0a-8da4-a1c777ba3d22', 'f835m', '2020-03-25 17:11:56');
INSERT INTO "public"."sys_captcha" VALUES ('1b9a6e87-ddc7-468a-87e4-ce571768dbe0', '8wb5p', '2020-03-25 17:17:54');
INSERT INTO "public"."sys_captcha" VALUES ('ac0445d3-24ab-4bbb-834e-c8abce664d76', 'bcwbb', '2020-03-25 17:18:09');
INSERT INTO "public"."sys_captcha" VALUES ('df47a9b9-e068-4cc8-8f4d-eb9c0aecda71', 'nnx84', '2020-03-25 17:53:19');
INSERT INTO "public"."sys_captcha" VALUES ('27804b0f-8472-4400-8a81-dbfb2b15e3bf', 'gg4dn', '2020-03-25 17:54:26');
INSERT INTO "public"."sys_captcha" VALUES ('5a215e45-771b-48f7-8ff8-9991136dd420', 'xfc7w', '2020-03-25 17:54:44');
INSERT INTO "public"."sys_captcha" VALUES ('cc8596ef-36ee-43eb-8620-4b3fc3014502', 'bn7ye', '2020-03-25 17:55:19');
INSERT INTO "public"."sys_captcha" VALUES ('b4cd2b06-0de5-41b8-8391-7df3e1831731', 'dcm86', '2020-03-26 08:51:54');
INSERT INTO "public"."sys_captcha" VALUES ('a21fa05b-bddd-4220-8e95-cca89b435a50', 'mg456', '2020-03-26 08:55:25');
INSERT INTO "public"."sys_captcha" VALUES ('5aa01a10-2c3f-42ef-8649-90496b7e9f25', '5e8gn', '2020-03-26 09:00:53');
INSERT INTO "public"."sys_captcha" VALUES ('ba8730b9-5178-4eb7-8605-3f48019b9325', '3ndwd', '2020-03-26 15:46:21');
INSERT INTO "public"."sys_captcha" VALUES ('61e4470e-a901-4c18-831a-459d726be244', '2abdm', '2020-03-26 15:46:30');
INSERT INTO "public"."sys_captcha" VALUES ('d48ed26c-e283-456a-8081-b0d17d825195', '7x23n', '2020-03-26 15:53:03');
INSERT INTO "public"."sys_captcha" VALUES ('2996aa55-ddd0-4aa3-8256-cd2f94159619', '2pnyg', '2020-03-26 18:05:50');
INSERT INTO "public"."sys_captcha" VALUES ('754ed0fb-f8ff-4437-8138-02adc3e45362', 'na5x4', '2020-03-26 18:11:29');
INSERT INTO "public"."sys_captcha" VALUES ('46a0304d-db43-4703-8b04-b1d8675b56de', '45a77', '2020-03-27 00:46:45');
INSERT INTO "public"."sys_captcha" VALUES ('87bd506c-1eff-4125-8d27-70c0aeeccbbe', 'm85nn', '2020-03-27 09:17:31');
INSERT INTO "public"."sys_captcha" VALUES ('7ab8e7c4-6d18-4eef-89ad-1518cebf2cb7', 'ndd3w', '2020-03-27 17:24:49');
INSERT INTO "public"."sys_captcha" VALUES ('42437d4e-944c-46c8-8ff4-1b758a84e582', '75ydm', '2020-03-27 17:33:27');
INSERT INTO "public"."sys_captcha" VALUES ('6ce71ca4-ef05-41b8-8268-8a5ea06ecc78', 'peg3m', '2020-03-27 17:44:37');
INSERT INTO "public"."sys_captcha" VALUES ('44252612-633a-4794-8d78-d444a99cbbfb', 'nxme2', '2020-03-27 17:54:26');
INSERT INTO "public"."sys_captcha" VALUES ('01a55838-4b65-482a-83a4-9259b6de68dd', 'gn4p5', '2020-03-27 17:55:42');
INSERT INTO "public"."sys_captcha" VALUES ('2d905bfa-cc69-4373-8b24-5b89cda16848', 'wdbd7', '2020-03-27 17:55:59');
INSERT INTO "public"."sys_captcha" VALUES ('8c98b2ef-44c1-41af-87df-4823cb79009e', 'nf34d', '2020-03-27 17:56:57');
INSERT INTO "public"."sys_captcha" VALUES ('2cd24ca5-8154-4a66-8f02-42b0383e3520', '2mewb', '2020-03-27 17:58:39');
INSERT INTO "public"."sys_captcha" VALUES ('a4f13dee-7693-4ad5-8949-2fa5aaeb5c1f', 'ea653', '2020-03-27 17:59:16');
INSERT INTO "public"."sys_captcha" VALUES ('4c346659-c1cf-45c2-8c4a-6fe7b26490fe', '523g2', '2020-03-27 18:09:43');
INSERT INTO "public"."sys_captcha" VALUES ('150e8508-9295-4af0-8daa-899f1b7835b6', 'be8fn', '2020-03-27 18:10:45');
INSERT INTO "public"."sys_captcha" VALUES ('51825a9f-1a0d-401d-8cb4-6b0b31c7db68', 'mdgx2', '2020-03-31 18:14:43');
INSERT INTO "public"."sys_captcha" VALUES ('4fc7928a-0d8b-4009-8f52-cbd31c06fe24', 'ppxan', '2020-03-31 23:00:38');
INSERT INTO "public"."sys_captcha" VALUES ('3bd19182-3170-4c4a-8581-65e3477084a2', '8pc26', '2020-03-31 23:12:24');
INSERT INTO "public"."sys_captcha" VALUES ('34ffc817-9bfc-47bd-8aa0-16766b62ab34', 'caeye', '2020-04-01 08:30:56');
INSERT INTO "public"."sys_captcha" VALUES ('3b120fed-7001-4b2c-8f4f-608eb4c7c1c0', '886gd', '2020-04-01 09:58:29');
INSERT INTO "public"."sys_captcha" VALUES ('65913c41-1e7b-40ea-8388-f0f3c068ba15', 'y67ma', '2020-03-28 00:04:33');
INSERT INTO "public"."sys_captcha" VALUES ('10757a94-b3a5-4822-84d6-417b9bd71c75', 'b5dan', '2020-04-01 10:02:15');
INSERT INTO "public"."sys_captcha" VALUES ('b1427f20-62fd-436e-8483-f9cc3d74747a', '7ayan', '2020-03-28 12:17:28');
INSERT INTO "public"."sys_captcha" VALUES ('6040605e-9cf6-44bc-86fd-dd03ccdd4a17', 'facyn', '2020-03-28 16:40:52');
INSERT INTO "public"."sys_captcha" VALUES ('0d886f37-7c14-4d5b-84ae-7f8295a0b94f', 'nd375', '2020-03-29 00:09:26');
INSERT INTO "public"."sys_captcha" VALUES ('b5a44108-7bba-4f38-842e-60122baeeb94', 'nncbm', '2020-04-01 11:25:35');
INSERT INTO "public"."sys_captcha" VALUES ('8855c95f-a28b-4f82-8ab3-540c9e3ea19e', 'gbd8p', '2020-04-01 11:25:46');
INSERT INTO "public"."sys_captcha" VALUES ('69ed465e-9857-4a31-89d0-c4b114c209e1', 'ecagd', '2020-03-29 23:06:57');
INSERT INTO "public"."sys_captcha" VALUES ('3ebbaebe-4ef5-491c-833f-c2bffa427122', 'c6xxp', '2020-03-29 23:07:15');
INSERT INTO "public"."sys_captcha" VALUES ('5b79573b-8189-4ddc-8b93-02f0c76a55a5', 'ngcnn', '2020-04-01 11:41:22');
INSERT INTO "public"."sys_captcha" VALUES ('0a6275eb-4f5b-4767-83d3-8810564a90c8', '652g8', '2020-03-30 09:46:56');
INSERT INTO "public"."sys_captcha" VALUES ('743e4c04-aefa-4729-8550-30a42a1f414d', 'pgdgc', '2020-04-01 14:17:35');
INSERT INTO "public"."sys_captcha" VALUES ('ea13561f-9e57-4b03-8f41-2f549eafd878', 'gcw75', '2020-04-01 14:54:31');
INSERT INTO "public"."sys_captcha" VALUES ('8bfb4c6b-43b9-4265-8b66-06a7fefb3e15', '3ng4p', '2020-04-01 14:55:14');
INSERT INTO "public"."sys_captcha" VALUES ('df976c20-df1e-47a8-85d1-ef66799e4483', '454nx', '2020-04-01 16:26:17');
INSERT INTO "public"."sys_captcha" VALUES ('cba924dc-d75b-4796-8016-e23457455470', '7d724', '2020-04-01 17:07:20');
INSERT INTO "public"."sys_captcha" VALUES ('4778fbb7-0c99-4196-803e-b426be4ed974', 'e76px', '2020-04-01 20:39:36');
INSERT INTO "public"."sys_captcha" VALUES ('57f25e44-9d4a-40e3-8e39-cd8f065e67c1', 'ex5nb', '2020-04-01 20:54:03');
INSERT INTO "public"."sys_captcha" VALUES ('df0ede49-31fd-45b8-8f83-2d6d8efd7b1b', 'w53fn', '2020-04-02 09:07:22');
INSERT INTO "public"."sys_captcha" VALUES ('7dea4393-89a7-4fb6-8709-5b229fdcce00', 'xnypf', '2020-04-02 09:07:44');
INSERT INTO "public"."sys_captcha" VALUES ('599895aa-059d-47eb-8b03-762dd9241a92', 'dnf6x', '2020-04-02 09:13:20');
INSERT INTO "public"."sys_captcha" VALUES ('64b8cd05-e1b5-4d9b-857f-21abe2ae39bf', 'dc52p', '2020-04-02 09:20:14');
INSERT INTO "public"."sys_captcha" VALUES ('33bee9c8-88f8-424e-8cf0-b39d39f1ebd4', 'ngxw2', '2020-04-02 09:29:31');
INSERT INTO "public"."sys_captcha" VALUES ('ca97ce52-8dd0-4bdc-8cd2-2b8d1ed25461', 'n5nna', '2020-04-02 09:37:40');
INSERT INTO "public"."sys_captcha" VALUES ('2d31144c-fd26-464c-8756-abc2d1d5c25b', 'mdnpy', '2020-04-02 09:53:45');
INSERT INTO "public"."sys_captcha" VALUES ('ae0623b2-69a9-4ca0-8757-6d7acb1fd4d8', 'a526b', '2020-04-02 12:33:06');
INSERT INTO "public"."sys_captcha" VALUES ('44738c4f-80ca-4698-848f-614eb6a72f78', 'p5nfe', '2020-04-02 13:32:47');
INSERT INTO "public"."sys_captcha" VALUES ('64c2ae9c-17d0-4189-8558-99fb0a315885', 'wffa5', '2020-04-02 13:32:49');
INSERT INTO "public"."sys_captcha" VALUES ('e46710f6-0966-46d6-81f3-1626172ae8e3', '6n5mb', '2020-04-02 13:33:14');
INSERT INTO "public"."sys_captcha" VALUES ('c308719d-37c4-4aa3-8097-2f4aaa8df900', '8g3nw', '2020-04-02 14:42:09');
INSERT INTO "public"."sys_captcha" VALUES ('dfe8c0dd-ef6c-4f9f-8450-aab69d545992', '3ww7n', '2020-04-02 15:21:35');
INSERT INTO "public"."sys_captcha" VALUES ('2d00dea7-8229-4847-89a0-5f9a2b309f11', 'g7w2w', '2020-04-02 15:22:20');
INSERT INTO "public"."sys_captcha" VALUES ('9cef5e56-6d33-4572-8577-d2109ce63966', '6png7', '2020-04-02 15:46:54');
INSERT INTO "public"."sys_captcha" VALUES ('c122e640-141c-470d-8333-a2a935adb401', 'g3w6n', '2020-04-02 15:46:56');
INSERT INTO "public"."sys_captcha" VALUES ('545af01d-67a6-4837-8246-68f6b49ead67', 'md7ee', '2020-04-02 15:46:57');
INSERT INTO "public"."sys_captcha" VALUES ('50767bc7-7e8c-4d56-8ca2-dbb52bdc154f', '282bc', '2020-04-02 15:47:03');
INSERT INTO "public"."sys_captcha" VALUES ('0ec38370-918c-42ed-81b6-067806622bd6', 'f5fda', '2020-04-02 15:56:23');
INSERT INTO "public"."sys_captcha" VALUES ('75f36df0-da35-4960-8042-395931776ac4', '26nnx', '2020-04-02 15:59:12');
INSERT INTO "public"."sys_captcha" VALUES ('7e130500-51fb-4eb4-810e-1f02a1113646', 'ncpcn', '2020-04-02 15:59:45');
INSERT INTO "public"."sys_captcha" VALUES ('7ba62cd2-48db-44d9-8afc-0cdecac5b0eb', 'me5n5', '2020-04-02 16:02:09');
INSERT INTO "public"."sys_captcha" VALUES ('a04429f5-824e-4d03-8d66-4273ed20e6d9', '2228a', '2020-04-02 16:02:09');
INSERT INTO "public"."sys_captcha" VALUES ('9daa2291-066a-4efa-879b-40e8e852cff7', 'dnyn8', '2020-04-02 16:02:10');
INSERT INTO "public"."sys_captcha" VALUES ('033e5c16-0173-4ed3-8b81-91dfe17ad373', 'y4ncy', '2020-04-02 16:02:10');
INSERT INTO "public"."sys_captcha" VALUES ('fab458c7-04bd-4724-8e74-8404dd01f8da', '5aawn', '2020-04-02 16:02:10');
INSERT INTO "public"."sys_captcha" VALUES ('502457ee-f812-40b4-80e5-743ad922093c', 'gww3w', '2020-04-02 16:02:10');
INSERT INTO "public"."sys_captcha" VALUES ('eb50b88e-3758-4ba5-872e-75393f19fa84', 'ncefa', '2020-04-02 16:02:10');
INSERT INTO "public"."sys_captcha" VALUES ('b32f10dc-c9bc-47d6-8440-c89e10cf5694', 'wx33m', '2020-04-02 16:02:11');
INSERT INTO "public"."sys_captcha" VALUES ('987111f5-2861-4fcb-83b9-aa3b6b391796', 'g2248', '2020-04-02 16:02:11');
INSERT INTO "public"."sys_captcha" VALUES ('aca99f39-9953-4d10-8baa-0d713e64f93e', 'e3wyb', '2020-04-02 16:02:11');
INSERT INTO "public"."sys_captcha" VALUES ('a6fd703e-7cb6-487e-882a-ad8109313dfb', 'peaep', '2020-04-02 16:02:11');
INSERT INTO "public"."sys_captcha" VALUES ('41fff7db-4aee-4b44-8fdf-d284f88b98f5', 'pp4p8', '2020-04-02 16:02:11');
INSERT INTO "public"."sys_captcha" VALUES ('0ada3727-f7d2-4164-863d-39fc0fef36cd', 'efn4y', '2020-04-02 16:02:12');
INSERT INTO "public"."sys_captcha" VALUES ('3b479e1d-a988-460a-88da-281bbab24ba7', 'x5276', '2020-04-02 16:02:12');
INSERT INTO "public"."sys_captcha" VALUES ('6d3cb9b3-078a-4465-8750-fa5c19078151', '7db5w', '2020-04-02 16:02:12');
INSERT INTO "public"."sys_captcha" VALUES ('1b3f406e-713c-49fc-8bff-207cfd683081', 'nmpyw', '2020-04-02 16:02:12');
INSERT INTO "public"."sys_captcha" VALUES ('5c5c3203-d71b-43a7-83ec-a011937c9431', 'm558m', '2020-04-02 16:02:12');
INSERT INTO "public"."sys_captcha" VALUES ('f1388fb5-2af0-4198-881d-b03c750bda2b', '6w78f', '2020-04-02 16:02:25');
INSERT INTO "public"."sys_captcha" VALUES ('6cb5c15d-ccb1-4337-81d7-cb55abde23e2', '3mnx6', '2020-04-02 16:02:26');
INSERT INTO "public"."sys_captcha" VALUES ('2edd0057-f889-460f-896a-059061d61985', 'pyxwg', '2020-04-02 16:02:26');
INSERT INTO "public"."sys_captcha" VALUES ('20efbb37-12dc-452c-8949-8df825f64b94', '3xf85', '2020-04-03 08:44:40');
INSERT INTO "public"."sys_captcha" VALUES ('ba042336-5370-4d73-8fe2-d73fb29e771c', 'd7dm8', '2020-04-03 08:44:55');
INSERT INTO "public"."sys_captcha" VALUES ('e5db4130-0589-4026-81fe-6f05bb986c4e', '2nbcd', '2020-04-03 09:23:27');
INSERT INTO "public"."sys_captcha" VALUES ('b8dd8b9d-d099-4a12-8383-3c1123331adf', 'nw348', '2020-04-03 09:26:47');
INSERT INTO "public"."sys_captcha" VALUES ('8fb33786-8008-4cea-80cc-76a424171488', '8xf3f', '2020-04-03 09:29:04');
INSERT INTO "public"."sys_captcha" VALUES ('ba8181a8-9161-40b7-8399-3ba2d0c8cf7a', 'gy4e6', '2020-04-03 09:45:20');
INSERT INTO "public"."sys_captcha" VALUES ('f8cc0de6-fd5c-42ea-8759-40ae2221d004', '7awpf', '2020-04-03 15:57:15');
INSERT INTO "public"."sys_captcha" VALUES ('95b804dc-ad99-4098-8ee9-9c159b285922', 'mfn4a', '2020-04-04 07:23:57');
INSERT INTO "public"."sys_captcha" VALUES ('f41563c8-8f5c-47af-86de-fb7da5d29f70', '66yb5', '2020-04-05 12:25:14');
INSERT INTO "public"."sys_captcha" VALUES ('db506f73-5afe-4373-877c-4e542ea2a588', 'fx8cn', '2020-04-05 12:32:13');
INSERT INTO "public"."sys_captcha" VALUES ('d68eed9c-8427-45fd-8c62-33a9c433cfa5', '78d3m', '2020-04-06 01:53:24');
INSERT INTO "public"."sys_captcha" VALUES ('cf39e097-1c73-4900-8dd5-ab156b399b6e', 'df3e6', '2020-04-06 01:53:42');
INSERT INTO "public"."sys_captcha" VALUES ('6c8edb7f-e0c5-437f-896a-2c6c802cd7d8', 'n6na3', '2020-04-06 02:15:10');
INSERT INTO "public"."sys_captcha" VALUES ('a4f12f5b-7d16-4ac4-838f-72ff40fc4f86', 'nm6yn', '2020-04-06 02:26:45');
INSERT INTO "public"."sys_captcha" VALUES ('71478817-fa4e-43fa-8ae0-8ff1866d9756', 'xb5ne', '2020-04-06 02:29:40');
INSERT INTO "public"."sys_captcha" VALUES ('3fb5d27c-7897-439d-8d14-465214509b82', '48gm3', '2020-04-07 09:06:26');
INSERT INTO "public"."sys_captcha" VALUES ('71bce183-8dd0-4311-8de4-8f0044d39d6e', 'adgyy', '2020-04-13 11:33:23');
INSERT INTO "public"."sys_captcha" VALUES ('93cfdf21-dcbc-4926-85a4-012195b329d9', 'ycdwn', '2020-04-13 11:40:49');
INSERT INTO "public"."sys_captcha" VALUES ('11acdce2-daec-4218-80c9-01b7bd35c7d7', 'n4fc5', '2020-04-13 11:47:57');
INSERT INTO "public"."sys_captcha" VALUES ('251f6e00-ffe5-4f71-84a0-9ce62e7013dc', '8mxed', '2020-04-14 09:28:33');
INSERT INTO "public"."sys_captcha" VALUES ('43f3edf8-c30e-4db0-8727-890afc9722d8', '4dfcm', '2020-04-14 12:07:15');
INSERT INTO "public"."sys_captcha" VALUES ('5ef61b94-6ab2-460f-8f3e-e4fb86ed4b2a', 'fe877', '2020-04-14 12:16:58');
INSERT INTO "public"."sys_captcha" VALUES ('f543d678-f5b9-4811-866d-44245aaddf8a', 'mna67', '2020-04-14 12:18:15');
INSERT INTO "public"."sys_captcha" VALUES ('47be966f-be63-4978-8973-2f80787aa7d8', 'y6mmw', '2020-04-14 12:18:32');
INSERT INTO "public"."sys_captcha" VALUES ('5f045297-f57f-4e66-8100-2c0c3dc320a6', 'mpn4c', '2020-04-14 12:18:45');
INSERT INTO "public"."sys_captcha" VALUES ('119d387e-bf9c-4c89-82b3-e376b734ba63', '64epx', '2020-04-14 12:24:16');
INSERT INTO "public"."sys_captcha" VALUES ('108af84e-50ba-4b62-81b3-af2297f14093', 'pe4ye', '2020-04-14 12:23:45');
INSERT INTO "public"."sys_captcha" VALUES ('f1d44e68-85b4-4a89-89a8-912ae093cb35', '2mc2b', '2020-04-15 08:46:34');
INSERT INTO "public"."sys_captcha" VALUES ('41aae70c-33f8-42e4-81af-eb0c650c6a47', 'nde6n', '2020-04-15 20:54:48');
INSERT INTO "public"."sys_captcha" VALUES ('6bd0551b-d557-4615-8e51-e25b7c9d052e', '4d426', '2020-04-16 02:32:19');
INSERT INTO "public"."sys_captcha" VALUES ('ab1f2a04-2258-4437-8847-036d8ab61de8', 'p7gap', '2020-04-22 23:32:10');

-- ----------------------------
-- Table structure for sys_department
-- ----------------------------
DROP TABLE IF EXISTS "public"."sys_department";
CREATE TABLE "public"."sys_department" (
  "dep_id" varchar(32) COLLATE "pg_catalog"."default" NOT NULL,
  "org_id" varchar(32) COLLATE "pg_catalog"."default" NOT NULL,
  "name" varchar(50) COLLATE "pg_catalog"."default" NOT NULL,
  "create_time" timestamp(0),
  "update_time" timestamp(0),
  "principal" varchar(50) COLLATE "pg_catalog"."default"
)
;
COMMENT ON COLUMN "public"."sys_department"."dep_id" IS '部门主键id';
COMMENT ON COLUMN "public"."sys_department"."org_id" IS '外键_组织架构id';
COMMENT ON COLUMN "public"."sys_department"."name" IS '部门名称';
COMMENT ON COLUMN "public"."sys_department"."create_time" IS '创建时间';
COMMENT ON COLUMN "public"."sys_department"."update_time" IS '修改时间';
COMMENT ON COLUMN "public"."sys_department"."principal" IS '负责人';
COMMENT ON TABLE "public"."sys_department" IS '部门表';

-- ----------------------------
-- Records of sys_department
-- ----------------------------
INSERT INTO "public"."sys_department" VALUES ('6d14c745e704653e7cc9cd986b18681b', '3a55ba063f356b495dc92b2de1218e2c', '测试部门', '2020-03-14 15:54:40', '2020-03-14 15:54:40', '');
INSERT INTO "public"."sys_department" VALUES ('18c949d164fd8369907afd25d3ae73ec', '47a381cbed420df373bfb900abc7ba4f', '立案庭', '2020-03-24 21:37:26', '2020-03-24 21:37:26', '');
INSERT INTO "public"."sys_department" VALUES ('eec6d5358717a7a96ec73e5b6ec2f711', '47a381cbed420df373bfb900abc7ba4f', '刑事审判第三庭', '2020-03-24 21:46:02', '2020-03-24 21:46:02', '');
INSERT INTO "public"."sys_department" VALUES ('9937cd136080107cda9c2ab9b9459930', '47a381cbed420df373bfb900abc7ba4f', '刑事审判第一庭', '2020-03-23 15:35:44', '2020-03-25 17:25:53', '');
INSERT INTO "public"."sys_department" VALUES ('f41a4bf2c69baa3d58e3e91d9b0afe67', '47a381cbed420df373bfb900abc7ba4f', '刑事审判第二庭', '2020-03-24 21:40:23', '2020-03-25 17:26:15', '');
INSERT INTO "public"."sys_department" VALUES ('5e4c115ea5cd0e1302caa06b78039e2c', '47a381cbed420df373bfb900abc7ba4f', '民事审判第一庭', '2020-03-24 21:40:41', '2020-03-25 17:26:28', '');
INSERT INTO "public"."sys_department" VALUES ('ba67a214cd7ff4e81fef592fb106b441', '47a381cbed420df373bfb900abc7ba4f', '民事审判第二庭', '2020-03-24 21:45:33', '2020-03-25 17:26:48', '');
INSERT INTO "public"."sys_department" VALUES ('16fba77e5d22dde665e8ec440671f8a4', '47a381cbed420df373bfb900abc7ba4f', '民事审判第三庭', '2020-03-24 21:45:47', '2020-03-25 17:27:02', '');
INSERT INTO "public"."sys_department" VALUES ('9e3a145bc8a118d1a2abafae8582057a', '47a381cbed420df373bfb900abc7ba4f', '民事审判第四庭', '2020-03-25 17:27:20', '2020-03-25 17:27:20', '');
INSERT INTO "public"."sys_department" VALUES ('9cf3dd989714c39072eb0e765f2250aa', '47a381cbed420df373bfb900abc7ba4f', '行政审判庭（赔偿委员会办公室）', '2020-03-25 17:27:59', '2020-03-25 17:27:59', '');
INSERT INTO "public"."sys_department" VALUES ('ecc93c5e99cb28f596c34afe7dfe5629', '47a381cbed420df373bfb900abc7ba4f', '审判监督庭', '2020-03-25 17:28:28', '2020-03-25 17:28:28', '');
INSERT INTO "public"."sys_department" VALUES ('2557ce8944f4598a9772026abdcba707', '47a381cbed420df373bfb900abc7ba4f', '执行局综合处', '2020-03-25 17:28:59', '2020-03-25 17:28:59', '');
INSERT INTO "public"."sys_department" VALUES ('b0cb34484f6aecc0f32e708babbe26cd', '47a381cbed420df373bfb900abc7ba4f', '执行一庭', '2020-03-25 17:29:18', '2020-03-25 17:29:18', '');
INSERT INTO "public"."sys_department" VALUES ('c91dc443b2e5d3863cc3daf1682792c2', '47a381cbed420df373bfb900abc7ba4f', '执行二庭', '2020-03-25 17:29:28', '2020-03-25 17:29:28', '');
INSERT INTO "public"."sys_department" VALUES ('050f2336b2d071c1105252a2ab0d29e6', '47a381cbed420df373bfb900abc7ba4f', '研究室', '2020-03-25 17:29:59', '2020-03-25 17:29:59', '');
INSERT INTO "public"."sys_department" VALUES ('af77707008af2b1ec6e4e546c3c078d3', '3753bed9631514a3998bbde9f72e5b0b', '立案庭', '2020-04-02 10:17:29', '2020-04-02 10:17:29', '');
INSERT INTO "public"."sys_department" VALUES ('216731894bd3a49042620ef5339c7c14', '610000', '人事部', '2020-04-05 22:53:16', '2020-04-05 22:53:16', '');

-- ----------------------------
-- Table structure for sys_dict
-- ----------------------------
DROP TABLE IF EXISTS "public"."sys_dict";
CREATE TABLE "public"."sys_dict" (
  "dict_id" varchar(40) COLLATE "pg_catalog"."default" NOT NULL,
  "value" varchar(255) COLLATE "pg_catalog"."default",
  "dict_name" varchar(50) COLLATE "pg_catalog"."default",
  "type" varchar(50) COLLATE "pg_catalog"."default",
  "description" text COLLATE "pg_catalog"."default",
  "seq" int4,
  "create_date" timestamp(6) DEFAULT now(),
  "update_date" timestamp(6) DEFAULT now(),
  "del_flag" int4 DEFAULT 0,
  "create_by" varchar(100) COLLATE "pg_catalog"."default",
  "update_by" varchar(100) COLLATE "pg_catalog"."default",
  "is_dict" varchar(255) COLLATE "pg_catalog"."default"
)
;
COMMENT ON COLUMN "public"."sys_dict"."dict_id" IS 'ID';
COMMENT ON COLUMN "public"."sys_dict"."value" IS '值';
COMMENT ON COLUMN "public"."sys_dict"."dict_name" IS '标签';
COMMENT ON COLUMN "public"."sys_dict"."type" IS '字典分类';
COMMENT ON COLUMN "public"."sys_dict"."description" IS '类型描述';
COMMENT ON COLUMN "public"."sys_dict"."seq" IS '序号';
COMMENT ON COLUMN "public"."sys_dict"."create_date" IS '创建时间';
COMMENT ON COLUMN "public"."sys_dict"."update_date" IS '更新时间';
COMMENT ON COLUMN "public"."sys_dict"."del_flag" IS '删除状态（0：可用   1：不可用）';
COMMENT ON COLUMN "public"."sys_dict"."create_by" IS '创建Id';
COMMENT ON COLUMN "public"."sys_dict"."update_by" IS '更新Id';
COMMENT ON COLUMN "public"."sys_dict"."is_dict" IS '是否是数据字典（用于动态表头）';
COMMENT ON TABLE "public"."sys_dict" IS '数据字典';

-- ----------------------------
-- Records of sys_dict
-- ----------------------------
INSERT INTO "public"."sys_dict" VALUES ('2e5fa58d124762dd78c3825455c0008d', '31', '优秀', 'coa_mgt', '考核标准管理', 31, '2019-11-13 13:57:59.173', '2019-11-13 13:57:59.173', 0, '', '', NULL);
INSERT INTO "public"."sys_dict" VALUES ('f250946b18ac30b90a98aed2eaff8e77', '3', '汉族', 'nation_mgt', '民族管理', 3, '2019-11-13 09:36:37', '2019-11-13 09:50:24', 0, '', 'admin', NULL);
INSERT INTO "public"."sys_dict" VALUES ('6a72b382437d3c0eb05c9c20cf6fa8c7', '4', '壮族', 'nation_mgt', '民族管理', 4, '2019-11-13 09:36:37', '2019-11-13 09:50:24', 0, '', 'admin', NULL);
INSERT INTO "public"."sys_dict" VALUES ('40091c3ebdfbac59d2a9954618e69387', '5', '满族', 'nation_mgt', '民族管理', 5, '2019-11-13 09:36:37', '2019-11-13 09:50:24', 0, '', 'admin', NULL);
INSERT INTO "public"."sys_dict" VALUES ('b7cd6a00737380b8f43611bd25c393fd', '6', '回族', 'nation_mgt', '民族管理', 6, '2019-11-13 09:36:37', '2019-11-13 09:50:24', 0, '', 'admin', NULL);
INSERT INTO "public"."sys_dict" VALUES ('c48c2e26180f4e0faf594f560176048f', '7', '苗族', 'nation_mgt', '民族管理', 7, '2019-11-13 09:36:37', '2019-11-13 09:50:24', 0, '', 'admin', NULL);
INSERT INTO "public"."sys_dict" VALUES ('d412210fa60d4200e029740c227cdc05', '9', '土家族', 'nation_mgt', '民族管理', 9, '2019-11-13 09:36:37', '2019-11-13 09:50:24', 0, '', 'admin', NULL);
INSERT INTO "public"."sys_dict" VALUES ('f14be904a036d0f97bcd8f99d42e815f', '10', '黎族', 'nation_mgt', '民族管理', 10, '2019-11-13 09:36:37', '2019-11-13 09:50:24', 0, '', 'admin', NULL);
INSERT INTO "public"."sys_dict" VALUES ('ca99b525fe72ad03185277c6703a32b5', '11', '蒙古族', 'nation_mgt', '民族管理', 11, '2019-11-13 09:36:37', '2019-11-13 09:50:24', 0, '', 'admin', NULL);
INSERT INTO "public"."sys_dict" VALUES ('b8114ae595ffb574479c05ea26be5cb5', '12', '藏族', 'nation_mgt', '民族管理', 12, '2019-11-13 11:50:20.399', '2019-11-13 11:50:20.399', 0, '', '', NULL);
INSERT INTO "public"."sys_dict" VALUES ('aa1e5a51f83b9373db4d59db16205e85', '15', '高级二等', 'rank_mgt', '职级管理', 15, '2019-11-13 11:55:21.909', '2019-11-13 11:55:21.909', 0, '', '', NULL);
INSERT INTO "public"."sys_dict" VALUES ('1576b34a3c4c53ec0d48b8d0ceb8c7ab', '16', '高级三等', 'rank_mgt', '职级管理', 16, '2019-11-13 11:55:41.717', '2019-11-13 11:55:41.717', 0, '', '', NULL);
INSERT INTO "public"."sys_dict" VALUES ('66bed89d72492fee4d76133fbddbbd83', '22', '初级三等', 'rank_mgt', '职级管理', 22, '2019-11-13 13:42:28.899', '2019-11-13 13:42:28.899', 0, '', '', NULL);
INSERT INTO "public"."sys_dict" VALUES ('7d467eb6cbaca10460ccbf2a0808f63e', '32', '良好', 'coa_mgt', '考核标准管理', 32, '2019-11-13 13:58:43.467', '2019-11-13 13:58:43.467', 0, '', '', NULL);
INSERT INTO "public"."sys_dict" VALUES ('3f5b6653a05dd5c38552eafc13097f59', '33', '称职', 'coa_mgt', '考核标准管理', 33, '2019-11-13 13:59:24.871', '2019-11-13 13:59:24.871', 0, '', '', NULL);
INSERT INTO "public"."sys_dict" VALUES ('55daff345f9a3243edc15790a915f599', '34', '基本称职', 'coa_mgt', '考核标准管理', 34, '2019-11-13 13:59:50.924', '2019-11-13 13:59:50.924', 0, '', '', NULL);
INSERT INTO "public"."sys_dict" VALUES ('3667208abcfe2ffcd34af76bbabde56e', '35', '不称职', 'coa_mgt', '考核标准管理', 35, '2019-11-13 14:00:30.55', '2019-11-13 14:00:30.55', 0, '', '', NULL);
INSERT INTO "public"."sys_dict" VALUES ('9f4d2a1f6bbfe879b7b59caad26acc62', '36', '年度考核', 'a_type_mgt', '考核类型管理', 36, '2019-11-13 14:03:18.343', '2019-11-13 14:03:18.343', 0, '', '', NULL);
INSERT INTO "public"."sys_dict" VALUES ('e11acee2ac6ae8241a5a601b199f8d10', '17', '中级一等', 'rank_mgt', '职级管理', 17, '2019-11-13 13:38:22.862', '2019-11-13 13:38:22.862', 0, '', '', NULL);
INSERT INTO "public"."sys_dict" VALUES ('029f8e0e4f022436096245a33b6ca654', '18', '中级二等', 'rank_mgt', '职级管理', 18, '2019-11-13 13:39:26.814', '2019-11-13 13:39:26.814', 0, '', '', NULL);
INSERT INTO "public"."sys_dict" VALUES ('be26bbf78f0113b9f17085f30a92739a', '19', '中级三等', 'rank_mgt', '职级管理', 19, '2019-11-13 13:40:13.225', '2019-11-13 13:40:13.225', 0, '', '', NULL);
INSERT INTO "public"."sys_dict" VALUES ('d079d95894a4255ed790658d47ccf742', '20', '初级一等', 'rank_mgt', '职级管理', 20, '2019-11-13 13:41:07.439', '2019-11-13 13:41:07.439', 0, '', '', NULL);
INSERT INTO "public"."sys_dict" VALUES ('e12f7e49ba7d442e4adb721886699d9e', '37', '季度考核', 'a_type_mgt', '考核类型管理', 37, '2019-11-13 14:03:43.226', '2019-11-13 14:03:43.226', 0, '', '', NULL);
INSERT INTO "public"."sys_dict" VALUES ('cfca1688426255568480a7f4e6971724', '21', '初级二等', 'rank_mgt', '职级管理', 21, '2019-11-13 13:41:51.915', '2019-11-13 13:41:51.915', 0, '', '', NULL);
INSERT INTO "public"."sys_dict" VALUES ('a0f4334a826d35e514f7d7d6ecd95958', '26', '奖励', 'rewpun_type_mgt', '奖惩类型管理', 26, '2019-11-13 13:52:08.478', '2019-11-13 13:52:08.478', 0, '', '', NULL);
INSERT INTO "public"."sys_dict" VALUES ('283f5d16cf5269f7af1da91c43dad3c2', '27', '处罚', 'rewpun_type_mgt', '奖惩类型管理', 27, '2019-11-13 13:52:31.322', '2019-11-13 13:52:31.322', 0, '', '', NULL);
INSERT INTO "public"."sys_dict" VALUES ('3ec567e9e501ef084b56523c6b2a58b9', '38', '月度考核', 'a_type_mgt', '考核类型管理', 38, '2019-11-13 14:04:24.383', '2019-11-13 14:04:24.383', 0, '', '', NULL);
INSERT INTO "public"."sys_dict" VALUES ('4b8eee9278098fac17fac84d9ca7c05a', '39', '个', 'es_mgt', '装备规格管理', 39, '2019-11-13 14:06:02.255', '2019-11-13 14:06:02.255', 0, '', '', NULL);
INSERT INTO "public"."sys_dict" VALUES ('06001fe129e2e66cd8ced58268a73c72', '41', '套', 'es_mgt', '装备规格管理', 41, '2019-11-13 14:06:47.686', '2019-11-13 14:06:47.686', 0, '', '', NULL);
INSERT INTO "public"."sys_dict" VALUES ('bdd5966ebf2974ce76171379fc8c4776', '42', '通知公告', 'at_mgt', '公告类型管理', 42, '2019-11-13 14:08:03.451', '2019-11-13 14:08:03.451', 0, '', '', NULL);
INSERT INTO "public"."sys_dict" VALUES ('63f0fd63cc09bfeea864227a8b5a4d83', '43', '设备类', 'et_mgt', '装备类型管理', 43, '2019-11-13 14:11:33.982', '2019-11-13 14:11:33.982', 0, '', '', NULL);
INSERT INTO "public"."sys_dict" VALUES ('fe3d8d9f3076cfb01da3ff28511724a4', '44', '材料类', 'et_mgt', '装备类型管理', 44, '2019-11-13 14:11:57.389', '2019-11-13 14:11:57.389', 0, '', '', NULL);
INSERT INTO "public"."sys_dict" VALUES ('a1f25979419bb897d17830a8e5d50d7e', '45', '耗材类', 'et_mgt', '装备类型管理', 45, '2019-11-13 14:12:28.364', '2019-11-13 14:12:28.364', 0, '', '', NULL);
INSERT INTO "public"."sys_dict" VALUES ('ef9c56eb43e320ad32316d53e3084ab6', '40', '台', 'es_mgt', '装备规格管理', 40, '2019-11-13 14:06:30.253', '2019-11-13 14:06:30.253', 0, '', '', NULL);
INSERT INTO "public"."sys_dict" VALUES ('2fbd0f4a11b6bbeb44f5f5fb63d45abf', '1', '男', 'gender', '性别', 1, '2019-11-21 17:01:24.042', '2019-11-21 17:01:24.042', 0, '', '', NULL);
INSERT INTO "public"."sys_dict" VALUES ('ace95095f4c02b50697dddb12a961525', '2', '女', 'gender', '性别', 2, '2019-11-21 17:01:49.226', '2019-11-21 17:01:49.226', 0, '', '', NULL);
INSERT INTO "public"."sys_dict" VALUES ('98cad6d14cab27acb1f0fe9bea569b43', '1', '未婚', 'marriageState', '婚姻状况', 1, '2019-11-22 08:53:39.47', '2019-11-22 08:53:39.47', 0, '', '', NULL);
INSERT INTO "public"."sys_dict" VALUES ('1bf71dbd6882e83c2f4fcf2be269ad06', '2', '已婚', 'marriageState', '婚姻状况', 2, '2019-11-22 08:54:14.339', '2019-11-22 08:54:14.339', 0, '', '', NULL);
INSERT INTO "public"."sys_dict" VALUES ('3f321810f5ac11ce0b5f16ec47e91bb6', '3', '离异', 'marriageState', '婚姻状况', 3, '2019-11-22 08:54:43.584', '2019-11-22 08:54:43.584', 0, '', '', NULL);
INSERT INTO "public"."sys_dict" VALUES ('c7cc79ea8366842f7d775545efbbd4ac', '4', '丧偶', 'marriageState', '婚姻状况', 4, '2019-11-22 08:55:34.385', '2019-11-22 08:55:34.385', 0, '', '', NULL);
INSERT INTO "public"."sys_dict" VALUES ('c3d2e4d76a5b704a2606dd4cd7094204', '2', '离职已归还', 'state', '装备管理', 2, '2019-11-26 09:51:37', '2020-04-01 17:31:09.034', 0, '', 'admin', NULL);
INSERT INTO "public"."sys_dict" VALUES ('18e7c7244335f6b81ec7c1911bd4caab', '3', '大专', 'edu_rank_mgt', '学历级别管理', 3, '2019-11-13 13:46:18', '2020-02-28 17:02:40.867', 0, '', 'admin', NULL);
INSERT INTO "public"."sys_dict" VALUES ('75024a68d81f790d633129c1280d0821', '2', '本科', 'edu_rank_mgt', '学历级别管理', 2, '2019-11-13 13:46:42', '2020-02-28 17:02:26.44', 0, '', 'admin', NULL);
INSERT INTO "public"."sys_dict" VALUES ('70e2116a4b26c2bed26ab806682f12cb', '13', '其他', 'nation_mgt', '民族管理', 13, '2019-11-13 11:50:52', '2020-03-24 17:29:02.057', 0, '', '833ea9c68cb9ca9a889293016c658c5d', NULL);
INSERT INTO "public"."sys_dict" VALUES ('28153555c89b1d4d90c5471b4e2a9e88', '14', '高级一等', 'rank_mgt', '职级管理', 1, '2019-11-13 11:55:00', '2020-03-12 15:06:27.881', 0, '', 'admin', NULL);
INSERT INTO "public"."sys_dict" VALUES ('731825670713ead928cbcbb824e105db', '1', '使用未归还', 'state', '装备管理', 1, '2019-11-26 09:51:11', '2020-04-01 17:30:52.5', 0, '', 'admin', NULL);
INSERT INTO "public"."sys_dict" VALUES ('895100637a1dc49f824c3752099f6f0c', '1', '学士', 'degree', '学位状况', 0, '2019-12-09 14:55:08.848', '2019-12-09 14:55:08.848', 0, '', '', NULL);
INSERT INTO "public"."sys_dict" VALUES ('9262ccd4520065d1f6b1f4fe08e8bac0', '2', '硕士', 'degree', '学位状况', 1, '2019-12-09 14:55:57.289', '2019-12-09 14:55:57.289', 0, '', '', NULL);
INSERT INTO "public"."sys_dict" VALUES ('743392c4995136843d38ae692dd3d1e4', '3', '博士', 'degree', '学位状况', 3, '2019-12-09 14:56:24.708', '2019-12-09 14:56:24.708', 0, '', '', NULL);
INSERT INTO "public"."sys_dict" VALUES ('1bd0c71a368d7ac47548be9e7bc83a84', '1', '事假', 'leaveType', '请假类型', 0, '2019-12-09 15:49:05.998', '2019-12-09 15:49:05.998', 0, '', '', NULL);
INSERT INTO "public"."sys_dict" VALUES ('99e4fc024a67792353525eed5c06bfbe', '2', '病假', 'leaveType', '请假类型', 2, '2019-12-09 15:49:31.93', '2019-12-09 15:49:31.93', 0, '', '', NULL);
INSERT INTO "public"."sys_dict" VALUES ('81f84c8f4e1f17bca5733397b5dfce84', '3', '婚假', 'leaveType', '请假类型', 3, '2019-12-09 15:50:44.199', '2019-12-09 15:50:44.199', 0, '', '', NULL);
INSERT INTO "public"."sys_dict" VALUES ('05d265275d94b7dc9ead33f75c2e0ecb', '4', '丧假', 'leaveType', '请假类型', 4, '2019-12-09 15:51:32.322', '2019-12-09 15:51:32.322', 0, '', '', NULL);
INSERT INTO "public"."sys_dict" VALUES ('7df1e6d0d1efa0be0084ccdd70603a7d', '5', '产假', 'leaveType', '请假类型', 5, '2019-12-09 15:52:10.732', '2019-12-09 15:52:10.732', 0, '', '', NULL);
INSERT INTO "public"."sys_dict" VALUES ('59dd1fd56a83b59cc1bee1ae973d1a8f', '6', '年假', 'leaveType', '请假类型', 6, '2019-12-09 15:52:38.121', '2019-12-09 15:52:38.121', 0, '', '', NULL);
INSERT INTO "public"."sys_dict" VALUES ('aeed8ce80719b08bb1453c65d3c25f6c', '1', '固定期限劳动合同', 'contractType', '合同类型', 1, '2019-12-10 15:06:42.126', '2019-12-10 15:06:42.126', 0, '', '', NULL);
INSERT INTO "public"."sys_dict" VALUES ('2a77bf053bf2f4fd03c32ee15cbc7bd8', '2', '无固定期限劳动合同', 'contractType', '合同类型', 2, '2019-12-10 15:07:38.965', '2019-12-10 15:07:38.965', 0, '', '', NULL);
INSERT INTO "public"."sys_dict" VALUES ('910eb7e18c70e1e2e49cb77938121f4d', '1', '配偶', 'sr_type_mgt', '社会关系类型管理', 1, '2019-11-13 13:56:59', '2020-01-03 16:06:15.602', 0, '', 'admin', NULL);
INSERT INTO "public"."sys_dict" VALUES ('5317a9431cea8f65cbfc369166c20ca6', '2', '父亲', 'sr_type_mgt', '社会关系类型管理', 2, '2019-11-13 13:56:01', '2020-01-03 16:04:19.267', 0, '', 'admin', NULL);
INSERT INTO "public"."sys_dict" VALUES ('8ced58089965dc355066764602b1eca0', '3', '母亲', 'sr_type_mgt', '社会关系类型管理', 3, '2019-11-13 13:55:18', '2020-01-03 16:04:07.945', 0, '', 'admin', NULL);
INSERT INTO "public"."sys_dict" VALUES ('be22f1e6bc7f71b9e19c717339df3283', '4', '儿子', 'sr_type_mgt', '社会关系类型管理', 4, '2019-11-13 13:56:01', '2020-01-03 16:01:29', 0, '', 'admin', NULL);
INSERT INTO "public"."sys_dict" VALUES ('bb73b8364df4481dd2c0c4cb7f2728d8', '1', '单位合同制', 'employmentForm', '用工形式', 1, '2019-12-09 16:11:17', '2020-03-30 14:16:45.587', 0, '', 'admin', NULL);
INSERT INTO "public"."sys_dict" VALUES ('ece2b1928b095f3a23f142a81ccd4ccb', '2', '派遣合同制', 'employmentForm', '用工形式', 2, '2019-12-09 16:11:37', '2020-03-30 14:17:35.799', 0, '', 'admin', NULL);
INSERT INTO "public"."sys_dict" VALUES ('a4ad71c0fcd9c0e98df64e835d3b76ae', '6', '其他', 'sr_type_mgt', '社会关系管理', 6, '2019-11-13 13:56:01', '2020-01-03 16:01:29', 0, '', 'admin', NULL);
INSERT INTO "public"."sys_dict" VALUES ('c727b6820d42bef84be172c385d7585f', '5', '女儿', 'sr_type_mgt', '社会关系管理', 5, '2019-11-13 13:56:01', '2020-01-03 16:06:32.147', 0, '', 'admin', NULL);
INSERT INTO "public"."sys_dict" VALUES ('f3eb6026c3d58959a76ec5e9f344e4bd', '1', '规定类', 'resourceType', '资源共享类型', 0, '2019-12-17 08:53:57', '2020-01-22 14:57:57.61', 0, '', 'admin', '');
INSERT INTO "public"."sys_dict" VALUES ('a56b811a963f09e77ebcc9d538fb6ec4', '2', '规定类', 'resourceType', '资源共享类型', 1, '2019-12-17 08:57:25', '2020-01-22 14:59:37.308', 0, '', 'admin', '');
INSERT INTO "public"."sys_dict" VALUES ('eeea019da638678cb786518d9f01be1e', '1', '研究生', 'edu_rank_mgt', '学历状况', 1, '2019-12-09 15:02:45', '2020-03-12 15:07:43.887', 0, '', 'admin', NULL);
INSERT INTO "public"."sys_dict" VALUES ('ceb86b4c2b7ea3e98ea527ced4271be2', '4', '中专', 'edu_rank_mgt', '学历级别管理', 4, '2019-11-13 13:45:44', '2020-02-28 17:02:53.82', 0, '', 'admin', NULL);
INSERT INTO "public"."sys_dict" VALUES ('52b0b999238b392578c87a5d95a63859', '23', '暂无职级', 'rank_mgt', '职级管理', 23, '2019-11-13 11:55:00', '2020-02-28 17:11:23.282', 0, '', 'admin', NULL);
INSERT INTO "public"."sys_dict" VALUES ('1fe99d46f0222879c7f0a8b35bc9a0f0', '1', '主账号', 'user_type', '用户类型', 0, '2020-03-09 15:55:28.721', '2020-03-09 15:55:28.721', 0, '', '', '');
INSERT INTO "public"."sys_dict" VALUES ('92ba8abbaa9dcd7d773260fe0a433b8b', '2', '子账号', 'user_type', '用户类型', 1, '2020-03-09 15:55:57.791', '2020-03-09 15:55:57.791', 0, '', '', '');
INSERT INTO "public"."sys_dict" VALUES ('7e6717aa151fd6d46407f610e7a66742', '1', '法学类', 'specialty', '所学专业', 1, '2020-03-25 17:40:37', '2020-03-27 21:56:17.006', 0, '', '833ea9c68cb9ca9a889293016c658c5d', '');
INSERT INTO "public"."sys_dict" VALUES ('fe8a8003ac160fdcf737b8d31031c781', '2', '其他类', 'specialty', '所学专业', 2, '2020-03-25 17:42:10', '2020-03-27 22:02:28.848', 0, '', '833ea9c68cb9ca9a889293016c658c5d', '');
INSERT INTO "public"."sys_dict" VALUES ('f07980867f362bddeb59ccb78082b04b', '42', '张', 'es_mgt', '装备规格管理', 0, '2019-12-17 08:53:57', '2020-03-30 09:33:48.954', 0, '', 'admin', '');
INSERT INTO "public"."sys_dict" VALUES ('1de5487fb56f19b1ff5a38d591aab5dd', '5', '高中', 'edu_rank_mgt', '学历管理', 6, '2019-11-13 13:45:44', '2020-04-01 16:15:46.97', 0, '', 'admin', NULL);
INSERT INTO "public"."sys_dict" VALUES ('af5bbadf073f6bab0405621df5b9c066', '6', '初中', 'edu_rank_mgt', '学历管理', 6, '2019-11-13 13:45:44', '2020-03-06 11:09:45', 0, '', 'admin', NULL);
INSERT INTO "public"."sys_dict" VALUES ('341e6f298dc28998d5ffa9c544134479', '7', '小学', 'edu_rank_mgt', '学历管理', 7, '2019-11-13 13:45:44', '2020-03-06 11:09:45', 0, '', 'admin', NULL);
INSERT INTO "public"."sys_dict" VALUES ('e70fa30e01f543402c1f1d92a3029196', '8', '学前', 'edu_rank_mgt', '学历管理', 8, '2019-11-13 13:45:44', '2020-03-06 11:09:45', 0, '', 'admin', NULL);
INSERT INTO "public"."sys_dict" VALUES ('982f99deb7d4e20664338a05d315792f', '2', '会计', 'position', '所任职位', 2, '2020-03-30 10:05:35', '2020-04-01 15:44:18.428', 0, '', 'admin', '');

-- ----------------------------
-- Table structure for sys_log
-- ----------------------------
DROP TABLE IF EXISTS "public"."sys_log";
CREATE TABLE "public"."sys_log" (
  "id" int4 NOT NULL DEFAULT nextval('sys_log_id_seq'::regclass),
  "username" varchar(254) COLLATE "pg_catalog"."default",
  "operation" varchar(254) COLLATE "pg_catalog"."default",
  "method" varchar(254) COLLATE "pg_catalog"."default",
  "params" text COLLATE "pg_catalog"."default",
  "time" int8,
  "ip" varchar(254) COLLATE "pg_catalog"."default",
  "create_date" timestamp(0)
)
;
COMMENT ON COLUMN "public"."sys_log"."username" IS '用户';
COMMENT ON COLUMN "public"."sys_log"."operation" IS '用户操作';
COMMENT ON COLUMN "public"."sys_log"."method" IS '请求方法';
COMMENT ON COLUMN "public"."sys_log"."params" IS '用户操作';
COMMENT ON COLUMN "public"."sys_log"."time" IS '执行时长(毫秒)';
COMMENT ON COLUMN "public"."sys_log"."ip" IS 'IP地址';
COMMENT ON COLUMN "public"."sys_log"."create_date" IS 'params';
COMMENT ON TABLE "public"."sys_log" IS '系统日志';

-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
DROP TABLE IF EXISTS "public"."sys_menu";
CREATE TABLE "public"."sys_menu" (
  "menu_id" varchar(32) COLLATE "pg_catalog"."default" NOT NULL,
  "parent_id" varchar(32) COLLATE "pg_catalog"."default",
  "name" varchar(254) COLLATE "pg_catalog"."default",
  "url" varchar(254) COLLATE "pg_catalog"."default",
  "perms" varchar(254) COLLATE "pg_catalog"."default",
  "type" int4,
  "icon" varchar(254) COLLATE "pg_catalog"."default",
  "order_num" int4,
  "component_url" varchar(254) COLLATE "pg_catalog"."default",
  "route_name" varchar(254) COLLATE "pg_catalog"."default",
  "enabled" int4 DEFAULT 1,
  "location_type" int4 DEFAULT 1,
  "route_only" int2 DEFAULT 1
)
;
COMMENT ON COLUMN "public"."sys_menu"."menu_id" IS '菜单ID';
COMMENT ON COLUMN "public"."sys_menu"."parent_id" IS '父菜单ID，一级菜单为null';
COMMENT ON COLUMN "public"."sys_menu"."name" IS '菜单名称';
COMMENT ON COLUMN "public"."sys_menu"."url" IS '菜单URL';
COMMENT ON COLUMN "public"."sys_menu"."perms" IS '授权(多个用逗号分隔，如：user:list,user:create)';
COMMENT ON COLUMN "public"."sys_menu"."type" IS '类型   0：目录   1：菜单   2：按钮';
COMMENT ON COLUMN "public"."sys_menu"."icon" IS '菜单图标';
COMMENT ON COLUMN "public"."sys_menu"."order_num" IS '排序';
COMMENT ON COLUMN "public"."sys_menu"."component_url" IS '组件的地址';
COMMENT ON COLUMN "public"."sys_menu"."route_name" IS '路由名称';
COMMENT ON COLUMN "public"."sys_menu"."enabled" IS '是否启用 1-启用';
COMMENT ON COLUMN "public"."sys_menu"."location_type" IS '放置类型 1-菜单 2-工具栏';
COMMENT ON TABLE "public"."sys_menu" IS '菜单管理';

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
INSERT INTO "public"."sys_menu" VALUES ('38b0786acd1a53450e1399836ce367ce', '0', '离职员工', '', '', 0, 'offwork', 5, '', '', 1, 1, 1);
INSERT INTO "public"."sys_menu" VALUES ('ce3b7e2fed333575499eff8f9e02f369', '08b0f5b6e5748d543aabea810808468a', '数据字典', '/sys/dict', 'sys:dict', 1, 'bianji', 0, 'main/black-main', 'sys_dict', 1, 1, 1);
INSERT INTO "public"."sys_menu" VALUES ('4', '08b0f5b6e5748d543aabea810808468a', '菜单管理', '/sys/menu', 'sys:menu', 1, 'menu', 2, 'main/black-main', 'sys_menu', 1, 1, 1);
INSERT INTO "public"."sys_menu" VALUES ('7c410ad5bfc99111cef48a76f7318117', '0', '在职员工', '', '', 0, 'onwork', 3, '', '', 1, 1, 1);
INSERT INTO "public"."sys_menu" VALUES ('59f2dfbb1f5bb1ed776219ef10c9d810', '7c410ad5bfc99111cef48a76f7318117', '在职员工管理', '/employee/inServiceStaff_list', '', 1, '', 1, 'employee/inServiceStaff_list', 'employee_inServiceStaff_list', 1, 1, 1);
INSERT INTO "public"."sys_menu" VALUES ('9d38bf2ff6d332f33624b92726be40af', '38b0786acd1a53450e1399836ce367ce', '离职人员管理', '/employee/dimissionServiceStaff_list', '', 1, '', 0, 'employee/dimissionServiceStaff_list', 'employee_dimissionServiceStaff_list', 1, 1, 1);
INSERT INTO "public"."sys_menu" VALUES ('6138755787a77ba237a2b39f865385ad', 'ce3b7e2fed333575499eff8f9e02f369', '列表', '/sys/dict/list', '', 1, '', 0, 'sys/dict/list', 'sys_dict_list', 1, 1, 2);
INSERT INTO "public"."sys_menu" VALUES ('22', '3', '删除', NULL, 'sys:role:delete', 2, NULL, 1, NULL, NULL, 1, 1, 1);
INSERT INTO "public"."sys_menu" VALUES ('26', '4', '删除', NULL, 'sys:menu:delete', 2, NULL, 0, NULL, NULL, 1, 1, 1);
INSERT INTO "public"."sys_menu" VALUES ('25', '4', '修改', '/sys/menu/update', 'sys:menu:update,sys:menu:select', 1, NULL, 3, 'sys/menu/add-or-update', 'sys_menu_update', 1, 1, 1);
INSERT INTO "public"."sys_menu" VALUES ('24', '4', '新增', '/sys/menu/add', 'sys:menu:save,sys:menu:select', 1, NULL, 2, 'sys/menu/add-or-update', 'sys_menu_add', 1, 1, 1);
INSERT INTO "public"."sys_menu" VALUES ('08b0f5b6e5748d543aabea810808468a', '0', '数据维护', '/sys/notice', '', 0, 'shuju', 2, 'sys/notice/list', '', 1, 1, 1);
INSERT INTO "public"."sys_menu" VALUES ('11111', '4', '菜单列表', '/sys/menu/list', NULL, 1, 'menu', -1, 'sys/menu/list', 'sys_menu_list', 1, 1, 2);
INSERT INTO "public"."sys_menu" VALUES ('23', '4', '查看', '/sys/menu/list', 'sys:menu:list,sys:menu:info', 1, NULL, 0, 'sys/menu/info', 'sys_menu_info', 1, 1, 1);
INSERT INTO "public"."sys_menu" VALUES ('12c605b33c65a90e26ce7836aed89f74', 'ce3b7e2fed333575499eff8f9e02f369', '修改', '/sys/dict/update', 'sys:sysdict:update', 1, '', 1, 'sys/dict/add-or-update', 'sys_dict_update', 1, 1, 2);
INSERT INTO "public"."sys_menu" VALUES ('7e52a6dce0b39ddd91e9b6c392c23ad9', 'ce3b7e2fed333575499eff8f9e02f369', '新增', '/sys/dict/add', 'sys:sysdict:save', 1, '', 2, 'sys/dict/add-or-update', 'sys_dict_add', 1, 1, 2);
INSERT INTO "public"."sys_menu" VALUES ('19', '3', '查看', '/sys/role/list', '', 1, NULL, 0, 'sys/role/list', 'sys-role-list', 1, 1, 1);
INSERT INTO "public"."sys_menu" VALUES ('20', '3', '新增', '/sys/role/add', 'sys:role:save,sys:menu:list', 1, NULL, 1, 'sys/role/add-or-update', 'sys_role_add', 1, 1, 1);
INSERT INTO "public"."sys_menu" VALUES ('21', '3', '修改', '/sys/role/update', 'sys:role:update,sys:menu:list', 1, NULL, 1, 'sys/role/add-or-update', 'sys_role_update', 1, 1, 1);
INSERT INTO "public"."sys_menu" VALUES ('5cf728b90d0e416a2e47084c90765c84', '2', '列表', '/sys/user/list', 'sys:user:list', 1, 'admin', 0, 'sys/user/list', 'sys/user/list', 1, 1, 1);
INSERT INTO "public"."sys_menu" VALUES ('02989315d1026ce87068c3d7c0a196f5', '2', '新增', '/sys/user/add', '', 1, '', 1, 'sys/user/add-or-update', 'sys/user/add', 1, 1, 1);
INSERT INTO "public"."sys_menu" VALUES ('0e0c12e149be9a37a611fd9fc4b56306', '27', '列表', '/sys/config/list', '', 1, '', 0, 'sys/config/list', 'sys_config_list', 1, 1, 2);
INSERT INTO "public"."sys_menu" VALUES ('f45b6fb5400f7e5c5349fbaa531704f6', '2', '修改', 'sys_role_update', '', 1, NULL, 2, 'sys/user/add-or-update', 'sys/user/update', 1, 1, 1);
INSERT INTO "public"."sys_menu" VALUES ('2', 'acf24b6931b04bc28508cd11c22dfba3', '账号管理', '/sys/user', '', 1, 'zhanghao', 0, 'sys/user/list', 'sys/user', 1, 1, 1);
INSERT INTO "public"."sys_menu" VALUES ('3', 'acf24b6931b04bc28508cd11c22dfba3', '角色管理', '/sys/role', NULL, 1, 'juese', 2, 'sys/role/list', 'sys_role', 1, 1, 1);
INSERT INTO "public"."sys_menu" VALUES ('acf24b6931b04bc28508cd11c22dfba3', '0', '系统管理', '', '', 0, 'xitong', 0, '', '', 1, 1, 1);
INSERT INTO "public"."sys_menu" VALUES ('bbd2ab2baf5d9c66fe5b194dfc78d7db', 'acf24b6931b04bc28508cd11c22dfba3', '密码修改', '/sys/user/password', '', 1, 'mima', 2, 'sys/user/info', 'sys/user/password', 1, 1, 1);

-- ----------------------------
-- Table structure for sys_organization
-- ----------------------------
DROP TABLE IF EXISTS "public"."sys_organization";
CREATE TABLE "public"."sys_organization" (
  "id" varchar(32) COLLATE "pg_catalog"."default" NOT NULL,
  "name" varchar(20) COLLATE "pg_catalog"."default" NOT NULL,
  "parent_id" varchar(32) COLLATE "pg_catalog"."default",
  "order_num" int2,
  "create_time" timestamp(6),
  "update_time" timestamp(6)
)
;
COMMENT ON COLUMN "public"."sys_organization"."id" IS '组织编码';
COMMENT ON COLUMN "public"."sys_organization"."name" IS '名称';
COMMENT ON COLUMN "public"."sys_organization"."parent_id" IS '上级组织';
COMMENT ON COLUMN "public"."sys_organization"."order_num" IS '排列顺序';
COMMENT ON COLUMN "public"."sys_organization"."create_time" IS '创建时间';
COMMENT ON COLUMN "public"."sys_organization"."update_time" IS '修改时间';
COMMENT ON TABLE "public"."sys_organization" IS '陕西省省市区级联表';

-- ----------------------------
-- Records of sys_organization
-- ----------------------------
INSERT INTO "public"."sys_organization" VALUES ('610000', '测试公司', '0', 0, NULL, '2020-03-25 08:28:58.64');

-- ----------------------------
-- Table structure for sys_res_file
-- ----------------------------
DROP TABLE IF EXISTS "public"."sys_res_file";
CREATE TABLE "public"."sys_res_file" (
  "file_uid" varchar(32) COLLATE "pg_catalog"."default",
  "res_id" varchar(32) COLLATE "pg_catalog"."default",
  "file_name" varchar(50) COLLATE "pg_catalog"."default",
  "state" int4,
  "file_url" varchar(100) COLLATE "pg_catalog"."default"
)
;
COMMENT ON COLUMN "public"."sys_res_file"."file_uid" IS '文件UUID';
COMMENT ON COLUMN "public"."sys_res_file"."res_id" IS '关联ID';
COMMENT ON COLUMN "public"."sys_res_file"."file_name" IS '文件名称';
COMMENT ON COLUMN "public"."sys_res_file"."state" IS '0-notice;1-resource';
COMMENT ON COLUMN "public"."sys_res_file"."file_url" IS '文件路径';

-- ----------------------------
-- Records of sys_res_file
-- ----------------------------
INSERT INTO "public"."sys_res_file" VALUES ('1577087284898', 'a252099896dc5d7e19a13a237b2b8d78', '企业改版开发计划_人员分工(1).xlsx', 0, 'http://114.116.30.229/group1/M00/00/FE/wKgBol4AcTeAXQJKAAAzWODdtxM35.xlsx');
INSERT INTO "public"."sys_res_file" VALUES ('1577087517809', 'a252099896dc5d7e19a13a237b2b8d78', '增加功能：(1).doc', 0, 'http://114.116.30.229/group1/M00/00/FE/wKgBol4AciCAfBbXAABoACpJngQ968.doc');
INSERT INTO "public"."sys_res_file" VALUES ('1577092506130', '2566b8532b3576c5b7a501d89e479b7d', '企业改版开发计划_人员分工(1).xlsx', 1, 'http://114.116.30.229/group1/M00/00/FE/wKgBol4AhZyABQN6AAAzWODdtxM50.xlsx');
INSERT INTO "public"."sys_res_file" VALUES ('1577092510897', '2566b8532b3576c5b7a501d89e479b7d', '增加功能：(1).doc', 1, 'http://114.116.30.229/group1/M00/00/FE/wKgBol4AhaGAa3XOAABoACpJngQ909.doc');
INSERT INTO "public"."sys_res_file" VALUES ('1577176302686', 'db9d6bbf5044ab6db8a4bd3e8ffe5629', '企业改版开发计划_人员分工(1).xlsx', 0, 'http://114.116.30.229/group1/M00/01/00/wKgBol4BzO6APWXTAAAzWODdtxM20.xlsx');
INSERT INTO "public"."sys_res_file" VALUES ('1577238547878', '1bd7d4b16b1e54c96cba7f47ca788f8b', '新文件名.xls', 1, 'http://114.116.30.229/group1/M00/01/00/wKgBol4CwBWAL6oKAAA1EB7jA0Q734.xls');
INSERT INTO "public"."sys_res_file" VALUES ('1577238552050', '1bd7d4b16b1e54c96cba7f47ca788f8b', '新文件名.xls', 1, 'http://114.116.30.229/group1/M00/01/00/wKgBol4CwBmAXyQzAAA1EB7jA0Q857.xls');
INSERT INTO "public"."sys_res_file" VALUES ('1577238557170', '1bd7d4b16b1e54c96cba7f47ca788f8b', '新文件名.xls', 1, 'http://114.116.30.229/group1/M00/01/00/wKgBol4CwB-Aez5KAAA1EB7jA0Q337.xls');
INSERT INTO "public"."sys_res_file" VALUES ('1577238561546', '1bd7d4b16b1e54c96cba7f47ca788f8b', '新文件名.xls', 1, 'http://114.116.30.229/group1/M00/01/00/wKgBol4CwCOAZEAZAAA1EB7jA0Q268.xls');
INSERT INTO "public"."sys_res_file" VALUES ('1577238566176', '1bd7d4b16b1e54c96cba7f47ca788f8b', 'linux目录结构.docx', 1, 'http://114.116.30.229/group1/M00/01/00/wKgBol4CwCiACFOIAAB39ZLsIqY48.docx');
INSERT INTO "public"."sys_res_file" VALUES ('1577238572620', '1bd7d4b16b1e54c96cba7f47ca788f8b', 'linux目录结构.docx', 1, 'http://114.116.30.229/group1/M00/01/00/wKgBol4CwC6AZP0VAAB39ZLsIqY21.docx');
INSERT INTO "public"."sys_res_file" VALUES ('1577252512009', 'f37c99d77939082683aac94715cbe471', '职员档案20191220.xls', 0, 'http://114.116.30.229/group1/M00/01/01/wKgBol4C9p-ACcFzAABgAKPs4J8454.xls');
INSERT INTO "public"."sys_res_file" VALUES ('1578385019212', '2495439d88e5815f7e87e043ca22842f', '职员档案20191220.xls', 0, 'http://114.116.30.229/group1/M00/01/0B/wKgBol4UPniAZOy7AABgAOQevFs900.xls');
INSERT INTO "public"."sys_res_file" VALUES ('1578449738928', '714cfb188589825a66d6eb90e4fedbf6', '职员档案20191220.xls', 1, 'http://114.116.30.229/group1/M00/01/0B/wKgBol4VO0eAOEx0AABgAOQevFs226.xls');
INSERT INTO "public"."sys_res_file" VALUES ('1578449745826', '714cfb188589825a66d6eb90e4fedbf6', '职员档案20191220.xls', 1, 'http://114.116.30.229/group1/M00/01/0B/wKgBol4VO06AWav8AABgAOQevFs946.xls');
INSERT INTO "public"."sys_res_file" VALUES ('1578449753689', '714cfb188589825a66d6eb90e4fedbf6', '职员档案20191220.xls', 1, 'http://114.116.30.229/group1/M00/01/0B/wKgBol4VO1aAAKdZAABgAOQevFs010.xls');
INSERT INTO "public"."sys_res_file" VALUES ('1578449915767', 'd3c15064edbb07b2fa8172463c7373de', '一期功能点列表(1).xlsx', 1, 'http://114.116.30.229/group1/M00/01/0B/wKgBol4VO_iAMOciAAA_qn08xik47.xlsx');
INSERT INTO "public"."sys_res_file" VALUES ('1578449922508', 'd3c15064edbb07b2fa8172463c7373de', '职员档案20191220.xls', 1, 'http://114.116.30.229/group1/M00/01/0B/wKgBol4VO_-ASuu9AABgAOQevFs745.xls');
INSERT INTO "public"."sys_res_file" VALUES ('1578449994855', '4be142f4ac8c0bff840361776d62a119', '一期功能点列表(1).xlsx', 1, 'http://114.116.30.229/group1/M00/01/0B/wKgBol4VPEeARbzdAAA_qn08xik09.xlsx');

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS "public"."sys_role";
CREATE TABLE "public"."sys_role" (
  "role_id" varchar(32) COLLATE "pg_catalog"."default" NOT NULL,
  "role_name" varchar(254) COLLATE "pg_catalog"."default",
  "remark" varchar(254) COLLATE "pg_catalog"."default",
  "create_user_id" varchar(254) COLLATE "pg_catalog"."default",
  "create_time" timestamp(0)
)
;
COMMENT ON COLUMN "public"."sys_role"."role_id" IS '角色ID';
COMMENT ON COLUMN "public"."sys_role"."role_name" IS '角色名称';
COMMENT ON COLUMN "public"."sys_role"."remark" IS '备注';
COMMENT ON COLUMN "public"."sys_role"."create_user_id" IS '创建者ID';
COMMENT ON COLUMN "public"."sys_role"."create_time" IS '创建时间';
COMMENT ON TABLE "public"."sys_role" IS '角色';

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO "public"."sys_role" VALUES ('89af4fdfde05a8689d47171e04a38449', '行政部', '', 'admin', '2020-04-13 12:55:07');

-- ----------------------------
-- Table structure for sys_role_menu
-- ----------------------------
DROP TABLE IF EXISTS "public"."sys_role_menu";
CREATE TABLE "public"."sys_role_menu" (
  "id" varchar(32) COLLATE "pg_catalog"."default" NOT NULL,
  "role_id" varchar(32) COLLATE "pg_catalog"."default",
  "menu_id" varchar(32) COLLATE "pg_catalog"."default"
)
;
COMMENT ON COLUMN "public"."sys_role_menu"."role_id" IS '角色ID';
COMMENT ON COLUMN "public"."sys_role_menu"."menu_id" IS '菜单ID';
COMMENT ON TABLE "public"."sys_role_menu" IS '角色与菜单对应关系';

-- ----------------------------
-- Records of sys_role_menu
-- ----------------------------
INSERT INTO "public"."sys_role_menu" VALUES ('fa61e8415e24e4c2ac3307de29e53d89', '89af4fdfde05a8689d47171e04a38449', 'acf24b6931b04bc28508cd11c22dfba3');
INSERT INTO "public"."sys_role_menu" VALUES ('b7bbfa0bb59a55e05b8863a1c75905eb', '89af4fdfde05a8689d47171e04a38449', '2');
INSERT INTO "public"."sys_role_menu" VALUES ('7680e393e44a64b742b75bfaee925d17', '89af4fdfde05a8689d47171e04a38449', '5cf728b90d0e416a2e47084c90765c84');
INSERT INTO "public"."sys_role_menu" VALUES ('ac5f6582ce8504f0fb83250bc884363b', '89af4fdfde05a8689d47171e04a38449', '02989315d1026ce87068c3d7c0a196f5');
INSERT INTO "public"."sys_role_menu" VALUES ('35e2a28b8f7fd7132599f19e62a3a4c6', '89af4fdfde05a8689d47171e04a38449', 'f45b6fb5400f7e5c5349fbaa531704f6');
INSERT INTO "public"."sys_role_menu" VALUES ('50604e220e2fe0aad6349e585ecc6dab', '89af4fdfde05a8689d47171e04a38449', '3');
INSERT INTO "public"."sys_role_menu" VALUES ('2c5cb7d566ba65186c94f377d785b904', '89af4fdfde05a8689d47171e04a38449', '19');
INSERT INTO "public"."sys_role_menu" VALUES ('4cea32e21ee8987ca16fb1a6174c4f85', '89af4fdfde05a8689d47171e04a38449', '22');
INSERT INTO "public"."sys_role_menu" VALUES ('93c73e780ca72317355e873b558d4b60', '89af4fdfde05a8689d47171e04a38449', '20');
INSERT INTO "public"."sys_role_menu" VALUES ('1424d6f43a65c6037285c0c1a7b3604e', '89af4fdfde05a8689d47171e04a38449', '21');
INSERT INTO "public"."sys_role_menu" VALUES ('939f3705af90dc85bd6e638807caa558', '89af4fdfde05a8689d47171e04a38449', 'bbd2ab2baf5d9c66fe5b194dfc78d7db');
INSERT INTO "public"."sys_role_menu" VALUES ('d03ce3b1f861ed10775f283fdeea6bd0', '89af4fdfde05a8689d47171e04a38449', 'f57fe4e317737c9f92c888fe019257af');
INSERT INTO "public"."sys_role_menu" VALUES ('adb9baa80d3be8cfae437a6bf8f54775', '89af4fdfde05a8689d47171e04a38449', '08b0f5b6e5748d543aabea810808468a');
INSERT INTO "public"."sys_role_menu" VALUES ('c379127b6fa07f2e370a6effa461e2cf', '89af4fdfde05a8689d47171e04a38449', 'ce3b7e2fed333575499eff8f9e02f369');
INSERT INTO "public"."sys_role_menu" VALUES ('2715dce016c22f7bd461d629dea87f60', '89af4fdfde05a8689d47171e04a38449', '6138755787a77ba237a2b39f865385ad');
INSERT INTO "public"."sys_role_menu" VALUES ('f6343e71eb8343338dd50c2e25513e9a', '89af4fdfde05a8689d47171e04a38449', '12c605b33c65a90e26ce7836aed89f74');
INSERT INTO "public"."sys_role_menu" VALUES ('f5a04b103ee06de2b123b5b68a3f2a07', '89af4fdfde05a8689d47171e04a38449', '7e52a6dce0b39ddd91e9b6c392c23ad9');
INSERT INTO "public"."sys_role_menu" VALUES ('dbbef5bae0464e634fa340d5040627b4', '89af4fdfde05a8689d47171e04a38449', '4');
INSERT INTO "public"."sys_role_menu" VALUES ('6eb3d11f9d0b47482fe5c84bd2beb2cb', '89af4fdfde05a8689d47171e04a38449', '11111');
INSERT INTO "public"."sys_role_menu" VALUES ('8d1ef6d05542f847e9f76428e43a0c4b', '89af4fdfde05a8689d47171e04a38449', '26');
INSERT INTO "public"."sys_role_menu" VALUES ('1e814b6383541077613526abcb332849', '89af4fdfde05a8689d47171e04a38449', '23');
INSERT INTO "public"."sys_role_menu" VALUES ('f804c1eb4941882ca42e6d404ad92a01', '89af4fdfde05a8689d47171e04a38449', '24');
INSERT INTO "public"."sys_role_menu" VALUES ('6881dc62cefac0f0dd61545da59666d0', '89af4fdfde05a8689d47171e04a38449', '25');
INSERT INTO "public"."sys_role_menu" VALUES ('ae878b3b23d739eb31c202fe2962246e', '89af4fdfde05a8689d47171e04a38449', '27');
INSERT INTO "public"."sys_role_menu" VALUES ('18ad42453712cd7e1f1d168b56e45de0', '89af4fdfde05a8689d47171e04a38449', 'bc94fde2a96742a5edc01a1148168e4c');
INSERT INTO "public"."sys_role_menu" VALUES ('d9003a454616b03559cdeee1d2f4745e', '89af4fdfde05a8689d47171e04a38449', '12b4fa7086d33b80198fc62a24e1c821');
INSERT INTO "public"."sys_role_menu" VALUES ('2a3689c063980c0617c51c3729c2a2ed', '89af4fdfde05a8689d47171e04a38449', 'b5704601866e58775a1ae3210a5c5615');

-- ----------------------------
-- Table structure for sys_upload
-- ----------------------------
DROP TABLE IF EXISTS "public"."sys_upload";
CREATE TABLE "public"."sys_upload" (
  "id" varchar(50) COLLATE "pg_catalog"."default" NOT NULL,
  "upload_name" varchar(50) COLLATE "pg_catalog"."default",
  "new_name" varchar(255) COLLATE "pg_catalog"."default",
  "url" varchar(255) COLLATE "pg_catalog"."default",
  "main_id" varchar(50) COLLATE "pg_catalog"."default"
)
;
COMMENT ON COLUMN "public"."sys_upload"."id" IS 'id';
COMMENT ON COLUMN "public"."sys_upload"."upload_name" IS '上传名称';
COMMENT ON COLUMN "public"."sys_upload"."new_name" IS '新名称';
COMMENT ON COLUMN "public"."sys_upload"."url" IS '地址';
COMMENT ON COLUMN "public"."sys_upload"."main_id" IS '主表id';
COMMENT ON TABLE "public"."sys_upload" IS '附件表';

-- ----------------------------
-- Records of sys_upload
-- ----------------------------
INSERT INTO "public"."sys_upload" VALUES ('a30709a9c892e84dbf9277b13f98a38c', NULL, '附件1', 'http://114.116.30.229/group1/M00/01/23/wKgBol4lf4aAFTEdAAVAIhO_a3w771.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('227bcaba3ecb7f068faa5775da24f4eb', NULL, '附件1', 'http://114.116.30.229/group1/M00/01/23/wKgBol4lgM-AfYx9AAYknhrDELo554.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('726fe3555dd11aff201e8e9097c0c750', NULL, '附件1', 'http://114.116.30.229/group1/M00/01/23/wKgBol4lgUyAW1q7AAX1ZH7S_gk957.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('57750af1f5d2ca8a2edd5f6aac5dcf17', NULL, '附件1', 'http://114.116.30.229/group1/M00/01/23/wKgBol4lgbuAY5zRAAXiqjddDxU272.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('15ff6d325f2ef2ced8727d744de7f0f8', NULL, '附件1', 'http://114.116.30.229/group1/M00/01/25/wKgBol4noReAZAyCAAXJzIh-TWM350.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('173aff9877aee1147892559dd296b032', NULL, '结婚证', 'http://114.116.30.229/group1/M00/01/25/wKgBol4noUKANXGbAAW0dHnrg3I816.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('23676a2fbd31f28d7835515e21a51883', NULL, '合同附件1', 'http://114.116.30.229/group1/M00/01/25/wKgBol4noXSAOEciAAXMvmlvk7M751.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('16651f8c5ebee8d91aa1fa3f44b11c02', NULL, '合同附件1', 'http://114.116.30.229/group1/M00/01/25/wKgBol4nop2AQ2CTAAXewYsnJP4912.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('f5a8baad26f398741228629e3a5d7f78', NULL, '职级管理1', 'http://114.116.30.229/group1/M00/01/25/wKgBol4nowWAD1AHAAXB9FJlibo386.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('cd4841f8bd2092479ebb6e1333574d0b', NULL, '职级管理2', 'http://114.116.30.229/group1/M00/01/25/wKgBol4nowWAdMDXAAWua1e8Mfg369.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('aecc6491f39ab233b2300b7d57ab2c97', NULL, '职级管理 3', 'http://114.116.30.229/group1/M00/01/25/wKgBol4nowaAedcNAAW8_OIfEEI231.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('9a2efa4373b70d402ba59fc0716f038f', NULL, '职级管理 4', 'http://114.116.30.229/group1/M00/01/25/wKgBol4nowaAfFcOAAW2LX-gwtU265.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('7921fe8cd3d23d34c17c80071915ee33', NULL, '职级管理 5', 'http://114.116.30.229/group1/M00/01/25/wKgBol4noweADMkNAAXCd7MJvbY177.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('fa3983ef4f44daef2ef3e74d4710aa25', NULL, '附件1', 'http://114.116.30.229/group1/M00/01/25/wKgBol4nozmAROzgAAQeJipWOG4066.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('78a1fb352c4421c4748dd774968fe284', NULL, '附件1', 'http://114.116.30.229/group1/M00/01/25/wKgBol4no0-AAWNDAAW_FYB9p0Q114.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('4dcc45da94291a9dc7dd828e3dba8662', NULL, '考核激励1', 'http://114.116.30.229/group1/M00/01/25/wKgBol4no3OAFlKrAAW7w0gxFZY083.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('40cbe5bcceb7e9380f417dea785bde64', NULL, '考核记录2', 'http://114.116.30.229/group1/M00/01/25/wKgBol4no7-ABra4AAXQ4PHdx3U108.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('0b20753fade3dc8a524ccb80cfc9065f', NULL, '考核记录3', 'http://114.116.30.229/group1/M00/01/25/wKgBol4no7-AOyVkAAXWA9hyhaI455.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('6c49c38a9b2ac285b8c955b0bcaf5de6', NULL, '考核记录4', 'http://114.116.30.229/group1/M00/01/25/wKgBol4no8CAcICoAAXEU7zGhbA905.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('470e984857d573037be08a74010a9902', NULL, '附件1', 'http://114.116.30.229/group1/M00/01/25/wKgBol4no-eAHdfeAAXDYgXnAZE494.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('821428f700e15576dd52046ddd198f11', NULL, '附件2', 'http://114.116.30.229/group1/M00/01/25/wKgBol4no-eAO51uAAXJiV3B3fA909.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('033e776481faedda7113bc1516a845ff', NULL, '附件3', 'http://114.116.30.229/group1/M00/01/25/wKgBol4no-iAV_JaAAXI6qTZ0uk537.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('99279f39044c013cf94518a70bd5ebdc', NULL, '附件4', 'http://114.116.30.229/group1/M00/01/25/wKgBol4no-iATAYRAAXHCGUaTuA157.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('3556a6943e7511057d47e9b4ea5902d8', NULL, '附件1', 'http://114.116.30.229/group1/M00/01/25/wKgBol4no_2AbhUJAARXNK8IsY0568.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('f658e6aaf979a31d580b18c1ef34c02e', NULL, '附件2', 'http://114.116.30.229/group1/M00/01/25/wKgBol4no_2ASlrnAAW8X4bD1Is365.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('32d9c4535620a89fdd4fb3c9b67b0ebd', NULL, '附件3', 'http://114.116.30.229/group1/M00/01/25/wKgBol4no_6ADxEoAAW9akk4M64855.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('70a7a74eb0c4091d942028e257eae472', NULL, '附件4', 'http://114.116.30.229/group1/M00/01/25/wKgBol4no_6ASwBTAAXDW3jYLRs430.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('2ae4ab013a051fffbcf3670ffd0a93e7', NULL, '附件1', 'http://114.116.30.229/group1/M00/01/25/wKgBol4npBuATwnVAAW6j0a13Q4497.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('cfc7cd1de2f4497e23b48d51bbf79618', NULL, '附件2', 'http://114.116.30.229/group1/M00/01/25/wKgBol4npBuAMWGeAAW9Bk76VeI011.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('d7465544c32ea6c130520cb93c5573ec', NULL, '附件1', 'http://114.116.30.229/group1/M00/01/25/wKgBol4npCOAOaIkAAW607LM1ns461.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('afe69660d372370261b300b3463c02c7', NULL, '附件2', 'http://114.116.30.229/group1/M00/01/25/wKgBol4npCOAX1eoAARatDA5lgY522.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('e873fd89b20a4c993d7d3863655ca42b', NULL, '附件11', 'http://114.116.30.229/group1/M00/01/25/wKgBol4npEmAD1XLAAWJOYsSp1I754.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('1812acdac9c1ddb076a3c16213839651', NULL, '附件22', 'http://114.116.30.229/group1/M00/01/25/wKgBol4npEmAJxqkAAWrV_O1mFQ022.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('13f9653415a52f4607839c277bb2d309', NULL, '附件34', 'http://114.116.30.229/group1/M00/01/25/wKgBol4npEqAFkh3AAW2X2J1GYQ349.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('146a28ae9889ea9643e99979390b8d79', NULL, '附件46', 'http://114.116.30.229/group1/M00/01/25/wKgBol4npEqADrNXAAWzgHk8XdY078.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('7778865f54476b65ce7782c1a3fc2c23', NULL, '附件1', 'http://114.116.30.229/group1/M00/01/25/wKgBol4npG-ACHhPAAXHDfa-C_A935.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('36d80eff4a232abfba73f44c6112be3b', NULL, '附件1', 'http://114.116.30.229/group1/M00/01/25/wKgBol4npKuAWmlLAAXTvYQP73I320.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('48c9f5a979b765e8b4d14a96e3557f40', NULL, '附件2', 'http://114.116.30.229/group1/M00/01/25/wKgBol4npKuAQ7ZnAAXWRnVTz-o010.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('89d8630bb0c24d759ea5899ff4623add', NULL, '附件3', 'http://114.116.30.229/group1/M00/01/25/wKgBol4npKyAf8lOAAXX8gll_Bw039.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('a8faad4bbf101b2d7b5ed8c77a13cfaa', NULL, '附件4', 'http://114.116.30.229/group1/M00/01/25/wKgBol4npK2ASnxkAAXX9V6dicI209.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('fa6ba60e0d70b170acbb280a1b63c4a0', NULL, '附件1', 'http://114.116.30.229/group1/M00/01/25/wKgBol4npOSAMtv7AAXXo1ndy-M401.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('661ff8c724bf0bbc89ca1b129b422074', NULL, '附件2', 'http://114.116.30.229/group1/M00/01/25/wKgBol4npOeAIdvgAAXXo1ndy-M558.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('57c90295614b12c4e2faf297007bad50', NULL, '附件3', 'http://114.116.30.229/group1/M00/01/25/wKgBol4npOmAc_diAARpUK0G2mk440.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('34332ca48ad9f542d9896658668359b4', NULL, '附件4', 'http://114.116.30.229/group1/M00/01/25/wKgBol4npOuAJjM1AAXU4p4s7A4074.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('208a3550288d6ebf0cfc8837612c3422', NULL, '附件1', 'http://114.116.30.229/group1/M00/01/25/wKgBol4npO2AQ9mZAAXXo1ndy-M114.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('0aeb9b36be62c56f0920ded69af30cd1', NULL, '附件2', 'http://114.116.30.229/group1/M00/01/25/wKgBol4npO-ACt3oAAXXo1ndy-M976.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('276f70f6f759ab28dfc624e7627ef332', NULL, '附件3', 'http://114.116.30.229/group1/M00/01/25/wKgBol4npPCAQOUKAARpUK0G2mk724.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('0068efbe676979f940aaf21efdfe3417', NULL, '附件4', 'http://114.116.30.229/group1/M00/01/25/wKgBol4npPKAB1fJAAXU4p4s7A4432.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('c74d4f945ec0f0c1b85a0557772203d9', NULL, '附件1', 'http://114.116.30.229/group1/M00/01/25/wKgBol4npTSAIqb8AAXGBNU--Y8587.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('5646bef743a4832b78f431be4e0cb24b', NULL, '附件2', 'http://114.116.30.229/group1/M00/01/25/wKgBol4npTiAVzteAAXJhjASRzM407.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('298137cb61d323d46488fbc17c1e6e77', NULL, '附件3', 'http://114.116.30.229/group1/M00/01/25/wKgBol4npTqAR7HGAAXIXkBd_Pc417.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('3cf58e45b5cf80b4797b86ede7494ee2', NULL, '附件4', 'http://114.116.30.229/group1/M00/01/25/wKgBol4npTqAf-ApAAXMJhyuibU006.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('a90ea0f771178b340012c268d2f60d6f', NULL, '附件5', 'http://114.116.30.229/group1/M00/01/25/wKgBol4npTuAByFEAAXKpT25U0Y397.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('858f13753490cc90d8f7290532ae3a70', NULL, '附件1', 'http://114.116.30.229/group1/M00/01/25/wKgBol4npY6AdJQqAAW45ghoT7w595.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('1303f5cfda7bd1acf4b6aa47c8795ccd', NULL, '附件2', 'http://114.116.30.229/group1/M00/01/25/wKgBol4npY-APHKJAAXAToDM7EI934.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('adc177f0260b8643c0b19a42130eca47', NULL, '附件3', 'http://114.116.30.229/group1/M00/01/25/wKgBol4npY-AZ5Q9AAW-6-Ao3PU757.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('df2bb02a16a880f0cb116c54a8055737', NULL, '附件4', 'http://114.116.30.229/group1/M00/01/25/wKgBol4npZCASysbAAXBru0xiqk870.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('913d2c6b8df6a1c2d5f19f4895679cf1', NULL, '附件1', 'http://114.116.30.229/group1/M00/01/25/wKgBol4npZCAYxatAAW45ghoT7w965.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('e31e70a4307e46b726c7caff61147ec4', NULL, '附件2', 'http://114.116.30.229/group1/M00/01/25/wKgBol4npZGAeeTVAAXAToDM7EI479.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('b72bab0adfab0d1b3e6eec7030afc690', NULL, '附件3', 'http://114.116.30.229/group1/M00/01/25/wKgBol4npZKADhk1AAW-6-Ao3PU391.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('eb04f9a695b505023ff6b70484beacaf', NULL, '附件4', 'http://114.116.30.229/group1/M00/01/25/wKgBol4npZKAPNX2AAXBru0xiqk338.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('7c1e9634344d60e37dd340f9012d675f', NULL, '附件1', 'http://114.116.30.229/group1/M00/01/25/wKgBol4npaGALllmAAXcppO-WKw173.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('9c66b1b08eb2306d05025aff8b3de891', NULL, '附件1', 'http://114.116.30.229/group1/M00/01/25/wKgBol4npcuADRNeAAR1XT86rb4721.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('ad2d5571a3737a62a2e25d66c20c05bf', NULL, '附件2', 'http://114.116.30.229/group1/M00/01/25/wKgBol4npc2ALfdPAAXFOR5OEq8241.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('128a08607595fbec702eccd124d7edd9', NULL, '附件3', 'http://114.116.30.229/group1/M00/01/25/wKgBol4npc6ABecuAAXOCCNf1wc971.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('e0f7f240edd21e2cc03fb1d475728dd1', NULL, '附件4', 'http://114.116.30.229/group1/M00/01/25/wKgBol4npc-AdEiCAAXIj_iPwxQ392.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('840611d5439b5a4ea307489b88c0c539', NULL, '附件5', 'http://114.116.30.229/group1/M00/01/25/wKgBol4npdKAThcZAAW91Og6DGU327.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('7f20ea727348849704908f3d247d6a41', NULL, '附件1', 'http://114.116.30.229/group1/M00/01/25/wKgBol4npdCAXjT7AAR1XT86rb4728.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('35059e410ece0de4ad31b4b48499f36a', NULL, '附件2', 'http://114.116.30.229/group1/M00/01/25/wKgBol4npdKAIcGRAAXFOR5OEq8613.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('0d0ded8d1a1d4670d4427b39810b92ed', NULL, '附件3', 'http://114.116.30.229/group1/M00/01/25/wKgBol4npdOAC8_oAAXOCCNf1wc599.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('45f26fd2a72ed9054d194fae243d39a1', NULL, '附件4', 'http://114.116.30.229/group1/M00/01/25/wKgBol4npdSABDjGAAXIj_iPwxQ634.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('44f333001cc5d1d85bcdd6e9e1b90b4b', NULL, '附件5', 'http://114.116.30.229/group1/M00/01/25/wKgBol4npdWAUIwyAAW91Og6DGU927.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('9dfda5699be731ba93a9a736b63ab87a', NULL, '附件1', 'http://114.116.30.229/group1/M00/01/25/wKgBol4npfKAJNEtAAXOXw1-VTg802.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('2e758b5f63ebd1e943bd57f062730260', NULL, '附件2', 'http://114.116.30.229/group1/M00/01/25/wKgBol4npfOAXd1hAARQsAFvQd0405.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('cdaff281439cca72b654001a633487ac', NULL, '附件3', 'http://114.116.30.229/group1/M00/01/25/wKgBol4npfSAQ25bAAXSN-UCQg8303.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('aff588b9c8a6c32cd083fea3a025be7e', NULL, '附件4', 'http://114.116.30.229/group1/M00/01/25/wKgBol4npfSAYb6eAAXO8qE0pHU847.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('2c4fa1cb4e372a3ec55bbd275608860a', NULL, '附件1', 'http://114.116.30.229/group1/M00/01/25/wKgBol4npiWATOJAAAZJ-VJHtBI615.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('668ad3c4fd0847ffb7b6a758245f7e39', NULL, '附件2', 'http://114.116.30.229/group1/M00/01/25/wKgBol4npiaAVYKeAAZIWUddgIw579.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('b32e5fa10188e1376ee6501587699ca3', NULL, '附件3', 'http://114.116.30.229/group1/M00/01/25/wKgBol4npiaALh6GAAZKMZFpWjk539.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('a7e01cc822c2c59bf058cc71edfd9b31', NULL, '附件4', 'http://114.116.30.229/group1/M00/01/25/wKgBol4npieAJ0-NAAZSjSDl9bc604.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('365aef78a311c9534885c629cd7d9b6a', NULL, '附件1', 'http://114.116.30.229/group1/M00/01/25/wKgBol4npnGAF6rJAAWUxRZs6kI316.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('a012bc9a617e3310227bdacd33b097c9', NULL, '附件2', 'http://114.116.30.229/group1/M00/01/25/wKgBol4npnGADGNsAAWTJi6KCVs300.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('7a20107ad30d598aa51b2a67fbce462f', NULL, '附件3', 'http://114.116.30.229/group1/M00/01/25/wKgBol4npnKAIyiIAAWRMJ8OL84797.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('da49ab342653b0eed36b84519ccc1f94', NULL, '附件4', 'http://114.116.30.229/group1/M00/01/25/wKgBol4npnKAK-PDAAWSUySuOPs530.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('59548783c3e25c078b812423f266f434', NULL, '附件1', 'http://114.116.30.229/group1/M00/01/25/wKgBol4npoOASSirAAWW7m2f4SQ817.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('2f0a35f20cd33cbbf7a5f98165136b53', NULL, '附件2', 'http://114.116.30.229/group1/M00/01/25/wKgBol4npoOAGndtAAWW7m2f4SQ541.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('f06ad085fe3bd4337b534f94263c226c', NULL, '附件3', 'http://114.116.30.229/group1/M00/01/25/wKgBol4npoSAOFi5AAQ4Ht2Qmi0985.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('50045cfad8b1286cc0dfdc142165b852', NULL, '附件4', 'http://114.116.30.229/group1/M00/01/25/wKgBol4npoSAWbJmAAWa_ezQzg4950.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('6b81ded1a761b1288d42be889f295433', NULL, '111', 'http://114.116.30.229/group1/M00/01/25/wKgBol4npwuAX5qXAAWl6mbIzvk482.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('4fe055983d1b1491d0a75c4199fc2e1c', NULL, '附件112', 'http://114.116.30.229/group1/M00/01/25/wKgBol4npwyAQMjDAAWl6mbIzvk228.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('c65c45db0392330f7c5c86f936cfcc72', NULL, '附件333', 'http://114.116.30.229/group1/M00/01/25/wKgBol4npw2AW6cGAAWhmZvnEvs904.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('0d7467e34d24322eceec55235cca97c5', NULL, '附件1', 'http://114.116.30.229/group1/M00/01/25/wKgBol4np1OAPl_DAAWtyGjndMM718.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('12a84726b4909e545b3c83776adfc7f4', NULL, '附件2', 'http://114.116.30.229/group1/M00/01/25/wKgBol4np1OAKBchAAWpZXjMBuY311.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('05780f329693c0f53aca39f05b890c9e', NULL, '附件3', 'http://114.116.30.229/group1/M00/01/25/wKgBol4np1SAQLS2AAWsRydb8wU232.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('63d23fa452e2e980a8c2be90d734dbd0', NULL, '附件1', 'http://114.116.30.229/group1/M00/01/25/wKgBol4np2mAdew0AAWueapVnXg119.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('796d4e7398cbe75aabc119c56be1f367', NULL, '附件2', 'http://114.116.30.229/group1/M00/01/25/wKgBol4np2mAFb8lAAWukxBJ594905.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('0bcaf2a235e0eb4a4603050db23cf535', NULL, '附件3', 'http://114.116.30.229/group1/M00/01/25/wKgBol4np2qAcRXgAAWvu1SBfhs309.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('a98d6323ac8a78df1862a07e819f77cc', NULL, '附件1', 'http://114.116.30.229/group1/M00/01/25/wKgBol4np3GAX897AAWvH311RE8873.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('502339e22d0b95230f4347a73429ae53', NULL, '附件1', 'http://114.116.30.229/group1/M00/01/25/wKgBol4np4GAemBmAAXFWVnrP3E336.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('cb24ecaf7327e5833187c072a677f273', NULL, '附件2', 'http://114.116.30.229/group1/M00/01/25/wKgBol4np4GAXIdcAAXKKoqmCro297.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('bc55f7334f991cf33780e5bea046f3c7', NULL, '附件3', 'http://114.116.30.229/group1/M00/01/25/wKgBol4np4KAIM_PAAXIweJ2bSI699.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('8c0e9f582cd4f342b04d97fe632a551a', NULL, '附件1', 'http://114.116.30.229/group1/M00/01/25/wKgBol4np6GAfJBqAAWvVKpTR98072.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('bde80a3ae9317bca467ac09bf6570f7c', NULL, '附件2', 'http://114.116.30.229/group1/M00/01/25/wKgBol4np6WAR1iRAAW2wa1_yIs172.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('1c590a18fabb19097899cbf36ba26361', NULL, '附件3', 'http://114.116.30.229/group1/M00/01/26/wKgBol4np6iAMNlGAAW33KZ_Fws707.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('2a6083f74fd5ae76fb6e09ce6b2b4a19', NULL, '附件4', 'http://114.116.30.229/group1/M00/01/26/wKgBol4np6uAB_RDAAW6g7oSiA8994.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('0fb585392b79d2ae64022b35df65144b', NULL, '附件1', 'http://114.116.30.229/group1/M00/01/26/wKgBol4np6yAVAGpAAWvVKpTR98563.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('ee1ad731cff42e0b7d3ba1954c476c5b', NULL, '附件2', 'http://114.116.30.229/group1/M00/01/26/wKgBol4np6yAHjvAAAW2wa1_yIs793.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('5b68ea9f5204a377e00215392ce178aa', NULL, '附件3', 'http://114.116.30.229/group1/M00/01/26/wKgBol4np62AYRFnAAW33KZ_Fws500.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('86ba8f008639c76dff617a6d95cbff42', NULL, '附件4', 'http://114.116.30.229/group1/M00/01/26/wKgBol4np62AX0-IAAW6g7oSiA8128.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('ea1803c6c98e4cbf6975f1f4518473bc', NULL, '附件1', 'http://114.116.30.229/group1/M00/01/26/wKgBol4np82AG38zAAXMuX2Inyg464.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('051811af73d8e731aac28a26e0719a6c', NULL, '附件2', 'http://114.116.30.229/group1/M00/01/26/wKgBol4np82AAeKaAAXHM_oGjak291.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('16ffb2a75229fa2f0ddc2e21358edd5d', NULL, '附件3', 'http://114.116.30.229/group1/M00/01/26/wKgBol4np86AGHfNAAXAotMTRYY229.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('607c3f58b93421040b49eafee9fd1a7c', NULL, '附件4', 'http://114.116.30.229/group1/M00/01/26/wKgBol4np86APaPBAAXC7Dp1PPo879.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('25efc3652dddf03716ea9df25461396d', NULL, '附件1', 'http://114.116.30.229/group1/M00/01/26/wKgBol4np-uANZejAARWmbgvI_M766.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('c1b540701c190e53f56918f8b2e19f7f', NULL, '附件2', 'http://114.116.30.229/group1/M00/01/26/wKgBol4np-uAShiVAAW98sT5Jqg099.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('7820c918f4d653e52c792d231522b3f1', NULL, '附件3', 'http://114.116.30.229/group1/M00/01/26/wKgBol4np-yAZDw3AAXC56g9ed8912.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('aed64d200c84e119d56adc254fe04214', NULL, '附件4', 'http://114.116.30.229/group1/M00/01/26/wKgBol4np-yAHGeIAAXJ8XFeLs0299.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('35f9e6f2891c0f2867581302552365de', NULL, '附件1', 'http://114.116.30.229/group1/M00/01/26/wKgBol4nqBeAV_VeAAXGHItIXzs048.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('d911356480169c2d9db4d012f7ce210d', NULL, '附件1', 'http://114.116.30.229/group1/M00/01/26/wKgBol4nqEyAFcxaAAQ0JnguBYE429.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('423dea74cadac38ba0d745f785baba4c', NULL, '附件1', 'http://114.116.30.229/group1/M00/01/26/wKgBol4nqFCAaU_aAAQ0JnguBYE384.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('adfe5c056ad9d14043d073a190445287', NULL, '附件1', 'http://114.116.30.229/group1/M00/01/26/wKgBol4nqGyAJLTBAAXB5vDp2S8534.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('bf725690034219c1ea42f40104dcbdd8', NULL, '附件1', 'http://114.116.30.229/group1/M00/01/26/wKgBol4nqUOAK5SUAAXsxBFKymI571.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('4ad6b9542a1d46ee0e517bbd83cedab8', NULL, '附件1', 'http://114.116.30.229/group1/M00/01/26/wKgBol4nqVuAGbjmAAX0ljPs5to592.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('41ecedcf57f03df6b80426c659d58717', NULL, '附件1', 'http://114.116.30.229/group1/M00/01/26/wKgBol4nwc2AMwWpAAXI2mFdGh4974.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('793e8ce932a36d39d3698828920e5b2d', NULL, '附件1', 'http://114.116.30.229/group1/M00/01/26/wKgBol4nwemAWswxAAS713WdodY045.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('ebe7dbb112c90266f525fd39ba5bfcfc', NULL, '附件1', 'http://114.116.30.229/group1/M00/01/26/wKgBol4nwhOAHhNAAAYQTDMa9Nk949.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('2bbec3873a17cc32d1b5954d7647d808', NULL, '附件2', 'http://114.116.30.229/group1/M00/01/26/wKgBol4nwhSAa_IMAAYQiHyi0bs139.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('68ba176eeebc7f7b96435ec95a027a23', NULL, '附件3', 'http://114.116.30.229/group1/M00/01/26/wKgBol4nwhSAB4saAAYPniciIKU747.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('317fb5e128d46deebe5cc50f18ba7eac', NULL, '附件4', 'http://114.116.30.229/group1/M00/01/26/wKgBol4nwhWANZo4AAYRiMpnR6U754.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('f0cba41b1efd13942790d86b01ab5210', NULL, '附件1', 'http://114.116.30.229/group1/M00/01/26/wKgBol4nwmuAAYEHAAXOaGzCuCs986.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('9ad26a34b131d31caf1c700e44530069', NULL, '附件2', 'http://114.116.30.229/group1/M00/01/26/wKgBol4nwmyALNrVAAYFm99dh8Y836.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('601c49ecaa4a08003fca56f6929e3547', NULL, '附件3', 'http://114.116.30.229/group1/M00/01/26/wKgBol4nwmyAOLPgAAYl9-WpB1c132.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('8cd7a8afa2d7117881aee9b1038a02f3', NULL, '附件4', 'http://114.116.30.229/group1/M00/01/26/wKgBol4nwm2ADIkYAAYswU4Y5s4985.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('9b2659fe0970eb3d04b5b5fe52a83401', NULL, '附件5', 'http://114.116.30.229/group1/M00/01/26/wKgBol4nwm2AfUmfAAYswU4Y5s4498.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('f78715adce772cbe65c8649eedc8d057', NULL, '附件6', 'http://114.116.30.229/group1/M00/01/26/wKgBol4nwm6Aa--jAAYZ2yI68g0194.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('370d7b56236a887be7ed64e2aea62358', NULL, '附件1', 'http://114.116.30.229/group1/M00/01/26/wKgBol4nwsOABTcoAAW8R_Fx_Qw033.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('a07ce1bbd650feedb22a61ffbc733374', NULL, '附件2', 'http://114.116.30.229/group1/M00/01/26/wKgBol4nwsSAQsAzAAYxgpP1HxQ530.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('6502b6771ff2f32bd5a71374d5e91328', NULL, '附件3', 'http://114.116.30.229/group1/M00/01/26/wKgBol4nwsWAOpdAAAY04Qd8Xzw848.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('e4c1b198e1e636912770921da9c5d983', NULL, '附件4', 'http://114.116.30.229/group1/M00/01/26/wKgBol4nwsWAVMgGAAY0ND5ooDA679.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('741bac3105ef482425d17f95ff49119c', NULL, '附件5', 'http://114.116.30.229/group1/M00/01/26/wKgBol4nwsWAPE3OAAYun1KBw_Y189.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('251c629de71ff577ca98f273eea68d6a', NULL, '附件6', 'http://114.116.30.229/group1/M00/01/26/wKgBol4nwsaAXT73AAYwNSQmsIo577.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('b1e70121b57c215d0a87fb0d2d567e37', NULL, '附件1', 'http://114.116.30.229/group1/M00/01/26/wKgBol4nwz-ATqgJAAWEDGhkBz8502.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('76130ae531f43e157282b61bb260534a', NULL, '附件2', 'http://114.116.30.229/group1/M00/01/26/wKgBol4nw0CAWaC0AAWBIPmHYU0662.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('5171adaaf75e427b01844dbf715459ad', NULL, '附件3', 'http://114.116.30.229/group1/M00/01/26/wKgBol4nw0CAfEjBAAWBIsouU8Y572.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('8a89f71ed78fe29cf92c2083fe395c1e', NULL, '附件4', 'http://114.116.30.229/group1/M00/01/26/wKgBol4nw0GAKDJYAAV8H1b2fb0537.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('93e4aadb68e9116eafdf89fa8b7c3a37', NULL, '附件5', 'http://114.116.30.229/group1/M00/01/26/wKgBol4nw0GAKkvCAAWG1mySGTo951.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('be576047a0f157718e4aaa2ccb7c87ed', NULL, '附件1', 'http://114.116.30.229/group1/M00/01/26/wKgBol4nw0GAe6hvAAWEDGhkBz8706.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('0c597f143af75ff7961c21ab7a4151a1', NULL, '附件2', 'http://114.116.30.229/group1/M00/01/26/wKgBol4nw0KAepJuAAWBIPmHYU0810.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('5d2d8b1e26e2f47456b2e36dac55b303', NULL, '附件3', 'http://114.116.30.229/group1/M00/01/26/wKgBol4nw0KAYmcAAAWBIsouU8Y527.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('300e6d75f68fc3b87ac0cb01a02547da', NULL, '附件4', 'http://114.116.30.229/group1/M00/01/26/wKgBol4nw0OAQsD6AAV8H1b2fb0723.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('742d0aaee56c9d603984ccc385b358bb', NULL, '附件5', 'http://114.116.30.229/group1/M00/01/26/wKgBol4nw0OAK5lGAAWG1mySGTo978.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('b1e306deb0bbebf7b56c62013a58496b', NULL, '附件1', 'http://114.116.30.229/group1/M00/01/26/wKgBol4nw6OAatN1AAU5BYJhL_A723.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('9edc3c87d8c06e5e4b2cedbe7b5c9280', NULL, '附件1', 'http://114.116.30.229/group1/M00/01/26/wKgBol4nw8WAdJZtAAS18w29mNY810.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('652012c1cae6bfff9b82f56b2bec022e', NULL, '附件1', 'http://114.116.30.229/group1/M00/01/26/wKgBol4nw-OAVE3cAAXzWRnn-sE879.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('29461b51feac7ea96e02c1a20e2a25f8', NULL, '附件1', 'http://114.116.30.229/group1/M00/01/26/wKgBol4nxAuALt4QAAX-HoMWQv4638.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('53c4ab845132e94572fab2ff49b30fd9', NULL, '附件2', 'http://114.116.30.229/group1/M00/01/26/wKgBol4nxAuAcnYdAAX-Yw9Y_HU384.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('5b24062f1d22b1d9bb84a6e8e337423f', NULL, '附件1', 'http://114.116.30.229/group1/M00/01/26/wKgBol4nxC2AZT6sAAX6T233Zsc482.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('236161c68b7276443f17c5af4ec359b1', NULL, '附件1', 'http://114.116.30.229/group1/M00/01/26/wKgBol4nxC6ABZfuAAX6T233Zsc707.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('81eba84a3a016931aa421b899dc539d9', NULL, '附件2', 'http://114.116.30.229/group1/M00/01/26/wKgBol4nxC6AEiFJAAX7bM0v4Nk577.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('99e534446ea5bedb9a8a2121080b8390', NULL, '附件1', 'http://114.116.30.229/group1/M00/01/26/wKgBol4nxD-AXWrhAAX7xadfQKo107.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('da0b6aeaef9c951665ecf79dae06fce0', NULL, '附件1', 'http://114.116.30.229/group1/M00/01/26/wKgBol4nxEmAUrVUAAX5E7DrYVo745.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('333c78b63e28a4881511d8f2bf681861', NULL, '附件1', 'http://114.116.30.229/group1/M00/01/26/wKgBol4nxEmAbQa0AAX5E7DrYVo004.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('77f19c225832153f9f4a3b1b8ecd6f50', NULL, '附件1', 'http://114.116.30.229/group1/M00/01/26/wKgBol4nxFOAH5z-AAWk3KtmFsE957.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('b59be56e178ed516f66033f6158bb45d', NULL, '附件1', 'http://114.116.30.229/group1/M00/01/26/wKgBol4nxGmATcC-AAXZeugD6Mw593.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('83703f1389620b41cb455dcd84f9c050', NULL, '附件1', 'http://114.116.30.229/group1/M00/01/27/wKgBol4nxHOAOEpvAAWKI9X-Xc8568.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('ede0c07db93ff96c7da04d83c0d6d3c7', NULL, '附件1', 'http://114.116.30.229/group1/M00/01/27/wKgBol4oAw-AIH2SAAWC8mjaCpM933.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('eafdd5837dd76d63e13f7de16d8fffe3', NULL, '修改1', 'http://114.116.30.229/group1/M00/01/27/wKgBol4oA3aAFqrtAAWQxVp4yKs050.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('3f23773c0e905a03126da235e52a251f', NULL, '附件1', 'http://114.116.30.229/group1/M00/01/27/wKgBol4oCnOAeuwcAAe3All5U94417.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('f95014babfa3280c1e344406207ffdb2', NULL, '附件2', 'http://114.116.30.229/group1/M00/01/27/wKgBol4oCnSAZEHDAAezaJ4qSSs301.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('185071c0c534f863ff97a38e12707542', NULL, '附件3', 'http://114.116.30.229/group1/M00/01/27/wKgBol4oCnWAQr6mAAe6u7rbS84178.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('1e0f67860bdb06ae056eefec9208a95d', NULL, '附件1', 'http://114.116.30.229/group1/M00/01/27/wKgBol4oCneACog5AAe3All5U94754.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('fe16cfa1cd3c19fb9a46069b4ce10927', NULL, '附件2', 'http://114.116.30.229/group1/M00/01/27/wKgBol4oCneAa5-OAAezaJ4qSSs413.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('ff520c3be597192ccf4d6b5b78b610b0', NULL, '附件3', 'http://114.116.30.229/group1/M00/01/27/wKgBol4oCniARSQ3AAe6u7rbS84166.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('b927512e85ee55eb8b390d0d37173dfa', NULL, '图片1', 'http://114.116.30.229/group1/M00/01/41/wKgBol54X8eAasiYAABXHcbjYTU028.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('83b38a3a642e91483ed52f173d38bfd7', NULL, 'pexels-photo-459225', 'http://114.116.30.229/group1/M00/01/43/wKgBol59wfeAWoSxAABLAvT5Q1k323.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('005ace3c6c0c5b0499950db8166a8d21', NULL, 'touxiang', 'http://114.116.30.229/group1/M00/01/43/wKgBol59xk6ACgbRAAB08UrnnNw341.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('66261bac3848b78b3653efa87e7f99c1', NULL, '1ea9da3932a8be55118859a320879cf', 'http://114.116.30.229/group1/M00/01/43/wKgBol59zs2AQRNYAABlrq1sjmk645.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('d2135890ebe4ae8cf476b677122f899b', NULL, '01300543453388144152731911410', 'http://114.116.30.229/group1/M00/01/45/wKgBol6EPF6AJInDABQ2d7rLgKI497.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('846a93df05f29471333589fec3d716dd', NULL, '201507122590', 'http://114.116.30.229/group1/M00/01/45/wKgBol6EPGmAWXp3AADQ9_UppqM292.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('50f824172e445be574c04cf1e96efbd1', NULL, '20150429113547267', 'http://114.116.30.229/group1/M00/01/45/wKgBol6EUhSAayWQAACGXc_CsZY931.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('2765671cc14a90f689f42bbb675a7274', NULL, '36464006', 'http://114.116.30.229/group1/M00/01/45/wKgBol6EVS6AUQQzAABLwkRcnhE378.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('cf0c1e28ec7114d9756d8720d065fdd2', NULL, 'a630410699d6cf38_n', 'http://114.116.30.229/group1/M00/01/45/wKgBol6EVhWAbBaBAACBLF6V4zk548.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('212b8c998b5f83b4ebd35f7a7d201dc1', NULL, 'u=2535994566,2862523534&fm=26&gp=0', 'http://114.116.30.229/group1/M00/01/45/wKgBol6EVruAILAdAACpxPYo-oA431.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('c2aa61d0551575ad86ea4a70b38f81b1', NULL, 'u=2535994566,2862523534&fm=26&gp=0', 'http://114.116.30.229/group1/M00/01/45/wKgBol6EVs6AY16ZAACpxPYo-oA692.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('d440c734308400391adc71b2bb0fcbd5', NULL, 'u=2535994566,2862523534&fm=26&gp=0', 'http://114.116.30.229/group1/M00/01/45/wKgBol6EVuWAbZr_AACpxPYo-oA634.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('4569b51916f153f8d4e99067aaaf3390', NULL, 'u=2535994566,2862523534&fm=26&gp=0', 'http://114.116.30.229/group1/M00/01/45/wKgBol6EWUuAXD3EAACpxPYo-oA706.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('0591bbbe466232d042d3915de4a092f3', NULL, 'u=2535994566,2862523534&fm=26&gp=0', 'http://114.116.30.229/group1/M00/01/45/wKgBol6EWVeAXJI1AACpxPYo-oA111.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('edd2e155d6d4e70aa6c2ae39ab77b047', NULL, 'u=2535994566,2862523534&fm=26&gp=0', 'http://114.116.30.229/group1/M00/01/45/wKgBol6EWY6AFnqPAACpxPYo-oA429.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('b86203be7a24c13583d53102897e9c20', NULL, 'u=2535994566,2862523534&fm=26&gp=0', 'http://114.116.30.229/group1/M00/01/45/wKgBol6EWZuAVNyEAACpxPYo-oA731.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('7aa5ba3527a71708524d8d23d20a0185', NULL, '20150429113547267', 'http://114.116.30.229/group1/M00/01/45/wKgBol6EWdaABMBbAACGXc_CsZY059.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('130b87510ad4a7425272414e8b56e8bb', NULL, 'u=2535994566,2862523534&fm=26&gp=0', 'http://114.116.30.229/group1/M00/01/45/wKgBol6EWiWABtPQAACpxPYo-oA784.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('edc01f772770315d37264b3a766df7d6', NULL, 'u=2535994566,2862523534&fm=26&gp=0', 'http://114.116.30.229/group1/M00/01/45/wKgBol6EWjSASNSdAACpxPYo-oA414.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('d168859dd6b472c5d18b1e5b206d06c5', NULL, '雁塔壁纸', 'http://114.116.30.229/group1/M00/01/45/wKgBol6EWvSAW0MXAGkrpOEtS34285.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('97f1eb01ae71d517ee666836856a9d04', NULL, '雁塔1024x1024', 'http://114.116.30.229/group1/M00/01/45/wKgBol6EWxeATSdeAB_qiafq_cs107.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('d40f5a508f1c2ff00d40a61967012d54', NULL, '雁塔1024x1024', 'http://114.116.30.229/group1/M00/01/45/wKgBol6EWxqAOIUzAB_qiafq_cs984.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('7bac16dbad7503c4d3c3e809800a8a09', NULL, '雁塔1024x1024', 'http://114.116.30.229/group1/M00/01/45/wKgBol6EWxyACowAAB_qiafq_cs037.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('0d50170c93e8a086524f2a0e7f1ed381', NULL, '雁塔1024x1024', 'http://114.116.30.229/group1/M00/01/45/wKgBol6EWyCAQr05AB_qiafq_cs568.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('8b6659ef4cbeea0dbad2a444c3660438', NULL, '03', 'http://114.116.30.229/group1/M00/01/45/wKgBol6EXL6ABKoXAAOI_slICOU301.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('5aff810d05b881f72cbc6fd218e9e0e2', NULL, '02', 'http://114.116.30.229/group1/M00/01/45/wKgBol6EXO2AJa54AANFrYW9230420.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('b09b099454e98b681de102f24ea5b535', NULL, '03', 'http://114.116.30.229/group1/M00/01/45/wKgBol6EXO2AKxACAAOI_slICOU569.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('b23df65bbc78a19f232054654b9412da', NULL, 'new_img_ccc2017', 'http://114.116.30.229/group1/M00/01/45/wKgBol6EXO6AfiCzAAE5idmEZ_s890.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('eba5a80e9cadb9e9c45f810e7de13027', NULL, 'fy', 'http://114.116.30.229/group1/M00/01/45/wKgBol6EXSGAMvMdAAA6xqMJlXY111.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('2d0b38ee6c816429b95487e3ab6a136e', NULL, 'fy', 'http://114.116.30.229/group1/M00/01/45/wKgBol6EXSGAGYiaAAA6xqMJlXY976.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('3c57a2928be2091071213209a28d1364', NULL, 'fy', 'http://114.116.30.229/group1/M00/01/45/wKgBol6EXTSAZsqfAAA6xqMJlXY783.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('e4eb4d153b6aefdfd175fb957e7fed19', NULL, 'fy', 'http://114.116.30.229/group1/M00/01/45/wKgBol6EXTSAMTqfAAA6xqMJlXY569.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('3caf975d4a0c9a3b551d46d64c6304ff', NULL, 'fy', 'http://114.116.30.229/group1/M00/01/45/wKgBol6EXTSABwX9AAA6xqMJlXY554.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('ac046d40439d26b6928bd97eab3ecc6f', NULL, 'fy', 'http://114.116.30.229/group1/M00/01/45/wKgBol6EXTSAc90IAAA6xqMJlXY943.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('b825b0b96a52a6355b99686ecdc0c69d', NULL, 'fy', 'http://114.116.30.229/group1/M00/01/45/wKgBol6EXUSAG20XAAA6xqMJlXY463.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('194ae1bc03f2023954c1ad6955fef363', NULL, 'fy', 'http://114.116.30.229/group1/M00/01/45/wKgBol6EXUSAGNzrAAA6xqMJlXY835.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('e2dee21a95618e55a8262066f2f60708', NULL, 'fy', 'http://114.116.30.229/group1/M00/01/45/wKgBol6EXUSARmbDAAA6xqMJlXY360.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('ca13f94ba30dee795b2b9dbe2c0da436', NULL, 'fy', 'http://114.116.30.229/group1/M00/01/45/wKgBol6EXlGAIjC-AAA6xqMJlXY884.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('9c0ed8caf0e1774941e345045f1ecc6f', NULL, 'fy', 'http://114.116.30.229/group1/M00/01/45/wKgBol6EXlGAIf6MAAA6xqMJlXY551.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('1bb4b0f3c5d379e5bfd47fe6be5e7809', NULL, 'fy', 'http://114.116.30.229/group1/M00/01/45/wKgBol6EXlGADo6MAAA6xqMJlXY505.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('d9cc49b861e0fd271a80efc177d01ac7', NULL, 'fy', 'http://114.116.30.229/group1/M00/01/45/wKgBol6EXlGABuvjAAA6xqMJlXY505.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('1d7e7be22a0b02e7a47c54afb40095aa', NULL, 'fy', 'http://114.116.30.229/group1/M00/01/45/wKgBol6EXlGAe0h8AAA6xqMJlXY552.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('9a44b2f987be3cc035edbd0f6eda7e14', NULL, 'fy', 'http://114.116.30.229/group1/M00/01/45/wKgBol6EXpWAOy7-AAA6xqMJlXY573.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('787bcada388d52288f66063d91e43d05', NULL, 'fy', 'http://114.116.30.229/group1/M00/01/45/wKgBol6EXpWACJK2AAA6xqMJlXY665.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('c52086077ff6137bc256461ee988a2ea', NULL, 'fy', 'http://114.116.30.229/group1/M00/01/45/wKgBol6EXpWADbyqAAA6xqMJlXY612.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('a82433e2a125fa1b2d983f260721c219', NULL, 'fy', 'http://114.116.30.229/group1/M00/01/45/wKgBol6EXpWAFEWuAAA6xqMJlXY264.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('8ccaf9cf07c572da8dbbfacc80aad116', NULL, 'fy', 'http://114.116.30.229/group1/M00/01/45/wKgBol6EXpWAOtEOAAA6xqMJlXY433.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('0084c936a62d83a5bd98ba959e25843f', NULL, 'fy', 'http://114.116.30.229/group1/M00/01/45/wKgBol6EXpWARDUfAAA6xqMJlXY139.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('bbaee5a9e7816fa6ae83663acbf1750d', NULL, '12345', 'http://114.116.30.229/group1/M00/01/45/wKgBol6EYH2AUXTAAAA6xqMJlXY366.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('f38cb205fce40140d5e4056c1e3e4be1', NULL, '123456', 'http://114.116.30.229/group1/M00/01/45/wKgBol6EYH2AeoPfAAA6xqMJlXY804.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('febd8e76a1d16e1313eaa8856699fe94', NULL, '234561', 'http://114.116.30.229/group1/M00/01/45/wKgBol6EYH2AfkP0AAA6xqMJlXY154.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('6b6596ac054267f13bd1d071bc2ffe1d', NULL, '123123121231123123', 'http://114.116.30.229/group1/M00/01/45/wKgBol6EYI6AdgVQAAA6xqMJlXY268.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('e1322cc9822b9bba64cc068961c276a0', NULL, '微信图片_20191028092426', 'http://114.116.30.229/group1/M00/01/45/wKgBol6EXs6Ab4GCAAEzXAVBaRU406.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('0ca9d1a0f1371fade7895fc83a5e5169', NULL, '微信图片_20191024090024', 'http://114.116.30.229/group1/M00/01/45/wKgBol6EXs6ACIcpAAGPc9a8xpY142.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('2e56486abb3f377f7b92b533a54b42af', NULL, '微信图片_20191024090101', 'http://114.116.30.229/group1/M00/01/45/wKgBol6EXs6AKFxbAAFhncnhv3I889.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('b96a613ce7308ef153c694f1082e8b6c', NULL, '微信图片_20191024090040', 'http://114.116.30.229/group1/M00/01/45/wKgBol6EXuuAN7sHAAF3jJPLgo8000.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('02295d0454832252d340c857c4000bdb', NULL, '微信图片_20191024090044', 'http://114.116.30.229/group1/M00/01/45/wKgBol6EXuuAA0q3AAFbFwPcM-w583.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('1fac26351963e33005b9db617d968124', NULL, '微信图片_20191024090047', 'http://114.116.30.229/group1/M00/01/45/wKgBol6EXuuAeJnfAAGSTKXjVxo586.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('06516bb4aa4549c34bc33e14ca5eba1f', NULL, '微信图片_20191024090024', 'http://114.116.30.229/group1/M00/01/45/wKgBol6EXwyALKtcAAGPc9a8xpY309.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('a793e2cbdff9fff331dc9e78025cae61', NULL, '微信图片_20191024090035', 'http://114.116.30.229/group1/M00/01/45/wKgBol6EXwyAYIIFAAC7Hst2p2o932.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('77fa2a71173c3d69ae5f18aad10eff28', NULL, '微信图片_20191024090024', 'http://114.116.30.229/group1/M00/01/45/wKgBol6EX2GABdJHAAGPc9a8xpY679.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('eeae2001f62e5c1b2dc5bb8cc7504802', NULL, '微信图片_20191024090035', 'http://114.116.30.229/group1/M00/01/45/wKgBol6EX2GADEeGAAC7Hst2p2o664.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('42a853103dac66067da548d9cd8ce873', NULL, '微信图片_20191024090044', 'http://114.116.30.229/group1/M00/01/45/wKgBol6EX2GARxkqAAFbFwPcM-w576.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('d4ff376fd70f92c08d5056549b66f8d8', NULL, '微信图片_20191024090120', 'http://114.116.30.229/group1/M00/01/45/wKgBol6EX2GAEwiSAAFDn-5aDoc734.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('4ed30b65aa267692995d96ab3e0c172b', NULL, '微信图片_20191024090051', 'http://114.116.30.229/group1/M00/01/45/wKgBol6EX2GAbS_BAAFHzPca3rA102.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('7e935cfb5b8f674235ccadd5062fabb8', NULL, '20150429113547267', 'http://114.116.30.229/group1/M00/01/46/wKgBol6EYomAI5lVAACST4ugna4194.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('90638b05ebf04507551d2264c93470db', NULL, '20150429113547267', 'http://114.116.30.229/group1/M00/01/46/wKgBol6EYpWAEylkAACST4ugna4200.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('c155e035f4628932f2da91ff50693334', NULL, '20150429113547267', 'http://114.116.30.229/group1/M00/01/46/wKgBol6EYuaANuEWAACST4ugna4543.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('c43567a10df7840c871155222a8f98a4', NULL, '20150429113547267', 'http://114.116.30.229/group1/M00/01/46/wKgBol6EYwOAEMsjAACST4ugna4874.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('ec750a58bdda07834e7bfa2193f98bb9', NULL, '20150429113547267', 'http://114.116.30.229/group1/M00/01/46/wKgBol6EYwyASctyAACST4ugna4222.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('386ca88325cf24e00fd973af7827c491', NULL, '20150429113547267', 'http://114.116.30.229/group1/M00/01/46/wKgBol6EYxOAHxIEAACST4ugna4132.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('9ad0fdaeeacb43854616b4d43e8371a8', NULL, '20150429113547267', 'http://114.116.30.229/group1/M00/01/46/wKgBol6EYxmAJQ5gAACST4ugna4568.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('2f2c2378448bbabe4f2a5314a7ecdb85', NULL, 'pexels-photo-459225', 'http://114.116.30.229/group1/M00/01/47/wKgBol6Ej9yAd6h1AABLAvT5Q1k582.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('bac707e2a7e2a32046ac1b1837913434', NULL, 'pexels-photo-1054289', 'http://114.116.30.229/group1/M00/01/47/wKgBol6Ej9yALl_bAAHUjm8SzdY463.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('6ec2067095b5068fabb1f994b5077bc3', NULL, 'pexels-photo-459225', 'http://114.116.30.229/group1/M00/01/47/wKgBol6Ej9yASezcAABLAvT5Q1k257.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('7690f28ec7f56af0fe65c8066a710138', NULL, 'pexels-photo-1054289', 'http://114.116.30.229/group1/M00/01/47/wKgBol6Ej9yADOPpAAHUjm8SzdY918.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('9198dcf58ca7290539f4ff640dd624b9', NULL, 'pexels-photo-459225', 'http://114.116.30.229/group1/M00/01/47/wKgBol6Ej9yAEOXNAABLAvT5Q1k011.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('25f0cabf6d69c83fa27944d564fa7646', NULL, 'pexels-photo-1054289', 'http://114.116.30.229/group1/M00/01/47/wKgBol6Ej9yAFTKKAAHUjm8SzdY292.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('b745cade87566dcf2697ee08c6910b5c', NULL, 'pexels-photo-1054289', 'http://114.116.30.229/group1/M00/01/47/wKgBol6EkBiAAsO1AAHUjm8SzdY714.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('d5895eb69905cf675e3961f4ab0aa164', NULL, '20150429113547267', 'http://114.116.30.229/group1/M00/01/47/wKgBol6FLb6AIamRAACGXc_CsZY531.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('7da734c33ca43bd45cab766c465f9d6e', NULL, '20150429113547267', 'http://114.116.30.229/group1/M00/01/47/wKgBol6FLdGAH69UAACGXc_CsZY252.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('2ce9f488c725c42b96abe10d863da5f2', NULL, '201507122590', 'http://114.116.30.229/group1/M00/01/47/wKgBol6FLfCALENAAADQ9_UppqM180.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('c757650699564a99dffbdb9ddf67ee7a', NULL, '20150429113547267', 'http://114.116.30.229/group1/M00/01/47/wKgBol6FLmqAB-nUAACGXc_CsZY792.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('51f6da8efb84df80e818433fceef4ff5', NULL, '20150429113547267', 'http://114.116.30.229/group1/M00/01/47/wKgBol6FLn2AcQniAACGXc_CsZY800.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('e1144a076a50591daa42c24b4b0fb6b1', NULL, 'a630410699d6cf38_n', 'http://114.116.30.229/group1/M00/01/47/wKgBol6FLteAEYR1AACBLF6V4zk965.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('2ae1f8c4ab467d343c0ae990c575f758', NULL, 'a630410699d6cf38_n', 'http://114.116.30.229/group1/M00/01/47/wKgBol6FLvCAc0PDAACBLF6V4zk226.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('15e097a367dba51a8eabd8ec17ac86f6', NULL, 'a630410699d6cf38_n', 'http://114.116.30.229/group1/M00/01/47/wKgBol6FLvuAGGCVAACBLF6V4zk251.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('0a2c080f2be4c808bdfda31bb2dcd6b4', NULL, 'u=2535994566,2862523534&fm=26&gp=0', 'http://114.116.30.229/group1/M00/01/47/wKgBol6FL06ACcXQAACpxPYo-oA667.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('a42ed698b17f8ac401534dffe92df427', NULL, '36464006', 'http://114.116.30.229/group1/M00/01/47/wKgBol6FL1uAIOmjAABLwkRcnhE742.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('a326ca60b0d5665244279dc15d84bd00', NULL, 't019ff1373e81042ad5', 'http://114.116.30.229/group1/M00/01/47/wKgBol6FMDyAeBAjAAActoKBnns861.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('0aac65497b224f34aab6d8e2e6737c6c', NULL, '01300543453388144152731911410', 'http://114.116.30.229/group1/M00/01/47/wKgBol6FMEuAV9jHABQ2d7rLgKI493.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('d67145480633e4b97a9dd914ce31802b', NULL, '01300543453388144152731911410', 'http://114.116.30.229/group1/M00/01/47/wKgBol6FMEyAeBHjABQ2d7rLgKI656.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('029f6fe7eb4eea2c17a8c468d670b873', NULL, '20150429113547267', 'http://114.116.30.229/group1/M00/01/47/wKgBol6FMFqABF0uAACGXc_CsZY557.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('e7d7022a2fb662eac166c931405c099f', NULL, '36464006', 'http://114.116.30.229/group1/M00/01/47/wKgBol6FML2AXLyEAABLwkRcnhE518.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('cf5a9a6412e1eacda11156a64c0bbaec', NULL, '20150429113547267', 'http://114.116.30.229/group1/M00/01/47/wKgBol6FMMeAOwx2AACGXc_CsZY272.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('3baf9285df8677c573b33b9dcaccf3b5', NULL, '20150429113547267', 'http://114.116.30.229/group1/M00/01/47/wKgBol6FPvCASwCDAACST4ugna4755.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('c2f6fea323e3ec3dc7bef9ab2d874dbc', NULL, '20150429113547267', 'http://114.116.30.229/group1/M00/01/47/wKgBol6FP2iADIOSAACST4ugna4346.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('b60b137d851bec59f26b0d10207261eb', NULL, 'fy', 'http://114.116.30.229/group1/M00/01/47/wKgBol6FQAiAAcnaAAA6xqMJlXY845.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('6c7e2b0d74fa68a9ff7f2b79ad3a2693', NULL, 'fy1', 'http://114.116.30.229/group1/M00/01/47/wKgBol6FQBWASLN2AABAfrcYLZA771.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('b2ed0d33c832067f7adc416e24b1823c', NULL, '微信图片_20191024090035', 'http://114.116.30.229/group1/M00/01/47/wKgBol6FQCOAYe2wAAC7Hst2p2o315.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('93b1ea87bcc4e7dc6baff10b59c86ff5', NULL, 'fy1', 'http://114.116.30.229/group1/M00/01/47/wKgBol6FQDeAVN3YAABAfrcYLZA323.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('97636e8c8ba18800ccb65f86bd7ca3b0', NULL, 'fy1', 'http://114.116.30.229/group1/M00/01/47/wKgBol6FQEOAfaTiAABAfrcYLZA844.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('a165c406304a3b64f8395c2e6f759ee6', NULL, 'fy1', 'http://114.116.30.229/group1/M00/01/47/wKgBol6FQG-AciV8AABAfrcYLZA578.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('ce9e1f66130d1ea4420a93efc734fea6', NULL, '微信图片_20191024090024', 'http://114.116.30.229/group1/M00/01/47/wKgBol6FRD-AOXmoAAGPc9a8xpY145.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('505c6d5d9c7f4777799c86193e1bfdb7', NULL, '20150429113547267', 'http://114.116.30.229/group1/M00/01/48/wKgBol6FSUeACqrDAACST4ugna4413.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('03e6abc30ed0bd80f609c9e821006861', NULL, '20150429113547267', 'http://114.116.30.229/group1/M00/01/48/wKgBol6FSVOAU4DiAACST4ugna4250.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('41623b9ac9ad5dff9afecf66195ec830', NULL, '20150429113547267', 'http://114.116.30.229/group1/M00/01/48/wKgBol6FSYeACp6rAACST4ugna4961.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('a95a26f9f56243a0604f4dbf5c96b68f', NULL, '20150429113547267', 'http://114.116.30.229/group1/M00/01/48/wKgBol6FShyAReXkAACST4ugna4036.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('3729c851a03682cc31bf22dd28690c42', NULL, '20150429113547267', 'http://114.116.30.229/group1/M00/01/48/wKgBol6FSiGAHXsdAACST4ugna4577.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('f47cefffe05d3833c9f8bbf73e730c3f', NULL, '20150429113547267', 'http://114.116.30.229/group1/M00/01/48/wKgBol6FSi2AaMBcAACST4ugna4907.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('c5ddf204e05633aeac00791fdcc9b97d', NULL, '20150429113547267', 'http://114.116.30.229/group1/M00/01/48/wKgBol6FSjGAZXBsAACST4ugna4037.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('453810f7909eb3eda71d29813cd7dd23', NULL, '20150429113547267', 'http://114.116.30.229/group1/M00/01/48/wKgBol6FTMeAULB1AACST4ugna4550.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('dc0d172508704319c2d7ec8cbeb63e11', NULL, '20150429113547267', 'http://114.116.30.229/group1/M00/01/48/wKgBol6FTQyAB38WAACST4ugna4117.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('a3d580de08345d03c0f363f84c862284', NULL, '20150429113547267', 'http://114.116.30.229/group1/M00/01/48/wKgBol6FTROAFE04AACST4ugna4092.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('a7477596df42d1ed437bd578a18e971b', NULL, '20150429113547267', 'http://114.116.30.229/group1/M00/01/48/wKgBol6FTReAd9CWAACST4ugna4285.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('47977c3b17a3de2daf9960dab566408f', NULL, '20150429113547267', 'http://114.116.30.229/group1/M00/01/49/wKgBol6FU2yAbz0hAACST4ugna4688.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('8804b047d8a8d695a75a9f4a90a3b032', NULL, '20150429113547267', 'http://114.116.30.229/group1/M00/01/49/wKgBol6FU3OAVKsBAACST4ugna4810.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('d77ccec9eafb770000bf3057fab0728c', NULL, '20150429113547267', 'http://114.116.30.229/group1/M00/01/49/wKgBol6FXrSAY5uFAACGXc_CsZY605.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('42e0baf7d08a1edb693d1d76f9c0f51f', NULL, '20150429113547267', 'http://114.116.30.229/group1/M00/01/49/wKgBol6FeGqAa8QbAACST4ugna4357.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('4b51995651d7ab9290a707c4d788247c', NULL, '20150429113547267', 'http://114.116.30.229/group1/M00/01/49/wKgBol6FeHqAUobhAACST4ugna4814.jpg', NULL);
INSERT INTO "public"."sys_upload" VALUES ('885633554a70473ca2a991d46d5098db', NULL, '20150429113547267', 'http://114.116.30.229/group1/M00/01/49/wKgBol6FgVuAJlwfAACST4ugna4817.jpg', NULL);

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS "public"."sys_user";
CREATE TABLE "public"."sys_user" (
  "user_id" varchar(32) COLLATE "pg_catalog"."default" NOT NULL,
  "username" varchar(254) COLLATE "pg_catalog"."default",
  "password" varchar(254) COLLATE "pg_catalog"."default",
  "salt" varchar(254) COLLATE "pg_catalog"."default",
  "mobile" varchar(254) COLLATE "pg_catalog"."default",
  "status" int4,
  "create_user_id" varchar(254) COLLATE "pg_catalog"."default",
  "create_time" timestamp(0),
  "user_no" varchar(254) COLLATE "pg_catalog"."default",
  "sex" int4,
  "org_id" varchar(100) COLLATE "pg_catalog"."default",
  "user_type" int4,
  "last_login_time" timestamp(6),
  "logo" varchar(100) COLLATE "pg_catalog"."default",
  "email" varchar(100) COLLATE "pg_catalog"."default",
  "context" text COLLATE "pg_catalog"."default",
  "dep_id" varchar(32) COLLATE "pg_catalog"."default",
  "dep_name" varchar(50) COLLATE "pg_catalog"."default",
  "name" varchar(50) COLLATE "pg_catalog"."default"
)
;
COMMENT ON COLUMN "public"."sys_user"."user_id" IS '用户ID';
COMMENT ON COLUMN "public"."sys_user"."username" IS '用户名，单位名称';
COMMENT ON COLUMN "public"."sys_user"."password" IS '密码';
COMMENT ON COLUMN "public"."sys_user"."salt" IS '盐';
COMMENT ON COLUMN "public"."sys_user"."mobile" IS '手机号';
COMMENT ON COLUMN "public"."sys_user"."status" IS '状态  0：禁用   1：正常';
COMMENT ON COLUMN "public"."sys_user"."create_user_id" IS '创建者ID';
COMMENT ON COLUMN "public"."sys_user"."create_time" IS '创建时间';
COMMENT ON COLUMN "public"."sys_user"."user_no" IS '登录账号';
COMMENT ON COLUMN "public"."sys_user"."sex" IS '性别';
COMMENT ON COLUMN "public"."sys_user"."org_id" IS '(省,市,区)；eq1（陕西省=610000）eq2（陕西省，西安市=610000，610100）eq3（陕西省，西安市，新城区=610000，610100，610102）';
COMMENT ON COLUMN "public"."sys_user"."user_type" IS '账号类型：0 admin账户,1 主账户 2 子账户';
COMMENT ON COLUMN "public"."sys_user"."last_login_time" IS '最后c登录时间';
COMMENT ON COLUMN "public"."sys_user"."dep_id" IS '部门表主键';
COMMENT ON COLUMN "public"."sys_user"."dep_name" IS '部门表名称';
COMMENT ON COLUMN "public"."sys_user"."name" IS '单位负责人名称';
COMMENT ON TABLE "public"."sys_user" IS '系统用户';

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO "public"."sys_user" VALUES ('admin', '管理员', 'a7364ac03ce4a71bceca27dac4c44be0324aee7c50beedae303cd3b235aa1586', 'tpKYdDGrd12jX7bAkogx', '13612345678', 1, '9ec9750e709431dad22365cabc5c625482e574c74adaebba7dd02f1129e4ce1d', '2016-11-11 00:00:00', 'admin', 1, '610000', 0, '2020-04-22 23:32:15.517', '', NULL, NULL, NULL, NULL, '管理员');
INSERT INTO "public"."sys_user" VALUES ('8e64b829fe92f946d29b05c2af5fc8bb', NULL, 'a13d498ec12e015dc1eb07fce1b445a9bdeb6865e5fba15f7abfcc6e989b37b2', 'BX8aPjeSQacrqbYUSgDR', NULL, 1, 'admin', '2020-04-13 13:12:00', 'xzb1', NULL, NULL, 1, NULL, '', NULL, NULL, NULL, NULL, '');

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS "public"."sys_user_role";
CREATE TABLE "public"."sys_user_role" (
  "id" varchar(32) COLLATE "pg_catalog"."default" NOT NULL,
  "user_id" varchar(254) COLLATE "pg_catalog"."default",
  "role_id" varchar(32) COLLATE "pg_catalog"."default"
)
;
COMMENT ON COLUMN "public"."sys_user_role"."user_id" IS '用户ID';
COMMENT ON COLUMN "public"."sys_user_role"."role_id" IS '角色ID';
COMMENT ON TABLE "public"."sys_user_role" IS '用户与角色对应关系';

-- ----------------------------
-- Table structure for sys_user_token
-- ----------------------------
DROP TABLE IF EXISTS "public"."sys_user_token";
CREATE TABLE "public"."sys_user_token" (
  "user_id" varchar(254) COLLATE "pg_catalog"."default" NOT NULL,
  "token" varchar(254) COLLATE "pg_catalog"."default",
  "expire_time" timestamp(0),
  "update_time" timestamp(0),
  "browser" varchar(50) COLLATE "pg_catalog"."default",
  "os" varchar(255) COLLATE "pg_catalog"."default"
)
;
COMMENT ON COLUMN "public"."sys_user_token"."user_id" IS '用户ID';
COMMENT ON COLUMN "public"."sys_user_token"."token" IS 'token';
COMMENT ON COLUMN "public"."sys_user_token"."expire_time" IS '过期时间';
COMMENT ON COLUMN "public"."sys_user_token"."update_time" IS '更新时间';
COMMENT ON COLUMN "public"."sys_user_token"."browser" IS '浏览器';
COMMENT ON COLUMN "public"."sys_user_token"."os" IS '操作系统';
COMMENT ON TABLE "public"."sys_user_token" IS '系统用户Token';

-- ----------------------------
-- Records of sys_user_token
-- ----------------------------
INSERT INTO "public"."sys_user_token" VALUES ('0abbb0d655834379b4092d04e53fba56', 'e92ee6884ca91f4c4bb59d9a6e960346', '2018-08-27 00:00:00', '2018-08-27 00:00:00', NULL, NULL);
INSERT INTO "public"."sys_user_token" VALUES ('7028e6a882c04388b0c4db76676f94c3', '3251e38f2714108d2b678c23a564df16', '2019-08-27 00:00:00', '2019-08-26 00:00:00', NULL, NULL);
INSERT INTO "public"."sys_user_token" VALUES ('af901dfd62cb470ea135994fd58ec263', 'fae882319903e26b8765c1db3e49b8f2', '2019-08-28 00:00:00', '2019-08-27 00:00:00', NULL, NULL);
INSERT INTO "public"."sys_user_token" VALUES ('cb4724ec2a5b479d8b1803cc1b9d56e0', '2e4d51d53c1e5853a221ce98c815154b', '2018-09-08 00:00:00', '2018-09-07 00:00:00', NULL, NULL);
INSERT INTO "public"."sys_user_token" VALUES ('d17fbe0ce74440d2908888f0483cdb9c', '70eb0f87b15533c2f14ea1f844ba41ca', '2019-08-29 00:00:00', '2019-08-28 00:00:00', NULL, NULL);
INSERT INTO "public"."sys_user_token" VALUES ('4375f57f6045485a8124a0023ca27cc1', '66d3e2addf123c13c4f295c7a5b2c65c', '2019-10-24 05:18:55', '2019-10-23 17:18:55', NULL, NULL);
INSERT INTO "public"."sys_user_token" VALUES ('e4f6668fc52a4de2bd9d75e5c9075745', '1439e8fdd462c86cd816db320cf86bec', '2019-10-27 02:43:25', '2019-10-26 14:43:25', NULL, NULL);
INSERT INTO "public"."sys_user_token" VALUES ('40828fbd9dc64fd880614fce0ede6dcf', '76afe8c2c40ddd2bdbb567d32137c407', '2019-10-25 02:24:52', '2019-10-24 14:24:52', NULL, NULL);
INSERT INTO "public"."sys_user_token" VALUES ('c802d968ec8b4729a8410a163bf9f845', '03137dce413e9acc9a3bbd74a2525ee7', '2019-10-16 01:48:04', '2019-10-15 13:48:04', NULL, NULL);
INSERT INTO "public"."sys_user_token" VALUES ('450a655978754bf38f5fd21a33cf22ed', '2dbad62bb58fc160ba3daf7e045b235c', '2019-10-27 03:05:09', '2019-10-26 15:05:09', NULL, NULL);
INSERT INTO "public"."sys_user_token" VALUES ('c61d1a799c5f428c9f15f1c1193e38be', '9c0b648ad829a594c0384d8ff75f59da', '2019-10-27 03:35:15', '2019-10-26 15:35:15', NULL, NULL);
INSERT INTO "public"."sys_user_token" VALUES ('f1b4d38fa9a4417ab33171624c9f97ae', '422a42301b3819ac672508b598f6eaee', '2019-10-27 03:46:16', '2019-10-26 15:46:16', NULL, NULL);
INSERT INTO "public"."sys_user_token" VALUES ('0f3dbc0bdf10e1c238fd7c2df4a0726f', '59429930d0ffe23b1f7e8cd06584ffc8', '2019-11-26 02:57:45', '2019-11-25 14:57:45', 'Opera浏览器', 'WinVista');
INSERT INTO "public"."sys_user_token" VALUES ('22fa8d115996fee0aacd697a92e1634f', 'bd9b50f5091b442c39947b99883bd17a', '2019-11-27 04:28:45', '2019-11-26 16:28:45', '苹果浏览器', 'Win10');
INSERT INTO "public"."sys_user_token" VALUES ('5676d7a1357cd78bc04daef587c46195', '6fa708de091deecd7e3e471962e1d1e9', '2020-03-16 23:43:15', '2020-03-16 11:12:39', '谷歌浏览器', 'Win7');
INSERT INTO "public"."sys_user_token" VALUES ('ec61a873141c1c322dd8ba6ffc5f1553', '5d8188a2576b889e0c9002eca689106c', '2019-11-26 22:44:50', '2019-11-26 10:44:50', 'Opera浏览器', 'WinVista');
INSERT INTO "public"."sys_user_token" VALUES ('fe3aa62165b65986ef215b83f1cd9ba1', '40c5a25db86f8d1a3536d01a6fcc49ad', '2019-11-29 23:31:22', '2019-11-29 11:31:22', 'Opera浏览器', 'WinVista');
INSERT INTO "public"."sys_user_token" VALUES ('fcf487003eb28539f4d29279f1485fd9', '45a3b67a040c33cbf0a4e41ed610987e', '2019-11-26 23:06:09', '2019-11-26 11:06:09', '苹果浏览器', 'Win10');
INSERT INTO "public"."sys_user_token" VALUES ('317a118324191ae6a91954d5d75a8eef', '943c1bc4ecc46232ef0c7a62d7352b52', '2019-11-21 05:39:13', '2019-11-20 17:39:13', NULL, NULL);
INSERT INTO "public"."sys_user_token" VALUES ('44bd7028580a721fc9f3d12289889af5', '4ebd686487585046c418fcdb1cc5e851', '2019-11-22 08:28:01', '2019-11-21 20:28:01', NULL, NULL);
INSERT INTO "public"."sys_user_token" VALUES ('253e11363efba95d1d436423ce5f927a', 'a4f3e73143bd45449e5a56dd51c66a72', '2019-11-22 21:03:53', '2019-11-22 09:03:53', NULL, NULL);
INSERT INTO "public"."sys_user_token" VALUES ('db5fb87a69792093f901a8a907d18e56', '07571c7ec45646cbc580af113e255dd7', '2019-11-24 01:46:36', '2019-11-23 13:46:36', '', '');
INSERT INTO "public"."sys_user_token" VALUES ('69d3dcddda674f76801d07087fd8b5d2', '01be984034ed68c7a07bd1886cea8247', '2019-10-25 05:02:49', '2019-10-24 17:02:49', NULL, NULL);
INSERT INTO "public"."sys_user_token" VALUES ('624d822cd1154df481b1596604cdc5a0', '8ea0c922ab08ecaa4de2b6a9675b8055', '2019-10-29 20:40:57', '2019-10-29 08:40:57', NULL, NULL);
INSERT INTO "public"."sys_user_token" VALUES ('45146d231c6145d38ea01bc78b0e1bbe', 'f2737c529531f89b7848b1dd6f3ad50a', '2019-11-21 05:35:12', '2019-11-20 17:35:12', NULL, NULL);
INSERT INTO "public"."sys_user_token" VALUES ('e54ccc2e72f94ecbbdce5d449c11b1f2', 'c7cda99bbfce01ac5b3967c4dea6080d', '2019-12-01 05:22:20', '2019-11-30 17:22:20', '苹果浏览器', 'Win10');
INSERT INTO "public"."sys_user_token" VALUES ('fbfc96ffa67784fe2ad9a6cd633cb699', 'e8c34421236c15a5fb77a92d46a957be', '2019-11-29 23:35:26', '2019-11-29 11:35:26', 'Opera浏览器', 'WinVista');
INSERT INTO "public"."sys_user_token" VALUES ('6faeedcc71fcbc8076e956ace8e0810c', 'd46d04977d789ef4e691d17447deec3c', '2019-12-26 05:12:05', '2019-12-25 17:12:05', '谷歌浏览器', 'Win10');
INSERT INTO "public"."sys_user_token" VALUES ('2484e47a126028e50f14398072228c7f', 'ae0d25a98161574664c2f2c8640c2106', '2019-12-06 02:04:48', '2019-12-05 14:04:48', 'Opera浏览器', 'WinVista');
INSERT INTO "public"."sys_user_token" VALUES ('0db9cf638c369616b37964f3146bf0d6', 'a0a1c476f68d4419b62974d377b70cf5', '2020-03-24 05:58:31', '2020-03-23 17:27:55', '谷歌浏览器', 'Win7');
INSERT INTO "public"."sys_user_token" VALUES ('86028fd84b8a9fdbf4958579fbea3d97', 'fd827820995d9d02cdf8db74cc0c1eec', '2019-12-06 02:06:23', '2019-12-05 14:06:23', 'Opera浏览器', 'WinVista');
INSERT INTO "public"."sys_user_token" VALUES ('ed1ec77147c69874410b9d906aa82983', '2d9fd6b7092b4c94a0409251de245b46', '2020-01-20 03:17:51', '2020-01-19 15:17:51', 'QQ浏览器', 'Win7');
INSERT INTO "public"."sys_user_token" VALUES ('0a59f1a9f9177afad239a6a19a0bf9f7', '99656ab4d523b5cbf7fa83a6162d5cf9', '2020-01-23 06:00:06', '2020-01-22 18:00:06', '谷歌浏览器', 'Win10');
INSERT INTO "public"."sys_user_token" VALUES ('848f084ea6e3df971e58c076173ab29d', '7bbba65c8a552f0ffbd23d2f243a74b5', '2019-12-06 22:20:07', '2019-12-06 10:20:07', '苹果浏览器', 'Win7');
INSERT INTO "public"."sys_user_token" VALUES ('6f6c2e30ee6f4379b39435cbfda70647', '63d6e83e67188b848ff4b6ea00a2b820', '2020-01-22 02:24:06', '2020-01-21 14:24:06', '谷歌浏览器', 'Win10');
INSERT INTO "public"."sys_user_token" VALUES ('0f3810ece7ea46c16cebab91c999c99b', 'e1c641cf0c9ed0dbb97af806fb4c1b5b', '2019-12-06 02:06:34', '2019-12-05 14:06:34', 'Opera浏览器', 'WinVista');
INSERT INTO "public"."sys_user_token" VALUES ('920a5a50a2a8e48562dfd514e0892eb5', 'b5861f18a5c06745108f8cb2764dd513', '2019-12-03 03:59:18', '2019-12-02 15:59:18', 'MicrosoftEdge', 'Win10');
INSERT INTO "public"."sys_user_token" VALUES ('9096dd6063ac5b6043d1b7351588d9cb', '7bda943f7913669de74df1bd90515f01', '2019-12-20 19:18:23', '2019-12-20 07:18:23', 'Opera浏览器', 'WinVista');
INSERT INTO "public"."sys_user_token" VALUES ('8913a306c97bd8b4defc8c52d540b56a', 'debecf14aa31039de5eacf685a0db586', '2019-12-30 21:38:27', '2019-12-30 09:38:27', '谷歌浏览器', 'Win10');
INSERT INTO "public"."sys_user_token" VALUES ('c2997e6077026684e32ccacb55ba1646', '4b59630950ed9d08fd56754eb63d4673', '2019-12-20 23:59:36', '2019-12-20 11:59:36', 'Opera浏览器', 'WinVista');
INSERT INTO "public"."sys_user_token" VALUES ('f07ff56e9900cad808af1bca1eded27d', '12c09b3e930aede98569852a6ee384a1', '2019-12-13 23:46:26', '2019-12-13 11:46:26', 'Opera浏览器', 'WinVista');
INSERT INTO "public"."sys_user_token" VALUES ('c2144f1a4df511f66f8b67da457bba74', '29f1952917ace1916cbf3dd3d40f9725', '2020-01-20 04:19:11', '2020-01-19 16:19:11', 'QQ浏览器', 'Win7');
INSERT INTO "public"."sys_user_token" VALUES ('c3eebc22c2020380355585c92aa68692', 'bd0ce575dc2c7bb3a0494027d3ed3c9e', '2020-01-21 21:31:27', '2020-01-21 09:31:27', '谷歌浏览器', 'Win10');
INSERT INTO "public"."sys_user_token" VALUES ('c72d73ab23b0ce1382191c1f5f1d84d8', '3e62c0157fc94bdfc6330719e3eeaa9e', '2020-02-29 03:23:01', '2020-02-28 15:23:01', '谷歌浏览器', 'Win7');
INSERT INTO "public"."sys_user_token" VALUES ('26fa53cca3ef9dc47e4b397704acbfbd', 'a410cc360de43ebe2b193911ad6f2d93', '2020-03-15 04:11:19', '2020-03-14 15:40:43', '谷歌浏览器', 'Win10');
INSERT INTO "public"."sys_user_token" VALUES ('857e96d8933ab2ec0c84ef243b3d86a0', 'b3c12a06f7ee588bca5a8409c2387471', '2019-12-20 21:59:15', '2019-12-20 09:59:15', 'Opera浏览器', 'WinVista');
INSERT INTO "public"."sys_user_token" VALUES ('d403097d1189279e64e3d8f8a32e4a68', 'c5a265995b1eca5e4ec5ec8522e8cd44', '2020-01-22 02:03:47', '2020-01-21 14:03:47', '谷歌浏览器', 'Win7');
INSERT INTO "public"."sys_user_token" VALUES ('7daf2e103f09792af33b7888de0e1b24', 'f1eee0859a6561a49d567f476efd8b01', '2020-01-21 21:12:22', '2020-01-21 09:12:22', '谷歌浏览器', 'Win7');
INSERT INTO "public"."sys_user_token" VALUES ('5e952cc54dc84692b712e34d88487788', '497c0fb36985fdcb5db1ea9be7f95614', '2020-01-20 03:52:37', '2020-01-19 15:52:37', '火狐浏览器', 'Win7');
INSERT INTO "public"."sys_user_token" VALUES ('79ab6a8e299427f9d01275843f79331f', 'b08150d1c08e40a698d9631320abd859', '2020-03-24 03:29:37', '2020-03-23 14:59:01', '谷歌浏览器', 'Win10');
INSERT INTO "public"."sys_user_token" VALUES ('6de0c9a745c55d3f8f8214e1bfb109e0', 'c04f501cd2a5d98c0741924873e92366', '2020-03-17 01:59:08', '2020-03-16 13:28:32', '谷歌浏览器', 'Win10');
INSERT INTO "public"."sys_user_token" VALUES ('897a8f5764020f86d64c3ad1ae25235c', '5dbdcbffe6bb5e608ca3bbad1be59c3e', '2020-03-29 04:35:52', '2020-03-28 16:05:16', '谷歌浏览器', 'Win7');
INSERT INTO "public"."sys_user_token" VALUES ('2aa5f468bd02204aa72b36170bc125d4', '6e052b44979c58ec927222222911e8c1', '2020-03-28 06:46:14', '2020-03-27 18:15:38', '谷歌浏览器', 'Win7');
INSERT INTO "public"."sys_user_token" VALUES ('974543c14ded76419050bf37009a06c5', '117b8dcbb240cf91f41933aec4d10ba8', '2020-04-02 20:38:33', '2020-04-02 08:07:57', '谷歌浏览器', 'Win7');
INSERT INTO "public"."sys_user_token" VALUES ('274f7d356eda2212e8303fd6adfc1902', '57ef2b7cbd2125ca38f4fced030af663', '2019-12-20 13:46:30', '2019-12-20 01:46:30', '谷歌浏览器', 'Win10');
INSERT INTO "public"."sys_user_token" VALUES ('d469b4c2051abba16b33567153586e83', '9abc222127d2049f3564a424809bee72', '2020-01-13 21:23:48', '2020-01-13 09:23:48', '谷歌浏览器', 'Win10');
INSERT INTO "public"."sys_user_token" VALUES ('53fc913bbc84ff9ad2258be022e5ae69', 'a7483a823bac4ca765684dfbf70f3462', '2020-01-23 06:01:17', '2020-01-22 18:01:17', '谷歌浏览器', 'Win7');
INSERT INTO "public"."sys_user_token" VALUES ('be38667e7d8571cf6b8fa19ed4381daf', '54f0d0b2d5e7d5a9e0eeaaf6a0d9b029', '2020-01-21 21:54:48', '2020-01-21 09:54:48', '谷歌浏览器', 'Win7');
INSERT INTO "public"."sys_user_token" VALUES ('52885d70f4dbdbc6b8ba23b1ddb1433a', '62a22fefa4a4c0d8f3783d107093db7c', '2020-01-21 05:53:44', '2020-01-20 17:53:44', '谷歌浏览器', 'Win10');
INSERT INTO "public"."sys_user_token" VALUES ('35cb9840fe3c3ba1cda0ed21c8871750', '7949ab31a02798b022f40323d74cdf46', '2020-01-08 23:30:08', '2020-01-08 11:30:08', '谷歌浏览器', 'Win7');
INSERT INTO "public"."sys_user_token" VALUES ('4ab74977a9054a85473824f37731c890', 'ca6645b556e8630d5efd82044aee7aac', '2020-01-09 03:17:44', '2020-01-08 15:17:44', '谷歌浏览器', 'Win10');
INSERT INTO "public"."sys_user_token" VALUES ('d5951d8dd40cda692e496f32e4275c5b', '4ee5904d8166ab611e048e14dde91d94', '2020-03-24 03:22:47', '2020-03-23 14:52:11', '谷歌浏览器', 'Win10');
INSERT INTO "public"."sys_user_token" VALUES ('ed81b1d2fc1f1e65f88a0f7304f59cbf', '9b1196a2030a60bf2051425a9602a47d', '2020-04-02 22:55:39', '2020-04-02 10:25:03', '谷歌浏览器', 'Win7');
INSERT INTO "public"."sys_user_token" VALUES ('24971d74989f5202f9884a1240d572ab', '327fb621425cfe45c765878e3e29133e', '2020-01-20 03:19:19', '2020-01-19 15:19:19', 'QQ浏览器', 'Win7');
INSERT INTO "public"."sys_user_token" VALUES ('925cd94f8f4bb32654e74de8758ef318', 'bb945f1ccb8d2a5783a2046844a5eb85', '2020-03-15 04:04:05', '2020-03-14 15:33:29', '谷歌浏览器', 'Win10');
INSERT INTO "public"."sys_user_token" VALUES ('d2e7df43dc5506899f9702208db5a063', 'b089211ed71b1ab7bb363dafdc41fbf6', '2020-01-23 02:27:42', '2020-01-22 14:27:42', '谷歌浏览器', 'Win10');
INSERT INTO "public"."sys_user_token" VALUES ('542a4629168946c5df150f99936985a4', '067c69d22c07424cfe569991286c5726', '2020-01-15 21:12:17', '2020-01-15 09:12:17', '谷歌浏览器', 'Win10');
INSERT INTO "public"."sys_user_token" VALUES ('cebaa8f88bec6a94e6a40b8748ca2c48', '732069816f925c89230389f0d59f6163', '2020-01-20 03:54:26', '2020-01-19 15:54:26', '火狐浏览器', 'Win7');
INSERT INTO "public"."sys_user_token" VALUES ('2bae768fcdf8485302de600bee75bf3f', '0534bda481e96d357851b442103e9a8f', '2020-01-04 03:03:18', '2020-01-03 15:03:18', '谷歌浏览器', 'Win7');
INSERT INTO "public"."sys_user_token" VALUES ('68c84b869714e49ce2adce8c27cc641f', '6143ac51429a7f058ef22209a4f6ce77', '2020-04-02 22:07:24', '2020-04-02 09:36:48', '谷歌浏览器', 'Win7');
INSERT INTO "public"."sys_user_token" VALUES ('e44708d1215bb80c6757ea1ddc1e8681', 'e38c52d9290bcbf2aeb2aff68f42f082', '2020-03-05 04:17:57', '2020-03-04 16:17:57', '谷歌浏览器', 'Win7');
INSERT INTO "public"."sys_user_token" VALUES ('8829b7a34857b5a1fefa5300e9ce6489', '5cdef7de71ac42351ccf7a23bc957259', '2019-12-20 21:59:41', '2019-12-20 09:59:41', 'Opera浏览器', 'WinVista');
INSERT INTO "public"."sys_user_token" VALUES ('0023e7af4982355a082f86fdd0dc0d79', '63170c95d66dca5ddf3f4faa74a5febb', '2020-03-26 00:15:42', '2020-03-25 11:45:06', '谷歌浏览器', 'Win10');
INSERT INTO "public"."sys_user_token" VALUES ('b2d3d20f2a2ba3d27614312591bbc656', '19165c8c93e6d9273df93477f60ccdd1', '2020-03-24 22:45:17', '2020-03-24 10:45:17', '谷歌浏览器', 'Win10');
INSERT INTO "public"."sys_user_token" VALUES ('bad0a397c2cca932fb78d5911aa67f02', '15d8e96b70863bfb2dd0dd6af93fbe72', '2020-01-22 22:43:52', '2020-01-22 10:43:52', '谷歌浏览器', 'Win10');
INSERT INTO "public"."sys_user_token" VALUES ('edc20506789321b8bbc80bc368515161', 'b5943a7f929decafdb9d5974ae667eaa', '2020-04-02 23:09:59', '2020-04-02 10:39:23', '谷歌浏览器', 'Win7');
INSERT INTO "public"."sys_user_token" VALUES ('bfe91ea9e1ba3d44547166cab96c2e6c', '76da10d643ce2e0ba2ee349de68eff57', '2020-04-03 04:09:16', '2020-04-02 16:09:16', '谷歌浏览器', 'Win10');
INSERT INTO "public"."sys_user_token" VALUES ('41c0f992049afb3b8e974917e60eaa24', 'b0c9f1ca84d66878f5a56fb96b712a95', '2020-03-15 04:10:50', '2020-03-14 15:40:14', '谷歌浏览器', 'Win10');
INSERT INTO "public"."sys_user_token" VALUES ('admin', 'c00bc596bf9ca437e63b9aa2959a3ece', '2020-04-23 11:33:16', '2020-04-22 23:02:40', '谷歌浏览器', 'Win10');
INSERT INTO "public"."sys_user_token" VALUES ('833ea9c68cb9ca9a889293016c658c5d', '36de52c73b56774d239b4036414ef261', '2020-04-06 11:59:25', '2020-04-05 23:28:49', '谷歌浏览器', 'Win10');

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."sys_log_id_seq"
OWNED BY "public"."sys_log"."id";
SELECT setval('"public"."sys_log_id_seq"', 3166, true);

-- ----------------------------
-- Primary Key structure for table employee_again_entry
-- ----------------------------
ALTER TABLE "public"."employee_again_entry" ADD CONSTRAINT "employee_again_entry_pkey" PRIMARY KEY ("again_id");

-- ----------------------------
-- Primary Key structure for table employee_assess_record
-- ----------------------------
ALTER TABLE "public"."employee_assess_record" ADD CONSTRAINT "employee_assess_record_pkey" PRIMARY KEY ("assess_id");

-- ----------------------------
-- Primary Key structure for table employee_base_info
-- ----------------------------
ALTER TABLE "public"."employee_base_info" ADD CONSTRAINT "employee_base_info_pkey" PRIMARY KEY ("base_id");

-- ----------------------------
-- Primary Key structure for table employee_call_record
-- ----------------------------
ALTER TABLE "public"."employee_call_record" ADD CONSTRAINT "employee_call_record_pkey" PRIMARY KEY ("call_id");

-- ----------------------------
-- Primary Key structure for table employee_dimission_record
-- ----------------------------
ALTER TABLE "public"."employee_dimission_record" ADD CONSTRAINT "employee_dimission_record_pkey" PRIMARY KEY ("dimission_id");

-- ----------------------------
-- Primary Key structure for table employee_edu_info
-- ----------------------------
ALTER TABLE "public"."employee_edu_info" ADD CONSTRAINT "employee_edu_info_pkey" PRIMARY KEY ("edu_id");

-- ----------------------------
-- Primary Key structure for table employee_equip_record
-- ----------------------------
ALTER TABLE "public"."employee_equip_record" ADD CONSTRAINT "employee_equip_record_pkey" PRIMARY KEY ("employee_equip_id");

-- ----------------------------
-- Primary Key structure for table employee_labor_contract
-- ----------------------------
ALTER TABLE "public"."employee_labor_contract" ADD CONSTRAINT "employee_labor_contract_pkey" PRIMARY KEY ("contract_id");

-- ----------------------------
-- Primary Key structure for table employee_leave_record
-- ----------------------------
ALTER TABLE "public"."employee_leave_record" ADD CONSTRAINT "employee_leave_record_pkey" PRIMARY KEY ("leave_id");

-- ----------------------------
-- Primary Key structure for table employee_license_record
-- ----------------------------
ALTER TABLE "public"."employee_license_record" ADD CONSTRAINT "employee_license_record_pkey" PRIMARY KEY ("license_id");

-- ----------------------------
-- Primary Key structure for table employee_rankmanage_record
-- ----------------------------
ALTER TABLE "public"."employee_rankmanage_record" ADD CONSTRAINT "employee_rankmanage_record_pkey" PRIMARY KEY ("rank_id");

-- ----------------------------
-- Primary Key structure for table employee_rew_pun_record
-- ----------------------------
ALTER TABLE "public"."employee_rew_pun_record" ADD CONSTRAINT "employee_rew_pun_record_pkey" PRIMARY KEY ("rew_pun_id");

-- ----------------------------
-- Primary Key structure for table employee_social_relation
-- ----------------------------
ALTER TABLE "public"."employee_social_relation" ADD CONSTRAINT "employee_social_relation_pkey" PRIMARY KEY ("soc_id");

-- ----------------------------
-- Primary Key structure for table employee_train_record
-- ----------------------------
ALTER TABLE "public"."employee_train_record" ADD CONSTRAINT "employee_train_record_pkey" PRIMARY KEY ("train_id");

-- ----------------------------
-- Primary Key structure for table employee_work_exp
-- ----------------------------
ALTER TABLE "public"."employee_work_exp" ADD CONSTRAINT "employee_work_exp_pkey" PRIMARY KEY ("exp_id");

-- ----------------------------
-- Primary Key structure for table sys_captcha
-- ----------------------------
ALTER TABLE "public"."sys_captcha" ADD CONSTRAINT "sys_captcha_pkey" PRIMARY KEY ("uuid");

-- ----------------------------
-- Primary Key structure for table sys_department
-- ----------------------------
ALTER TABLE "public"."sys_department" ADD CONSTRAINT "sys_department_pkey" PRIMARY KEY ("dep_id");

-- ----------------------------
-- Primary Key structure for table sys_dict
-- ----------------------------
ALTER TABLE "public"."sys_dict" ADD CONSTRAINT "sys_dict_pkey" PRIMARY KEY ("dict_id");

-- ----------------------------
-- Primary Key structure for table sys_log
-- ----------------------------
ALTER TABLE "public"."sys_log" ADD CONSTRAINT "sys_log_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table sys_menu
-- ----------------------------
ALTER TABLE "public"."sys_menu" ADD CONSTRAINT "sys_menu_pkey" PRIMARY KEY ("menu_id");

-- ----------------------------
-- Primary Key structure for table sys_organization
-- ----------------------------
ALTER TABLE "public"."sys_organization" ADD CONSTRAINT "pro_city_area_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table sys_role
-- ----------------------------
ALTER TABLE "public"."sys_role" ADD CONSTRAINT "sys_role_pkey" PRIMARY KEY ("role_id");

-- ----------------------------
-- Primary Key structure for table sys_role_menu
-- ----------------------------
ALTER TABLE "public"."sys_role_menu" ADD CONSTRAINT "sys_role_menu_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table sys_upload
-- ----------------------------
ALTER TABLE "public"."sys_upload" ADD CONSTRAINT "sys_upload_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table sys_user
-- ----------------------------
ALTER TABLE "public"."sys_user" ADD CONSTRAINT "sys_user_admin_pkey" PRIMARY KEY ("user_id");

-- ----------------------------
-- Primary Key structure for table sys_user_role
-- ----------------------------
ALTER TABLE "public"."sys_user_role" ADD CONSTRAINT "sys_user_role_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table sys_user_token
-- ----------------------------
ALTER TABLE "public"."sys_user_token" ADD CONSTRAINT "sys_user_token_pkey" PRIMARY KEY ("user_id");
