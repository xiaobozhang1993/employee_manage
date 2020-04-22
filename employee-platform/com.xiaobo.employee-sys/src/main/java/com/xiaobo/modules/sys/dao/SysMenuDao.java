

package com.xiaobo.modules.sys.dao;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.xiaobo.modules.sys.entity.SysMenuEntity;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.List;

/**
 * 菜单管理
 * 
 * zhangxiaobo
 * @email 1920969038@qq.com.com
 * @date 2016年9月18日 上午9:33:01
 */
@Mapper
public interface SysMenuDao extends BaseMapper<SysMenuEntity> {
	
	/**
	 * 根据父菜单，查询子菜单
	 * @param parentId 父菜单ID
	 */
	@Select("select * from sys_menu where parent_id = #{parentId} and enabled = 1 order by order_num asc")
	List<SysMenuEntity> queryListParentId(@Param("parentId") String parentId);
	
	/**
	 * 获取不包含按钮的菜单列表
	 */
	@Select("select * from sys_menu where type != 2 and enabled = 1 order by order_num asc")
	List<SysMenuEntity> queryNotButtonList();

	/**
	 * 通过ID获取菜单列表
	 */
	@Select("select f.* FROM sys_menu f RIGHT JOIN (" +
			" select distinct c.menu_id from sys_role_menu c RIGHT JOIN" +
			" (SELECT b.role_id FROM sys_user a " +
			" LEFT JOIN sys_user_role b ON a.user_id = b.user_id" +
			" where a.user_id = #{userId}) d on  c.role_id = d .role_id ) e on  f.menu_id = e.menu_id")
	List<SysMenuEntity> queryMenuById(String userId);

	@Select("SELECT distinct parent_id FROM sys_menu WHERE menu_id IN " +
			"(select menu_id from sys_role_menu rm LEFT JOIN sys_user_role ur on " +
			"rm.role_id = ur.role_id where ur.user_id = #{userid} )")
	List<String> queryParent(String userid);
}
