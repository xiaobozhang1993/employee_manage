package com.xiaobo.common.log.annotation;

public enum SysModule {

	sys("用户中心") , unknow("未知");
	
	private String name ;

	private SysModule(String name) {
		this.name = name;
	}
	
	public String getName() {
		return name;
	}
	
	
}
