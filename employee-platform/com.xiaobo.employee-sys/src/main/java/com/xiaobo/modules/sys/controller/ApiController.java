package com.xiaobo.modules.sys.controller;


import com.xiaobo.common.entity.SysUser;
import com.xiaobo.common.utils.R;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/sys/api")
public class ApiController {
	
	@Autowired
	private com.xiaobo.common.security.SecurityUtils securityUtils;

	/**
	 * 拿到当前用户 如果有的话
	 * @return
	 */
	@GetMapping("/user/info")
	@ApiOperation("获取当前用户")
	@ApiResponse(code=0,message="获取成功",response=SysUser.class)
	public R userInfo() {
		
		SysUser user = securityUtils.getCurrentUser();
		if(user != null)
			user.setPassword(null);
		
		return R.ok().put("user", user);
	}
	
}
