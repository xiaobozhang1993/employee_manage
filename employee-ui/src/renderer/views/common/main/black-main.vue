<template>
<div>
 
	<keep-alive>
      <router-view />
    </keep-alive>
</div> 
</template> 

<script>
export default {
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