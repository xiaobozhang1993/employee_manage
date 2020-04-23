package com.xiaobo.modules.sys.dao;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.xiaobo.modules.sys.entity.SysUserEntity;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import java.util.List;

/**
 * 系统用户
 * 
 * zhangxiaobo
 * @date 2017年9月18日 上午9:34:11
 */
@Mapper
public interface SysUserDao extends BaseMapper<SysUserEntity> {
	
	/**
	 * 查询用户的所有权限
	 * @param userId  用户ID
	 */
	@Select("select m.perms from sys_user_role ur " + 
			"			LEFT JOIN sys_role_menu rm on ur.role_id = rm.role_id " + 
			"			LEFT JOIN sys_menu m on rm.menu_id = m.menu_id " + 
			"		where ur.user_id = #{userId}")
	public List<String> queryAllPerms(@Param("userId") String userId);
	
	/**
	 * 查询用户的所有菜单ID
	 */
	@Select("select distinct rm.menu_id from sys_user_role ur  " + 
			"			LEFT JOIN sys_role_menu rm on ur.role_id = rm.role_id  " + 
			"		where ur.user_id = #{userId}")
	public List<String> queryAllMenuId(@Param("userId") String userId);
	
	/**
	 * 根据用户编号，查询系统用户
	 */
	@Select("select * from sys_user where user_no = #{userNo}")
	public SysUserEntity queryByUserNo(@Param("userNo") String userNo);
	
 
	
	/**
	 * 重置管理员用户密码
	 * @param userId
	 * @param newPass
	 */
	@Update("update sys_user set password = #{password} where user_id = #{userId}")
	public void resetPass(@Param("userId") String userId, @Param("password") String newPass);


	/**
	 * 查询创建的用户
	 * @param createuserid
	 * @return
	 */
	@Select("select * from sys_user where create_user_id = #{createuserid}" )
	public List<SysUserEntity> queryByCreateID(String createuserid);

	@Select("WITH RECURSIVE T ( ID, NAME, PARENT_ID, order_num ) AS (\n" +
			"SELECT ID,NAME,PARENT_ID,order_num \n" +
			"FROM\n" +
			"\tsys_organization \n" +
			"WHERE\n" +
			"\tID = #{orgId} UNION ALL\n" +
			"SELECT\n" +
			"\tT1.ID,\n" +
			"\tT1.NAME,\n" +
			"\tT1.PARENT_ID,\n" +
			"\tT1.order_num \n" +
			"FROM\n" +
			"\tsys_organization T1\n" +
			"\tJOIN T ON T1.PARENT_ID = T.ID \n" +
			"\t) SELECT\n" +
			"\t* \n" +
			"FROM\n" +
			"\tsys_user \n" +
			"WHERE\n" +
			"\torg_id IN (SELECT ID FROM T)" +
			"and user_id !=#{currUserId}"+
			" ORDER BY create_time DESC")
	List<SysUserEntity> queryByOrgParent(String orgId, String currUserId);

	/**
	 * 查询创建的用户
	 */
	@Select("select * from sys_user where 1 = 1")
	public List<SysUserEntity> queryUsers();

	@Select("select count(user_id) from sys_user where org_id = #{orgId} and user_type='1'")
	int queryMainNum(String orgId);

	@Select("select * from sys_user where user_id = #{id}")
	SysUserEntity queryById(String id);
}
