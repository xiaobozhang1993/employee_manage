package com.xiaobo.modules.sys.controller;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.xiaobo.common.entity.SysUser;
import com.xiaobo.common.enums.UserType;
import com.xiaobo.common.log.annotation.SysLog;
import com.xiaobo.common.log.annotation.SysModule;
import com.xiaobo.common.utils.Constant;
import com.xiaobo.common.utils.PageUtils;
import com.xiaobo.common.utils.R;
import com.xiaobo.common.utils.RsaUtils;
import com.xiaobo.common.validator.Assert;
import com.xiaobo.common.validator.ValidatorUtils;
import com.xiaobo.common.validator.group.AddGroup;
import com.xiaobo.common.validator.group.UpdateGroup;
import com.xiaobo.modules.sys.entity.SysUserEntity;
import com.xiaobo.modules.sys.form.PasswordForm;
import com.xiaobo.modules.sys.service.SysDictService;
import com.xiaobo.modules.sys.service.SysOrganizationService;
import com.xiaobo.modules.sys.service.SysUserRoleService;
import com.xiaobo.modules.sys.service.SysUserService;
import com.xiaobo.sys.controller.AbstractController;
import io.swagger.annotations.ApiOperation;
import org.apache.commons.lang.ArrayUtils;
import org.apache.commons.lang.RandomStringUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.apache.shiro.crypto.hash.Sha256Hash;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;

/**
 * 系统用户
 *
 * zhangxiaobo
 * @email 1920969038@qq.com.com
 * @date 2016年10月31日 上午10:40:10
 */
@RestController
@RequestMapping("/sys/user")
public class SysUserController extends AbstractController {
	@Autowired
	private SysUserService sysUserService;
	@Autowired
	private SysUserRoleService sysUserRoleService;
	@Autowired
	private com.xiaobo.common.security.SecurityUtils securityUtils ;
	@Autowired
	private SysOrganizationService sysOrganizationService;

	@Autowired
	private SysDictService dictService;


	/**
	 * 所有用户列表
	 */
	@GetMapping("/list")
	@RequiresPermissions("sys:user:list")
	public R list(SysUserEntity entity , PageUtils page){
		//只有超级管理员，才能查看所有管理员列表
//		if(!getUserId().equals(Constant.SUPER_ADMIN)){
//			params.put("createUserId", getUserId());
//		}

		PageUtils pageData = sysUserService.queryPage(entity , page);

		return R.ok().put("page", pageData);
	}

	/**
	 * 条件查询
	 */
	@PostMapping("/queryList")
	public R queryList(@RequestBody SysUserEntity entity){

		//这块也要考虑高级机构的主账号，看到数据和admin是一样的
		//查询省高级主账号
		SysUserEntity adminUser = this.sysUserService.getById(Constant.SUPER_ADMIN);
		//admin与省高级机构id一样
		String adminOrgId = adminUser.getOrgId();
		SysUser currUser = getUser();
		if (!"admin".equals(getUserId())){
			if(!(currUser.getOrgId().equals(adminOrgId))){
				//子账号可以看同创建人子账号
				if(currUser.getUserType()== UserType.subUser){
					SysUserEntity currUserEntituy = this.sysUserService.getById(getUserId());
					entity.setCreateUserId(currUserEntituy.getCreateUserId());
				}else{
					entity.setCreateUserId(getUserId());
				}
			}
		}
		entity.setUserId(getUserId());

		List<SysUserEntity> list = sysUserService.queryList(entity);

		return R.ok().put("list", list);
	}

	/**
	 * 获取登录的用户信息
	 */
	@GetMapping("/info")
	public R info(){
		SysUser user = getUser();
		//user.setAppRoleIdList(sysUserService.queryAllAppRoles(user.getUserId()));

		return R.ok().put("user", user);
	}

	/**
	 * 修改登录用户密码
	 */
	@SysLog("修改密码")
	@PostMapping("/password")
	public R password(@RequestBody PasswordForm form){
		Assert.isBlank(form.getNewPassword(), "新密码不为能空");

		//解密
		String o_pass = RsaUtils.decryptByPrivateKey(form.getPassword());
		if(o_pass == null) {
			R.error("原密码不正确");
		}
		String n_pass = RsaUtils.decryptByPrivateKey(form.getNewPassword());
		if(n_pass == null) {
			R.error("新密码格式不正确");
		}

		//sha256加密
		String password = new Sha256Hash(o_pass, getUser().getSalt()).toHex();
		//sha256加密
		String newPassword = new Sha256Hash(n_pass, getUser().getSalt()).toHex();

		//更新密码
		boolean flag = sysUserService.updatePassword(getUserId(), password, newPassword);
		if(!flag){
			return R.error("原密码不正确");
		}

		return R.ok();
	}

	/**
	 * 用户信息
	 */
	@GetMapping("/info/{userId}")
	@RequiresPermissions("sys:user:info")
	public R info(@PathVariable("userId") String userId){
		SysUserEntity user = sysUserService.getById(userId);

		//获取用户所属的角色列表
//		List<String> roleIdList = sysUserRoleService.queryRoleIdList(userId);
//		user.setRoleIdList(roleIdList);



		return R.ok().put("user", user);
	}

	/**
	 * 保存用户
	 */
	@SysLog("保存用户")
	@PostMapping("/save")
	public R save(@RequestBody SysUserEntity user){
		ValidatorUtils.validateEntity(user, AddGroup.class);

		if (1==user.getUserType().getValue()){
			int mainAccountNum = sysUserService.queryMainNum(user.getOrgId());
			if (mainAccountNum>0){
				return R.error("当前单位已经拥有主账号");
			}
		}

		//密码解密
		String pass = RsaUtils.decryptByPrivateKey(user.getPassword());
		String cpass = RsaUtils.decryptByPrivateKey(user.getComfirmPassword());
		if(pass == null) {
			return R.error("密码不能为空");
		}
		if(cpass == null) {
			return R.error("确认密码不能为空");
		}
		if(!pass.equals(cpass)) {
			return R.error("确认密码不正确");
		}
		if(user.getRoleId()==null||user.getRoleId().isEmpty()){
			return R.error("角色不能为空");
		}
		user.setPassword(pass);

		user.setCreateUserId(getUserId());
		sysUserService.saveUser(user);

		return R.ok();
	}

	/**
	 * 修改用户
	 */
	@SysLog("修改用户")
	@PostMapping("/update")
	public R update(@RequestBody SysUserEntity user){
		ValidatorUtils.validateEntity(user, UpdateGroup.class);

		SysUserEntity checkUser = sysUserService.queryById(user.getUserId());
		String orgid = "0";
		if (checkUser!=null){
			orgid = checkUser.getOrgId();
		}
		if (1==checkUser.getUserType().getValue()){
			int mainAccountNum = sysUserService.queryMainNum(user.getOrgId());
			if (mainAccountNum>0&&!user.getOrgId().equals(orgid)){
				return R.error("当前单位已经拥有主账号");
			}
		}
		if(user.getName()==null||user.getName().isEmpty()){
			return R.error("归属人不能为空");
		}
		//admin用户除了自己可以修改以外,其他都不允许修改
		//另外,自己不可以直接在这里修改自己的密码
		String loginUserId = getUserId();
		if(user.getUserId().equals(loginUserId) && user.getPassword() != null && !user.getPassword().trim().isEmpty()) {
			return R.error("当前用户不可以直接在此重置自己的密码!");
		}

		//当前用户非admin 不可以修改admin
		if(!loginUserId.equals(Constant.SUPER_ADMIN) && user.getUserId().equals(Constant.SUPER_ADMIN)) {
			return R.error("普通用户不可以修改超管用户信息");
		}


		//user.setCreateUserId(getUserId());
		sysUserService.update(user);

		return R.ok();
	}

	/**
	 * 删除用户
	 */
	@SysLog("删除用户")
	@PostMapping("/delete")
	public R delete(@RequestBody String[] userIds){
		if(ArrayUtils.contains(userIds, Constant.SUPER_ADMIN)){
			return R.error("系统管理员不能删除");
		}

		if(ArrayUtils.contains(userIds, getUserId())){
			return R.error("当前用户不能删除");
		}

		sysUserService.deleteBatch(userIds);

		return R.ok();
	}

	/**
	 * 密码重置 前提<br>
	 * 1、当前用户不能重置 超管密码<br>
	 * 2、当前用户不能重置自己密码<br>
	 *  0309新
	 *  高级机构账号及admin，可以修改所有账号
	 *  当前账号为主账号的，可以修改自己创建的子账号
	 *  当前用户可以改自己，包括admin
	 * @param userId 用户ID
	 * @param newPass 新密码
	 * @return
	 */
	@SysLog("重置人员账号密码")
	@GetMapping("/resetPass")
	public R resetPass(String userId ,String newPass) {
		Assert.isBlank(userId, "用户不能为空");
		Assert.isBlank(newPass, "密码不能为空");

		//拿到当前用户
		String currUserId = getUserId();
		if(userId.equals(Constant.SUPER_ADMIN) && !currUserId.equals(Constant.SUPER_ADMIN)) {
			return R.error("不能重置超管用户密码");
		}
		//查询省高级主账号
		SysUserEntity adminUser = this.sysUserService.getById(Constant.SUPER_ADMIN);
		//admin与省高级机构id一样
		String adminOrgId = adminUser.getOrgId();
		SysUserEntity currUser = this.sysUserService.getById(currUserId);
		SysUserEntity user = this.sysUserService.getById(userId);
		if(!currUser.getOrgId().equals(adminOrgId)&&!currUserId.equals(Constant.SUPER_ADMIN)&&!currUserId.equals(user.getCreateUserId())&&!currUserId.equals(userId)){
			return R.error("当前用户不能修改该用户密码");
		}


		//密码解密后根据盐值加密
		String dePass = RsaUtils.decryptByPrivateKey(newPass);
		if(dePass == null) {
			return R.error("密码异常");
		}
		/*String password = new Sha256Hash(newPass, user.getSalt()).toHex();*/
		String salt = RandomStringUtils.randomAlphanumeric(20);
		user.setPassword(new Sha256Hash(dePass, salt).toHex());
		user.setSalt(salt);
		//重置
		sysUserService.updateById(user);
		/*sysUserService.resetPass(userId, password);*/

		return R.ok();
	}


	/**
	 * 所有用户列表
	 * 0309，省高级机构及admin，所有用户
	 */
	@GetMapping("/newList")
	public R newList(){

		SysUser user = getUser();
		String  userId = user.getUserId();
		List<SysUserEntity> userlist = new ArrayList<>();
		/*String userid = user.getUserId();*/
		//查询省高级主账号
		SysUserEntity adminUser = this.sysUserService.getById(Constant.SUPER_ADMIN);
		//admin与省高级机构id一样
		String adminOrgId = adminUser.getOrgId();
		//账号管理过滤用户自己
		if (!Constant.SUPER_ADMIN.equals(userId)&&!(user.getOrgId().equals(adminOrgId))){
			SysUserEntity currUser = this.sysUserService.getById(userId);
			QueryWrapper<SysUserEntity> wrapper = new QueryWrapper();
			if(user.getUserType()==UserType.subUser){
				//除省级子账号可以看除自己主账号外所有数据
				wrapper.in(currUser.getCreateUserId() != null,"create_user_id", currUser.getCreateUserId())
						.ne(userId != null,"user_id", userId)
						.orderByAsc("create_time");
			}else{
				wrapper.in(userId != null,"create_user_id", userId)
						.orderByAsc("create_time");
			}

			userlist= sysUserService.list(wrapper);
		}else{
			QueryWrapper<SysUserEntity> wrapper = new QueryWrapper();
			wrapper.ne(userId != null,"user_id", userId)
					.ne(userId != null,"user_id", Constant.SUPER_ADMIN)
					.orderByAsc("create_time");
			userlist= sysUserService.list(wrapper);
		}
		/*if ("admin".equals(userid)){

			userlist = sysUserService.queryUsers();

		}else{
			userlist = sysUserService.queryByCreateID(userid);
		}*/
		boolean isCanDo = false;
		//判断主账号/admin才可以有操作权限
		if(user.getUserType()!= UserType.subUser){
			isCanDo=true;
		}
		return R.ok().put("list", userlist).put("isCanDo",isCanDo);
	}

	/**
	 * 用户信息
	 */
	@GetMapping("/newinfo/{userId}")
	public R newInfo(@PathVariable("userId") String userId){
		SysUserEntity user = sysUserService.getById(userId);

		//获取用户所属的角色列表
		/*List<String> roleIdList = sysUserRoleService.queryRoleIdList(userId);*/
		String roleId = sysUserRoleService.queryRoleId(userId);
		user.setRoleId(roleId);



		return R.ok().put("user", user);
	}

	/**
	 * 获取全部信息
	 * @return
	 */
	@GetMapping("/getinfo")
	public R getInfo(){

		SysUser user = securityUtils.getCurrentUser();

		String userno = user.getUserNo();

		SysUserEntity userinfo = sysUserService.queryByUserNo(userno);

		return R.ok().put("user",userinfo);
	}






	/**
	 * 查询用户信息
	 */
	@GetMapping("/getuser")
	public R getuser(){
		SysUserEntity user = sysUserService.getById(getUserId());
		return R.ok().put("user", user);
	}

	/**
	 * 查询用户信息
	 */
	@GetMapping("/getMainNum")
	public R getMainNum(String orgId,String Id){
		int mainAccountNum = sysUserService.queryMainNum(orgId);
		SysUserEntity user = sysUserService.queryById(Id);
		String orgid = "0";
		if (user!=null){
			orgid = user.getOrgId();
		}
		return R.ok().put("num", mainAccountNum).put("orgid",orgid);
	}
	@SysLog(value="查询用户名是否存在",system = SysModule.sys)
	@RequestMapping("/getUserNoExist")
	@ApiOperation("查询用户名是否存在")
	public R getUserNoExist(String userNo){
		List<SysUserEntity> tmp =  sysUserService.list(new QueryWrapper<SysUserEntity>()
				.eq("user_no", userNo.trim()));
		return  R.ok().put("isExist",tmp.size()>0 ? true :false);
	}
}
