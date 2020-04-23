package com.xiaobo.oauth2.dao;

import java.util.Date;
import java.util.Set;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.xiaobo.common.entity.SysUser;

@Mapper
public interface OauthDao {

	
	/**
	 * 基于token查询用户
	 * @param token 用户token
	 * @return
	 */
	@Select("select t1.* from " + 
			"sys_user as t1 , sys_user_token as t2 " + 
			"where t1.user_id = t2.user_id and t2.token = #{token}")
	SysUser selectUserByToken(String token);
	
	/**
	 * 基于app token查询用户
	 * @param token 用户token
	 * @return
	 */
	@Select("select t1.* from " + 
			"sys_user as t1 , sys_user_app_token as t2 " + 
			"where t1.user_id = t2.user_id and t2.token = #{appToken}")
	SysUser selectUserByAppToken(String appToken);
	
	/**
	 * 查询用户的权限列表
	 * @param userId 用户ID
	 * @return 用户的权限列表
	 */
	@Select("select DISTINCT m1.perms " + 
			"		from sys_menu as m1 " + 
			"			inner join sys_role_menu as m2 on m1.menu_id = m2.menu_id" + 
			"			inner join sys_user_role as m3 on m3.role_id = m2.role_id" + 
			"			where m3.user_id = #{userId}")
	Set<String> selectPermsByUser(String userId);
	
	/**
	 * 查询全部权限列表
	 * @param userId 用户ID
	 * @return 用户的权限列表
	 */
	@Select("select DISTINCT m1.perms " + 
			"		from sys_menu as m1" + 
			"		where m1.perms is not null")
	Set<String> selectAllPerms();
	
	/**
	 * 更新token当前更新时间
	 * @param token
	 */
	@Update("update sys_user_token set update_time = #{updateTime} , expire_time = #{expireTime} where token = #{token}")
	void updateTokenUpdateTime(@Param("token") String token ,@Param("updateTime")  Date updateTime ,@Param("expireTime")  Date expireTime);
	
	
	
}
