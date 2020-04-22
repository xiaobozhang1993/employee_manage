
 

/**
 * 创建百度地图
 * @param _div 地图所处div
 * @param _centerPoint 地图当前中心点
 * @param _mapZoom 当前缩放层级 0-19
 * @param _is_hybrid_map 是否卫星图
 * @param _overView 是否包含鹰眼图
 * @returns 百度地图 Bmap
 */
export function bmap(_div ,_centerPoint , _mapZoom , _is_hybrid_map   , _overView , _navigation ) {
	 
	if(_is_hybrid_map == null) {
		_is_hybrid_map = false
	}
	if(_overView == null) {
		_overView = true 
	}
	if(_navigation == null) {
		_navigation = true
	}


	var map = _is_hybrid_map ? new BMap.Map(_div, {mapType: BMAP_HYBRID_MAP,enableMapClick:false}) : new BMap.Map(_div , {enableMapClick:false});    // 创建Map实例
	
	map.addControl(new BMap.MapTypeControl({
		mapTypes:[
            BMAP_NORMAL_MAP,
            BMAP_HYBRID_MAP
        ]}) ,{enableHighResolution:true});	  
	
	if(_centerPoint && _mapZoom) {
		map.centerAndZoom(_centerPoint, _mapZoom);  // 初始化地图,设置中心点坐标和地图级别
		 
	} else {
		
		//准备iP定位回调 
		var point = new BMap.Point(108.95309828,34.2777999);//, 11
		map.centerAndZoom(point, 12);
			
		var myCity = new BMap.LocalCity();
		myCity.get(function(result){
			var cityName = result.name; 
			map.setCenter(cityName);
			//alert("当前定位城市:"+cityName);
			 
		});
		
		
	}
	 
 	map.enableScrollWheelZoom(true);     //开启鼠标滚轮缩放
 	if(_navigation) {
 		var top_left_navigation = new BMap.NavigationControl(/*{type:BMAP_NAVIGATION_CONTROL_ZOOM}*/);  //左上角，添加默认缩放平移控件
 	 	map.addControl(top_left_navigation);      // 
 	 
 	}
 	
 	if(_overView) {
 		var overView = new BMap.OverviewMapControl();
 	 	var overViewOpen = new BMap.OverviewMapControl({isOpen: false, anchor: BMAP_ANCHOR_BOTTOM_RIGHT});

 		map.addControl(overView);          //添加默认缩略地图控件
 	 	map.addControl(overViewOpen);      //右下角，打开
 	}
 	
 /*	map.addEventListener('moveend' , function(type ,target){
		  
			redrawCells(map);
		});
	map.addEventListener('zoomend' , function(type ,target){
		 
			redrawCells(map);
		});*/
 	 
 	return map ;
}


