package com.xiaobo.modules.sys.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.xiaobo.common.utils.PageUtils;
import com.xiaobo.modules.sys.entity.SysRoleEntity;

import java.util.List;


/**
 * 角色
 * 
 * zhangxiaobo
 * @email 1920969038@qq.com.com
 * @date 2016年9月18日 上午9:42:52
 */
public interface SysRoleService extends IService<SysRoleEntity> {

	PageUtils queryPage(SysRoleEntity entity, PageUtils page);
 

	void update(SysRoleEntity role);

	void deleteBatch(String[] roleIds);

	
	/**
	 * 查询用户创建的角色ID列表
	 */
	List<Long> queryRoleIdList(String createUserId);

	/**
	 * 查询用户创建的角色列表
	 */
	List<SysRoleEntity> queryRoleList(String createUserId);
}
