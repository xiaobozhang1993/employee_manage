
package com.xiaobo.common.log.dao;


import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.xiaobo.common.log.entity.SysLogEntity;
import org.apache.commons.lang.StringUtils;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.SelectProvider;

import java.util.List;

/**
 * 系统日志
 * 
 * @author zhangxiaobo
 * 
 * @date 2017-03-08 10:40:56
 */
@Mapper
public interface SysLogDao extends BaseMapper<SysLogEntity> {

    @SelectProvider(type = queryLog.class,method = "logSql")
    List<SysLogEntity> queryLog(String username);

    class queryLog{
        public String logSql(String username){
            StringBuffer sql= new StringBuffer("select l.*,u.username unit,u.name from sys_log l left join sys_user u" +
                    " on l.username = u.user_no");
            if (StringUtils.isNotBlank(username)){
                sql.append(" where l.username = #{username}");
            }
            sql.append(" order by l.create_date");
            return sql.toString();
        }
    }

}
