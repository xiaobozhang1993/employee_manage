package com.xiaobo.modules.sys.dao;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.xiaobo.modules.sys.entity.SysRoleEntity;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.List;

/**
 * 角色管理
 * 
 * zhangxiaobo
 * @date 2016年9月18日 上午9:33:33
 */
@Mapper
public interface SysRoleDao extends BaseMapper<SysRoleEntity> {
	
	/**
	 * 查询用户创建的角色ID列表
	 */
	@Select("select role_id from sys_role where create_user_id = #{createUserId} ")
	List<Long> queryRoleIdList(@Param("createUserId") String createUserId);

	/**
	 * 查询用户创建的角色列表
	 */
	@Select("select role_id,role_name,remark,create_user_id,create_time from sys_role where create_user_id = #{createUserId}")
	List<SysRoleEntity> queryRoleList(@Param("createUserId") String createUserId);
}
