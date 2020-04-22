<template>
<div>
 	 <breadcrumb></breadcrumb>  
	<keep-alive>
      <router-view />
    </keep-alive>
</div> 
</template> 

<script>

import breadcrumb from  '@/components/breadcrumb' 
export default {
	components:{
	    breadcrumb
	  },
	name:'BlcakMain',
	data(){
		return {
			 
		}
	},
	created(){

	},
	activated () {
       // 获取当前路由判定是不是带了http


    },
	methods:{

	}
}

</script>