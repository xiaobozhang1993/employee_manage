package com.xiaobo.modules.sys.controller;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.xiaobo.common.entity.SysUser;
import com.xiaobo.common.enums.UserType;
import com.xiaobo.common.log.annotation.SysLog;
import com.xiaobo.common.utils.Constant;
import com.xiaobo.common.utils.PageUtils;
import com.xiaobo.common.utils.R;
import com.xiaobo.common.validator.ValidatorUtils;
import com.xiaobo.modules.sys.entity.SysRoleEntity;
import com.xiaobo.modules.sys.entity.SysUserEntity;
import com.xiaobo.modules.sys.service.SysRoleMenuService;
import com.xiaobo.modules.sys.service.SysRoleService;
import com.xiaobo.modules.sys.service.SysUserService;
import com.xiaobo.sys.controller.AbstractController;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.Collection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 角色管理
 * 
 * zhangxiaobo
 * @email 1920969038@qq.com.com
 * @date 2016年11月8日 下午2:18:33
 */
@RestController
@RequestMapping("/sys/role")
public class SysRoleController extends AbstractController {
	@Autowired
	private SysRoleService sysRoleService;
	@Autowired
	private SysRoleMenuService sysRoleMenuService;
	@Autowired
	private SysUserService sysUserService;
	@Autowired
	private com.xiaobo.common.security.SecurityUtils securityUtils ;

	/**
	 * 角色列表-新修改的注释
	 */
	@GetMapping("/list")
	public R list(SysRoleEntity entity , PageUtils page){
		//如果不是超级管理员，则只查询自己创建的角色列表
//		if(!getUserId().equals(Constant.SUPER_ADMIN) ){
//			params.put("createUserId", getUserId());
//		}

		PageUtils pageData = sysRoleService.queryPage(entity , page);

		return R.ok().put("page", pageData);
	}
	
	/**
	 * 角色列表
	 */
	@GetMapping("/select")
	public R select(){
		Map<String, Object> map = new HashMap<>();
		
		//如果不��超级管理员，则只查询自己所拥有的角色列表
//		if(!getUserId().equals(Constant.SUPER_ADMIN)){
//			map.put("createUserId", getUserId());
//		}
		Collection<SysRoleEntity> list = sysRoleService.listByMap(map);
		
		return R.ok().put("list", list);
	}
	
	/**
	 * 角色信息
	 */
	@GetMapping("/info/{roleId}")
	public R info(@PathVariable("roleId") String roleId){
		SysRoleEntity role = sysRoleService.getById(roleId);
		
		//查询角色对应的菜单
		List<String> menuIdList = sysRoleMenuService.queryMenuIdList(roleId);


		role.setMenuIdList(menuIdList);
		
		return R.ok().put("role", role);
	}
	
	/**
	 * 保存角色
	 */
	@SysLog("保存角色")
	@PostMapping("/save")
	public R save(@RequestBody SysRoleEntity role){
		ValidatorUtils.validateEntity(role);
		
		role.setCreateUserId(getUserId());
		sysRoleService.save(role);
		
		return R.ok();
	}
	
	/**
	 * 修改角色
	 */
	@SysLog("修改角色")
	@PostMapping("/update")
	public R update(@RequestBody SysRoleEntity role){
		ValidatorUtils.validateEntity(role);
		
		role.setCreateUserId(getUserId());
		sysRoleService.update(role);
		
		return R.ok();
	}
	
	/**
	 * 删除角色
	 */
	@SysLog("删除角色")
	@PostMapping("/delete")
	public R delete(@RequestBody String[] roleIds){
		sysRoleService.deleteBatch(roleIds);
		
		return R.ok();
	}

	/**
	 * 角色列表
	 */
	@GetMapping("/newlist")
	public R newList(){

		SysRoleEntity sr = new SysRoleEntity();

		SysUser user = securityUtils.getCurrentUser();

		String userid = user.getUserId();

		List<SysRoleEntity> roleList = sysRoleService.queryRoleList(userid);
		boolean isCanDo = false;
		//判断主账号/admin才可以有操作权限
		if(user.getUserType()!= UserType.subUser){
			isCanDo=true;
		}
		return R.ok().put("roleList", roleList).put("isCanDo",isCanDo);
	}
	/**
	 *  @author: zhangxiaobo
	 *  @Date: 2020/3/13 15:02
	 *  @Description:判断是否添加过角色
	 */
	@GetMapping("/isCreateRoles")
    public R isCreateRoles(){
        boolean isCreateRoles = false;
		SysUser user = securityUtils.getCurrentUser();
		if(user.getUserType()!= UserType.subUser){
            //判断是否已创建角色
			List<SysRoleEntity> sysRoleEntities = sysRoleService.queryRoleList(user.getUserId());
			if(!sysRoleEntities.isEmpty()){
				isCreateRoles = true;
			}
        }
        return R.ok().put("isCreateRoles",isCreateRoles);
    }
    /**
     *  @author: zhangxiaobo
     *  @Date: 2020/3/13 16:30
     *  @Description:
	 *  新增传值为空
     */
	@GetMapping("/getRolesByOrgId")
    public R getRolesByUserId(@RequestParam("userId") String userId, @RequestParam("orgId") String orgId){
		//查询省高级主账号
		SysUserEntity adminUser = this.sysUserService.getById(Constant.SUPER_ADMIN);
		//admin与省高级机构id一样
		String adminOrgId = adminUser.getOrgId();
		//当前登录用户
		SysUser currUser = getUser();
		//被操作的用户
		SysUserEntity sysUserEntity1 = sysUserService.queryById(userId);
		//如果新增
		if(userId.isEmpty()&&orgId.isEmpty()){
			//admin，省高级
			/*if(Constant.SUPER_ADMIN.equals(getUserId())){
				//省高级主账号
				QueryWrapper<SysUserEntity> sysUserEntityQueryWrapper = new QueryWrapper<>();
				sysUserEntityQueryWrapper.eq("org_id",adminOrgId)
						.eq("user_type",UserType.primaryUser);
				SysUserEntity topUser = sysUserService.getOne(sysUserEntityQueryWrapper);

				QueryWrapper<SysRoleEntity> sysRoleEntityQueryWrapper = new QueryWrapper<>();
				sysRoleEntityQueryWrapper.in("create_user_id",new String[]{Constant.SUPER_ADMIN,null!= topUser ?topUser.getUserId() : ""});
				List<SysRoleEntity> list = sysRoleService.list(sysRoleEntityQueryWrapper);
				return R.ok().put("roleList",list);
			}else{
				List<SysRoleEntity> roleList = sysRoleService.queryRoleList(getUserId());
				return R.ok().put("roleList",roleList);
			}*/
			//只查询当前用户
			List<SysRoleEntity> roleList = sysRoleService.queryRoleList(getUserId());
			return R.ok().put("roleList",roleList);
		}
		//如果修改
		//当前操作用户是admin或者省高级主账号，并且修改主账号 要综合二者的权限给主账号
		if(sysUserEntity1.getUserType()==UserType.primaryUser && (Constant.SUPER_ADMIN.equals(getUserId()) || (currUser.getUserType()==UserType.primaryUser &&currUser.getOrgId().equals(adminOrgId)))){
			//省高级主账号
//			QueryWrapper<SysUserEntity> sysUserEntityQueryWrapper = new QueryWrapper<>();
//			sysUserEntityQueryWrapper.eq("org_id",adminOrgId)
//					.eq("user_type",UserType.primaryUser);
//			SysUserEntity topUser = sysUserService.getOne(sysUserEntityQueryWrapper);
//
//			QueryWrapper<SysRoleEntity> sysRoleEntityQueryWrapper = new QueryWrapper<>();
//			sysRoleEntityQueryWrapper.in("create_user_id",new String[]{Constant.SUPER_ADMIN,null!=topUser ? topUser.getUserId() : ""});
//			List<SysRoleEntity> list = sysRoleService.list(sysRoleEntityQueryWrapper);
//			return R.ok().put("roleList",list);
			//只查询当前用户
			List<SysRoleEntity> roleList = sysRoleService.queryRoleList(getUserId());
			return R.ok().put("roleList",roleList);
		}else{
			//子账号动态显示
			QueryWrapper<SysUserEntity> sysUserEntityQueryWrapper = new QueryWrapper<>();
			sysUserEntityQueryWrapper.eq("org_id",orgId)
					.eq("user_type",UserType.primaryUser);
			SysUserEntity sysUserEntity = sysUserService.getOne(sysUserEntityQueryWrapper);
			List<SysRoleEntity> roleList = sysRoleService.queryRoleList(sysUserEntity.getUserId());
			return R.ok().put("roleList",roleList);
		}
	}
}
