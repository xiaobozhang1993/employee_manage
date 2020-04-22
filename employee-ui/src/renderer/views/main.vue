<template>
  <!-- 个人中心框架页 -->
  <div style="background:#f4f4f4;"  >

    <el-container class="content-container">
      <el-header height="97px" style="background-color:white;border-top: 1px solid rgb(230, 230, 230);">
         <!-- 头部信息 -->
        <MainHeader style="height:97px" @reload="reload"> </MainHeader> 
      </el-header>
      <el-main :style="{ 'min-height': documentClientHeight + 'px' ,
                         'height': documentClientHeight + 'px',
                         'background-color': '#F4F4F4',
                         'overflow':'hidden',
                         'margin':'10px'}">
          <!--内容区-->
          <!--  <el-aside width="150px" class="backAside">

            <sidebar/>

          </el-aside> -->
          <!--  <breadcrumb></breadcrumb>   -->
         <keep-alive>
              <router-view v-if="isRouterAlive" />
          </keep-alive> 
      </el-main>
      <el-footer height="30px">
         <MainFooter></MainFooter>
      </el-footer>
    </el-container>


   
   
 <!--    <div class="kuandu">
    <el-row>
 
       <el-col :span="24">
        <el-container class="content-container">
         
          <el-main>
       
            <keep-alive>
              <router-view />
            </keep-alive>
          </el-main>
      </el-container>
       </el-col>

    </el-row>
    </div>
    <el-row>
      <MainFooter></MainFooter>
    </el-row> -->
  </div>
</template>
<script>

import breadcrumb from  '@/components/breadcrumb' 
import sidebar from './main-sidebar';  

import MainHeader from '@/components/include/header'
import MainFooter from '@/components/include/footer'
 

export default {
  name:'tender-manager-main' ,
  data() {
    return {
      documentClientHeight: 550,
      login:false, // 是否登陆
      isRouterAlive:true
    }
  } ,
  components:{
    sidebar, breadcrumb,MainHeader,MainFooter
  },
  computed:{

        userId: {
          get () { return this.$store.state.user.id },
          set (val) { this.$store.commit('user/updateId', val) }
        },
        userName: {
          get () { return this.$store.state.user.name },
          set (val) { this.$store.commit('user/updateName', val) }
        },
         menuActiveName: {
        get () { return this.$store.state.common.menuActiveName },
        set (val) { this.$store.commit('common/updateMenuActiveName', val) }
      },
  },
  mounted () {
      this.resetDocumentClientHeight()
  },
  created(){
    
  },

  methods:{
    handleOpen(key, keyPath) {
      //console.log(key, keyPath);
    },
    handleClose(key, keyPath) {
      //console.log(key, keyPath);
    },
     
    resetDocumentClientHeight () {
        this.documentClientHeight =document.documentElement['clientHeight'] - 31 - 97 - 20 - 30
        window.onresize = () => {
          this.documentClientHeight = document.documentElement['clientHeight'] -  31 - 97 -20  - 30
        }
    },
     reload(){
       this.isRouterAlive = false
       this.$nextTick(function(){
          this.isRouterAlive = true
       })
     },
    // 个人中心
    goUserHome() {
    /*  let routeUrl = this.$router.resolve({
              path: "/user",
              // query: {id:96}
         });
         window.open(routeUrl.href, '_blank');
*/
      this.$router.replace({  path: "/user"})
    },
      
  }
}


</script>

<style>
  .content-container{  
    min-height: 550px!important;
  }

  
  .el-main{
    padding: 0px 0px 0px 0px!important;
  }
    
</style>


