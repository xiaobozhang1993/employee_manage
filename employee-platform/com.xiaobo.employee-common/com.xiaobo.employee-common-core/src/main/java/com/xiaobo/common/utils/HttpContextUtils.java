package com.xiaobo.common.utils;

import org.apache.commons.lang.StringUtils;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;

public class HttpContextUtils {

	public static HttpServletRequest getHttpServletRequest() {
		return ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
	}

	public static String getDomain(){
		HttpServletRequest request = getHttpServletRequest();
		StringBuffer url = request.getRequestURL();
		return url.delete(url.length() - request.getRequestURI().length(), url.length()).toString();
	}

	public static String getOrigin(){
		HttpServletRequest request = getHttpServletRequest();
		return request.getHeader("Origin");
	}
	
	  /**
     * 获取请求的token
     */
    public static String getRequestToken(HttpServletRequest httpRequest){
        //从header中获取token
        String token = httpRequest.getHeader("token");
        
        //尝试session
 //       HttpSession session = httpRequest.getSession();
 //       Enumeration<String> names = session.getAttributeNames();
        
//        System.out.println("names : " + names);
//        System.out.println("sessionid : " + session.getId());
      
      

        //如果header中不存在token，则从参数中获取token
        if(StringUtils.isBlank(token)){
            token = httpRequest.getParameter("token");
        }
        
        if(token == null || token.equals("") || token.equals("null")) {
        	Cookie[] cs = httpRequest.getCookies();
        	if(cs != null)
            for(Cookie c : cs) {
            	if(c.getName() != null && c.getName().equals("token")) {
            		token = c.getValue();
            	} else if(c.getPath() != null && c.getPath().equals("token")) {
            		token = c.getValue();
            	}
            }
            
      }

        return token;
    }
}
