package com.xiaobo.modules.sys.dao;


import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.xiaobo.modules.sys.entity.SysOrganizationEntity;
import com.xiaobo.modules.sys.entity.vo.SysOrgVo;
import org.apache.ibatis.annotations.*;

import java.util.List;

@Mapper
public interface SysOrganizationDao extends BaseMapper<SysOrganizationEntity> {

    @Select("select id,name,parent_id,order_num,create_time,update_time, 'filedk' as fileIconName  from sys_organization where id = #{parentId} " +
            "order by order_num")
    @Results({
            @Result(id = true, column = "id", property = "id"),
            @Result(column = "name", property = "name"),
            @Result(column = "parent_id", property = "parentId"),
            @Result(column = "order_num", property = "orderNum"),
            @Result(column = "create_time", property = "createTime"),
            @Result(column = "update_time", property = "updateTime"),
            @Result(column = "fileIconName", property = "fileIconName"),
            @Result(column = "id", property = "list",
                    many = @Many(select = "com.tr.modules.sys.dao.SysOrganizationDao.findParentId1")),
    })
    List<SysOrgVo> findParentId(@Param("parentId") String parentId);


    @Select("select id,name,parent_id,order_num,create_time,update_time,'filedk' as fileIconName from sys_organization where parent_id = #{parentId} " +
            "order by order_num")
    @Results({
            @Result(id = true, column = "id", property = "id"),
            @Result(column = "name", property = "name"),
            @Result(column = "parent_id", property = "parentId"),
            @Result(column = "order_num", property = "orderNum"),
            @Result(column = "create_time", property = "createTime"),
            @Result(column = "update_time", property = "updateTime"),
            @Result(column = "fileIconName", property = "fileIconName"),
            @Result(column = "id", property = "list",
                    many = @Many(select = "com.tr.modules.sys.dao.SysOrganizationDao.findParentId1")),
    })
    List<SysOrgVo> findParentId1(@Param("parentId") String parentId);

    @Select("select id,name,parent_id,order_num,create_time,update_time from sys_organization where parent_id = #{parentId} " +
            "order by order_num")
    List<SysOrganizationEntity> findChild(@Param("parentId") String parentId);

    @Select("select id,name,parent_id from sys_organization where id = #{orgId}")
    SysOrganizationEntity queryById(String orgId);

    @Select("select id from sys_organization where parent_id = '0'")
    String findSgjId();

    @Select("select DISTINCT t1.*  from\n" +
            "(\n" +
            "\tWITH RECURSIVE T (ID, NAME, PARENT_ID, order_num ) AS (\n" +
            "                    SELECT ID,NAME, PARENT_ID, order_num \n" +
            "                    FROM sys_organization WHERE ID = #{orgId}\n" +
            "\t\t\t\t\t\t\t\t\t\tUNION ALL\n" +
            "                    SELECT T1.ID, T1.NAME,T1.PARENT_ID,T1.order_num \n" +
            "                    FROM sys_organization T1\n" +
            "                    JOIN T ON T1.PARENT_ID = T.ID \n" +
            "                    )\n" +
            "\t\tselect * from T\t\t\n" +
            ") t1 \n" +
            "\n" +
            "  order by t1.order_num ")
    List<SysOrganizationEntity> getTreeList(@Param("orgId") String orgId);

    /**
     * 递归查询orgID
     */
    @Select("with recursive t(id) as (\n" +
            " select id from sys_organization where parent_id = #{orgId} \n" +
            " union all\n" +
            " select s.id from t , sys_organization as s\n" +
            " where t.id = s.parent_id  \n" +
            "),\n" +
            "t2 as (\n" +
            " select #{orgId} as id \n" +
            "union \n" +
            "select id from t  \n" +
            ")\n" +
            "select id FROM t2")
    List<String> recursiveQuery(String orgId);

    //递归查询单位
    @Select("WITH RECURSIVE T ( ID, NAME, PARENT_ID, order_num ) AS (\n" +
            "SELECT ID\n" +
            "\t,\n" +
            "\tNAME,\n" +
            "\tPARENT_ID,\n" +
            "\torder_num \n" +
            "FROM\n" +
            "\tsys_organization \n" +
            "WHERE\n" +
            "\tID = #{orgId} UNION ALL\n" +
            "SELECT\n" +
            "\tT1.ID,\n" +
            "\tT1.NAME,\n" +
            "\tT1.PARENT_ID,\n" +
            "\tT1.order_num \n" +
            "FROM\n" +
            "\tsys_organization T1\n" +
            "\tJOIN T ON T1.PARENT_ID = T.ID \n" +
            "\t) SELECT\n" +
            "\t* from sys_organization \n" +
            "WHERE\n" +
            "\tid IN ( SELECT ID FROM T )")
    List<SysOrganizationEntity> recursiveQueryEntity(String orgId);

    @Select("select id,name from sys_organization ORDER BY id")
    List<SysOrganizationEntity> queryName();

    @Select("SELECT  id FROM sys_organization where parent_id= #{parentOrgId} order by order_num")
    List<String> queryChildrenIds(String parentOrgId);
}
