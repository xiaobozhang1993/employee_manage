package com.xiaobo.oauth2.service;

import java.util.Set;

import com.xiaobo.common.entity.SysUser;

public interface OauthService {
	
	/**
	 * 根据token查询用户  
	 * @param token 用户当前授权token
	 * @return
	 */
	public SysUser queryByToken(String token);
	
	/**
	 * 基于app token查询用户
	 * @param appToken
	 * @return
	 */
	public SysUser queryByAppToken(String appToken);
	
	/**
	 * 查询用户的权限列表
	 * @param userId
	 * @return
	 */
	public Set<String> queryPermsByUser(String userId);
	
	/**
	 * 刷新token最后的更新时间
	 * @param token
	 */
	public void updateTokenUpdateTime(String token);
 
}
