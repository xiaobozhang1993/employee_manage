package com.xiaobo.modules.sys.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.xiaobo.modules.sys.entity.SysOrganizationEntity;
import com.xiaobo.modules.sys.entity.vo.SysOrgVo;

import java.util.List;

public interface SysOrganizationService extends IService<SysOrganizationEntity> {

     List<SysOrgVo> listAll();

}
