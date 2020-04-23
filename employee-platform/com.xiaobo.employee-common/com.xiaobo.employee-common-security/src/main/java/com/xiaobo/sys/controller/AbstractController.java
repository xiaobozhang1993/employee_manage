package com.xiaobo.sys.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;



/**
 * Controller公共组件
 * 
 * @author zhangxiaobo
 * 
 * @date 2016年11月9日 下午9:42:26
 */
public abstract class AbstractController {
	protected Logger logger = LoggerFactory.getLogger(getClass());
	
	protected com.xiaobo.common.entity.SysUser getUser() {
		return com.xiaobo.common.security.SecurityUtils.getUser();
	}

	protected String getUserId() {
		com.xiaobo.common.entity.SysUser user = getUser();
		return user != null ? user.getUserId() : null;
	}
}
