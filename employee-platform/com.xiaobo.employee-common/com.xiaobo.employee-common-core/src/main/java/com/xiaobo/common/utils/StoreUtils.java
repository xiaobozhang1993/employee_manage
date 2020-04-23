package com.xiaobo.common.utils;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import java.io.File;

@Component
public class StoreUtils {

	Logger logger = LoggerFactory.getLogger(getClass());
	
	@Value("${xb.upload.temp}")
	private String storePath;
	
	/**
	 * 返回用户数据目录
	 * @param userId 用户ID
	 * @return
	 */
	public File getUserPath(String userId) {
		
		File f = new File(storePath , userId);
		if(!f.exists()) {
			boolean mkdir = f.mkdirs();
		
			logger.info("mkdir user path : " + f.getPath() + " , result : " + mkdir);
		}
		
		return f ;
		
	}
	
	/**
	 * 返回用户工参存储目录
	 * @param userId 用户ID
	 * @return
	 */
	public File getUserCellPath(String userId) {
		File userStorePath = getUserPath(userId);
		
		File f = new File(userStorePath , "cell");
		if(!f.exists()) {
			boolean mkdir = f.mkdirs();
		
			logger.info("mkdir user cell path : " + f.getPath() + " , result : " + mkdir);
		}
		
		return f ;
	}
	
	/**
	 * 返回用户路测日志存储目录
	 * @param userId 用户ID
	 * @return
	 */
	public File getUserLogPath(String userId) {
		File userStorePath = getUserPath(userId);
		
		File f = new File(userStorePath , "log");
		if(!f.exists()) {
			boolean mkdir = f.mkdirs();
		
			logger.info("mkdir user cell path : " + f.getPath() + " , result : " + mkdir);
		}
		
		return f ;
	}
	
}
