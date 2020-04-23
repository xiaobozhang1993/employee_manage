package com.xiaobo.modules.sys.controller;


import com.xiaobo.common.entity.SysUser;
import com.xiaobo.common.utils.PageUtils;
import com.xiaobo.common.utils.R;
import com.xiaobo.modules.sys.entity.SysDepartmentEntity;
import com.xiaobo.modules.sys.service.SysDepartmentService;
import com.xiaobo.sys.controller.AbstractController;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.Arrays;
import java.util.Date;
import java.util.List;

/**
 * 部门表
 *
 * zhangxiaobo
 * @email 1920969038.com
 * @date 2019-11-15 09:05:42
 */
@RestController
@RequestMapping("sys/sysdepartment")
@Api(value = "部门表API", tags = { "部门表API-通用" })
public class SysDepartmentController extends AbstractController {
    @Autowired
    private SysDepartmentService sysDepartmentService;

        /**
         * 列表
         */
        @GetMapping("/list")
        @ApiOperation("部门表列表")
        @ApiResponse(code=0,message="查询成功",response= SysDepartmentEntity.class)
	    public R list(SysDepartmentEntity SysDepartment , PageUtils page){

            /*PageUtils pageData = sysDepartmentService.queryPage(SysDepartment , page);*/
            List<SysDepartmentEntity> depts= sysDepartmentService.childList(SysDepartment.getOrgId());

            return R.ok().put("depts", depts);
        }

        @GetMapping("/listAll")
        @ApiOperation("部门表列表")
        @ApiResponse(code=0,message="查询成功",response= SysDepartmentEntity.class)
	    public R listAll(){
            return R.ok().put("list", sysDepartmentService.list());
        }

        /**
         * 信息
         */
        @GetMapping("/info/{depId}")
        @ApiOperation("根据ID获取部门表信息")
        @ApiResponse(code=0,message="查询成功",response=SysDepartmentEntity.class)
	    public R info(@PathVariable("depId") String depId){
            SysDepartmentEntity sysDepartment = sysDepartmentService.getById(depId);

            return R.ok().put("sysDepartment", sysDepartment);
        }

        /**
         * 保存
         */
        @PostMapping("/save")
        @ApiOperation("保存部门表信息")
	    public R save(@RequestBody SysDepartmentEntity sysDepartment){
            sysDepartment.setCreateTime(new Date());
            sysDepartment.setUpdateTime(new Date());
            sysDepartmentService.save(sysDepartment);

            return R.ok();
        }

        /**
        * 修改
        */
        @PostMapping("/update")
        @ApiOperation("修改部门表信息")
	    public R update(@RequestBody SysDepartmentEntity sysDepartment){
            sysDepartment.setUpdateTime(new Date());
            sysDepartmentService.updateById(sysDepartment);

            return R.ok();
    }

        /**
        * 删除
        */
        @PostMapping("/delete")
        @ApiOperation("删除部门表信息")
	    public R delete(@RequestBody String[] depIds){
            sysDepartmentService.removeByIds(Arrays.asList(depIds));

            return R.ok();
        }


        @PostMapping("/childList")
        public R childList(@RequestParam("orgid") String orgid){
            if ("".equals(orgid)||orgid.isEmpty()){
                SysUser user = getUser();
                orgid = user.getOrgId();
            }

            List<SysDepartmentEntity> deptlist = sysDepartmentService.childList(orgid);

            return R.ok().put("deptlist",deptlist);
        }

    /**
     * 获取部门负责人
     */
    @PostMapping("/queryDeptPrincipal")
    public R queryDeptPrincipal(@RequestParam("depid") String depid){

        SysDepartmentEntity dept = sysDepartmentService.queryDeptById(depid);

        String principal = dept.getPrincipal();

        return R.ok().put("principal",principal);
    }

}
