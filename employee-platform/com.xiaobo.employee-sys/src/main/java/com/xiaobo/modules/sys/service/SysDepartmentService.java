package com.xiaobo.modules.sys.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.xiaobo.common.utils.PageUtils;
import com.xiaobo.modules.sys.entity.SysDepartmentEntity;

import java.util.List;


/**
 * 部门表
 *
 * zhangxiaobo
 * @email 1920969038.com
 * @date 2019-11-15 09:05:42
 */
public interface SysDepartmentService extends IService<SysDepartmentEntity> {

    PageUtils queryPage(SysDepartmentEntity SysDepartment, PageUtils page);

    List<SysDepartmentEntity> childList(String orgid);

    SysDepartmentEntity queryDeptById(String depid);

    List<String> queryName(String orgId);
}

