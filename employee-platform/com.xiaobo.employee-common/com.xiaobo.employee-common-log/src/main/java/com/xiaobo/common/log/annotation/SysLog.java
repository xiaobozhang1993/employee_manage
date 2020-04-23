package com.xiaobo.common.log.annotation;

import java.lang.annotation.*;

/**
 * 系统日志注解
 * 
 * @author zhangxiaobo
 * @date 2017年3月8日 上午10:19:56
 */
@Target(ElementType.METHOD)
@Retention(RetentionPolicy.RUNTIME)
@Documented
public @interface SysLog {

	/**
	 * 功能名称
	 * @return
	 */
	String value() default "";
	
	/**
	 * 系统名称
	 * @return
	 */
	SysModule system() default SysModule.unknow   ;
}
