package com.xiaobo.common.fileupload.service;

import java.io.InputStream;
import java.util.Collection;

import com.baomidou.mybatisplus.extension.service.IService;
import com.xiaobo.common.fileupload.entity.UploadFileInfoEntity;

/**
 *
 *
 * @author zhangxiaobo
 * @email 1920969038.com
 * @date 2019-03-25 15:18:30
 */ 
public interface UploadFileInfoService  extends IService<UploadFileInfoEntity> {
 

	/**
	 * 插入一条附件信息
	 * @param entity
	 * @return
	 */
	boolean insert(UploadFileInfoEntity entity);
	
 
 


	/**
	 * 根据多条ID 查询附件集合
	 * @param ids
	 * @return
	 */
	Collection<UploadFileInfoEntity> selectList(String[] ids);
 
 
   
}

