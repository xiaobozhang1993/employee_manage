package com.xiaobo.common.annotation;

import java.lang.annotation.*;

/**
 *  cache 注解
 * 
 * @author zhangxiaobo
 * @date 2018年10月13日 上午10:19:56
 */
@Target(ElementType.METHOD)
@Retention(RetentionPolicy.RUNTIME)
@Documented
public @interface TrCache {

	/**
	 * 缓存key
	 * @return
	 */
	String key() default "";
	
	/**
	 * 缓存秒数 -1 描述参考系统默认缓存时间
	 */
	int cacheSecond() default -1;
}
