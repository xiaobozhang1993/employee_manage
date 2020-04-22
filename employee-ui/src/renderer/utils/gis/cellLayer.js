 
export	function CellLayer(_cells){
		 
		this.cells = _cells;
		 
		 
	}
	CellLayer.prototype = new BMap.Overlay();
	 
	CellLayer.prototype.change = function(_carrierType,_netType){
		this.carrierType = _carrierType;
		this.netType =_netType;
		this.draw();
	},
	CellLayer.prototype.initialize = function(map){
		this._map = map;
		canvas = document.createElement("canvas");
		canvas.style.cssText = "position:absolute;left:0;top:0;opacity:0.9;";
		 
		var size = map.getSize();
		canvas.width =  size.width;
		canvas.height =   size.height;
		//panel = this._map.getPanes().labelPane ;
		this._map.getPanes().markerPane.appendChild(canvas);
		this.canvas = canvas ;
		
		var _celllayer = this;
		//注册监听服务,监听鼠标移动
	//	this._map.addEventListener('mousemove' , this.mouseMove);
		this._map._cellLayer = this ;
		
		
		 
		return canvas;
	}
	 
	/*CellLayer.prototype.mouseMove = function(e){
		//console.log(  e.target + ' ' + e.point + ' ' + e.pixel  );
		
		  var pos=getPosition(e );
          
          var cell = this.selectCell(pos);
          if(cell) {
        	  console.log(JSON.stringify(cell));
          }
		 
		return;
		
	}*/
	CellLayer.prototype.numCells =  function(_bounds){
		 
		var _cells = this.cells ;
		if(!_cells) return  0; 
		
		var num = 0;
		 for(var i in _cells){
			 var c = _cells[i];
			 if(c.bd_lon >= _bounds.minx && c.bd_lon <= _bounds.maxx
					 && c.bd_lat >= _bounds.miny && c.bd_lat <= _bounds.maxy){
				 num++;
			}
		 }
		 
		 return num ;
	},
	CellLayer.prototype.showLayer =  function(show){
		this._show = show ;
		//console.log(this.name + 'set show:' + this._show);
		if(show == true) {
			this.show() ;
		} else {
			this.hide() ;
		}
		this.draw() ;
	},
	 
	CellLayer.prototype.focusCell = function(_cell) {
		//console.log('_cell.id  :' + _cell.id );
		this.focusCellId = _cell.id ;
	},
	CellLayer.prototype.getCell = function(_id) {
		 var _cells = this.cells ;
         //修改符合条件的公参都拉出来,取半径最短的那个返回 2018-02-28
         
         for(var i in _cells) {
       	  var cell = _cells[i];
       	  
       	  if(cell.polygon && cell.id == _id) {
       		 return cell;
       	  }
       	  
         }
	},
	CellLayer.prototype.selectCell = function(pos) {
		//console.log(this.name +  'this._show : ' + this._show);
		if(this._show != null && this._show == false) return null;
		 var _cells = this.cells ;
         //修改符合条件的公参都拉出来,取半径最短的那个返回 2018-02-28
          
         var _mincell ;
         for(var i in _cells) {
       	  var cell = _cells[i];
       	  
       	  if(cell.polygon && PointInPoly(pos , cell.polygon)) {
       		 // alert(JSON.stringify(cell));
       		 if(!_mincell || _mincell.r > cell.r) _mincell = cell;
       		 
       	  }
       	  
         }
         
         if(_mincell) {
       	  //找出距离最短的
       	  	return _mincell ;
         }
         return null;
         
	},
	CellLayer.prototype.addEventListener = function(type , _callback){
		var _celllayer = this ;
		if(type == 'click') {
			
			//找到当前的point
			_celllayer.canvas.addEventListener('click',function(ev){
              var pos=getPosition(ev);
             
              var cell = _celllayer.selectCell(pos);
              if(cell) {
            	  _celllayer.focusCell(cell);
            	  _callback(pos ,cell);
            	  if(_celllayer.ctx) {
            		  _celllayer.drawCell( _celllayer.ctx ,cell);
            	  }
            		 
              }
            	  
            		 
              
          },false);
		 
		}else if(type == 'mouseMove') {
			_celllayer.canvas.addEventListener('mousemove',function(ev){
	              var pos=getPosition(ev);
	             
	              var cell = _celllayer.selectCell(pos);
	            //  console.log('c:' + JSON.stringify(cell));
	              if(cell)
	            	  _callback(pos ,cell);
	            		 
	              
	          },false);
		}
	},
	CellLayer.prototype.clearFocus = function( ) {
		/*var fid = this.focusCellId;
		if(!fid)return;
		
		var cell = this.getCell(fid);
		if(cell) {
			
		}*/
	},
	
	CellLayer.prototype.getCenter = function() {
		
		var _center_point = this.center ;
		if(_center_point && _center_point.lng > 0 && _center_point.lat > 0){
			return _center_point ;
		}
		
		var _cells = this.cells ;
		 var minx,miny,maxx,maxy ;
		 for(var i in _cells){
			 var x = _cells[i].bd_lon;
			 var y = _cells[i].bd_lat;
			 
			 if(!minx || minx > x){
				 minx = x;
			 }
			 if(!miny || miny > y){
				 miny = y;
			 }
			 if(!maxx || maxx < x){
				 maxx = x; 
			 }
			 if(!maxy || maxy < y){
				 maxy = y;
			 }
			 
		 }
		 
		 if(minx && miny && maxx && maxy && maxx < 180 && maxy < 90) {
			 _center_point = new BMap.Point((minx + (maxx - minx)/2) , (miny + (maxy-miny)/2)) ;// {x:(minx + (maxx - minx)/2) , y:(miny + (maxy-miny)/2)};
		 } else if(_cells && _cells.length > 0){
			 _center_point = new BMap.Point(_cells[0].bd_lon , _cells[0].bd_lat ); 
		 }
		 
		//console.log('_center_point : ' + JSON.stringify(_center_point) + "   @@@   " + minx + '&&' +  miny + '&&' +  maxx + '&&' +  maxy);
		 
		return _center_point;
	},
	
	CellLayer.prototype.setColorOption = function(_fun){
		 
		this._color_option = _fun;
		this.draw();
	},
	CellLayer.prototype.setLabelOption = function(_label_option){
		 
		this._label_option = _label_option;
		 
	},
	CellLayer.prototype.drawCellLabel = function( ctx ,_cell){
		
	} ,
	CellLayer.prototype.drawCell = function( ctx ,_cell){
		//var map = this._map;
		var color ;
		 if(this._color_option ) {

			color = this._color_option(_cell);  // 绿色路径
			if(!color) return null;
		 }   
			 
		//按照像素走,不管缩放到哪个层级,扇区大小都一样大
		var radis_color = getRadioAndColor(_cell.fbtype , _cell.indoor , _cell.nettype);
		
		var lon = _cell.bd_lon;
		var lat = _cell.bd_lat ;
		var azimuth = _cell.azimuth ;
		var indoor = _cell.indoor ;
		var r = radis_color.radis ;
		_cell.r = r ;
		
		if(!color){
			color = radis_color.rgba;
		}
		 
		 
		var _zoom = this._map.getZoom();
		/*if(_zoom == 13){
			_r = r * 0.2 ;
		}
		else*/ if(_zoom == 14){
			r = r * 0.5 ;
		}
		else if(_zoom == 16){
			r = r * 1.5;
		} else if(_zoom >=  17 && _zoom < 19){
			r = r * 2;
		} else if(_zoom >= 19){
			r = r * 3;
		}
		
		var offsetX = this.offsetX;
		var offsetY = this.offsetY;
		
		var pixel = this._map.pointToOverlayPixel(new BMap.Point(lon,lat));
		var x = parseInt(pixel.x - offsetX);
		var y = parseInt(pixel.y - offsetY);
		
		var _label_x = x ;
		var _label_y = y ;
		 
		var points = []; 
	    if(_cell.indoor) {
	        //室内站,画八边形
	        for(var i = 0 ; i <= 360 ; i += 45) {
	            var _x = parseInt(x +  r * 1.0 * Math.cos(i * Math.PI / 180))  ;
	            var _y = parseInt(y +  r * 1.0 * Math.sin(i * Math.PI / 180))  ;
	            //if(_x != x && _y != y)
	            	points.push({x:_x,y:_y});
	        }
	        
	    } else {
	        //室外站 每5度一个点
	        for(var i = azimuth - 15 ; i < azimuth + 15 ; i += 5) {
	            var _x = parseInt(x +   r * 1.0 * Math.sin(i * Math.PI / 180))  ;
	            var _y = parseInt(y -   r * 1.0 * Math.cos(i * Math.PI / 180))  ;
	            points.push({x:_x,y:_y});
	             
	        } 
	        _label_x = parseInt(x +   r * 1.0 * Math.sin(azimuth * Math.PI / 180))   ;
	        _label_y = parseInt(y -   r * 1.0 * Math.cos(azimuth * Math.PI / 180))  ;
	      
	        _label_x = _label_x - 15;
	        
	        //判断象限
	        if( azimuth <= 180){
	        	 
	        	_label_y = _label_y - 15;
	        }   else  {
	        	 
	        	_label_y = _label_y + 15;
	        } 
	        
	        
	        
	        points.push({x:x,y:y});
	       
	    }
		
	    if(!points ) {
	    	return null;
	    }
	    
	    ctx.beginPath();              
	    
	   
	    
	    ctx.fillStyle= color ;//radis_color.rgba;  // 绿色路径
	   
	    ctx.strokeStyle= 'blue';  // 绿色路径
	  
	    if(this.focusCellId && this.focusCellId == _cell.id){
	    	// console.log(this.focusCellId + ' ' + _cell.id);
	    	 ctx.strokeStyle= 'red';  // 绿色路径
	    	 ctx.fillStyle= 'red';  // 绿色路径
	    }
	   
	   // console.log('style:' + ctx.fillStyle);
	    if(!_cell.indoor)
	    	ctx.moveTo(x,y);
	    for(var i in points) {
	    	ctx.lineTo(points[i].x,points[i].y);
	    }
	    ctx.stroke();
	    ctx.fill();  // 进行绘制
	   
		var center = getCenter(points);
		if(center){
			if(_zoom >= 15) {
				var enodeb_id = !_cell.nettype || _cell.nettype == 'lte' ? _cell.cgi >>> 8 :  _cell.cgi >>> 16; 
				var ci =  !_cell.nettype ||_cell.nettype == 'lte' ?  _cell.cgi & 255 :  _cell.cgi & 65535;
				var _continue = true ;
				//15 1/3 ,16 1/5, 17 1/3 , 18  1/2
				if((_zoom == 15 && enodeb_id % 3 > 0 && ci % 2 > 0 )
						|| (_zoom == 16 &&  ci % 2 > 0)
						/* || (_zoom == 17 &&  enodeb_id % 2 > 0)
						|| (_zoom == 18 &&  ci % 2 > 0)*/
						) {
					_continue = false ;
				}
			
				//针对室内站 如果重复只打一个label
				if(_continue ){
					var _p_centers = this._p_centers ;
					if(_p_centers) {
						for(var k in _p_centers){
							var _p = _p_centers[k];
							if((_label_x >= _p.x - 15 && _label_x <= _p.x + 15)
									&& (_label_y >= _p.y - 10 && _label_y <= _p.y + 10)){ //外廓三个像素
								_continue = false;
							}
						}
					}
					
					if(_continue)
						_p_centers.push({x:_label_x , y:_label_y});
					
				}
				
				if(_continue && this._label_option) {
					
					var color = this._label_option.color ;
					var column = this._label_option.column ;
					var fontsize = this._label_option.size;
					
					ctx.strokeStyle = color
				    ctx.font = fontsize + "px 宋体";
					var _text = '';
					if(column == 'cellname') {
						_text = _cell.cellname;
					}else if(column == 'enodebid_ci'){
 						
 						_text = enodeb_id + '-' + ci;
					} else if(column == 'pci') {
						_text = _cell.earfcn + '-' + _cell.pci;
					}
//					var _x = parseInt(x +   r * 1.0 * Math.sin(azimuth * Math.PI / 180))  ;
//			        var _y = parseInt(y -   r * 1.0 * Math.cos(azimuth * Math.PI / 180))  ;
//			        _label_x = _x - parseInt(_text.length * fontsize * 0.1);
//			        _label_y = _y + parseInt(ci % 3 == 0 ? fontsize : -1 * fontsize)  ;
					
					//ctx.strokeText(_text,_label_x, _label_y);
					_cell.strokeText = {text:_text , x:_label_x , y:_label_y};
					
				}
				
				
			}
			center.x = center.x + offsetX;
			center.y = center.y + offsetY;
			points.center = center ;
		}
	    
	   
	    
	    return points;
	    
	   // ctx.stark();
	  //  ctx.save();  // 进行绘制
	  //  ctx.fillStyle = 'transparent';
	}
	,
	CellLayer.prototype.draw = function(){
		this._p_centers = [];
		var map = this._map;
		
		var size = map.getSize();
		var BW = size.width;
		var BH = size.height;
		
		var canvas = this.canvas ;
		//this.canvas.style.cssText = "position:absolute;left:0;top:0;";
		canvas.width = BW;
		canvas.height = BH;
		
		
		var ctx = canvas.getContext('2d');
		if (!ctx) {
	            return;
		}
		this.ctx = ctx ;
		ctx.save(); // Workaround for a bug in Google Chrome
		ctx.fillStyle = 'transparent';
		//ctx.fillStyle = '#55000005';
		ctx.fillRect(0, 0, BW, BH);
		ctx.restore();
		
		if(this._show != null && this._show == false) {
			return ;
		}
		
	
		 
		//获取层级
		var zoom = map.getZoom();
		if(zoom < 14 && this.isVisible()) {
			this.hide() ;
		}
		if(zoom >= 14 && !this.isVisible()) {
			this.show() ;
		}
	//	console.log('this.isVisible() :' + this.isVisible());
		if(!this.isVisible()) return ;
		 
		
		//ctx.clearRect(0, 0, ctx.canvas.width, ctx.canvas.height);
		
		
		 //偏移
	    var someLoc = new BMap.Point(0,0);
	    var offsetX = map.pointToOverlayPixel(someLoc).x -
	   						map.pointToPixel(someLoc).x;
	    var offsetY = map.pointToOverlayPixel(someLoc).y -
	                   		map.pointToPixel(someLoc).y;
	    
	   // console.log('offsetx:' + offsetX + ',offsety:' + offsetY);
		this. offsetX = offsetX;
		this. offsetY = offsetY;
	    
		//左上右下的经纬度卡住
		 
		var bounds = map.getBounds();
		var sw = bounds.getSouthWest();
		var ne = bounds.getNorthEast(); 
	 	
		
		
		var _cells = this.cells ;
		
		var draw_labels = [];
		
		for(var i in _cells) {
			 
  			//console.log('_cell:' + _cells[i]);  
	  		var cell = _cells[i];
	  		
	  		if(cell.bd_lon < sw.lng || cell.bd_lat < sw.lat 
					|| cell.bd_lon > ne.lng || cell.bd_lat > ne.lat ){
	  			cell.polygon = null;
				continue ;//不在当前显示范围的point
			}
	  		cell.strokeText = null;
  			var cell_polygon = this.drawCell( ctx ,  cell );
  			 
  			cell.polygon = cell_polygon;
  			
  			if(cell.strokeText)
  				draw_labels.push(cell.strokeText);
  			 
  			//ctx.strokeText(_text,_label_x, _label_y);
			 
  		} 
		
		if(this._label_option) {
			
			var color = this._label_option.color ; 
			var fontsize = this._label_option.size;
			
			ctx.strokeStyle = color
		    ctx.font = fontsize + "px 宋体";
			
			for(var i in draw_labels){
				var l = draw_labels[i];
				ctx.strokeText(l.text,l.x, l.y);
				//_cell.strokeText = {text:_text , x:_label_x , y:_label_y};
			}
		}
		  
		
  		var dat = ctx.getImageData(0, 0, canvas.width, canvas.height);
		   
		ctx.putImageData(dat, 0, 0); 
		 
		 
		canvas.style.left = (offsetX) + 'px';
		canvas.style.top = (offsetY) + 'px';
		
		
		 
	}
	 function getPosition(ev){
         var x, y;
         if (ev.layerX || ev.layerX == 0){
             x = ev.layerX;
             y = ev.layerY;
         }else if (ev.offsetX || ev.offsetX == 0){
             x = ev.offsetX;
             y = ev.offsetY;
       }
       return {x: x,y: y};
	 }
	 
	 
	 function getCenter(polygon) {
		 
		 var minx,miny,maxx,maxy ;
		 for(var i in polygon){
			 var x = polygon[i].x;
			 var y = polygon[i].y;
			 
			 if(!minx || minx > x){
				 minx = x;
			 }
			 if(!miny || miny > y){
				 miny = y;
			 }
			 if(!maxx || maxx < x){
				 maxx = x;
			 }
			 if(!maxy || maxy < y){
				 maxy = y;
			 }
			 
		 }
		 
		 if(minx && miny && maxx && maxy) {
			 return {x:(minx + (maxx - minx)/2) , y:(miny + (maxy-miny)/2)};
		 }
		 
		 return null;
		 
	 }
	 
  