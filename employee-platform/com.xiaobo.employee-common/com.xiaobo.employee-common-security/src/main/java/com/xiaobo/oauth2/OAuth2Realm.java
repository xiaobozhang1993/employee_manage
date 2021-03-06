package com.xiaobo.oauth2;

import java.util.Set;

import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.IncorrectCredentialsException;
import org.apache.shiro.authc.SimpleAuthenticationInfo;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.xiaobo.common.entity.SysUser;
import com.xiaobo.oauth2.service.OauthService;

/**
 * 认证
 *
 * @author zhangxiaobo
 * @date 2017-05-20 14:00
 */
@Component
public class OAuth2Realm extends AuthorizingRealm {
    @Autowired
    private OauthService oauthService;

    @Override
    public boolean supports(AuthenticationToken token) {
        return token instanceof OAuth2Token;
    }

    /**
     * 授权(验证权限时调用)
     */
    @Override
    protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principals) {
        SysUser user = (SysUser)principals.getPrimaryPrincipal();
      //  String userId = user.getUserId();

        //用户权限列表
        Set<String> permsSet = oauthService.queryPermsByUser(user.getUserId());

        SimpleAuthorizationInfo info = new SimpleAuthorizationInfo();
        info.setStringPermissions(permsSet);
        return info;
    }

    /**
     * 认证(登录时调用)
     */
    @Override
    protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken token) throws AuthenticationException {
        String accessToken = (String) token.getPrincipal();

        //根据accessToken，查询用户信息
        SysUser user = oauthService.queryByToken(accessToken);
        //token失效
        if(user == null  ){
            throw new IncorrectCredentialsException("登录信息已失效或账号在其他地方登录。如非本人操作，请登录后修改密码。");
        }

        // 更新用户token
        oauthService.updateTokenUpdateTime(accessToken);
        
        //查询用户信息
//        SysUser user = shiroService.queryUser(tokenEntity.getUserId());
        //账号锁定
//        if(user.get){
//            throw new LockedAccountException("账号已被锁定,请联系管理员");
//        }

        SimpleAuthenticationInfo info = new SimpleAuthenticationInfo(user, accessToken, getName());
        return info;
    }
}
