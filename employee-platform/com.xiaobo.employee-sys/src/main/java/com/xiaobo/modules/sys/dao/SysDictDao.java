package com.xiaobo.modules.sys.dao;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.xiaobo.modules.sys.entity.SysDictEntity;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.List;

/**
 * 数据字典
 *
 * zhangxiaobo
 * @email 1920969038.com
 * @date 2019-03-20 10:54:34
 */
@Mapper
public interface SysDictDao extends BaseMapper<SysDictEntity> {


    @Select({
            "<script>",
            "select",
            "json_build_object ( 'name', t.dict_name, 'value', t.VALUE, 'isDict', t.is_dict, 'seq', t.seq ) AS json  ",
            "from sys_dict t",
            "where t.type = 'table' AND t.VALUE in ",
            "<foreach item='item' index='index' collection='values'",
            "open='(' separator=',' close=')'>",
            "#{item}",
            "</foreach>",
            "</script>"
    })
    List<String> getTableTitle(@Param("values") String[] values);

    @Select("select dict_name from sys_dict where type = #{type}")
    List<String> getByType(String type);
}
