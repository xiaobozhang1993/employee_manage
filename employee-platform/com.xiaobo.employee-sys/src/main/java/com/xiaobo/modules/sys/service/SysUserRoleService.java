package com.xiaobo.modules.sys.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.xiaobo.modules.sys.entity.SysUserRoleEntity;

import java.util.List;


/**
 * 用户与角色对应关系
 * 
 * zhangxiaobo
 * @date 2017年9月18日 上午9:43:24
 */
public interface SysUserRoleService extends IService<SysUserRoleEntity> {
	
	void saveOrUpdate(String userId, List<String> roleIdList);
	
	/**
	 * 根据用户ID，获取角色ID列表
	 */
	List<String> queryRoleIdList(String userId);

	/**
	 * 根据角色ID数组，批量删除
	 */
	int deleteBatch(String[] roleIds);

	/**
	 * 根据用户ID，获取角色ID
	 */
	String queryRoleId(String userId);

	void newSaveOrUpdate(String userId, String roleId);

	/**
	 * 根据角色ID数组，批量删除
	 */
	int deleteUserBatch(String[] roleIds);
}
