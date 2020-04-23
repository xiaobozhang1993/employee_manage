package com.xiaobo.modules.sys.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;

import java.io.Serializable;
import java.util.Date;

/**
 * 部门表
 * 
 * zhangxiaobo
 * @email 1920969038.com
 * @date 2019-11-15 09:05:42
 */
@TableName("sys_department")
@ApiModel("部门表")
public class SysDepartmentEntity implements Serializable {
	private static final long serialVersionUID = 1L;


	/**
	 * 创建时间
	 */
	@TableField("create_time") 
	@ApiModelProperty("创建时间")
	private Date createTime;
	/**
	 * 部门主键id
	 */
	@TableId(type = IdType.UUID)
	@TableField("dep_id") 
	@ApiModelProperty("部门主键id")
	private String depId;
	/**
	 * 部门名称
	 */
	@TableField("name") 
	@ApiModelProperty("部门名称")
	private String name;
	/**
	 * 外键_组织架构id
	 */
	@TableField("org_id") 
	@ApiModelProperty("外键_组织架构id")
	private String orgId;
	/**
	 * 负责人
	 */
	@TableField("principal") 
	@ApiModelProperty("负责人")
	private String principal;
	/**
	 * 修改时间
	 */
	@TableField("update_time") 
	@ApiModelProperty("修改时间")
	private Date updateTime;

	/**
	 * 设置：创建时间
	 */
	 
	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}
	/**
	 * 获取：创建时间
	 */
	public Date getCreateTime() {
		return createTime;
	}
	/**
	 * 设置：部门主键id
	 */
	 
	public void setDepId(String depId) {
		this.depId = depId;
	}
	/**
	 * 获取：部门主键id
	 */
	public String getDepId() {
		return depId;
	}
	/**
	 * 设置：部门名称
	 */
	 
	public void setName(String name) {
		this.name = name;
	}
	/**
	 * 获取：部门名称
	 */
	public String getName() {
		return name;
	}
	/**
	 * 设置：外键_组织架构id
	 */
	 
	public void setOrgId(String orgId) {
		this.orgId = orgId;
	}
	/**
	 * 获取：外键_组织架构id
	 */
	public String getOrgId() {
		return orgId;
	}
	/**
	 * 设置：负责人
	 */
	 
	public void setPrincipal(String principal) {
		this.principal = principal;
	}
	/**
	 * 获取：负责人
	 */
	public String getPrincipal() {
		return principal;
	}
	/**
	 * 设置：修改时间
	 */
	 
	public void setUpdateTime(Date updateTime) {
			this.updateTime = updateTime;
	}
	/**
	 * 获取：修改时间
	 */
	public Date getUpdateTime() {
		return updateTime;
	}
}
