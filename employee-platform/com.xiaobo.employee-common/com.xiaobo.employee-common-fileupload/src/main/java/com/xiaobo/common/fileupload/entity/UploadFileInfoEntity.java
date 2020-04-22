package com.xiaobo.common.fileupload.entity;

import java.io.Serializable;
import java.util.Date;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.core.enums.IEnum;

/**
 * 文件信息表
 * @author CaoRui
 * @email caorui@com.xiaobo.employee-software.com
 * @date 2019-04-10 18:20:48
 */ 
public class UploadFileInfoEntity implements Serializable {
	private static final long serialVersionUID = 1L;
	
	/**
	 * 存储方式
	 * @author zhangxiaobo
	 *
	 */
	public enum StoreType implements IEnum<Integer>{
		lcoal, // 本地
		ftp, //ftp
		fastDfs ,;

		@Override
		public Integer getValue() {
			// TODO Auto-generated method stub
			return this.ordinal();
		} // fastdfs
		
		 
	}

	/**
	 * 主键id
	 */
	@TableId(type = IdType.UUID)
	private String fileId;
	

	/**
	 * 原始（自定义）文件名称
	 */
	private String oldFileName;
	/**
	 * 文件类型，即后缀
	 */
	private String fileSuffix;
	/**
	 * 文件保存父路径
	 */
	private String parentPath;
	/**
	 * 文件路径
	 */
	private String fileUrl;
	/**
	 * 文件大小（byte），预留
	 */
	private long fileSize;

	/**
	 * 创建时间
	 */
	private Date createdAt;
	
	/**
	 *文件名 
	 */
	private String name;
	
	/**
	 *事项文件表Id 
	 */
	private String materialId;

	public String getFileId() {
		return fileId;
	}

	public void setFileId(String fileId) {
		this.fileId = fileId;
	}

	public String getOldFileName() {
		return oldFileName;
	}

	public void setOldFileName(String oldFileName) {
		this.oldFileName = oldFileName;
	}

	public String getFileSuffix() {
		return fileSuffix;
	}

	public void setFileSuffix(String fileSuffix) {
		this.fileSuffix = fileSuffix;
	}

	public String getFileUrl() {
		return fileUrl;
	}

	public void setFileUrl(String fileUrl) {
		this.fileUrl = fileUrl;
	}

	public long getFileSize() {
		return fileSize;
	}

	public void setFileSize(long fileSize) {
		this.fileSize = fileSize;
	}

	public Date getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(Date createdAt) {
		this.createdAt = createdAt;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getMaterialId() {
		return materialId;
	}

	public void setMaterialId(String materialId) {
		this.materialId = materialId;
	}
	
	public String getParentPath() {
        return parentPath;
    }

    public void setParentPath(String parentPath) {
        this.parentPath = parentPath;
    }
    
    /**
   	 * 存储类型 0- 本地  1- ftp  2- fastdfs
   	 */
   	
    @TableField(exist=false)
   	private Integer storeType ; 
   	
   	public void setStoreType(Integer storeType) {
   		this.storeType = storeType;
   	}
   	
   	public Integer getStoreType() {
   		return storeType;
   	}
       
}
