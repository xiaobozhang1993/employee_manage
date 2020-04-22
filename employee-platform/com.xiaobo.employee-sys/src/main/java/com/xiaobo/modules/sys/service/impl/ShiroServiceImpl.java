package com.xiaobo.modules.sys.service.impl;


import com.xiaobo.modules.sys.entity.SysUserTokenEntity;
import com.xiaobo.modules.sys.service.ShiroService;
import com.xiaobo.modules.sys.service.SysUserTokenService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;

import java.util.Set;

@Service

public class ShiroServiceImpl implements ShiroService {
//    @Autowired
//    private SysUserService sysUserService;
    @Autowired
    private SysUserTokenService sysUserTokenService;
    
    @Autowired
    private com.xiaobo.oauth2.service.OauthService oauthService ;
    
   /* @Autowired
    private RedisUtils redisUtils ;*/
  
    
 
	@Override
	@Cacheable(value="tr", key="'getUserPermissions-' + #userId")
    public Set<String> getUserPermissions(String userId) {
       
       /* String token = sysUserTokenService.queryTokenByUserId(userId);
        String key = getClass().getSimpleName() + "-userPerm-" + token;
        if(token != null) {
        	if(redisUtils.containKey(key))
        		return redisUtils.get(key , Set.class);
        }*/
    	
    	
        Set<String> permsList = oauthService.queryPermsByUser(userId);
        //        //系统管理员，拥有最高权限
       /* if(userId.equals(Constant.SUPER_ADMIN)){
            List<SysMenuEntity> menuList = sysMenuService.selectList(null);
            permsList = new ArrayList<>(menuList.size());
            for(SysMenuEntity menu : menuList){
                permsList.add(menu.getPerms());
            }
        }else{
            permsList = sysUserService.queryAllPerms(userId);
        }
        //用户权限列表
        Set<String> permsSet = new HashSet<>();
        for(String perms : permsList){
            if(StringUtils.isBlank(perms)){
                continue;
            }
            permsSet.addAll(Arrays.asList(perms.trim().split(",")));
        }*/
        
        
       /*
        if(token != null) {
        	redisUtils.set(key, permsList);
        }*/
        
       
        return permsList;
    }

    @Override
    public SysUserTokenEntity queryByToken(String token) {
        return sysUserTokenService.queryByToken(token);
    }
/*
    @Override
    public SysUserEntity queryUser(String userId) {
    	 
        return sysUserService.getById(userId);
    }*/
}
