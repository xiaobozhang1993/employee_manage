<template>
	<el-container class="menu-container">
	  <el-aside width="150px">
	  	<div style="height: 100%;">
		  	<el-menu class="container-main-menu" style="border-right-width: 3px;">
		  	 <el-menu-item
		  	  	v-for="item in menus"
		  	  	:key="item.menuId"
			    :index="item.menuId " @click="go(item)">
			    <span class="subPoint cname" >
			      <icon-svg :name="item.icon || ''" class="site-sidebar__menu-icon"></icon-svg>
			    </span>
			      <span class="cname">{{ item.name }}</span>

			</el-menu-item>
			</el-menu>
		</div>
	  </el-aside>
	  <el-main style="overflow:hidden">
	  	<keep-alive>
      		<router-view style="height:100%" />
    	</keep-alive>
	  </el-main>
	</el-container>
</template>
<script>
export default {
	data() {
		return {
			id: '',
			menus: []
		}
	},
//	props: {
	// 	menus:{
	//       type: Array ,
	//       default: ()=>{return []}
	//     },
	// },
	activated () {
      const routeMatched = this.$route.matched

 	 for(var i in routeMatched){
 	 	if(routeMatched[i].meta && routeMatched[i].meta.componentUrl && routeMatched[i].meta.componentUrl.indexOf('menu-main') >= 0) {
 	 		console.log('dddddddddddddddddd')
 	 		this.init(routeMatched[i].meta.menuId)
 	 		return ;
 	 	}


 	 }

    },
	methods: {
		init(menuId) {
			// 从当前权限中判断哪些菜单要出来
			// childByPerm
			this.$http({
	            url: this.$http.adornUrl(`/sys/menu/childById?id=` + menuId ),
	            method: 'get',
	            params: this.$http.adornParams()
	          }).then(({data}) => {
	            if (data.code === 0) {
	              this.menus = data.data

	              // 不为空 跳第一个路由
	              /*if(this.menus && this.menus.length > 0) {
	              	const routeName = this.menus[0].routeName;

	              	  this.$router.push({ name: routeName })
	              }
*/
	            }

	          })

		},
		go(menu) {
			let name = menu.routeName
          	this.$router.push({ name: name })
		}

	}
}

</script>
<style>
.menu-container {
	height: 100%;

}
.menu-container ul {
	height: 100%;
	padding-left: 10px;
}

.menu-container .container-main-menu {
	/*padding-top: 20px;*/
}



</style>
