package com.xiaobo.common.form;

import io.swagger.annotations.ApiModelProperty;

public class IdForm implements java.io.Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = -3881316087785444236L;
	@ApiModelProperty("ID")
	private String id ;
	
	public void setId(String id) {
		this.id = id;
	}
	
	
	public String getId() {
		return id;
	}

}
