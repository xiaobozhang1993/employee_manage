package com.xiaobo.modules.sys.dao;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.xiaobo.modules.sys.entity.SysUserTokenEntity;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

/**
 * 系统用户Token
 * 
 * zhangxiaobo
 * @date 2017-03-23 15:22:07
 */
@Mapper
public interface SysUserTokenDao extends BaseMapper<SysUserTokenEntity> {

	@Select("select * from sys_user_token where token = #{token}")
    SysUserTokenEntity queryByToken(@Param("token") String token);

	@Update("update sys_user_token set update_time = update_time - '0.51 hour'::interval where user_id = #{userId}")
	void updateLogoutTime(String userId);
	
}
