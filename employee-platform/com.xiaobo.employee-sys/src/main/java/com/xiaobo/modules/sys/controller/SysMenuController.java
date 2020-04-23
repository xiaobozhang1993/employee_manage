

package com.xiaobo.modules.sys.controller;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.xiaobo.common.entity.SysUser;
import com.xiaobo.common.enums.MenuType;
import com.xiaobo.common.exception.RRException;
import com.xiaobo.common.log.annotation.SysLog;
import com.xiaobo.common.utils.Constant;
import com.xiaobo.common.utils.R;
import com.xiaobo.modules.sys.entity.SysMenuEntity;
import com.xiaobo.modules.sys.service.*;
import com.xiaobo.sys.controller.AbstractController;
import org.apache.commons.lang.StringUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.*;
import java.util.function.Consumer;
import java.util.stream.Collectors;

/**
 * 系统菜单
 * 
 * zhangxiaobo
 * @date 2017年10月27日 下午9:58:15
 */
@RestController
@RequestMapping("/sys/menu")
public class SysMenuController extends AbstractController {
	@Autowired
	private SysMenuService sysMenuService;
	@Autowired
	private ShiroService shiroService;
	
	@Autowired
	private SysUserService sysUserService ;
	
	@Autowired
	private com.xiaobo.common.security.SecurityUtils securityUtils ;
	@Autowired
	private SysUserRoleService sysUserRoleService;
	@Autowired
	private SysRoleMenuService sysRoleMenuService;

	/**
	 * 导航菜单
	 */
	@GetMapping("/nav")
	public R nav(){
		
		SysUser user = getUser();
		
		List<SysMenuEntity> menuList = sysMenuService.getUserMenuList(user.getUserId());
		Set<String> permissions = shiroService.getUserPermissions(user.getUserId());
		List<SysMenuEntity> departingTools = this.departingTools();

		return R.ok()
				.put("menuList", menuList)
				.put("permissions", permissions)
				.put("departingTools",departingTools);
	}

	/**
	 * 离职人员库的工具栏
	 * */
	public List<SysMenuEntity> departingTools(){
		List<SysMenuEntity> menuList  = new ArrayList<>();
		//离职人员库的工具栏工具栏第一层 工作管理
		SysMenuEntity sysMenuEntityWork = new SysMenuEntity();
		sysMenuEntityWork.setMenuId(UUID.randomUUID().toString().replaceAll("-",""));
		sysMenuEntityWork.setName("工作管理");
		sysMenuEntityWork.setLocationType(2);
		sysMenuEntityWork.setIcon("gzgl");
		sysMenuEntityWork.setType(MenuType.CATALOG);
		sysMenuEntityWork.setRouteOnly(1);
		sysMenuEntityWork.setEnabled(1);

		List<SysMenuEntity> menuList1  = new ArrayList<>();
		sysMenuEntityWork.setList(menuList1);

		//给离职人员库工具栏添加工具
		menuList.add(sysMenuEntityWork);
//		menuList.add(sysMenuEntityMess);
		return menuList;
	}



	/**
	 * 所有菜单列表
	 */
	@GetMapping("/list")
	@RequiresPermissions("sys:menu:list")
	public R list(){
		
		
	 	
		List<SysMenuEntity> menuList = sysMenuService.list();
		
		 
		Map<String, String> parent_name = new HashMap<>();
		menuList.forEach(new Consumer<SysMenuEntity>() {

			@Override
			public void accept(SysMenuEntity t) {
				parent_name.put(t.getMenuId() , t.getName());
				
			}
		});
		
		for(SysMenuEntity sysMenuEntity : menuList){
			String pname = parent_name.get(sysMenuEntity.getParentId());
			if(pname != null){
				sysMenuEntity.setParentName(pname);
			}
		}
		
		// 过滤拆分除工具和菜单
		List<SysMenuEntity> mlist = menuList.stream()
				.filter(m -> m.getLocationType() == 1)
				.sorted( (x , y)-> x.getOrderNum().compareTo(y.getOrderNum()))
				.collect(Collectors.toList());
		
		List<SysMenuEntity> tlist = menuList.stream()
				.filter(m -> m.getLocationType() == 2)
				.sorted( (x , y)-> x.getOrderNum().compareTo(y.getOrderNum()))
				.collect(Collectors.toList());
		
		

		return R.ok().put("mlist", mlist).put("tlist", tlist);
	}

	/**
	 * 登录用户的菜单列表
	 */
	@GetMapping("/newlist")
	public R newList(){
		//获取当前登录ID
		SysUser user = securityUtils.getCurrentUser();

		String userid = user.getUserId();

		List<SysMenuEntity> menuList = new ArrayList<SysMenuEntity>();

		if ("admin".equals(userid)){
		/*if ("admin".equals(userid)){*/
			//获取全部menu
			menuList = sysMenuService.list();
		}else {
			/*//查询自己的roleid
			String roleId = sysUserRoleService.queryRoleId(userid);
			//根据roleid查询menuid
			List<String> menuIds = sysRoleMenuService.queryMenuIdList(roleId);*/
			//根据userid查询menu实体
			menuList = sysMenuService.getMenuListByID(userid);
		}

		Map<String, String> parent_name = new HashMap<>();
		menuList.forEach(new Consumer<SysMenuEntity>() {

			@Override
			public void accept(SysMenuEntity t) {
				parent_name.put(t.getMenuId() , t.getName());

			}
		});

		for(SysMenuEntity sysMenuEntity : menuList){
			String pname = parent_name.get(sysMenuEntity.getParentId());
			if(pname != null){
				sysMenuEntity.setParentName(pname);
			}
		}

		// 过滤拆分除工具和菜单
		List<SysMenuEntity> mlist = menuList.stream()
				.filter(m -> m.getLocationType() == 1)
				.sorted( (x , y)-> x.getOrderNum().compareTo(y.getOrderNum()))
				.collect(Collectors.toList());

		List<SysMenuEntity> tlist = menuList.stream()
				.filter(m -> m.getLocationType() == 2)
				.sorted( (x , y)-> x.getOrderNum().compareTo(y.getOrderNum()))
				.collect(Collectors.toList());

		return R.ok().put("mlist", mlist).put("tlist", tlist);
	}
	
	/**
	 * 根据权限码获取子菜单列表
	 * @param perm权限码
	 * @return
	 */
	@GetMapping("/childByPerm")
	public R childByPerm(String perm) {
		if(StringUtils.isBlank(perm)) return R.error();
		
		QueryWrapper<SysMenuEntity> query = new QueryWrapper<>();
		query.eq("perms", perm);
		
		SysMenuEntity parent = sysMenuService.getOne(query);
		if(parent == null) return R.error();
		
		 
		List<SysMenuEntity> list = sysMenuService.queryListParentId(parent.getMenuId());
		
		if(list != null) {
			// 权限筛选
			String userId = securityUtils.getCurrentUser().getUserId();
			if(!userId.equals(Constant.SUPER_ADMIN)) {
				List<String> userMenuIds = sysUserService.queryAllMenuId(userId);
				// 筛选过滤
				list = list.stream().filter(t->userMenuIds.contains(t.getMenuId())).collect(Collectors.toList());

			}
		}
	
		
		return R.ok().put("data", list);
	}
	
	/**
	 * 根据权限码获取子菜单列表
	 * @param perm权限码
	 * @return
	 */
	@GetMapping("/childById")
	public R childById(String id) {
		if(StringUtils.isBlank(id)) return R.error();
		 
		List<SysMenuEntity> list = sysMenuService.queryListParentId(id);
		
		if(list != null) {
			// 权限筛选 
			String userId = securityUtils.getCurrentUser().getUserId();
			if(!userId.equals(Constant.SUPER_ADMIN)) {
				List<String> userMenuIds = sysUserService.queryAllMenuId(userId);
				// 筛选过滤
				list = list.stream().filter(t->userMenuIds.contains(t.getMenuId())).collect(Collectors.toList());

			}
		}
		
		return R.ok().put("data", list);
	}
	
	
	/**
	 * 选择菜单(添加、修改菜单)
	 */
	@GetMapping("/select")
	@RequiresPermissions("sys:menu:select")
	public R select(){
		//查询列表数据
		List<SysMenuEntity> menuList = sysMenuService.queryNotButtonList();
		
		// 拆解菜单栏和工具栏

		List<SysMenuEntity> mlist = menuList.stream().filter(m -> m.getLocationType() == 1).collect(Collectors.toList());
		{
			//添加顶级菜单
			SysMenuEntity root = new SysMenuEntity();
			root.setMenuId("0");
			root.setName("一级菜单");
			root.setParentId("-1");
			root.setOpen(true);
			mlist.add(root);
		}
		
		List<SysMenuEntity> tlist = menuList.stream().filter(m -> m.getLocationType() == 2).collect(Collectors.toList());
		{
			//添加顶级菜单
			SysMenuEntity root = new SysMenuEntity();
			root.setMenuId("0");
			root.setName("一级工具");
			root.setParentId("-1");
			root.setOpen(true);
			tlist.add(root);
		}
		
		
		return R.ok().put("menuList", mlist).put("toolList", tlist);
	}
	
	/**
	 * 菜单信息
	 */
	@GetMapping("/info/{menuId}")
	@RequiresPermissions("sys:menu:info")
	public R info(@PathVariable("menuId") String menuId){
		SysMenuEntity menu = sysMenuService.getById(menuId);
		return R.ok().put("menu", menu);
	}
	
	/**
	 * 保存
	 */
	@SysLog("保存菜单")
	@PostMapping("/save")
	@RequiresPermissions("sys:menu:save")
	public R save(@RequestBody SysMenuEntity menu){
		//数据校验
		verifyForm(menu);
		
		sysMenuService.save(menu);
		
		return R.ok();
	}
	
	/**
	 * 修改
	 */
	@SysLog("修改菜单")
	@PostMapping("/update")
	@RequiresPermissions("sys:menu:update")
	public R update(@RequestBody SysMenuEntity menu){
		//数据校验
		verifyForm(menu);
				
		sysMenuService.updateById(menu);
		
		return R.ok();
	}
	
	/**
	 * 删除
	 */
	@SysLog("删除菜单")
	@PostMapping("/delete/{menuId}")
	@RequiresPermissions("sys:menu:delete")
	public R delete(@PathVariable("menuId") String menuId){
		/*if(menuId <= 31){
			return R.error("系统菜单，不能删除");
		}
*/
		//判断是否有子菜单或按钮
		List<SysMenuEntity> menuList = sysMenuService.queryListParentId(menuId);
		if(menuList.size() > 0){
			return R.error("请先删除子菜单或按钮");
		}

		sysMenuService.delete(menuId);

		return R.ok();
	}
	
	/**
	 * 验证参数是否正确
	 */
	private void verifyForm(SysMenuEntity menu){
		if(StringUtils.isBlank(menu.getName())){
			throw new RRException("菜单名称不能为空");
		}
		
		if(menu.getParentId() == null){
			throw new RRException("上级菜单不能为空");
		}
		
		//菜单
		if(menu.getType() == MenuType.MENU){
			if(StringUtils.isBlank(menu.getUrl())){
				throw new RRException("菜单URL不能为空");
			}
		}
		
		//上级菜单类型
		/*MenuType parentType = MenuType.CATALOG;
		if(!menu.getParentId().equals("0")){
			SysMenuEntity parentMenu = sysMenuService.getById(menu.getParentId());
			parentType = parentMenu.getType();
		}
		
		//目录、菜单
		if(menu.getType() == MenuType.CATALOG  ||
				menu.getType() == MenuType.MENU ){
			if(parentType != MenuType.CATALOG ){
				throw new RRException("上级菜单只能为目录类型");
			}
			return ;
		}
		
		//按钮
		if(menu.getType() == MenuType.BUTTON ){
			if(parentType != MenuType.MENU ){
				throw new RRException("上级菜单只能为菜单类型");
			}
			return ;
		}*/
	}
}
