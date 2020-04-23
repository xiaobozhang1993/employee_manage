package com.xiaobo.modules.sys.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.xiaobo.common.exception.RRException;
import com.xiaobo.common.utils.Constant;
import com.xiaobo.common.utils.PageUtils;
import com.xiaobo.common.utils.Query;
import com.xiaobo.modules.sys.dao.SysRoleDao;
import com.xiaobo.modules.sys.dao.SysUserDao;
import com.xiaobo.modules.sys.entity.SysRoleEntity;
import com.xiaobo.modules.sys.entity.SysUserEntity;
import com.xiaobo.modules.sys.entity.SysUserRoleEntity;
import com.xiaobo.modules.sys.service.SysRoleMenuService;
import com.xiaobo.modules.sys.service.SysRoleService;
import com.xiaobo.modules.sys.service.SysUserRoleService;
import com.xiaobo.modules.sys.service.SysUserService;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * 角色
 * 
 * zhangxiaobo
 * @email 1920969038@qq.com.com
 * @date 2016年9月18日 上午9:45:12
 */
@Service
public class SysRoleServiceImpl extends ServiceImpl<SysRoleDao, SysRoleEntity> implements SysRoleService {
	@Autowired
	private SysRoleMenuService sysRoleMenuService;
	@Autowired
	private SysUserService sysUserService;
    @Autowired
    private SysUserRoleService sysUserRoleService;
    
    @Autowired
    private SysUserDao sysUserDao;

	@Override
	public PageUtils queryPage(SysRoleEntity entity , PageUtils page) {
		String roleName = entity.getRoleName() ;// (String)params.get("roleName");
		//String createUserId =  (String)params.get("createUserId");

		IPage<SysRoleEntity> ipage = this.page(
			new Query<SysRoleEntity>(page).getPage(),
			new QueryWrapper<SysRoleEntity>()
				.like(StringUtils.isNotBlank(roleName),"role_name", roleName)
				//.eq(createUserId != null,"create_user_id", createUserId)
		);

		return new PageUtils(ipage);
	}

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean save(SysRoleEntity role) {
        role.setCreateTime(new Date());
        boolean s = super.save(role);

        //检查权限是否越权
        checkPrems(role);

        //保存角色与菜单关系
        sysRoleMenuService.saveOrUpdate(role.getRoleId(), role.getMenuIdList());
        
        return s ;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void update(SysRoleEntity role) {
        this.updateById(role);

        //检查权限是否越权
        checkPrems(role);

        //更新角色与菜单关系
        sysRoleMenuService.saveOrUpdate(role.getRoleId(), role.getMenuIdList());
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void deleteBatch(String[] roleIds) {
        ArrayList<String> allRoleIds = new ArrayList<>();
	    //查询roleIds及以下的roleIds
        for(String roleId: roleIds){
            allRoleIds.add(roleId);
            //查询单个角色下所有用户
            QueryWrapper<SysUserRoleEntity> sysUserRoleEntityQueryWrapper = new QueryWrapper<>();
            sysUserRoleEntityQueryWrapper.eq("role_id",roleId);
            List<SysUserRoleEntity> list = sysUserRoleService.list(sysUserRoleEntityQueryWrapper);

            if(null!= list && list.size()>0){
                //查询该角色的用户是否存在子角色
                list.forEach((sysUser)->{
                    QueryWrapper<SysUserEntity> sysUserEntityQueryWrapper = new QueryWrapper<>();
                    sysUserEntityQueryWrapper.eq("user_id",sysUser.getUserId());
                    SysUserEntity one = sysUserService.getOne(sysUserEntityQueryWrapper);
                    //如果主账号
                    if(null != one && 1 == one.getUserType().getValue()){
                        QueryWrapper<SysRoleEntity> sysRoleEntityQueryWrapper= new QueryWrapper<>();
                        sysRoleEntityQueryWrapper.eq("create_user_id",one.getUserId());
                        List<SysRoleEntity> list1 = this.list(sysRoleEntityQueryWrapper);
                        list1.forEach(v->{
                            allRoleIds.add(v.getRoleId());
                        });
                    }
                });
            }

        }
        String[] allRoles1 = allRoleIds.toArray(new String[allRoleIds.size()]);
        //删除角色
        this.removeByIds(allRoleIds);

        //删除角色与菜单关联g
        sysRoleMenuService.deleteBatch(allRoles1);
       //删除角色下的用户
        sysUserRoleService.deleteUserBatch(allRoles1);
        //删除角色与用户关联
        sysUserRoleService.deleteBatch(allRoles1);
    }


    @Override
	public List<Long> queryRoleIdList(String createUserId) {
		return baseMapper.queryRoleIdList(createUserId);
	}

	/**
	 * 检查权限是否越权
	 */
	private void checkPrems(SysRoleEntity role){
		//如果不是超级管理员，则需要判断角色的权限是否超过自己的权限
		if(role.getCreateUserId().equals(Constant.SUPER_ADMIN) ){
			return ;
		}
		
		//查询用户所拥有的菜单列表
		List<String> menuIdList = sysUserDao.queryAllMenuId(role.getCreateUserId());
		
		//判断是否越权
		if(!menuIdList.containsAll(role.getMenuIdList())){
			throw new RRException("新增角色的权限，已超出你的权限范围");
		}
	}

    @Override
    public List<SysRoleEntity> queryRoleList(String createUserId) {
        return baseMapper.queryRoleList(createUserId);
    }
}
