package com.xiaobo.modules.sys.dao;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.xiaobo.modules.sys.entity.SysUserRoleEntity;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.List;

/**
 * 用户与角色对应关系
 * 
 * @author  zhangxiaobo
 * @date 2017年9月18日 上午9:34:46
 */
@Mapper
public interface SysUserRoleDao extends BaseMapper<SysUserRoleEntity> {
	
	/**
	 * 根据用户ID，获取角色ID列表
	 */
	@Select("select role_id from sys_user_role where user_id = #{userId}")
	List<String> queryRoleIdList(@Param("userId") String userId);


	/**
	 * 根据角色ID数组，批量删除
	 */
	@Delete({"<script>"
			+ "delete from sys_user_role where role_id in ",
			"		<foreach item='roleId' collection='roleIds' open='(' separator=',' close=')'> ", 
			"			#{roleId} " , 
			"		</foreach>" ,
			"</script>"})
	int deleteBatch(@Param("roleIds") String[] roleIds);

	/**
	 * 根据用户ID，获取角色ID
	 */
	@Select("select role_id from sys_user_role where user_id = #{userId}")
	String queryRoleId(@Param("userId") String userId);
	/**
	 * 根据角色ID数组，批量删除用户
	 */
	@Delete({"<script>"
			+ "delete from  sys_user where user_id  in (select user_id from  sys_user_role where role_id in ",
			"		<foreach item='roleId' collection='roleIds' open='(' separator=',' close=')'> ",
			"			#{roleId} " ,
			"		</foreach>)" ,
			"</script>"})
	int deleteUserBatch(@Param("roleIds") String[] roleIds);
}
