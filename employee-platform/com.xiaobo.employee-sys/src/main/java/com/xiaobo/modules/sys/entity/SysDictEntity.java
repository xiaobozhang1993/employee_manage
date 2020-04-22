package com.xiaobo.modules.sys.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import io.swagger.annotations.ApiModelProperty;

import java.io.Serializable;
import java.util.Date;

/**
 * 数据字典
 *
 * zhangxiaobo
 * @email 1920969038.com
 * @date 2019-03-20 10:54:34
 */
@TableName("sys_dict")
public class SysDictEntity  implements Serializable {

	/**
	 *
	 */
	private static final long serialVersionUID = -4754957935328935572L;
	/**
	 * id
	 */
	@TableId(type = IdType.UUID)
	@TableField("dict_id")
	@ApiModelProperty("ID")
	private String dictId;
	/**
	 * 值
	 */
	@TableField("value")
	@ApiModelProperty("值")
	private String value;
	/**
	 * 标签
	 */
	@ApiModelProperty("标签")
	@TableField("dict_name")
	private String dictName;
	/**
	 * 字典分类
	 */
	@TableField("type")
	@ApiModelProperty("字典分类")
	private String type;
	/**
	 * 类型名称
	 */
	@ApiModelProperty("类型名称/描述")
	@TableField("description")
	private String description;
	/**
	 * 序号
	 */
	@TableField("seq")
	@ApiModelProperty("序号")
	private Integer seq;
	/**
	 * 创建时间
	 */
	@TableField("create_date")
	@ApiModelProperty(hidden=true)
	private Date createDate;
	/**
	 * 更新时间
	 */
	@TableField("update_date")
	@ApiModelProperty(hidden=true)
	private Date updateDate;
	/**
	 * 删除状态（0：可用   1：不可用）
	 */
	@TableField("del_flag")
	@ApiModelProperty("删除状态（0：可用   1：不可用）")
	private Integer delFlag;
	/**
	 * 创建Id
	 */
	@TableField("create_by")
	@ApiModelProperty(hidden=true)
	private String createBy;
	/**
	 * 更新Id
	 */
	@TableField("update_by")
	@ApiModelProperty()
	private String updateBy;

	public String getIsDict() {
		return isDict;
	}

	public void setIsDict(String isDict) {
		this.isDict = isDict;
	}

	@TableField("is_dict")
	@ApiModelProperty()
	private String isDict;

	@TableField(exist = false)
	@ApiModelProperty(hidden=true)
	private int count;

	public int getCount() {
		return count;
	}

	public void setCount(int count) {
		this.count = count;
	}

	public String getDictId() {
		return dictId;
	}
	public void setDictId(String dictId) {
		this.dictId = dictId;
	}
	public String getValue() {
		return value;
	}
	public void setValue(String value) {
		this.value = value;
	}
	public String getDictName() {
		return dictName;
	}
	public void setDictName(String dictName) {
		this.dictName = dictName;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public Integer getSeq() {
		return seq;
	}
	public void setSeq(Integer seq) {
		this.seq = seq;
	}
	public Date getCreateDate() {
		return createDate;
	}
	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}
	public Date getUpdateDate() {
		return updateDate;
	}
	public void setUpdateDate(Date updateDate) {
		this.updateDate = updateDate;
	}
	public Integer getDelFlag() {
		return delFlag;
	}
	public void setDelFlag(Integer delFlag) {
		this.delFlag = delFlag;
	}
	public String getCreateBy() {
		return createBy;
	}
	public void setCreateBy(String createBy) {
		this.createBy = createBy;
	}
	public String getUpdateBy() {
		return updateBy;
	}
	public void setUpdateBy(String updateBy) {
		this.updateBy = updateBy;
	}


}
