package com.xiaobo.common.enums;

import com.baomidou.mybatisplus.core.enums.IEnum;
import com.fasterxml.jackson.annotation.JsonValue;

/**
 * 用户类型
 * @author zhangxiaobo
 *
 */
public enum UserType  implements IEnum<Integer>{
	
	/**
	 * 平台管理
	 */
	admin(0) ,
	
	/**
	 * 部门级主账号
	 */
	primaryUser(1) ,
	
	/**
	 * 部门子账号
	 */
	subUser(2) 
	;

	private int value;

	UserType(int value) {
		this.value = value;
	}

	@JsonValue
	public Integer getValue() {
		return value;
	}

}
