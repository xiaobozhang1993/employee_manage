
package com.xiaobo.modules.sys.service.impl;


import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.xiaobo.common.entity.SysUser;
import com.xiaobo.common.redis.RedisUtils;
import com.xiaobo.common.utils.Constant;
import com.xiaobo.common.utils.MapUtils;
import com.xiaobo.modules.sys.dao.SysMenuDao;
import com.xiaobo.modules.sys.entity.SysMenuEntity;
import com.xiaobo.modules.sys.service.SysMenuService;
import com.xiaobo.modules.sys.service.SysRoleMenuService;
import com.xiaobo.modules.sys.service.SysUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.stream.Collectors;


@Service
public class SysMenuServiceImpl extends ServiceImpl<SysMenuDao, SysMenuEntity> implements SysMenuService {
	@Autowired
	private SysUserService sysUserService;
	@Autowired
	private SysRoleMenuService sysRoleMenuService;
	@Autowired
	private com.xiaobo.common.security.SecurityUtils securityUtils ;
	
/*	@Autowired
	private SysUserTokenService userTokenService;
	*/
	
	@Autowired
	private RedisUtils redisUtils ;
	
	 
	public List<SysMenuEntity> queryListParentId(String parentId, List<String> menuIdList , List<SysMenuEntity> allMenu) {
		List<SysMenuEntity> menuList = allMenu.stream().
					filter(t-> (menuIdList != null ? menuIdList.contains(t.getMenuId()) : true ) && (t.getParentId() != null ? t.getParentId().equals(parentId) : true ))
					.sorted((t1 , t2)-> t1.getOrderNum().compareTo(t2.getOrderNum()))
					.collect(Collectors.toList());
		 
		/*if(menuIdList == null){
			return menuList;
		}
		
		List<SysMenuEntity> userMenuList = new ArrayList<>();
		for(SysMenuEntity menu : menuList){
			if(menuIdList.contains(menu.getMenuId())){
				userMenuList.add(menu);
			}
		}*/
		return menuList;
	}

	

	@Override
	public List<SysMenuEntity> queryNotButtonList() {
		return baseMapper.queryNotButtonList();
	}

 
	@Override
	@Cacheable(value="tr",  key="methodName + '-' + #userId" )
	public List<SysMenuEntity> getUserMenuList(String userId) {
		
		/*String token = userTokenService.queryTokenByUserId(userId);
		String key = getClass().getSimpleName() + "-getUserMenuList-" + userId;
		if(token != null) { 
			//redis 判断
			if(redisUtils.containKey(key)) {
				return redisUtils.get(key , List.class);
			}
		}*/
		 
		List<SysMenuEntity> list = new ArrayList<>();
		//系统管理员，拥有最高权限
		if(userId.equals(Constant.SUPER_ADMIN)|| userId.equals("6f6c2e30ee6f4379b39435cbfda70647") ){
			list = getAllMenuList(null);
		} else {
			//用户菜单列表
			List<String> menuIdList = sysUserService.queryAllMenuId(userId);
			list = getAllMenuList(menuIdList);
		}
		 
		
		
		/*if(token != null) {
			//redis 缓存
			redisUtils.set(key, list);
		}*/
		
		
		return list ;
	}
	
	@Cacheable(value="tr")
	public List<SysMenuEntity> getAllMenu() {
		
		String key = getClass().getSimpleName() +  "-getAllMenu";
		if(redisUtils.containKey(key)) {
			return redisUtils.get(key, List.class);
		}
		 
		
		List<SysMenuEntity> list = super.list();
		
		redisUtils.set(key, list , 5*60);
		
		return list ;
	}
	
	@Override
	public void delete(String menuId){
		//删除菜单
		this.removeById(menuId);
		//删除菜单与角色关联
		sysRoleMenuService.removeByMap(new MapUtils().put("menu_id", menuId));
		
		clearCache();
		
	}

	/**
	 * 获取所有菜单列表
	 */
	private List<SysMenuEntity> getAllMenuList(List<String> menuIdList){
		
		// 拿到所有菜单
		List<SysMenuEntity> allMenu = getAllMenu();
		if(allMenu == null || allMenu.isEmpty()) return Collections.emptyList() ;

		SysUser user = securityUtils.getCurrentUser();
		List<String> pid = this.baseMapper.queryParent(user.getUserId());
		if (!pid.isEmpty()&&null != menuIdList){
			menuIdList.removeAll(pid);
			menuIdList.addAll(pid);
		}
		//查询根菜单列表
		List<SysMenuEntity> menuList = queryListParentId("0", menuIdList ,allMenu);
		/*List<String> pid = new ArrayList<>();
		if(menuList.isEmpty()&&!menuIdList.isEmpty()){
			SysUser user = securityUtils.getCurrentUser();
			pid = this.baseMapper.queryParent(user.getUserId());
			menuIdList.removeAll(pid);
			menuIdList.addAll(pid);
			menuList = queryListParentId("0", menuIdList ,allMenu);
		}*/
		//递归获取子菜单
		getMenuTreeList(menuList, menuIdList ,allMenu);
		
		return menuList;
	}

	/**
	 * 递归
	 */
	private List<SysMenuEntity> getMenuTreeList(List<SysMenuEntity> menuList, List<String> menuIdList , List<SysMenuEntity> allMenu){
		List<SysMenuEntity> subMenuList = new ArrayList<SysMenuEntity>();
		
		for(SysMenuEntity entity : menuList){
			//目录
			//if(entity.getType().getValue() <= MenuType.CATALOG.getValue()){
				entity.setList(getMenuTreeList(queryListParentId(entity.getMenuId(), menuIdList,allMenu), menuIdList ,allMenu));
			//}
			subMenuList.add(entity);
		}
		
		return subMenuList;
	}
	
	@Override
	public List<SysMenuEntity> queryListParentId(String parentId) {
		
		
		
		return baseMapper.queryListParentId(parentId);
	}

	@Override
	public void clearCache() {
		//每次删除之后直接清空当前类下的所有缓存
		redisUtils.deletePattern(getClass().getSimpleName() + "*");
		
	}

	@Override
	public List<SysMenuEntity> getMenuListByID(String userId){

		List<SysMenuEntity> lists = new ArrayList<SysMenuEntity>();

		lists = this.baseMapper.queryMenuById(userId);

		return lists;
	}
}
