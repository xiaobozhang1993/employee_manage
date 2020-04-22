package com.xiaobo.modules.sys.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.xiaobo.common.entity.SysUser;
import com.xiaobo.common.enums.UserType;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

/**
 * 系统用户
 *
 * zhangxiaobo
 * @date 2017年9月18日 上午9:28:55
 */
@TableName("sys_user")
public class SysUserEntity extends SysUser implements Serializable {
	private static final long serialVersionUID = 1L;


	/**
	 * 用户ID
	 */
	@TableId(type= IdType.UUID)
	private String userId;

	/**
	 * 唯一编号
	 */
	private String userNo ;

	/**
	 * 单位名称
	 */
	private String username ;

	/**
	 * 密码盐值
	 */
	@JsonIgnore
	private String salt ;

	/**
	 * 密码
	 */
	//@JsonIgnore
	private String password ;


	/**
	 * 手机号
	 */
//	@NotBlank(message="手机不能为空", groups = {AddGroup.class, UpdateGroup.class})
	private String mobile;

	/**
	 * 状态  0：禁用   1：正常
	 */
	private Integer status;



	/**
	 * 创建时间
	 */
	private Date createTime;


	/**
	 * 最后登陆时间
	 */
	private Date lastLoginTime;



	/**
	 * logo
	 */
	private String logo ;


	/**
	 * 邮箱
	 */
	private String email ;

	/**
	 * 归属部门/区域机构ID
	 */
	private String orgId ;

	/**
	 * 用户类型 0-admin 1-主账号 2-子账号
	 */
	private UserType userType ;

	/***
	 *用户定制的表头
	 */
	private String title;
	/**
	 * 备注
	 */
	@TableField(exist = false)
	private String context;

	/**
	 * 角色ID列表
	 */
	@TableField(exist = false)
	private List<String> roleIdList;

	@TableField(exist = false)
	private String[] tabletitle;

	/**
	 * 角色ID
	 */
	@TableField(exist = false)
	private String roleId;

	/**
	 * 部门ID
	 */
	private String depId;

	/**
	 * 部门名称
	 */
	private String depName;

	/**
	 * 单位负责人
	 */
	private String name;

	/**
	 * 创建人
	 */
	public String createUserId;

	@TableField(exist=false)
	public String comfirmPassword;


	/**
	 * 账户类型值
	 */
	@TableField(exist=false)
	public Integer userTypeValue;
	public String[] getTabletitle() {
		return tabletitle;
	}

	public void setTabletitle(String[] tabletitle) {
		this.tabletitle = tabletitle;
	}

	public String getContext() {
		return context;
	}

	public void setContext(String context) {
		this.context = context;
	}

	public List<String> getRoleIdList() {
		return roleIdList;
	}

	public void setRoleIdList(List<String> roleIdList) {
		this.roleIdList = roleIdList;
	}

	public String getSalt() {
		return salt;
	}

	public void setSalt(String salt) {
		this.salt = salt;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getUserNo() {
		return userNo;
	}

	public void setUserNo(String userNo) {
		this.userNo = userNo;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}


	public void setUsername(String username) {
		this.username = username;
	}
	public String getUsername() {
		return username;
	}

	public String getMobile() {
		return mobile;
	}

	public void setMobile(String mobile) {
		this.mobile = mobile;
	}

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	public Date getLastLoginTime() {
		return lastLoginTime;
	}

	public void setLastLoginTime(Date lastLoginTime) {
		this.lastLoginTime = lastLoginTime;
	}

	public String getLogo() {
		return logo;
	}

	public void setLogo(String logo) {
		this.logo = logo;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	public String getOrgId() {
		return orgId;
	}

	public void setOrgId(String orgId) {
		this.orgId = orgId;
	}

	public UserType getUserType() {
		return userType;
	}

	public void setUserType(UserType userType) {
		this.userType = userType;
	}

	public String getDepId() {
		return depId;
	}

	public void setDepId(String depId) {
		this.depId = depId;
	}

	public String getDepName() {
		return depName;
	}

	public void setDepName(String depName) {
		this.depName = depName;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getCreateUserId() {
		return createUserId;
	}

	public void setCreateUserId(String createUserId) {
		this.createUserId = createUserId;
	}

	public String getRoleId() {
		return roleId;
	}

	public void setRoleId(String roleId) {
		this.roleId = roleId;
	}

	public String getComfirmPassword() {
		return comfirmPassword;
	}

	public void setComfirmPassword(String comfirmPassword) {
		this.comfirmPassword = comfirmPassword;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}
	public Integer getUserTypeValue() {
		return userTypeValue;
	}

	public void setUserTypeValue(Integer userTypeValue) {
		this.userTypeValue = userTypeValue;
	}
}
