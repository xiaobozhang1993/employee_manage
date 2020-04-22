package com.xiaobo.common.fileupload;

import com.xiaobo.common.exception.RRException;
import com.xiaobo.common.fileupload.entity.UploadFileInfoEntity;
import com.xiaobo.common.fileupload.utils.FastdfsUtils;
import com.xiaobo.common.fileupload.utils.FtpFileUitls;
import com.xiaobo.common.fileupload.utils.LocalFileUtils;
import com.xiaobo.common.utils.SpringContextUtils;
import org.springframework.core.env.Environment;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.OutputStream;

/**
 * 文件公共上传下载服务
 * @author zhangxiaobo
 *
 */
public abstract class AltFileUtils {
	
	/**
	 * 上传文件 
	 * @param file
	 * @return
	 */
	public abstract UploadFileInfoEntity uploadFile(MultipartFile file) ;
	
	
	/**
	 * 上传本地文件
	 * @param file
	 * @return
	 */
	public abstract UploadFileInfoEntity uploadFile(File file);
	
	/**
	 * 下载文件 默认当fastdfs 和ftp 的时候应该通过nginx代理过去直接下载 而不是通过此犯法,但此方法依然要实现下载的业务
	 * @param entity 实体
	 * @param out 输出流 
	 */
	public abstract void downFile(UploadFileInfoEntity entity , OutputStream out);
	
	/**
	 * 删除文件 
	 * @param entity
	 * @return
	 */
	public abstract boolean deleteFile(UploadFileInfoEntity entity);
	
	private static AltFileUtils uploadFile ;
	
	/**
	 * 读取文件流
	 * @param path
	 * @return
	 */
	public abstract byte[] readFile(String path);
	
	/**
	 * 根据配置获取当前的上传附件配置信息 获取对应的上传util类
	 * @return
	 */
	public static AltFileUtils getFileUtil() {
		
		if(uploadFile != null) {
			return uploadFile ;
		}
		
		// 取出配置 判断当前基于哪一个上传
		
		// 获取配置信息
		
		Environment env = SpringContextUtils.getBean(Environment.class);
		 
		String type = env.getProperty("tr.upload.type").trim();
		
		// 判断类型  0- 本地  1- ftp  2- fastdfs
		if(type != null && (type.equals("local") || type.equals("0") )) {
			// local
			String localPath = env.getProperty("tr.upload.local.upload_local_path");
			 
			uploadFile = new LocalFileUtils(localPath);
			 
			
		}  else if(type != null && (type.equals("ftp") || type.equals("1")) ) {
		 
			// 回填参数
 

			String host =  env.getProperty("tr.upload.ftp.host");
			Integer port =  env.getProperty("tr.upload.ftp.hport" ,Integer.class);
			String username =  env.getProperty("tr.upload.ftp.husername");
			String pass =  env.getProperty("tr.upload.ftp.hpassword");

			String baseDir =  env.getProperty("tr.upload.ftp.hbase");


			uploadFile = new FtpFileUitls(host , port , username , pass , baseDir);

			
		}  else if(type != null && (type.equals("fastdfs") || type.equals("2"))) {
		 	
			// fastdfs的配置 政务外网

			//System.out.println("-----------fastdfsConfig------:"+fastdfsConfig);

			String tracker_server = env.getProperty("tr.upload.fastDfs.tracker_server");
			String storage_server = env.getProperty("tr.upload.fastDfs.storage_server");
			String nginxUrl = env.getProperty("tr.upload.fastDfs.nginx_url");
			//System.out.println("---------server info:" + tracker_server+","+ storage_server + ","+ nginxUrl);
			//Integer secret_key = jo.getInteger("secret_key");

			uploadFile = new FastdfsUtils(tracker_server ,storage_server, nginxUrl);
				
		 
			
		}
		
		if(uploadFile == null) {
			throw new RRException("上传请求错误,请稍后再试");
		}
		
	 
		
		return uploadFile ;
	}
	

}
