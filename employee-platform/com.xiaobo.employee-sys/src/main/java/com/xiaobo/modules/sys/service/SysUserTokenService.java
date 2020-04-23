package com.xiaobo.modules.sys.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.xiaobo.common.utils.R;
import com.xiaobo.modules.sys.entity.SysUserTokenEntity;

/**
 * 用户Token
 * 
 * zhangxiaobo
 * @email 1920969038@qq.com.com
 * @date 2017-03-23 15:22:07
 */
public interface SysUserTokenService extends IService<SysUserTokenEntity> {

	/**
	 * 生成token
	 * @param userId    用户ID
	 * @param browser  用户登录用的浏览器
	 * @param os       用户登录用的操作系统
	 */
	R createToken(String userId, String browser, String os);

	/**
	 * 退出，修改token值
	 * @param userId  用户ID
	 */
	void logout(String userId);
	
	SysUserTokenEntity queryByToken(String token);
	
	String queryTokenByUserId(String userId);

	void updateLogoutTime(String userId);

}
