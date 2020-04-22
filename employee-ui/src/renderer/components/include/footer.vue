<template>
	<div class="footer">
    <el-row :gutter="5" class="_footer_row">
        <el-col :span="12"><div  class="_ao">登录人：[{{name}}]&nbsp;&nbsp;</div></el-col>
        <el-col :span="12"><div class="_ao">员工信息管理系统</div></el-col>
    </el-row>

			<!-- <a class="b-lnk-gy" href="/duty" target="_blank">服务协议</a>
			|  -->
			<!-- <a class="b-lnk-gy" href="/copyright" target="_blank">权利声明</a>
			|
			<a class="b-lnk-gy" href="/features" target="_blank">版本更新</a>
			|  -->

      <!-- <span style="float: right;margin-right: 2%;color:black;font-size: 12px;"></span> -->
			<!-- |
			<a class="b-lnk-gy" href="/complaint" target="_blank">版权投诉</a> -->
		
	</div>

</template>
<script>

export default {
	data(){
		return {
      name:'',
		}
	},
  created(){
    this.init();
  },
	methods:{
    init(){
      this.$http({
        url: this.$http.adornUrl(`/sys/user/getinfo`),
        method: "get",
        params: this.$http.adornParams()
      }).then(({data}) => {
        if (data && data.code === 0) {
          this.name = data.user.userNo;
        }
      });
    },
	}
}

</script>
<style>
  ._ao{
    box-shadow:inset 1px 1px 3px #909399;
    color: black;
  }
  ._footer_row{
    width: 99%;
  }
</style>
