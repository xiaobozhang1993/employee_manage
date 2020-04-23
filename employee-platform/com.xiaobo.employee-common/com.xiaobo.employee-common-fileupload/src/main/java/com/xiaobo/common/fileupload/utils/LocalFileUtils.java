package com.xiaobo.common.fileupload.utils;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.Serializable;
import java.util.Date;

import org.apache.commons.io.IOUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.multipart.MultipartFile;

import com.google.common.io.Files;
import com.xiaobo.common.fileupload.AltFileUtils;
import com.xiaobo.common.fileupload.entity.UploadFileInfoEntity;
import com.xiaobo.common.fileupload.entity.UploadFileInfoEntity.StoreType;
import com.xiaobo.common.utils.DateUtils;
import com.xiaobo.common.utils.StringUtils;

/**
 * 
 * 
 * 
 * @author Administrator
 * @version 1.0
 *
 */ 
public class LocalFileUtils extends AltFileUtils implements Serializable {

	Logger logger = LoggerFactory.getLogger(getClass());
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private String path ;
	
	 
	
	public String getPath() {
		return path;
	}
	
	
	
	
	public LocalFileUtils(String path) {
		super();
		this.path = path.endsWith("/") || path.endsWith("\\") ? path : path + "/";
	}

	 
	
	/**
	       文件下载
	 * @param filePath
	 * @return
	 * @throws IOException 
	 */
	
	public byte[] readFile(String filePath)   {
		InputStream inStream;
		try {
			inStream = new FileInputStream(filePath);
			ByteArrayOutputStream swapStream = new ByteArrayOutputStream();  
	        byte[] buff = new byte[100];  
	        int rc = 0;  
	        while ((rc = inStream.read(buff, 0, 100)) > 0) {  
	            swapStream.write(buff, 0, rc);  
	        }  
	        byte[] in2b = swapStream.toByteArray();  
	        inStream.close();
	        swapStream.close();
	        return in2b;  
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	
        return null;  
	}
	
	
	
	/**
	 * 删除文件
	 * @param filePath
	 * @return
	 */
	public boolean deleteFile(String filePath) {
		File file = new File(filePath);
		if(file.exists()) {
			boolean flag  = file.delete();
			return flag;
		}
		
		return false;
	}


	@Override
	public UploadFileInfoEntity uploadFile(MultipartFile file) {
		
		 String month = DateUtils.format(new Date(), "yyyyMM");
	        
		
		File dirFile = new File(path , month);
		if(!dirFile.exists()) {
			boolean mkdirs = dirFile.mkdirs();
			logger.info("mkdirs " + dirFile.getPath() + " , result : " + mkdirs);
		}
		
		String filename = file.getOriginalFilename();
		
		String suffix = StringUtils.getSuffixName(filename);
		
		// 文件名随机
		String currName = DateUtils.format(new Date(), "yyyyMMddHHmmssSSS") + ((int)(Math.random() * 100000) ) + "." + suffix ;
	
		
		File localFile = new File(dirFile , currName);
		
		try {
			file.transferTo(localFile);
			
			UploadFileInfoEntity entity = new UploadFileInfoEntity();
			/*entity.setCreateDate(new Date());
			entity.setFileName(currName);
			entity.setFilePath(localFile.getPath());
			entity.setStoreType(StoreType.lcoal.ordinal());
			entity.setRealName(filename);
			*/
			entity.setCreatedAt(new Date());
			entity.setOldFileName(filename);
			entity.setName(currName);
			entity.setFileUrl(localFile.getPath());
			entity.setFileSize(file.getSize());
			entity.setStoreType(StoreType.lcoal.ordinal());
		 
			return entity;
			
		} catch (IllegalStateException | IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		
		return null;
	}


	@Override
	public void downFile(UploadFileInfoEntity entity, OutputStream out) {
		
		String path = entity.getFileUrl();
		
		try {
			IOUtils.copy(new FileInputStream(path), out, 5 * 1024);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}


	@Override
	public boolean deleteFile(UploadFileInfoEntity entity) {
		
		
		return deleteFile(entity.getFileUrl());
	}




	@Override
	public UploadFileInfoEntity uploadFile(File file) {
		 String month = DateUtils.format(new Date(), "yyyyMM");
	        
			
			File dirFile = new File(path , month);
			if(!dirFile.exists()) {
				boolean mkdirs = dirFile.mkdirs();
				logger.info("mkdirs " + dirFile.getPath() + " , result : " + mkdirs);
			}
			
			String filename = file.getName();
			
			String suffix = StringUtils.getSuffixName(filename);
			
			// 文件名随机
			String currName = DateUtils.format(new Date(), "yyyyMMddHHmmssSSS") + ((int)(Math.random() * 100000) ) + "." + suffix ;
		
			
			File localFile = new File(dirFile , currName);
			
			try {
				
				Files.copy(file, localFile);
				
				UploadFileInfoEntity entity = new UploadFileInfoEntity();

				entity.setCreatedAt(new Date());
				entity.setOldFileName(filename);
				entity.setName(currName);
				entity.setFileUrl(localFile.getPath());
				entity.setFileSize(file.length());
				entity.setStoreType(StoreType.lcoal.ordinal());
			 
				return entity;
				
			} catch (IllegalStateException | IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			
			
			return null;
	}
	
	
	

}
