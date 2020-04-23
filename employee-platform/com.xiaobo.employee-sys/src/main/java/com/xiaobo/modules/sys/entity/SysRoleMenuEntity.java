package com.xiaobo.modules.sys.entity;


import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;

import java.io.Serializable;

/**
 * 角色与菜单对应关系
 * 
 * zhangxiaobo
 * @email 1920969038@qq.com.com
 * @date 2016年9月18日 上午9:28:13
 */
@TableName("sys_role_menu")
public class SysRoleMenuEntity implements Serializable {
	private static final long serialVersionUID = 1L;

	@TableId(type= IdType.UUID)
	private String id;

	/**
	 * 角色ID
	 */
	private String roleId;

	/**
	 * 菜单ID
	 */
	private String menuId;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	/**
	 * 设置：角色ID
	 * @param roleId 角色ID
	 */
	public void setRoleId(String roleId) {
		this.roleId = roleId;
	}

	/**
	 * 获取：角色ID
	 * @return Long
	 */
	public String getRoleId() {
		return roleId;
	}
	
	/**
	 * 设置：菜单ID
	 * @param menuId 菜单ID
	 */
	public void setMenuId(String menuId) {
		this.menuId = menuId;
	}

	/**
	 * 获取：菜单ID
	 * @return Long
	 */
	public String getMenuId() {
		return menuId;
	}
	
}
