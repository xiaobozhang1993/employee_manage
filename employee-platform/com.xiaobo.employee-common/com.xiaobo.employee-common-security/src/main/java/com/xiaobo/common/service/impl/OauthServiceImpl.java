package com.xiaobo.oauth2.service.impl;

import java.util.Arrays;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.xiaobo.common.entity.SysUser;
import com.xiaobo.common.redis.RedisUtils;
import com.xiaobo.common.utils.Constant;
import com.xiaobo.common.utils.DateUtils;
import com.xiaobo.oauth2.dao.OauthDao;
import com.xiaobo.oauth2.service.OauthService;

@Service
public class OauthServiceImpl implements OauthService {

	@Autowired
	private OauthDao oauthDao ;
	
	@Autowired
	private RedisUtils redisUtils ;
	 
	

	@Override
	public SysUser queryByToken(String token) {
		// TODO Auto-generated method stub
		if(StringUtils.isBlank(token))
			return null;
		
		String key = "token_user_" + token ;
		
		// 判断缓存
		if(redisUtils.containKey(key)) {
			SysUser user = redisUtils.get(key, SysUser.class);
			if(user != null)
				return user ;
		}
		
		SysUser user = oauthDao.selectUserByToken(token);
		 
		redisUtils.set(key, user);
		
		return user;
	}

	@Override
	public Set<String> queryPermsByUser(String userId) {
		if(StringUtils.isBlank(userId))
			return null;
		// TODO Auto-generated method stub
		
		// 取出token  基于token的缓存，重登录避免缓存
		
		// 查询到公司ID 
		 
		//String userId = user.getUserId();
		
		String key = "perms-user-" + userId ;
		
		// 判断缓存
		if(redisUtils.containKey(key)) {
			@SuppressWarnings("unchecked")
			Set<String> perms = redisUtils.get(key, Set.class);
			if(perms != null)
				return perms ;
		}
		
		Set<String> perms = new HashSet<>();
		// 判断是否超管
		if(userId.equals(Constant.SUPER_ADMIN)|| userId.equals("6f6c2e30ee6f4379b39435cbfda70647")) {
			perms = oauthDao.selectAllPerms();
		} else {
			perms = oauthDao.selectPermsByUser(userId) ;// sysService.selectUserPerms(userId);
			 
		}
		
		//拆分
		Set<String> ps = new HashSet<>();
		for(String s : perms) {
			if(StringUtils.isBlank(s)) continue;
			
			String[] ss = s.split(",");
			
			ps.addAll(Arrays.asList(ss));
			
		}
		 
		// 存入缓存 缓存5分钟
		redisUtils.set(key, ps );
		
		
		return ps ; 
		
	}

	@Override
	public SysUser queryByAppToken(String appToken) {
		if(StringUtils.isBlank(appToken))
			return null;
		
	String key = "app_token_user_" + appToken ;
		
		// 判断缓存
		if(redisUtils.containKey(key)) {
			SysUser user = redisUtils.get(key, SysUser.class);
			if(user != null)
				return user ;
		}
		
		SysUser user = oauthDao.selectUserByAppToken(appToken);
		 
		redisUtils.set(key, user);
		
		return user;
		 
	}

	@Override
	public void updateTokenUpdateTime(String token) {
		// TODO Auto-generated method stub
		Date updateTime = new Date();
		
		Date expireTime = DateUtils.addDateSeconds(updateTime, Constant.EXPIRE);
		
		oauthDao.updateTokenUpdateTime(token, updateTime, expireTime);
	}
	
	
	
}
