package com.xiaobo.app;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.method.support.HandlerMethodArgumentResolver;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import com.xiaobo.app.interceptor.AuthorizationInterceptor;
import com.xiaobo.app.resolver.LoginUserHandlerMethodArgumentResolver;

/**
 * MVC配置
 *
 * @author zhangxiaobo
 * @email 1920969038@qq.com.com
 * @date 2017-04-20 22:30
 */
@Configuration
public class WebMvcConfig implements WebMvcConfigurer {
    @Autowired
    private AuthorizationInterceptor authorizationInterceptor;
    @Autowired
    private LoginUserHandlerMethodArgumentResolver loginUserHandlerMethodArgumentResolver;

    @Override
    public void addInterceptors(InterceptorRegistry registry) {
    	 
    	
        registry.addInterceptor(authorizationInterceptor).addPathPatterns("/**/app/**");
    }

    @Override
    public void addArgumentResolvers(List<HandlerMethodArgumentResolver> argumentResolvers) {
        argumentResolvers.add(loginUserHandlerMethodArgumentResolver);
    }
    
	 @Override
	    public void addCorsMappings(CorsRegistry registry) { 
	        registry.addMapping("/**")
	                .allowedMethods("*")
	                .allowedOrigins("*")
	                .allowedHeaders("*").allowCredentials(true).maxAge(30 * 1000);
	        WebMvcConfigurer.super.addCorsMappings(registry);

	    }
}