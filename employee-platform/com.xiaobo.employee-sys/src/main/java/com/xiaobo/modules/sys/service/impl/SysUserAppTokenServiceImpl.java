package com.xiaobo.modules.sys.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.xiaobo.common.redis.RedisUtils;
import com.xiaobo.common.utils.Constant;
import com.xiaobo.common.utils.R;
import com.xiaobo.common.utils.TokenGenerator;
import com.xiaobo.modules.sys.dao.SysUserTokenDao;
import com.xiaobo.modules.sys.entity.SysUserTokenEntity;
import com.xiaobo.modules.sys.service.SysUserTokenService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;


@Service
public class SysUserAppTokenServiceImpl extends ServiceImpl<SysUserTokenDao, SysUserTokenEntity> implements SysUserTokenService {
	

	
	@Autowired
	private RedisUtils redisUtils;

	@Override
	public R createToken(String userId, String browser, String os) {
		//生成一个token
		String token = TokenGenerator.generateValue();

		//当前时间
		Date now = new Date();
		//过期时间
		Date expireTime = new Date(now.getTime() + Constant.EXPIRE * 1000);

		//判断是否生成过token
		SysUserTokenEntity tokenEntity = this.getById(userId);
		if(tokenEntity == null){
			tokenEntity = new SysUserTokenEntity();
			tokenEntity.setUserId(userId);
			tokenEntity.setToken(token);
			tokenEntity.setUpdateTime(now);
			tokenEntity.setExpireTime(expireTime);
			tokenEntity.setBrowser(browser);
			tokenEntity.setOs(os);

			//保存token
			this.save(tokenEntity);
		}else{
			tokenEntity.setToken(token);
			tokenEntity.setUpdateTime(now);
			tokenEntity.setExpireTime(expireTime);
			tokenEntity.setBrowser(browser);
			tokenEntity.setOs(os);
			//更新token
			this.updateById(tokenEntity);
		}

		//清理用户之前的token
		if(redisUtils.containKey(getClass().getSimpleName() + userId)) {
			String oToken = redisUtils.get(getClass().getSimpleName() + userId);

			redisUtils.delete(getClass().getSimpleName() + oToken);
		}

		redisUtils.set(getClass().getSimpleName() + userId, token);
		redisUtils.set(getClass().getSimpleName() + token, tokenEntity);
		
		R r = R.ok().put("token", token).put("expire", Constant.EXPIRE);

		return r;
	}

	@Override
	public void logout(String userId) {
		//生成一个token
		String token = TokenGenerator.generateValue();

		//修改token
		SysUserTokenEntity tokenEntity = new SysUserTokenEntity();
		tokenEntity.setUserId(userId);
		tokenEntity.setToken(token);
		this.updateById(tokenEntity);
		
		//清理用户之前的token
		if(redisUtils.containKey(getClass().getSimpleName() + userId)) {
			String oToken = redisUtils.get(getClass().getSimpleName() + userId);
			
			redisUtils.delete(getClass().getSimpleName() + oToken);
		}
		
		redisUtils.set(getClass().getSimpleName() + userId, token);
		redisUtils.set(getClass().getSimpleName() + token, tokenEntity);
	}

	@Override
	public SysUserTokenEntity queryByToken(String token) {
		// TODO Auto-generated method stub
		if(redisUtils.containKey(getClass().getSimpleName() + token)) {
			return redisUtils.get(getClass().getSimpleName() + token, SysUserTokenEntity.class);
		}
		return baseMapper.queryByToken(token);
	}

	/**
	 * 基于redis,如果redis没有开启则不管
	 */
	@Override
	public String queryTokenByUserId(String userId) {
		if(redisUtils.containKey(getClass().getSimpleName() + userId)) {
			return redisUtils.get(getClass().getSimpleName() + userId);
		}
		return null; 
	}

	public void updateLogoutTime(String userId){ baseMapper.updateLogoutTime(userId);}
}
