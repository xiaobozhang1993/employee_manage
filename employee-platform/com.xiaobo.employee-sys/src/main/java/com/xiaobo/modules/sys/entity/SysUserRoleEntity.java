package com.xiaobo.modules.sys.entity;


import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;

import java.io.Serializable;

/**
 * 用户与角色对应关系
 * 
 * zhangxiaobo
 * @date 2017年9月18日 上午9:28:39
 */
@TableName("sys_user_role")
public class SysUserRoleEntity implements Serializable {
	private static final long serialVersionUID = 1L;
	@TableId(type = IdType.UUID)
	private String  id;

	/**
	 * 用户ID
	 */
	private String userId;

	/**
	 * 角色ID
	 */
	private String roleId;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	/**
	 * 设置：用户ID
	 * @param userId 用户ID
	 */
	public void setUserId(String userId) {
		this.userId = userId;
	}

	/**
	 * 获取：用户ID
	 * @return Long
	 */
	public String getUserId() {
		return userId;
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
	
}
