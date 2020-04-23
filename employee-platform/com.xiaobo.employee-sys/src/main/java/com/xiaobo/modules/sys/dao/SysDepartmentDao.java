package com.xiaobo.modules.sys.dao;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.xiaobo.modules.sys.entity.SysDepartmentEntity;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import java.util.List;

/**
 * 部门表
 * 
 * zhangxiaobo
 * @email 1920969038.com
 * @date 2019-11-15 09:05:42
 */
@Mapper
public interface SysDepartmentDao extends BaseMapper<SysDepartmentEntity> {
	
	/*推荐在此直接添加注解写sql,可读性比较好*/
    @Select("select * from sys_department where org_id = #{orgid}")
    public List<SysDepartmentEntity> childList(String orgid);

    @Select("select * from sys_department where dep_id = #{depid} ")
    public SysDepartmentEntity queryDeptById(String depid);

    @Select("select name from sys_department where org_id = #{orgid}")
    public List<String> queryName(String orgid);
}
