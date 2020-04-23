package com.xiaobo.common.utils;

/**
 * 常量
 * 
 * @author  zhangxiaobo
 * @date 2017年11月15日 下午1:23:52
 */
public class Constant {
	/** 超级管理员ID */
	public static final String SUPER_ADMIN = "admin";
	 
	
	//token 12小时后过期
	public final static int EXPIRE = 3600 * 12;
	 
   

    /**
     * 定时任务状态
     * 
     */
    public enum ScheduleStatus {
        /**
         * 正常
         */
    	NORMAL(0),
        /**
         * 暂停
         */
    	PAUSE(1);

        private int value;

        ScheduleStatus(int value) {
            this.value = value;
        }
        
        public int getValue() {
            return value;
        }
    }
    //机构导入，导出excel标题列
    public static final String IMPORT_ORG_TITLE_COULMN0 = "上级机构名称";
    public static final String IMPORT_ORG_TITLE_COULMN1 = "机构名称";
    public static final String IMPORT_ORG_TITLE_COULMN2 = "部门";
    public static final String IMPORT_ORG_TITLE_COULMN3 = "部门负责人";
    //系统帮助缓存key
    public static final String HELP_DOCUMENT_KEY = "help_document";
    //账号信息导出excel标题列
    public static final String IMPORT_USER_TITLE_USERNO= "用户名";
    public static final String IMPORT_USER_TITLE_USERNAME = " 归属人";
    public static final String IMPORT_USER_TITLE_ORGNAME = " 归属单位";
}
