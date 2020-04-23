package com.xiaobo.modules.sys.controller;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.xiaobo.common.log.annotation.SysLog;
import com.xiaobo.common.log.annotation.SysModule;
import com.xiaobo.common.utils.PageUtils;
import com.xiaobo.common.utils.R;
import com.xiaobo.modules.sys.entity.SysDictEntity;
import com.xiaobo.modules.sys.service.SysDictService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.apache.commons.lang.StringUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.Arrays;
import java.util.List;


/**
 * 数据字典
 *
 * zhangxiaobo
 * @email 1920969038.com
 * @date 2019-03-20 10:54:34
 */
@RestController
@RequestMapping("sys/sysdict")
@Api(value = "字典表-通用", tags = {"字典表-通用"})
public class SysDictController {
    @Autowired
    private SysDictService sysDictService;

    /**
     * 列表
     */
    @GetMapping("/list")
    @ApiOperation(httpMethod = "GET",value ="字典表列表信息")
   // @RequiresPermissions("sys:sysdict:list")
    public R list(SysDictEntity entity , PageUtils page){
        QueryWrapper<SysDictEntity> objectQueryWrapper = new QueryWrapper<>();
        objectQueryWrapper.
                like(StringUtils.isNotEmpty(entity.getDescription()),"description",entity.getDescription());
        List<SysDictEntity> list = sysDictService.list(objectQueryWrapper);
        //PageUtils pageData = sysDictService.queryPage(entity , page);

        return R.ok().put("list", list);
    }


    /**
     * 信息
     */
    @GetMapping("/info/{dictId}")
    @ApiOperation("查询字典表详情")
    public R info(@PathVariable("dictId")  String dictId){
			SysDictEntity sysDict = sysDictService.getById(dictId);

        return R.ok().put("sysDict", sysDict);
    }


    /**
     * 保存
     */
    @PostMapping("/save")
    @ApiOperation(httpMethod = "POST",value ="保存字典表信息")
    @SysLog(value="保存字典表信息" , system= SysModule.sys)
    @RequiresPermissions("sys:sysdict:save")
    public R save(@RequestBody SysDictEntity sysDict){
			sysDictService.save(sysDict);

        return R.ok();
    }

    /**
     * 修改
     */
    @PostMapping("/update")
    @ApiOperation(httpMethod = "POST",value ="修改字典表信息")
    @SysLog(value="修改字典表信息" , system=SysModule.sys)
    @RequiresPermissions("sys:sysdict:update")
    public R update(@RequestBody SysDictEntity sysDict){
			sysDictService.updateById(sysDict);

        return R.ok();
    }

    @GetMapping("/findByType")
    @ApiOperation(httpMethod = "GET",value ="按照类型查询字典表信息")
    public R findByType(String type) {

    	QueryWrapper<SysDictEntity> wrapper = new QueryWrapper<>();
        wrapper.eq("type", type);
        wrapper.orderByAsc("seq");

    	List<SysDictEntity> list = sysDictService.list(wrapper);

    	return R.ok().put("data", list);
    }

    @GetMapping("/findByTypeValue")
    @ApiOperation(httpMethod = "GET",value ="按照类型和值查询字典表信息")
    public R findByTypeValue(String type ,String value) {

    	QueryWrapper<SysDictEntity> wrapper = new QueryWrapper<>();
    	wrapper.eq("type", type);
    	wrapper.eq("value", value);

    	SysDictEntity data = sysDictService.getOne(wrapper);

    	return R.ok().put("data", data);
    }

    /*
    * 查询全部数据*/
    @GetMapping("/findDictListAll")
    @ApiOperation(httpMethod = "GET",value ="查询全部数据")
    public R findListAll(){
        List<SysDictEntity> list = sysDictService.list();
        return R.ok().put("list", list);
    }

    /**
     * 删除
     */
    @PostMapping("/delete")
    @ApiOperation(httpMethod = "POST",value ="删除字典表信息")
    @SysLog(value="删除字典表信息" , system=SysModule.sys)
    public R delete(@RequestBody String[] dictIds){
			sysDictService.removeByIds(Arrays.asList(dictIds));

        return R.ok();
    }


}
