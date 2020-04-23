 

package com.xiaobo.common.form;


import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import org.hibernate.validator.constraints.Length;

import javax.validation.constraints.Email;
import javax.validation.constraints.NotBlank;

/**
 * 注册表单
 *
 * @author Mark sunlightcs@gmail.com
 * @since 3.1.0 2018-01-25
 */
@ApiModel(value = "注册表单")
public class RegisterForm implements java.io.Serializable{
	
	//String username, String password, String email, String mobile,String businessType
	
    /**
	 * 
	 */
	private static final long serialVersionUID = -1555015444386329708L;

	@ApiModelProperty(value = "手机号")
    @NotBlank(message="手机号不能为空")
    @Length(min=11,max=11,message="手机号非法")
    private String mobile;
    
    /**
     * 用户名
     */
    @ApiModelProperty(value = "用户名")
    @NotBlank(message="用户名不能为空")
    @Length(min = 4, max = 20)
	//@Pattern.List({ @Pattern(regexp = "^[0-9a-zA-Z_\\u4e00-\\u9fa5]+$"), @Pattern(regexp = "^.*[^\\d].*$") })
    private String username ;
    
    /**
     *  邮箱
     */
    @ApiModelProperty(value = "邮箱")
    @NotBlank(message="邮箱不能为空")
    @Email
	@Length(max = 200)
    private String email ;


    @ApiModelProperty(value = "密码")
    @NotBlank(message="密码不能为空")
    private String password;
    
    /**
     * 登录账号
     */
    @ApiModelProperty(value = "登录账号")
    @NotBlank(message="登录账号不能为空")
    @Length(max = 40)
    private String userNo ;
     
    /**
     * 验证码
     */
//    @ApiModelProperty(value = "验证码,长度为四位数字")
//    @NotBlank(message="验证码不能为空")
    private String authCode;
    
    /**
     * 性别
     */
    @ApiModelProperty(value = "性别")
    private Integer sex ;

    public String getMobile() {
        return mobile;
    }

    public void setMobile(String mobile) {
        this.mobile = mobile;
    }

    public String getPassword() {
        return password; 
    }

    public void setPassword(String password) {
        this.password = password;
    }

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	 
    
	public void setAuthCode(String authCode) {
		this.authCode = authCode;
	}
	public String getAuthCode() {
		return authCode;
	}

	public String getUserNo() {
		return userNo;
	}

	public void setUserNo(String userNo) {
		this.userNo = userNo;
	}

	public Integer getSex() {
		return sex;
	}

	public void setSex(Integer sex) {
		this.sex = sex;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}
    
    
}
