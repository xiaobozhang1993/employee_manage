
package com.xiaobo.common.utils;

import java.util.HashMap;


/**
 * Map工具类
 *
 * @author Mark sunlightcs@gmail.com
 * @since 2.0.0
 */
public class MapUtils extends HashMap<String, Object> {

    /**
	 * 
	 */
	private static final long serialVersionUID = 6696799017739437549L;

	@Override
    public MapUtils put(String key, Object value) {
        super.put(key, value);
        return this;
    }
     
}
