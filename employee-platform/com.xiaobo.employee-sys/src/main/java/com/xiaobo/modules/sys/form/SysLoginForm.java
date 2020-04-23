

package com.xiaobo.modules.sys.form;

/**
 * 登录表单
 *
 * @author Mark sunlightcs@gmail.com
 * @since 2.0.0 2018-01-25
 */
public class SysLoginForm {
    private String userNo;
    private String password;
    private String captcha;
    private String uuid;
    private String browser;
    private String os;


    public String getBrowser() {
        return browser;
    }

    public void setBrowser(String browser) {
        this.browser = browser;
    }

    public String getOs() {
        return os;
    }

    public void setOs(String os) {
        this.os = os;
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

    public String getCaptcha() {
        return captcha;
    }

    public void setCaptcha(String captcha) {
        this.captcha = captcha;
    }

    public String getUuid() {
        return uuid;
    }

    public void setUuid(String uuid) {
        this.uuid = uuid;
    }
}
