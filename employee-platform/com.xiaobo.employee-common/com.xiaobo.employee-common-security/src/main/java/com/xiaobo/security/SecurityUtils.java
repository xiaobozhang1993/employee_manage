package com.xiaobo.common.security;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.xiaobo.common.entity.SysUser;
import com.xiaobo.common.utils.HttpContextUtils;
import com.xiaobo.common.utils.SpringContextUtils;
import com.xiaobo.oauth2.service.OauthService;

/**
 * 认证公共类,获取当前用户等信息
 * @author zhangxiaobo
 *
 */
@Component
public class SecurityUtils {

	@Autowired
	private OauthService service ;
 
	public SysUser getCurrentUser() {
		// TODO Auto-generated method stub
		
		
		  //获取请求token
    	HttpServletRequest hsr = HttpContextUtils.getHttpServletRequest();
    	
		
		String token = HttpContextUtils.getRequestToken(hsr) ;
		
		if(StringUtils.isBlank(token)) {
			return null ;
		}
		
		if(token.length() > 50) {
			return service.queryByAppToken(token);
		}
		
		SysUser ret = service.queryByToken(token);
		 
		return ret;
	}
	
	
	/**
	 * static 方法请求 当前用户 
	 * @return
	 */
	public static SysUser getUser() {
		
		SecurityUtils securityUtils = SpringContextUtils.getBean(SecurityUtils.class);
		if(securityUtils != null) {
			return securityUtils.getCurrentUser();
		}
		
		return null ;
		
	}
	
	
}
