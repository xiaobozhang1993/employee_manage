package com.xiaobo.modules.sys.dao;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.xiaobo.modules.sys.entity.SysRoleMenuEntity;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.List;

/**
 * 角色与菜单对应关系
 * 
 * zhangxiaobo
 * @email 1920969038@qq.com.com
 * @date 2016年9月18日 上午9:33:46
 */
@Mapper
public interface SysRoleMenuDao extends BaseMapper<SysRoleMenuEntity> {
	
	/**
	 * 根据角色ID，获取菜单ID列表
	 */
	@Select("select menu_id from sys_role_menu where role_id = #{roleId}")
	List<String> queryMenuIdList(@Param("roleId") String roleId);

	/**
	 * 根据角色ID数组，批量删除
	 */
	@Delete({"<script>",
			"delete from sys_role_menu where role_id in " , 
			"		<foreach item='roleId' collection='roleIds' open='(' separator=',' close=')'> " , 
			"			#{roleId}" , 
			"		</foreach>",
			"</script>"})
	int deleteBatch(@Param("roleIds") String[] roleIds);
}
