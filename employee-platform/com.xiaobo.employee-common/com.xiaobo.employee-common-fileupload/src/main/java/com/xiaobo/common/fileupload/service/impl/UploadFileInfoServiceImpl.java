package com.xiaobo.common.fileupload.service.impl;

import java.util.Arrays;
import java.util.Collection;

import org.springframework.stereotype.Service;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.xiaobo.common.fileupload.dao.UploadFileInfoDao;
import com.xiaobo.common.fileupload.entity.UploadFileInfoEntity;
import com.xiaobo.common.fileupload.service.UploadFileInfoService;




@Service
public class UploadFileInfoServiceImpl extends ServiceImpl<UploadFileInfoDao, UploadFileInfoEntity> implements UploadFileInfoService {
 

	@Override
	public boolean insert(UploadFileInfoEntity entity) {
		// TODO Auto-generated method stub
		return this.save(entity);
	}
 

	@Override
	public Collection<UploadFileInfoEntity> selectList(String[] ids) {
		// TODO Auto-generated method stub
		return listByIds(Arrays.asList(ids));
	}

 
	 
 
}
