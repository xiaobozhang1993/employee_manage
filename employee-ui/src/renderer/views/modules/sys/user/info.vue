<template>
  <el-container class="con_bg"   :style="{'height':asideHeight+'px'}">
      
          <info-main v-if="visible"></info-main>
          <password-main v-if="!visible"></password-main>
    <!-- 图像上传组件-->
    <photograph v-if="photographVisible" ref="openPhotograph" @watchData="photograph(arguments)"></photograph>
  </el-container>

</template>

<script>
  import photograph from "@/components/common/photograph"
  import passwordMain from './password_main.vue'
  import logo from "@/assets/img/bg1.png";
  export default {
    data() {
      return {
        visible:true,
        photographVisible: false,
        logo:logo,
        menu_active:'',
        dataForm:{
          photoPath:''
        }
      };
    },
    activated:{

    },
    created() {
      this.photo = logo;
      this.getDataList();
    },
    components:{
      photograph,
      passwordMain
          },
    watch:{
        //from 对象中包含当前地址
        //to 对象中包含目标地址
        //其实还有一个next参数的，这个参数是控制路由是否跳转的，如果没写，可以不用写next()来代表允许路由跳转，如果写了就必须写next(),否则路由是不会生效的。
        "$route":function(to,from){
          var path = to.path;
          if(path.indexOf('password')!==-1){
              this.menu_active = '1';
              this.visible = false
          }else{
              this.menu_active = '0';
              this.visible = true
          }
  }

    },
    computed: {
        headImage: {
          get() {
            return this.$store.state.user.headImage;
          }
        }, 
      //计算内部元素的高度
      asideHeight: function () {
        return document.documentElement['clientHeight'] - 110 - 25-20
      }
  },
    mounted(){
        this.menuactive();
    },
    activated(){

        this.menuactive();

    },
    methods: {
      //激活菜单选项
      menuactive(){
          var path = this.$route.path
          if(path.indexOf('password')!==-1){
              this.menu_active = '1';
              this.visible = false
          }else{
              this.menu_active = '0';
          }
      },
      getDataList(){
        this.$http({
          url: this.$http.adornUrl(`/sys/user/getinfo`),
          method: "get",
          params: this.$http.adornParams()
        }).then(({data}) => {
          if (data && data.code === 0) {
            this.dataForm.photoPath = data.user.logo;
          }
        });
      },
      upload() {
        this.photographVisible = true
        this.$nextTick(() => {
          this.$refs.openPhotograph.init()
        })
      },
      //监听子组件图片上传
      photograph(data) {
        for (let item in data[0]) {
          this.dataForm[item] = data[0][item];
        }
      },
      //账户管理
      account_mana() {
        this.visible =true;
      },
      //密码修改
      pass_modi() {
        this.visible =false;
      },
    }
  }
</script>
<style scoped>
  .el-menu{
        border-right: solid 0px #e6e6e6;
  }
</style>
<style>


  .row-bg{
    padding: 10px 0;
    background-color: #f9fafc;
  }
  .int_main_form{
    padding: 100px
  }
</style>
