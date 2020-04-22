package com.xiaobo.modules.sys.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.xiaobo.common.utils.MapUtils;
import com.xiaobo.modules.sys.dao.SysUserRoleDao;
import com.xiaobo.modules.sys.entity.SysUserRoleEntity;
import com.xiaobo.modules.sys.service.SysUserRoleService;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;


/**
 * 用户与角色对应关系
 * 
 * zhangxiaobo
 * @date 2017年9月18日 上午9:45:48
 */
@Service
public class SysUserRoleServiceImpl extends ServiceImpl<SysUserRoleDao, SysUserRoleEntity> implements SysUserRoleService {

	@Override
	public void saveOrUpdate(String userId, List<String> roleIdList) {

		//先删除用户与角色关系
		this.removeByMap(new MapUtils().put("user_id", userId));

		if(roleIdList == null || roleIdList.size() == 0){
			return ;
		}

		//保存用户与角色关系
		List<SysUserRoleEntity> list = new ArrayList<>(roleIdList.size());
		for(String roleId : roleIdList){
			SysUserRoleEntity sysUserRoleEntity = new SysUserRoleEntity();
			sysUserRoleEntity.setUserId(userId);
			sysUserRoleEntity.setRoleId(roleId);

			list.add(sysUserRoleEntity);
		}
		this.saveBatch(list);
	}

	@Override
	public List<String> queryRoleIdList(String userId) {
		return baseMapper.queryRoleIdList(userId);
	}

	@Override
	public int deleteBatch(String[] roleIds){
		return baseMapper.deleteBatch(roleIds);
	}

	@Override
	public void newSaveOrUpdate(String userId, String roleId) {

		//先删除用户与角色关系
		this.removeByMap(new MapUtils().put("user_id", userId));

		if(roleId == null || roleId.isEmpty()){
			return ;
		}
		SysUserRoleEntity sysUserRoleEntity = new SysUserRoleEntity();
		sysUserRoleEntity.setUserId(userId);
		sysUserRoleEntity.setRoleId(roleId);

		this.save(sysUserRoleEntity);
	}

	@Override
	public String queryRoleId(String userId) { return baseMapper.queryRoleId(userId); }

	@Override
	public int deleteUserBatch(String[] roleIds){
		return baseMapper.deleteUserBatch(roleIds);
	}
}
