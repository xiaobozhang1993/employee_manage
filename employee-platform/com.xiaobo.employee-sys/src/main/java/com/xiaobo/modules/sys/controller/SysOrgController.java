package com.xiaobo.modules.sys.controller;

import com.xiaobo.common.utils.R;
import com.xiaobo.modules.sys.entity.SysOrganizationEntity;
import com.xiaobo.modules.sys.service.SysOrganizationService;
import com.xiaobo.sys.controller.AbstractController;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;


/**
 * 组织架构层级*/
@RestController
@RequestMapping("/sys/org")
@Api(value="组织架构",tags={"组织架构-通用"} )
public class SysOrgController extends AbstractController {

    @Autowired
    private SysOrganizationService sysOrganizationService;

    @RequestMapping(value = "/list",method = RequestMethod.POST)
    @ApiOperation("查询整个组织架构")
    public R listAll(){
        R r = new R();
        List<SysOrganizationEntity> list = sysOrganizationService.list();
        return r.put("orgList",list);
    }


}
