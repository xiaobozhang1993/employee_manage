package com.xiaobo.app.interceptor;


import com.xiaobo.common.app.annotation.AppPerm;
import com.xiaobo.common.app.annotation.Login;
import com.xiaobo.common.entity.SysUser;
import com.xiaobo.common.exception.RRException;
import com.xiaobo.common.utils.JwtUtils;
import com.xiaobo.oauth2.service.OauthService;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Component;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Set;

/**
 * 权限(Token)验证
 * @author zhangxiaobo
 * @email 1920969038@qq.com.com
 * @date 2017-03-23 15:38
 */
@Component
public class AuthorizationInterceptor extends HandlerInterceptorAdapter {
    @Autowired
    private JwtUtils jwtUtils;

    public static final String USER_KEY = "userId";
    
    @Autowired
    private OauthService oauthService ;
     

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        Login annotation;
        AppPerm aperm;
        if(handler instanceof HandlerMethod) {
            annotation = ((HandlerMethod) handler).getMethodAnnotation(Login.class);
            aperm = ((HandlerMethod) handler).getMethodAnnotation(AppPerm.class); 
        }else{
            return true;
        }

        if(annotation == null){
            return true;
        }

        //获取用户凭证
        String token = request.getHeader(jwtUtils.getHeader());
        if(StringUtils.isBlank(token)){
            token = request.getParameter(jwtUtils.getHeader());
        }

        //凭证为空
        if(StringUtils.isBlank(token)){
            //throw new RRException(jwtUtils.getHeader() + "不能为空", HttpStatus.UNAUTHORIZED.value());
            throw new RRException("请先登录", HttpStatus.UNAUTHORIZED.value());
        }
         
     /*   Claims claims = jwtUtils.getClaimByToken(token);
        if(claims == null){
            throw new RRException(jwtUtils.getHeader() + "失效，请重新登录", HttpStatus.UNAUTHORIZED.value());
        }*/
        
        // user 存在说明还在有效期并且用户存在
        SysUser user = oauthService.queryByAppToken(token); 
        
		if(user == null  ) {
			throw new RRException("请先登录", HttpStatus.UNAUTHORIZED.value());
		}
		
		request.setAttribute("user", user);
        
        //判断权限perm
        if(aperm != null){
        	
        	String perm = aperm.perm();
        	 
        	
        	// 判断此处基于角色还是基于具体的权限码
        	if(perm != null && !perm.trim().isEmpty()) {
        		Set<String> perms = oauthService.queryPermsByUser(user.getUserId());
        		if(perms == null || !perms.contains(perm.trim())) {
            		throw new RRException("操作失败，您当前无此权限!", HttpStatus.UNAUTHORIZED.value());
            	}
        	}
        	 
        } 

        //设置userId到request里，后续根据userId，获取用户信息
        request.setAttribute(USER_KEY, user.getUserId());

        return true;
    }
}
