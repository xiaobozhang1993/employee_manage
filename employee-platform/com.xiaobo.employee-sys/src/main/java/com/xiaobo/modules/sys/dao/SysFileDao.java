package com.xiaobo.modules.sys.dao;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.xiaobo.modules.sys.entity.SysFileEntity;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import java.util.List;

@Mapper
public interface SysFileDao extends BaseMapper<SysFileEntity> {

    @Select("select file_uid,file_name,file_url from sys_res_file where res_id = #{resId} and state = #{state}")
    List<SysFileEntity> queryFileList(String resId, Integer state);

    @Delete("delete from sys_res_file where res_id = #{resId} and state = #{state}")
    void deleteByResId(String resId, Integer state);
}
