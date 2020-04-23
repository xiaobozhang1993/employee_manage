package com.xiaobo.modules.sys.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

/**
 * 级联表
 *
 * @author zhangxiaobo
 * @date 2019年11月13日 15点49分
 */
@TableName("sys_organization")
public class SysOrganizationEntity implements Serializable {
	private static final long serialVersionUID = 1L;

	/**
	 * 组织编码
	 */
	@TableId(type = IdType.UUID)
	private String id;
	/**
	 * 名称
	 */
	private String name;
	/**
	 * 上级组织
	 */
	private String parentId;


	/**
	 * 排序
	 * */
	private int    orderNum;

	/**
	 * 创建时间
	 * */
	private Date createTime;

	/**

	 * 修改时间
	 * */
	private Date updateTime;

	@TableField(exist = false)
	private List<SysOrganizationEntity> children;

	public Integer getValue() {
		return value;
	}

	public void setValue(Integer value) {
		this.value = value;
	}

	@TableField(exist = false)
	private Integer value;

	/**
	 * 设置：组织编码
	 */
	public void setId(String id) {
		this.id = id;
	}

	public List<SysOrganizationEntity> getChildren() {
		return children;
	}

	public void setChildren(List<SysOrganizationEntity> children) {
		this.children = children;
	}

	/**
	 * 获取：组织编码
	 */
	public String getId() {
		return id;
	}
	/**
	 * 设置：名称
	 */
	public void setName(String name) {
		this.name = name;
	}
	/**
	 * 获取：名称
	 */
	public String getName() {
		return name;
	}
	/**
	 * 设置：上级组织
	 */
	public void setParentId(String parentId) {
		this.parentId = parentId;
	}
	/**
	 * 获取：上级组织
	 */
	public String getParentId() {
		return parentId;
	}

	public int getOrderNum() {
		return orderNum;
	}

	public void setOrderNum(int orderNum) {
		this.orderNum = orderNum;
	}

	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		if (this.id==null){
			this.createTime = new Date();
		}

	}

	public Date getUpdateTime() {
		return updateTime;
	}

	public void setUpdateTime(Date updateTime) {
		if(this.id!=null){
			this.updateTime = new Date();
		}
	}


}
