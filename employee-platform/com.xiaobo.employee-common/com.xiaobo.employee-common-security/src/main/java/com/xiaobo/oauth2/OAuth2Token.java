package com.xiaobo.oauth2;


import org.apache.shiro.authc.AuthenticationToken;

/**
 * token
 *
 * @author zhangxiaobo
 * 
 * @date 2017-05-20 13:22
 */
public class OAuth2Token implements AuthenticationToken {
    /**
	 * 
	 */
	private static final long serialVersionUID = 6260919252108035896L;
	private String token;

    public OAuth2Token(String token){
        this.token = token;
    }

    @Override
    public String getPrincipal() {
        return token;
    }

    @Override
    public Object getCredentials() {
        return token;
    }
}
