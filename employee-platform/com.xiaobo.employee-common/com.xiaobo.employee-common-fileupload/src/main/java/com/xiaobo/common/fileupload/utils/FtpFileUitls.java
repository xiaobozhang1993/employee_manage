package com.xiaobo.common.fileupload.utils;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.Serializable;
import java.net.SocketException;
import java.util.Date;

import org.apache.commons.net.ftp.FTPClient;
import org.apache.commons.net.ftp.FTPReply;
import org.slf4j.LoggerFactory;
import org.springframework.web.multipart.MultipartFile;

import com.xiaobo.common.fileupload.AltFileUtils;
import com.xiaobo.common.fileupload.entity.UploadFileInfoEntity;
import com.xiaobo.common.fileupload.entity.UploadFileInfoEntity.StoreType;
import com.xiaobo.common.utils.DateUtils;
import com.xiaobo.common.utils.StringUtils;

 
public class FtpFileUitls extends AltFileUtils implements Serializable {

	org.slf4j.Logger logger = LoggerFactory.getLogger(getClass());
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private String host;
	private Integer port;
	private String username;
	private String password;
	
	/**
	 * 上传的基础目录  然后按照每个月一个大目录
	 */
	private String baseDir ;
	
	
	
	
	 public String getHost() {
		return host;
	}

	 


	public FtpFileUitls(String host, Integer port, String username, String password, String baseDir) {
		super();
		this.host = host;
		this.port = port;
		this.username = username;
		this.password = password;
		this.baseDir = baseDir.endsWith("/") || baseDir.endsWith("\\") ? baseDir : baseDir +  "/";
	}
	
	
	public boolean equals(String host, Integer port, String username, String password, String baseDir) {
		
		String dir = baseDir.endsWith("/") || baseDir.endsWith("\\") ? baseDir : baseDir +  "/";
		
		if(this.host.equals(host)
				&& this.port.equals(port)
				&& this.username.equals(username)
				&& this.password.equals(password)
				&& this.baseDir.equals(dir)) {
			return true ;
		}
		return false;
	}
	

	//连接ftp服务器
	public FTPClient initFtpClient() {
		FTPClient ftpClient = new FTPClient();
		try {
			
			 // 连接FTP服务器
            ftpClient.connect(host,  port );
            //获取服务器返回码
            int reply = ftpClient.getReplyCode();
            //验证服务器是否连接成功
            if (!FTPReply.isPositiveCompletion(reply)) {
                ftpClient.disconnect();
                return null;
            }
			
			ftpClient.setControlEncoding("utf-8");
			/*boolean login =*/ ftpClient.login(username, password); //登录ftp服务器
			
			
			
		} catch (NumberFormatException e) {
			e.printStackTrace();
		} catch (SocketException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return ftpClient;
	}
	
	
	/**
     * 上传文件
     * @param pathname ftp服务保存地址
     * @param fileName 上传到ftp的文件名
     * @param inputStream 输入文件流 
     * @return
     */
    public boolean uploadFile(String fileDir , String fileName,InputStream inputStream){
        boolean flag = false;
        FTPClient ftpClient = initFtpClient();
        try{
            ftpClient.setFileType(FTPClient.BINARY_FILE_TYPE);
            
            
            createDirecroty(ftpClient , fileDir);
            //ftpClient.makeDirectory(fileDir);
            ftpClient.changeWorkingDirectory(fileDir);
            ftpClient.storeFile(fileName, inputStream);
            inputStream.close();
            ftpClient.logout();
            flag = true;
        }catch (Exception e) {
            e.printStackTrace();
        }finally{
            if(ftpClient.isConnected()){ 
                try{
                    ftpClient.disconnect();
                }catch(IOException e){
                    e.printStackTrace();
                }
            } 
            if(null != inputStream){
                try {
                    inputStream.close();
                } catch (IOException e) {
                    e.printStackTrace();
                } 
            } 
        }
        return flag;
    }
	
  //创建多层目录文件，如果有ftp服务器已存在该文件，则不创建，如果无，则创建
    public boolean createDirecroty(FTPClient client , String remote) throws IOException {
        boolean success = true;
         
        String dir = remote.replace(baseDir, "");
        if(dir.startsWith("/")) {
        	dir = dir.substring(1);
        }
        
        String[] ss = dir.split("/");
        
        client.changeWorkingDirectory(baseDir);
        
        for(String s : ss) {
        	boolean change = client.changeWorkingDirectory(s);
        	if(!change) {
        		boolean makeDir = client.makeDirectory(s);
        		logger.info("make dir " + s + " ,result : " + makeDir);
        	}
        	success |= change ;
        }
       /* 
        String directory = remote + "/";
        // 如果远程目录不存在，则递归创建远程服务器目录
        if (!directory.equalsIgnoreCase("/") && !changeWorkingDirectory(new String(directory))) {
            int start = 0;
            int end = 0;
            if (directory.startsWith("/")) {
                start = 1;
            } else {
                start = 0;
            }
            end = directory.indexOf("/", start);
            String path = "";
            String paths = "";
            while (true) {
                String subDirectory = new String(remote.substring(start, end).getBytes("UTF-8"), "iso-8859-1");
                path = path + "/" + subDirectory;
                if (!existFile(path)) {
                    if (makeDirectory(subDirectory)) {
                        changeWorkingDirectory(subDirectory);
                    } else {
                        System.out.println("创建目录[" + subDirectory + "]失败");
                        changeWorkingDirectory(subDirectory);
                    }
                } else {
                    changeWorkingDirectory(subDirectory);
                }

                paths = paths + "/" + subDirectory;
                start = end + 1;
                end = directory.indexOf("/", start);
                // 检查所有目录是否创建完毕
                if (end <= start) {
                    break;
                }
            }
        }*/
        return success;
    }
     
    
    
    /** * 下载文件 * 
     * @param pathname FTP服务器文件目录 * 
     * @param filename 文件名称 * 
     * @return */
     public  byte[] readFile(String filePath){ 
        
         OutputStream os=null;
         FTPClient ftpClient = initFtpClient();
         
         String path =  filePath;
         
         try { 
             //切换FTP目录 
             //ftpClient.changeWorkingDirectory(baseDir); 
             InputStream inputstream = ftpClient.retrieveFileStream(path);
             ByteArrayOutputStream baos = new ByteArrayOutputStream();
             byte[] buffer = new byte[1024];
             int num = -1 ;
             while ((num = inputstream.read(buffer)) != -1 ) {
                 baos.write(buffer, 0, num); 
             }
             baos.flush();
             byte[] by = baos.toByteArray();
             ftpClient.logout(); 
             
             return by ;
         } catch (Exception e) { 
             e.printStackTrace(); 
         } finally{ 
             if(ftpClient.isConnected()){ 
                 try{
                     ftpClient.disconnect();
                 }catch(IOException e){
                     e.printStackTrace();
                 }
             } 
             if(null != os){
                 try {
                     os.close();
                 } catch (IOException e) {
                     e.printStackTrace();
                 } 
             } 
         } 
         return null; 
     }
     
     /** * 删除文件 * 
     * @param pathname FTP服务器保存目录 * 
     * @param filename 要删除的文件名��� * 
     * @return */ 
     public boolean deleteFile( String filePath){ 
         boolean flag = false; 
         FTPClient ftpClient = initFtpClient();
         try { 
             //切换FTP目录 
           
             
             ftpClient.deleteFile(filePath);
             
             ftpClient.logout();
             flag = true; 
         } catch (Exception e) { 
             e.printStackTrace(); 
         } finally {
             if(ftpClient.isConnected()){ 
                 try{
                     ftpClient.disconnect();
                 }catch(IOException e){
                     e.printStackTrace();
                 }
             } 
         }
         return flag; 
     }

	@Override
	public UploadFileInfoEntity uploadFile(MultipartFile file) {
		
		String filename = file.getOriginalFilename();
		 String month = DateUtils.format(new Date(), "yyyyMM");
         
		String fileDir =baseDir + month ;
        
		String suffix = StringUtils.getSuffixName(filename);
		
		// 文件名随机
		String currName = DateUtils.format(new Date(), "yyyyMMddHHmmssSSS") + ((int)(Math.random() * 100000) ) + "." + suffix ;
		
		try {
			InputStream input = file.getInputStream();
			
			boolean upload = uploadFile(fileDir , currName, input);
			
			if(upload ) {
				UploadFileInfoEntity entity = new UploadFileInfoEntity();
			
				
			/*	entity.setCreateDate(new Date());
				entity.setFileName(currName);
				entity.setFilePath(fileDir + "/" + currName);
				entity.setStoreType(StoreType.ftp.ordinal());*/
				 
			
				entity.setCreatedAt(new Date());
				entity.setOldFileName(filename);
				entity.setFileSuffix(suffix);
				entity.setFileSize(file.getSize());
				entity.setFileUrl(fileDir + "/" + currName);
				entity.setName(currName); 
				entity.setStoreType(StoreType.ftp.ordinal());
				
				return entity;
			}
			
			
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		
		return null;
	}

	@Override
	public void downFile(UploadFileInfoEntity entity, OutputStream out) {
		// TODO Auto-generated method stub
		
		// ftp 获取流
		byte[] bs = readFile(entity.getFileUrl());
		
		try {
			out.write(bs);
			out.flush();    //将存储在管道中的数据强制刷新出去
			out.close();
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
		
		String filename = file.getName();
		 String month = DateUtils.format(new Date(), "yyyyMM");
        
		String fileDir =baseDir + month ;
       
		String suffix = StringUtils.getSuffixName(filename);
		
		// 文件名随机
		String currName = DateUtils.format(new Date(), "yyyyMMddHHmmssSSS") + ((int)(Math.random() * 100000) ) + "." + suffix ;
		
		try {
			InputStream input = new FileInputStream(file);
			
			boolean upload = uploadFile(fileDir , currName, input);
			
			if(upload ) {
				UploadFileInfoEntity entity = new UploadFileInfoEntity();
			
	
				entity.setCreatedAt(new Date());
				entity.setOldFileName(filename);
				entity.setFileSuffix(suffix);
				entity.setFileSize(file.length());
				entity.setFileUrl(fileDir + "/" + currName);
				entity.setName(currName); 
				entity.setStoreType(StoreType.ftp.ordinal());
				
				return entity;
			}
			
			
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		
		return null;
	}




	 
     
    
    

}
