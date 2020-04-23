package com.xiaobo.common.app.annotation;

import java.lang.annotation.*;

/**
 * app perm验证
 * @author zhangxiaobo
 * 
 * @date 2017/9/23 14:30
 */
@Target(ElementType.METHOD)
@Retention(RetentionPolicy.RUNTIME)
@Documented
public @interface AppPerm {
	String perm()  default ""; // 权限码
	//UserType role() default UserType.unknow; // 用户类型
}
