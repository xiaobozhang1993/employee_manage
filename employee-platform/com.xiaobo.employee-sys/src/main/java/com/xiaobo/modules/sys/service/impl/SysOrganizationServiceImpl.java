package com.xiaobo.modules.sys.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.xiaobo.modules.sys.dao.SysDepartmentDao;
import com.xiaobo.modules.sys.dao.SysOrganizationDao;
import com.xiaobo.modules.sys.entity.SysOrganizationEntity;
import com.xiaobo.modules.sys.entity.vo.SysOrgVo;
import com.xiaobo.modules.sys.service.SysDepartmentService;
import com.xiaobo.modules.sys.service.SysOrganizationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service("sysOrganizationService")
public class SysOrganizationServiceImpl extends ServiceImpl<SysOrganizationDao, SysOrganizationEntity>
        implements SysOrganizationService {
    @Autowired
    private SysOrganizationDao sysOrganizationDao;
    @Autowired
    private SysDepartmentDao sysDepartmentDao;

    @Autowired
    private SysDepartmentService departmentService;

    @Override
    public List<SysOrgVo> listAll() {

        List<SysOrgVo> list = sysOrganizationDao.findParentId("610000");

        return list;
    }




}
