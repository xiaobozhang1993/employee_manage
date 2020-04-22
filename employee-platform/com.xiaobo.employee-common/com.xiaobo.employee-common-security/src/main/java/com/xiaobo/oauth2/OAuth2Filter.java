package com.xiaobo.oauth2;

import java.io.IOException;

import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils; 
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.web.filter.authc.AuthenticatingFilter;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.RequestMethod;

import com.alibaba.fastjson.JSON;
import com.xiaobo.common.utils.HttpContextUtils;
import com.xiaobo.common.utils.R;

/**
 * oauth2过滤器
 *
 * @author zhangxiaobo
 * 
 * @date 2017-05-20 13:00
 */
public class OAuth2Filter extends AuthenticatingFilter {

    @Override
    protected AuthenticationToken createToken(ServletRequest request, ServletResponse response) throws Exception {
        //获取请求token
    	HttpServletRequest hsr = (HttpServletRequest) request;
    	
    	
    	
        String token = HttpContextUtils.getRequestToken(hsr);

        if(StringUtils.isBlank(token)){
            return null;
        }

        return new OAuth2Token(token);
    }

    @Override
    protected boolean isAccessAllowed(ServletRequest request, ServletResponse response, Object mappedValue) {
         if(((HttpServletRequest) request).getMethod().equals(RequestMethod.OPTIONS.name())){
            return true;
        }

        return false;  
    }
    
    

    @Override
    protected boolean onAccessDenied(ServletRequest request, ServletResponse response) throws Exception {
    	//判断请求是否有鉴权要求,如果没有的话直接让过去即可 2018-08-20
    	request.setCharacterEncoding("UTF-8");
    	response.setContentType("application/json");
        //解决一下跨域问题
    	if(response instanceof HttpServletResponse ) {
    		HttpServletResponse servletResponse = (HttpServletResponse) response;
    		String origin = ((HttpServletRequest) request).getHeader("Origin");
    		
    		if(origin == null) {
    			origin = "*";
    		}
    		
    		servletResponse.setHeader("Access-Control-Allow-Origin", origin);
    		servletResponse.setHeader("Access-Control-Allow-Methods", "*");
    		servletResponse.setHeader("Access-Control-Max-Age", "300");
    		servletResponse.setHeader("Access-Control-Allow-Headers", "Origin, No-Cache, X-Requested-With, If-Modified-Since, Pragma, Last-Modified, Cache-Control, Expires, Content-Type, X-E4M-With,userId,token");
    		servletResponse.setHeader("Access-Control-Allow-Credentials", "true");
    		servletResponse.setHeader("XDomainRequestAllowed","1");
    		
    	}
    	
 
    	
    	//获取请求token，如果token不存在，直接返回401
        String token = HttpContextUtils.getRequestToken((HttpServletRequest) request);
        if(StringUtils.isBlank(token)){
            HttpServletResponse httpResponse = (HttpServletResponse) response;
           /* if(!httpResponse.containsHeader("Access-Control-Allow-Credentials"))
            	httpResponse.setHeader("Access-Control-Allow-Credentials", "true");
            if(!httpResponse.containsHeader("Access-Control-Allow-Origin"))
            	httpResponse.setHeader("Access-Control-Allow-Origin", HttpContextUtils.getOrigin());
*/
            String json =  JSON.toJSONString(R.error(HttpStatus.UNAUTHORIZED.value(), "invalid token"));

            httpResponse.getWriter().print(json);

            return false;
        }

        return executeLogin(request, response);
    }

    @Override
    protected boolean onLoginFailure(AuthenticationToken token, AuthenticationException e, ServletRequest request, ServletResponse response) {
       
        
        //解决一下跨域问题
    	if(response instanceof HttpServletResponse ) {
    		
    		String origin = ((HttpServletRequest) request).getHeader("Origin");
    		
    		if(origin == null) {
    			origin = "*";
    		}
    		
    		HttpServletResponse servletResponse = (HttpServletResponse) response;
    		servletResponse.setContentType("application/json;charset=utf-8");
    		servletResponse.setHeader("Access-Control-Allow-Origin", origin);
    		servletResponse.setHeader("Access-Control-Allow-Methods", "*");
    		servletResponse.setHeader("Access-Control-Max-Age", "300");
    		servletResponse.setHeader("Access-Control-Allow-Headers", "Origin, No-Cache, X-Requested-With, If-Modified-Since, Pragma, Last-Modified, Cache-Control, Expires, Content-Type, X-E4M-With,userId,token");
    		servletResponse.setHeader("Access-Control-Allow-Credentials", "true");
    		servletResponse.setHeader("XDomainRequestAllowed","1");
    		
    	}
        
      
        
        try {
            //处理登录失败的异常
            Throwable throwable = e.getCause() == null ? e : e.getCause();
            R r = R.error(HttpStatus.UNAUTHORIZED.value(), throwable.getMessage());

            String json = JSON.toJSONString(r);
            response.getWriter().print(json);
        } catch (IOException e1) {

        }

        return false;
    }

   


}
