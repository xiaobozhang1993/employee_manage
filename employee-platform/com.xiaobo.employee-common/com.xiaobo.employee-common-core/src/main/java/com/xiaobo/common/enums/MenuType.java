package com.xiaobo.common.enums;

import com.baomidou.mybatisplus.core.enums.IEnum;
import com.fasterxml.jackson.annotation.JsonValue;

/**
 * 菜单类型
 * @author zhangxiaobo
 *
 */
public enum MenuType  implements IEnum<Integer>{
	   /**
     * 系统
     */
    //SYSTEM(0),
    /**
     * 目录
     */
    CATALOG(0),
    /**
     * 菜单
     */
    MENU(1),
    /**
     * 按钮
     */
    BUTTON(2);

    private int value;

    MenuType(int value) {
        this.value = value;
    }

    @JsonValue
    public Integer getValue() {
        return value;
    }

	 

}
