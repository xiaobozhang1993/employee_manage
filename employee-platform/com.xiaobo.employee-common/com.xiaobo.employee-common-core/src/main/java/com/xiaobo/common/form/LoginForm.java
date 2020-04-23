

package com.xiaobo.common.form;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;

import javax.validation.constraints.NotBlank;

/**
 * 登录表单
 *
 * @author Mark sunlightcs@gmail.com
 * @since 3.1.0 2018-01-25
 */
@ApiModel(value = "登录表单")
public class LoginForm implements java.io.Serializable{
    /**
	 * 
	 */
	private static final long serialVersionUID = 8196400672574734524L;

	@ApiModelProperty(value = "用户账号")
    @NotBlank(message="用户账号不能为空")
    private String userNo;

    @ApiModelProperty(value = "密码")
    @NotBlank(message="密码不能为空")
    private String password;

   
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
}
