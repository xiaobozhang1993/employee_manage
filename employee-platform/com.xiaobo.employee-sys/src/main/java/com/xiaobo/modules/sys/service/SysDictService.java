package com.xiaobo.modules.sys.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.xiaobo.common.utils.PageUtils;
import com.xiaobo.modules.sys.entity.SysDictEntity;

import java.util.List;

/**
 * 数据字典
 *
 * zhangxiaobo
 * @email 1920969038.com
 * @date 2019-03-20 10:54:34
 */
public interface SysDictService extends IService<SysDictEntity> {

    PageUtils queryPage(SysDictEntity entity, PageUtils page);



    /**
     * 根据 type ,dict_name 联合查询数据
     */
    SysDictEntity byTypeDictName(String type, String dictName);

    /**
     * 根据 type ,dict_value 联合查询数据
     */
    SysDictEntity byTypeDictValue(String type, String value);

    /**
     * 根据 type ,dict_value 联合查询数据
     */
    List<SysDictEntity> selectByTypeValue(String type, List<String> value);

    List<String> getTableTitle(String[] values);

    List<String> getByType(String type);

}

