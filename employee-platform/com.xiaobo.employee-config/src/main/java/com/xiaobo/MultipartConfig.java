package com.xiaobo;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.web.servlet.MultipartConfigFactory;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import javax.servlet.MultipartConfigElement;
import java.io.File;

@Configuration
public class MultipartConfig {
	 
	@Value("${xb.upload.temp}")
	private String tmpPath;
	
	/**
	 * 文件上传临时路径
	 */
	 @Bean
     MultipartConfigElement multipartConfigElement() {
	    MultipartConfigFactory factory = new MultipartConfigFactory();
	    if(tmpPath == null || tmpPath.trim().isEmpty() || !new File(tmpPath).exists()) {
	    	tmpPath = System.getProperty("java.io.tmpdir");
	    }
	    factory.setLocation(tmpPath);
	    factory.setMaxFileSize("10Mb");
	    factory.setMaxRequestSize("10Mb");
	    
	    return factory.createMultipartConfig();
	
	
	}
}
