package com.xiaobo.modules.sys.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.xiaobo.common.form.LoginForm;
import com.xiaobo.common.utils.PageUtils;
import com.xiaobo.common.utils.R;
import com.xiaobo.modules.sys.entity.SysUserEntity;

import java.util.List;
import java.util.Set;


/**
 * 系统用户
 * 
 * zhangxiaobo
 * @email 1920969038@qq.com.com
 * @date 2016年9月18日 上午9:43:39
 */
public interface SysUserService extends IService<SysUserEntity> {

	PageUtils queryPage(SysUserEntity entity, PageUtils page);

	List<SysUserEntity> queryList(SysUserEntity entity);

	/**
	 * 查询用户的所有权限
	 * @param userId  用户ID
	 */
	Set<String> queryAllPerms(String userId);

	/**
	 * 查询用户的所有菜单ID
	 */
	List<String> queryAllMenuId(String userId);

	/**
	 * 根据用户名，查询系统用户
	 */
	SysUserEntity queryByUserNo(String userNo);


	/**
	 * 修改用户
	 */
	void update(SysUserEntity user);

	/**
	 * 删除用户
	 */
	void deleteBatch(String[] userIds);

	/**
	 * 修改密码
	 * @param userId       用户ID
	 * @param password     原密码
	 * @param newPassword  新密码
	 */
	boolean updatePassword(String userId, String password, String newPassword);


	/**
	 * 重置用户密码
	 * @param userId 用户ID
	 * @param newPass 新密码,经过加密后的
	 * @return
	 */
	public boolean resetPass(String userId, String newPass);

	/**
	 * 用户登录
	 * @param form    登录表单
	 * @return        返回用户权限和用户信息 登陆异常返回登陆错误信息
	 */
	R appLogin(LoginForm form);

	/**
	 * 保存用户
	 */
	void saveUser(SysUserEntity user);


	/**
	 * 查询自己添加的账户
	 */
	List<SysUserEntity> queryByCreateID(String createuserid);

	/**
	 * 查询账户列表
	 */
	List<SysUserEntity> queryUsers();


	/**
	 * 修改最后登录时间
	 * */
	void updateLastDate(SysUserEntity user);

	int queryMainNum(String orgId);

	//查询用户当前单位及下属的账号
	List<SysUserEntity> queryByOrgParent(String orgId, String currUserId);

	SysUserEntity queryById(String id);
}
