package com.xiaobo.modules.sys.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.xiaobo.modules.sys.entity.SysRoleMenuEntity;

import java.util.List;


/**
 * 角色与菜单对应关系
 * 
 * zhangxiaobo
 * @email 1920969038@qq.com.com
 * @date 2016年9月18日 上午9:42:30
 */
public interface SysRoleMenuService extends IService<SysRoleMenuEntity> {
	
	void saveOrUpdate(String roleId, List<String> menuIdList);
	
	/**
	 * 根据角色ID，获取菜单ID列表
	 */
	List<String> queryMenuIdList(String roleId);

	/**
	 * 根据角色ID数组，批量删除
	 */
	int deleteBatch(String[] roleIds);
	
}
