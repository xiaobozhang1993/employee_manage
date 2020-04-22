

package com.xiaobo.common.log.controller;


import com.xiaobo.common.log.entity.SysLogEntity;
import com.xiaobo.common.log.service.SysLogService;
import com.xiaobo.common.utils.R;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;


/**
 * 系统日志
 * 
 * @author zhangxiaobo
 * @email 1920969038@qq.com.com
 * @date 2017-03-08 10:40:56
 */
@Controller
@RequestMapping("/sys/log")
public class SysLogController {
	@Autowired
	private SysLogService sysLogService;
	
	/**
	 * 列表
	 */
	@ResponseBody
	@GetMapping("/list")
	public R list(@RequestParam Map<String, Object> params){
			/*PageUtils page = sysLogService.queryPage(params);*/

		List<SysLogEntity> list = sysLogService.queryLog(params.get("key").toString());

		return R.ok().put("list", list);
	}

	/**
	 * 删除日志*/
	@ResponseBody
	@PostMapping("/delete")
	public R delete(@RequestBody String ids){
		List<String> strings = Arrays.asList(ids);
		ArrayList<Long> longs = new ArrayList<>();
		for (String string : strings) {
			Long aLong = Long.valueOf(string);
			longs.add(aLong);
		}
		try {
			sysLogService.removeByIds(longs);
			return R.ok();
		} catch (Exception e) {
			e.printStackTrace();
			return  R.error();
		}


	}
}
