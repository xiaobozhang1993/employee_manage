package com.xiaobo.common.fileupload.vo;
 

 
public class FastdfsUploadResult implements java.io.Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = -8616555289515702973L;

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
