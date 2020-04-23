package com.xiaobo;

import com.xiaobo.common.xss.XssFilter;
import org.springframework.boot.web.servlet.FilterRegistrationBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import javax.servlet.DispatcherType;


/**
 * Filter配置
 *
 * @author zhangxiaobo
 * 
 * @date 2017-04-21 21:56
 */
@Configuration
public class FilterConfig {


    @Bean
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public FilterRegistrationBean xssFilterRegistration() {
        FilterRegistrationBean registration = new FilterRegistrationBean();
        registration.setDispatcherTypes(DispatcherType.REQUEST);
        registration.setFilter(new XssFilter());
        registration.addUrlPatterns("/*");
        registration.setName("xssFilter");
        registration.setOrder(Integer.MAX_VALUE);
        return registration;
    }
}
