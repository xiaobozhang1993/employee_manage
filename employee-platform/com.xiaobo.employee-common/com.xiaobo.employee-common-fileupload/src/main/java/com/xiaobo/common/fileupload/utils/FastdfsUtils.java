package com.xiaobo.common.fileupload.utils;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.Serializable;
import java.util.Date;

import org.apache.commons.io.IOUtils;
import org.csource.common.MyException;
import org.csource.common.NameValuePair;
import org.csource.fastdfs.ClientGlobal;
import org.csource.fastdfs.FileInfo;
import org.csource.fastdfs.StorageClient;
import org.csource.fastdfs.StorageServer;
import org.csource.fastdfs.TrackerClient;
import org.csource.fastdfs.TrackerServer;
import org.springframework.web.multipart.MultipartFile;

import com.xiaobo.common.fileupload.AltFileUtils;
import com.xiaobo.common.fileupload.entity.UploadFileInfoEntity;
import com.xiaobo.common.fileupload.entity.UploadFileInfoEntity.StoreType;
import com.xiaobo.common.utils.StringUtils;

/**
 * 
 * fastdfs 上传下载文件工具类， 其中包含 上传，下载，获取上传文件信息，获取文件名称，删除文件 得到Storage服务，获得可用的storage
 * IP 等功能
 * 
 * @author changhuan
 * @version 1.0
 * @date 2019/03/20
 *
 */ 
public class FastdfsUtils extends AltFileUtils implements Serializable {

 
	 private static final String group = "group1" ;
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
  
	private String trackerServer ;
	private String storageServer ;
	private String nginxUrl ;
	
	private static final int store_index = 0; // storage 的默认索引
	
	public FastdfsUtils(String trackerServer , String nginxUrl) {
		// TODO Auto-generated constructor stub
		this.trackerServer = trackerServer;
		this.nginxUrl = nginxUrl.endsWith("/") ? nginxUrl : nginxUrl + "/";
		try {
			ClientGlobal.initByTrackers(trackerServer);
		} catch (IOException | MyException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	
	public FastdfsUtils(String trackerServer , String storageServer, String nginxUrl) {
		// TODO Auto-generated constructor stub
		this.trackerServer = trackerServer;
		this.storageServer = storageServer;
		this.nginxUrl = nginxUrl.endsWith("/") ? nginxUrl : nginxUrl + "/";
		try {
			ClientGlobal.initByTrackers(trackerServer);
		} catch (IOException | MyException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	
	public String getTrackerServer() {
		return trackerServer;
	}

	/**
	 * 上传文件到FastDFS
	 * 
	 * @param byteFile
	 * @param ext_file
	 * @param file_Name
	 * @return string 地址值
	 * @author changhuan
	 * @throws MyException
	 * @throws IOException
	 * @date 2019/03/20
	 */
	public String[] uploadFile(InputStream inputStream, String fileSuffix) throws IOException, MyException {

		byte[] bs = IOUtils.toByteArray(inputStream);

		// 1、把FastDFS提供的jar包添加到工程中
		// String url =
		// FastdfsUtils.class.getClassLoader().getResource("fdfs_client.conf").getPath();

		// 2、初始化全局配置。加载一个配置文件。
		
		
		 
		
		// 3、创建一个TrackerClient对象。
		TrackerClient trackerClient = new TrackerClient();
		// 4、创建一个TrackerServer对象。
		TrackerServer trackerServer = trackerClient.getConnection();
		// 5、声明一个StorageServer对象，null。
		StorageServer storageServer = null ;
		
		// 判断配置的storageServer是否为空 不为空这里开始回填
		if(org.apache.commons.lang.StringUtils.isNotBlank(this.storageServer)) {
			String[] ss = this.storageServer.split(":");
			String ip = ss[0];
			int port = Integer.valueOf(ss[1]);
			
			storageServer = new StorageServer(ip, port, store_index);
		}
		
		// 6、获得StorageClient对象。
		StorageClient storageClient = new StorageClient(trackerServer, storageServer);
		// 7、直接调用StorageClient对象方法上传文件即可。
		String[] strings = storageClient.upload_file(bs, fileSuffix, null);
		// for (String string : strings) {
		// System.out.println(string);
		// }
		
		 
		
		return strings;
	}

	/**
	 * 上传文件到FastDFS
	 * 
	 * @param byteFile
	 * @param ext_file
	 * @param file_Name
	 * @return string 地址值
	 * @throws MyException
	 * @throws IOException
	 * @date 2019/03/20
	 */
	public FastdfsUploadResult fastUploadFile(InputStream inputStream, String fileSuffix)
			throws IOException, MyException {

		byte[] bs = IOUtils.toByteArray(inputStream);

		// 1、把FastDFS提供的jar包添加到工程中
		// String url =
		// FastdfsUtils.class.getClassLoader().getResource("fdfs_client.conf").getPath();

		// 2、初始化全局配置。加载一个配置文件。
		// 3、创建一个TrackerClient对象。
		TrackerClient trackerClient = new TrackerClient();
		// 4、创建一个TrackerServer对象。
		TrackerServer trackerServer = trackerClient.getConnection();
		// 5、声明一个StorageServer对象，null。
		
		
		
		StorageServer storageServer = null ;
		
		// 判断配置的storageServer是否为空 不为空这里开始回填
		if(this.storageServer != null) {
			String[] ss = this.storageServer.split(":");
			String ip = ss[0];
			int port = Integer.valueOf(ss[1]);
			
			storageServer = new StorageServer(ip, port, store_index);
		}
		
		// 6、获得StorageClient对象。
		StorageClient storageClient = new StorageClient(trackerServer, storageServer);
		// 7、直接调用StorageClient对象方法上传文件即可。
		String[] strings = storageClient.upload_file(bs, fileSuffix, null);

		FastdfsUploadResult result = new FastdfsUploadResult();
		
		if (strings == null || strings.length < 2) {
			result.setSuccess(false);
		} else {
			result.setSuccess(true);
		}
		
		result.setFileContent(bs);
		result.setFilePath(strings[1]);

		return result;
	}
	
	 

	/**
	 * 获得可用的storage IP
	 *
	 * @param trackerClient
	 * @param trackerServer
	 * @return 返回storage IP
	 */
	private String getStorageServerIp(TrackerClient trackerClient, TrackerServer trackerServer) {
		String storageIp = null;
		if (trackerClient != null && trackerServer != null) {
			try {
				StorageServer storageServer = trackerClient.getStoreStorage(trackerServer, group);
				storageIp = storageServer.getSocket().getInetAddress().getHostAddress();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		// log.debug("——获取组中可用的storage IP——" + storageIp);
		return storageIp;
	}

	/**
	 * 得到Storage服务
	 *
	 * @param storageIp
	 * @return 返回Storage服务
	 */
	private StorageServer getStorageServer(String storageIp) {
		StorageServer storageServer = null;
		if (storageIp != null && !("").equals(storageIp)) {
			try {
				// ip port store_path下标
				storageServer = new StorageServer(storageIp, 23000, 1);
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		// log.debug("——storage server生成");
		return storageServer;
	}

	/**
	 * FastDFS实现文件下载
	 *
	 * @param filePath
	 * @throws MyException
	 * @throws IOException
	 */
	public byte[] fastDFSDownload(String filePath) throws IOException, MyException {

		TrackerClient trackerClient = new TrackerClient();
		TrackerServer trackerServer = trackerClient.getConnection();
		StorageServer storageServer = null;
		 
		// 判断配置的storageServer是否为空 不为空这里开始回填
		if(this.storageServer != null) {
			String[] ss = this.storageServer.split(":");
			String ip = ss[0];
			int port = Integer.valueOf(ss[1]);
			
			storageServer = new StorageServer(ip, port, store_index);
		}
		
		
		StorageClient storageClient = new StorageClient(trackerServer, storageServer);
		// 根据文件标识下载文件
		byte[] b = storageClient.download_file(group, filePath);
	 
		if (b == null) {
			throw new IOException("文件" + filePath + "不存在");
		}

		// String fileName = filePath.substring(filePath.lastIndexOf("/") + 1);
		// FileOutputStream fileOutputStream = new FileOutputStream("c://" + fileName);
		// IOUtils.write(b, fileOutputStream);
		// fileOutputStream.close();
		return b;
	}

	/**
	 * FastDFS获取将上传文件信息
	 */
	public String fastDFSGetFileInfo(String filePath) {
		String fileInfo = null;
		try {
			// 链接FastDFS服务器，创建tracker和Stroage
			TrackerClient trackerClient = new TrackerClient();
			TrackerServer trackerServer = trackerClient.getConnection();
 
			StorageServer storageServer = null;
			 
			// 判断配置的storageServer是否为空 不为空这里开始回填
			if(this.storageServer != null) {
				String[] ss = this.storageServer.split(":");
				String ip = ss[0];
				int port = Integer.valueOf(ss[1]);
				
				storageServer = new StorageServer(ip, port, store_index);
			} else {
				String storageServerIp = getStorageServerIp(trackerClient, trackerServer);
				storageServer = getStorageServer(storageServerIp);
			}
			
			StorageClient storageClient = new StorageClient(trackerServer, storageServer);

			FileInfo fi = storageClient.get_file_info(group, filePath);
			if (fi == null) {
				throw new IOException("文件" + filePath + "不存在");
			}
			fileInfo = fi.toString();
			// log.debug("文件信息=" + fi.toString());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return fileInfo;
	}

	/**
	 * 获取文件名称
	 * 
	 * @param filePath
	 * @return 文件名称 filename
	 */
	public String fastDFSGetFileName(String filePath) {
		String fileName = null;
		try {
			// 链接FastDFS服务器，创建tracker和Stroage

			TrackerClient trackerClient = new TrackerClient();
			TrackerServer trackerServer = trackerClient.getConnection();

			 
			StorageServer storageServer =  null;
			
			 
			// 判断配置的storageServer是否为空 不为空这里开始回填
			if(this.storageServer != null) {
				String[] ss = this.storageServer.split(":");
				String ip = ss[0];
				int port = Integer.valueOf(ss[1]);
				
				storageServer = new StorageServer(ip, port, store_index);
			} else {
				String storageServerIp = getStorageServerIp(trackerClient, trackerServer);
				storageServer = getStorageServer(storageServerIp);
			}
			
			StorageClient storageClient = new StorageClient(trackerServer, storageServer);

			NameValuePair[] nvps = storageClient.get_metadata(group, filePath);
			if (nvps == null) {
				throw new IOException("文件" + filePath + "不存在");
			}
			fileName = nvps[0].getName() + "." + nvps[0].getValue();
			// log.debug(nvps[0].getName() + "." + nvps[0].getValue());

		} catch (Exception e) {
			e.printStackTrace();
		}
		return fileName;
	}

	/*
	 ** 
	 * FastDFS实现删除文件 当返回结果集为0删除成功，其他值为删除失败
	 */

	public int fastDFSDelete(String filePath) {
		int i = -1;
		try {
			// 链接FastDFS服务器，创建tracker和Stroage

			TrackerClient trackerClient = new TrackerClient();
			TrackerServer trackerServer = trackerClient.getConnection();
 
			StorageServer storageServer = null;
			
			 
			// 判断配置的storageServer是否为空 不为空这里开始回填
			if(this.storageServer != null) {
				String[] ss = this.storageServer.split(":");
				String ip = ss[0];
				int port = Integer.valueOf(ss[1]);
				
				storageServer = new StorageServer(ip, port, store_index);
			} else {
				String storageServerIp = getStorageServerIp(trackerClient, trackerServer);
				storageServer = getStorageServer(storageServerIp);
			}
			
			StorageClient storageClient = new StorageClient(trackerServer, storageServer);
			i = storageClient.delete_file(group , filePath);

			// log.debug(i == 0 ? "删除成功" : "删除失败:" + i);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return i;
	}

	@Override
	public UploadFileInfoEntity uploadFile(MultipartFile file) {
		// TODO Auto-generated method stub
	
		InputStream input;
		try {
			input = file.getInputStream();
			
			String name = file.getOriginalFilename();
			
			String suffix = StringUtils.getSuffixName(name);
			 
			String[] resource = uploadFile(input, suffix);
			UploadFileInfoEntity atbAtta = new UploadFileInfoEntity();
			//String path = result.getFilePath();
			 if(resource !=null) {
				/*atbAtta.setFilePath(resource[1]);
				atbAtta.setCreateDate(new Date());
				atbAtta.setFileName(resource[1].substring(resource[1].lastIndexOf("/")+1,resource[1].length()));
				atbAtta.setRealName(file.getOriginalFilename());//文件真实名字
				atbAtta.setStoreType(StoreType.fastDfs.ordinal());
				atbAtta.setUrl(nginxUrl + resource[0]+"/"+resource[1]);*/
				
				atbAtta.setCreatedAt(new Date());
				atbAtta.setFileUrl( nginxUrl +  resource[0]+"/"+resource[1]);
				//
				
				atbAtta.setOldFileName(name);
				atbAtta.setFileSuffix(suffix);
				atbAtta.setFileSize(file.getSize());
				atbAtta.setName( resource[1]);
				atbAtta.setStoreType(StoreType.fastDfs.ordinal());
				
				
			 }
			
			
			return atbAtta ;
			
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (MyException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
				
		return null;
	}

	@Override
	public void downFile(UploadFileInfoEntity entity, OutputStream out) {
		// TODO Auto-generated method stub
		
		String path = entity.getName();
		
		  byte[] bs;
		try {
			bs = fastDFSDownload(path);
			  out.write(bs);
			  out.flush();    //将存储在管道中的数据强制刷新出去
			  out.close();
		} catch (IOException | MyException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
	}

	@Override
	public boolean deleteFile(UploadFileInfoEntity entity) {
		
		int res =  fastDFSDelete(entity.getName());
		
		return res == 0;
	}

	@Override
	public byte[] readFile(String path) {
		
		try {
			return fastDFSDownload(path);
		} catch (IOException | MyException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
		 
	}

	@Override
	public UploadFileInfoEntity uploadFile(File file) {
		  
		InputStream input;
		try {
			input = new FileInputStream(file);
			
			String name = file.getName();
			
			String suffix = StringUtils.getSuffixName(name);
			 
			String[] resource = uploadFile(input, suffix);
			UploadFileInfoEntity atbAtta = new UploadFileInfoEntity();
			//String path = result.getFilePath();
			 if(resource !=null) {
				
				atbAtta.setCreatedAt(new Date());
				atbAtta.setFileUrl(nginxUrl + resource[0]+"/"+resource[1]);
				//
				
				atbAtta.setOldFileName(name);
				atbAtta.setFileSuffix(suffix);
				atbAtta.setFileSize(file.length());
				atbAtta.setName( resource[1]);
				atbAtta.setStoreType(StoreType.fastDfs.ordinal());
				
				
			 }
			
			
			return atbAtta ;
			
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (MyException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
				
		return null;
	}

	public static String getGroup() {
		return group;
	}
	
 
	
	

}

class FastdfsUploadResult{

	private boolean isSuccess;

	private String filePath;
	
	private byte[] fileContent;

	public boolean isSuccess() {
		return isSuccess;
	}

	public void setSuccess(boolean isSuccess) {
		this.isSuccess = isSuccess;
	}

	public String getFilePath() {
		return filePath;
	}

	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}

	public byte[] getFileContent() {
		return fileContent;
	}

	public void setFileContent(byte[] fileContent) {
		this.fileContent = fileContent;
	}
}
