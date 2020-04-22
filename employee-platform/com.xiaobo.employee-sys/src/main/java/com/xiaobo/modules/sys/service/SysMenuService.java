

package com.xiaobo.modules.sys.service;


import com.baomidou.mybatisplus.extension.service.IService;
import com.xiaobo.modules.sys.entity.SysMenuEntity;

import java.util.List;


/**
 * 菜单管理
 * 
 * zhangxiaobo
 * @email 1920969038@qq.com.com
 * @date 2016年9月18日 上午9:42:16
 */
public interface SysMenuService extends IService<SysMenuEntity> {

	/**
	 * 根据父菜单，查询子菜单
	 * @param parentId 父菜单ID
	 * @param menuIdList  用户菜单ID
	 */
	// List<SysMenuEntity> queryListParentId(String parentId, List<String> menuIdList);

	/**
	 * 根据父菜单，查询子菜单
	 * @param parentId 父菜单ID
	 */
	List<SysMenuEntity> queryListParentId(String parentId);
	
	/**
	 * 获取不包含按钮的菜单列表
	 */
	List<SysMenuEntity> queryNotButtonList();
	
	/**
	 * 获取用户菜单列表
	 */
	List<SysMenuEntity> getUserMenuList(String userId);

	/**
	 * 删除
	 */
	void delete(String menuId);
	
	/**
	 * 清空缓存 当角色变动或者用户所属角色变动的时候 为了简单 这里全部清空缓存
	 */
	public void clearCache();

	/**
	 *获取菜单列表
	 */
	List<SysMenuEntity> getMenuListByID(String userId);
 
}
