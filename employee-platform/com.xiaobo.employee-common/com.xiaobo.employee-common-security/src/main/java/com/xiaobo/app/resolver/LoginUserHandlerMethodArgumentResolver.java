package com.xiaobo.app.resolver;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.MethodParameter;
import org.springframework.stereotype.Component;
import org.springframework.web.bind.support.WebDataBinderFactory;
import org.springframework.web.context.request.NativeWebRequest;
import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.method.support.HandlerMethodArgumentResolver;
import org.springframework.web.method.support.ModelAndViewContainer;

import com.xiaobo.common.app.annotation.LoginUser;
import com.xiaobo.common.entity.SysUser;
import com.xiaobo.common.utils.JwtUtils;
import com.xiaobo.oauth2.service.OauthService;

/**
 * 有@LoginUser注解的方法参数，注入当前登录用户
 * @author zhangxiaobo
 * @email 1920969038@qq.com.com
 * @date 2017-03-23 22:02
 */
@Component
public class LoginUserHandlerMethodArgumentResolver implements HandlerMethodArgumentResolver {
    @Autowired
    private OauthService oauthService;
    
    @Autowired
    private JwtUtils jwtUtils;
 
     

    @Override
    public boolean supportsParameter(MethodParameter parameter) {
        return parameter.getParameterType().isAssignableFrom(SysUser.class)  && parameter.hasParameterAnnotation(LoginUser.class) ;
    }

    @Override
    public Object resolveArgument(MethodParameter parameter, ModelAndViewContainer container,
                                  NativeWebRequest request, WebDataBinderFactory factory) throws Exception {
       
    	
    	
    	SysUser user = null;
    	
    	// 判断request里是否已经由了user
    	Object user_ = request.getAttribute("user", RequestAttributes.SCOPE_REQUEST);
    	if(user_ != null && user_ instanceof SysUser) {
    		user = (SysUser) user_ ;
    	}
    	if(user == null) {
    		  
    		// 再次判断请求的request里是否包含token 尝试通过token获取user

    		String token = request.getHeader(jwtUtils.getHeader());
    		if(StringUtils.isBlank(token)){
    			token = request.getParameter(jwtUtils.getHeader());
    		}

    		if(!StringUtils.isBlank(token)) {

    			// user 存在说明还在有效期并且用户存在
    			user = oauthService.queryByAppToken(token);  

    		}
            	 
           
    	}
    	 
       /*  
        if(user == null  ) {
        	return null;
			//throw new RRException("请先登录", HttpStatus.UNAUTHORIZED.value());
		}
        
       */
        
        return user;
     
    }
}
