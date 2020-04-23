package com.xiaobo.modules.sys.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.xiaobo.common.exception.RRException;
import com.xiaobo.common.form.LoginForm;
import com.xiaobo.common.redis.RedisUtils;
import com.xiaobo.common.utils.*;
import com.xiaobo.common.validator.Assert;
import com.xiaobo.modules.sys.dao.SysUserDao;
import com.xiaobo.modules.sys.entity.SysUserEntity;
import com.xiaobo.modules.sys.service.ShiroService;
import com.xiaobo.modules.sys.service.SysUserRoleService;
import com.xiaobo.modules.sys.service.SysUserService;
import com.xiaobo.modules.sys.service.SysUserTokenService;
import org.apache.commons.lang.RandomStringUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.shiro.crypto.hash.Sha256Hash;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;


/**
 * 系统用户
 * 
 * zhangxiaobo
 * @date 2016年9月18日 上午9:46:09
 */
@Service
public class SysUserServiceImpl extends ServiceImpl<SysUserDao, SysUserEntity> implements SysUserService {
	@Autowired
	private SysUserRoleService sysUserRoleService;
//	@Autowired
//	private SysRoleService sysRoleService;
	
	/**
	 * 缓存基于token,这样每次登陆后重新拉取数据,避免根据用户之后任意的修改导致数据没有清退机制
	 */
	@Autowired
	private SysUserTokenService tokenService ;
	
	@Autowired
	private ShiroService shiroService;
	
	@Autowired
	private RedisUtils redisUtils ;
	
	@Autowired
	private JwtUtils jwtUtils ;

	
	@Override
	public PageUtils queryPage(SysUserEntity entity , PageUtils page) {
		String username = entity.getUsername();// (String)params.get("username"); 
		//String createUserId = (String)params.get("createUserId");

		IPage<SysUserEntity> ipage = this.page(
			new Query<SysUserEntity>(page).getPage(),
			new QueryWrapper<SysUserEntity>()
				.like(StringUtils.isNotBlank(username),"username", username)
				//.eq(createUserId != null,"create_user_id", createUserId)
		);

		return new PageUtils(ipage);
	}

	@Override
	public List<SysUserEntity> queryList(SysUserEntity entity) {
		String username = entity.getUsername();
		String createUserId = entity.getCreateUserId();
		QueryWrapper<SysUserEntity> wrapper = new QueryWrapper();
		wrapper.like(StringUtils.isNotBlank(username),"username", username)
				.eq(createUserId != null,"create_user_id", createUserId)
				.eq(entity.getUserTypeValue() != null,"user_type", entity.getUserTypeValue())
				//不查当前用户
				.ne(entity.getUserId() != null,"user_id", entity.getUserId())
				//不查admin
				.ne(entity.getUserId() != null,"user_id", Constant.SUPER_ADMIN)
				.orderByAsc("create_time");
		List<SysUserEntity> list = this.baseMapper.selectList(wrapper);

		return list;
	}

	@SuppressWarnings("unchecked")
	@Override
	public Set<String> queryAllPerms(String userId) {
		
		//拿到用户token
		String token = tokenService.queryTokenByUserId(userId);
		String key = getClass().getSimpleName() + "-queryAllPerms-" + token ;
		if(token != null) {
			 
			if(redisUtils.containKey(key)) {
				return redisUtils.get(key , Set.class);
			}
		}
		 
		Set<String> list = shiroService.getUserPermissions(userId);
		
		if(token != null) {
			redisUtils.set(key, list);
		}
		
		return list ;
	}
	
	

	@SuppressWarnings("unchecked")
	@Override
	public List<String> queryAllMenuId(String userId) {
		 
		//拿到用户token
		String token = tokenService.queryTokenByUserId(userId);
		String key = getClass().getSimpleName() + "-queryAllMenuId-" + token ;
		if(token != null) {

			if(redisUtils.containKey(key)) {
				return redisUtils.get(key , List.class);
			}
		}
		
		

		List<String> list = baseMapper.queryAllMenuId(userId);

		if(token != null) {
			redisUtils.set(key, list);
		}

		return list ;  
	}

	@Override
	public SysUserEntity queryByUserNo(String userNo) {
		String key = getClass().getSimpleName() + "-no-" + userNo ;
		if(redisUtils.containKey(key)) {
			return redisUtils.get(key , SysUserEntity.class);
		}
		SysUserEntity sae = baseMapper.queryByUserNo(userNo);
		
		redisUtils.set(key, sae);
		
		return sae ;
	}
  
//	@Transactional
//	public boolean save(SysUserEntity user) {
//
//
//
//		user.setCreateTime(new Date());
//		//sha256加密
//		String salt = RandomStringUtils.randomAlphanumeric(20);
//		user.setPassword(new Sha256Hash(user.getPassword(), salt).toHex());
//		user.setSalt(salt);
//		boolean s = this.save(user);
//
//		//检查角色是否越权
//		checkRole(user);
//
//		//保存用户与角色关系
//		//sysUserRoleService.saveOrUpdate(user.getUserId(), user.getRoleIdList());
//
//
//		String key = getClass().getSimpleName() + "-no-" + user.getUserNo() ;
//		if(redisUtils.containKey(key)) {
//			redisUtils.delete(key);
//		}
//		return s ;
//	}

	@Override
	@Transactional
	public void update(SysUserEntity user) {
		
		if(StringUtils.isBlank(user.getPassword())){
			user.setPassword(null);
		}else{
			//密码解密
			String pass = RsaUtils.decryptByPrivateKey(user.getPassword());
			if(pass != null && !pass.isEmpty()){
				String salt = RandomStringUtils.randomAlphanumeric(20);
				user.setPassword(new Sha256Hash(pass, salt).toHex());
				user.setSalt(salt);
			}

			else {
				user.setPassword(null);
			}
		}

		if(user.getRoleId()!=null){
            //保存用户与角色关系
            sysUserRoleService.newSaveOrUpdate(user.getUserId(), user.getRoleId());
        }



		this.updateById(user);
		
		
		//检查角色是否越权
		//checkRole(user);
		
		//保存用户与角色关系
		//sysUserRoleService.saveOrUpdate(user.getUserId(), user.getRoleIdList());
		 
		
		
	}

	@Override
	public void deleteBatch(String[] userId) {
		this.removeByIds(Arrays.asList(userId));
	}

	@Override
	public boolean updatePassword(String userId, String password, String newPassword) {
		SysUserEntity userEntity = new SysUserEntity();
		userEntity.setPassword(newPassword);
		return this.update(userEntity,
				new QueryWrapper<SysUserEntity>().eq("user_id", userId).eq("password", password));
	}
	
	/**
	 * 检查角色是否越权
	 */
	private void checkRole(SysUserEntity user){
		/*if(user.getRoleIdList() == null || user.getRoleIdList().size() == 0){
			return;
		}*/
		//如果不是超级管理员，则需要判断用户的角色是否自己创建
		/*if(user.getCreateUserId().equals(Constant.SUPER_ADMIN)){
			return ;
		}*/
		
		/*//查询用户创建的角色列表
		List<Long> roleIdList = sysRoleService.queryRoleIdList(user.getCreateUserId());

		//判断是否越权
		if(!roleIdList.containsAll(user.getRoleIdList())){
			throw new RRException("新增用户所选角色，不是本人创建");
		}*/
	}

	@Override
	public boolean resetPass(String userId, String newPass) {
		 baseMapper.resetPass(userId, newPass);
		
		return true;
	}

	@Override
	public R appLogin(LoginForm form) {
		SysUserEntity user = queryByUserNo(form.getUserNo());
		Assert.isNull(user, "账号或密码错误");

		//密码错误
		String pass = new Sha256Hash(form.getPassword(), user.getSalt()).toHex();
		if(!user.getPassword().equals(pass)){
			throw new RRException("账号或密码错误");
		}
		
		//账号锁定
		if(user.getStatus() == 0){
			return R.error("账号已被锁定,请联系管理员");
		}

		//生成token
		String token = jwtUtils.generateToken(user.getUserId());


		Map<String, Object> map = new HashMap<>();
		map.put("token", token);
		map.put("expire", jwtUtils.getExpire());
		
		Set<String> appPerms = shiroService.getUserPermissions(user.getUserId());
		//给用户权限列表
		 
		 map.put("perms", appPerms);
			 
		 
		
		//redis缓存token到用户的映射
		redisUtils.set(getClass().getSimpleName() + "-u-t-" + user.getUserId(), token);
		redisUtils.set(getClass().getSimpleName() + "-t-u-" + token, user);
		redisUtils.set(getClass().getSimpleName() + "-t-p-" + token, appPerms);

		user.setPassword(null);
		//带上用户 
		
		map.put("user", user);
		
		return R.ok(map);
	
 
	}

    @Override
    public void saveUser(SysUserEntity user) {
		user.setCreateTime(new Date());
		//sha256加密
		String salt = RandomStringUtils.randomAlphanumeric(20);
		user.setPassword(new Sha256Hash(user.getPassword(), salt).toHex());
		user.setSalt(salt);

		List<SysUserEntity> tmp =  this.list(new QueryWrapper<SysUserEntity>()
				.eq("user_no", user.getUserNo().trim()));

		if(tmp != null && tmp.size() > 0) {
			throw new RRException("该账号已存在，请修改");
		}

		this.save(user);

		//检查角色是否越权
		checkRole(user);

		//保存用户与角色关系
		sysUserRoleService.newSaveOrUpdate(user.getUserId(), user.getRoleId());



		String key = getClass().getSimpleName() + "-no-" + user.getUserNo() ;
		if(redisUtils.containKey(key)) {
			redisUtils.delete(key);
		}
    }



	@Override
	public List<SysUserEntity> queryByCreateID(String createuserid){

		return baseMapper.queryByCreateID(createuserid);
	}

	@Override
	public List<SysUserEntity> queryUsers(){

		return baseMapper.queryUsers();
	}

	@Override
	public void updateLastDate(SysUserEntity user) {
		baseMapper.updateById(user);
	}

	@Override
	public int queryMainNum(String orgId){ return baseMapper.queryMainNum(orgId);}

	@Override
	public List<SysUserEntity> queryByOrgParent(String orgId,String currUserId){return baseMapper.queryByOrgParent(orgId,currUserId);}

	public SysUserEntity queryById(String id){ return  baseMapper.queryById(id);}
}
