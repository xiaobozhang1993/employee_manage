package com.xiaobo;

import com.fasterxml.jackson.databind.DeserializationFeature;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.MediaType;
import org.springframework.http.converter.HttpMessageConverter;
import org.springframework.http.converter.json.MappingJackson2HttpMessageConverter;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

/**
 * WebMvc配置
 *
 * @author zhangxiaobo
 */
@Configuration
public class WebConfig implements WebMvcConfigurer {
	  

	@Override
	public void configureMessageConverters(List<HttpMessageConverter<?>> converters) {
		 
		List<MediaType> list = new ArrayList<MediaType>();
    	list.add(MediaType.APPLICATION_JSON_UTF8);
		 
    	
    	//yyyy-MM-dd
    	MappingJackson2HttpMessageConverter dateFormat2 = new MappingJackson2HttpMessageConverter();
    	//设置日期格式
    	ObjectMapper objectMapper2 = new ObjectMapper();
    	SimpleDateFormat smt2 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    	objectMapper2.setDateFormat(smt2);
    	dateFormat2.setObjectMapper(objectMapper2);
    	objectMapper2.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES,false);
    	//设置中文编码格式
     
    	dateFormat2.setSupportedMediaTypes(list);
    	converters.add(dateFormat2);
    	
		 
	}
	 @Override
	    public void addCorsMappings(CorsRegistry registry) {
	        registry.addMapping("/**") 
	                .allowedMethods("*")
	                .allowedOrigins("*")
	                .allowedHeaders("*").allowCredentials(true).maxAge(30 * 1000);
	       // WebMvcConfigurer.super.addCorsMappings(registry);
 
	    }
 
	 @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
		 registry.addResourceHandler("/static/**").addResourceLocations("classpath:/static/");

		 registry.addResourceHandler("/swagger/**").addResourceLocations("classpath:/static/swagger/");

		 registry.addResourceHandler("/**").addResourceLocations("classpath:/static/");
		 // 解决swagger无法访问
		 registry.addResourceHandler("/swagger-ui.html") .addResourceLocations("classpath:/META-INF/resources/");
		 // 解决swagger的js文件无法访问
		 registry.addResourceHandler("/webjars/**").addResourceLocations("classpath:/META-INF/resources/webjars/");
   
		 
    } 
	 
	 
}
