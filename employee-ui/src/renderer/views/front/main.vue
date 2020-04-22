<template>
  <!-- 招投标系统的入口页面 内带头部和尾部这些 其他详情信息在此跳转 -->
 
      <el-container class="front-main" direction="vertical">
        <el-header class="header" height="40px"> 
          <MainHeader  color="#000000"/>  
        </el-header>
        <el-main  class="main-content">
          <keep-alive>
            <router-view />
          </keep-alive> 
        </el-main>
        <el-footer height="40px"  class="footer">
           <MainFooter />
        </el-footer>
      </el-container>
 
</template>

<script>
  import MainHeader from '@/components/include/header'
  import MainFooter from '@/components/include/footer'
 
  export default {
    data () {
      return {
        loading: true
      }
    },
    components: {
      MainFooter,
      MainHeader 
    },
    computed: {
      
      
    },
    created () {
      
    },
    mounted () {
      
    },
    methods: {
       
      
    }
  }
</script>
<style scoped>
.site-content__wrapper{
  top:57px !important;
}

 .front-main {
 /* min-height: 500px;*/
 height: 100%;
} 

.front-main .header{
   /* 我们希望 header 采用固定的高度，只占用必须的空间 */
   /* 0 flex-grow, 0 flex-shrink, auto flex-basis */
   flex: 0 0 auto;
}

.front-main .main-content{
   /* 将 flex-grow 设置为1，该元素会占用全部可使用空间 
      而其他元素该属性值为0，因此不会得到多余的空间*/
   /* 1 flex-grow, 0 flex-shrink, auto flex-basis */
   flex: 1 0 auto;
   padding: 0px;
   min-height: 500px;
    height: 100%;
}

.front-main .footer{
   /* 和 header 一样，footer 也采用固定高度*/
   /* 0 flex-grow, 0 flex-shrink, auto flex-basis */
   flex: 0 0 auto;
   height: 24px;
}
</style>
