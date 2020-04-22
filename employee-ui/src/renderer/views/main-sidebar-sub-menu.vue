<template>
  <el-submenu

    v-if="menu.list && menu.list.length >= 1"
    :index="menu.menuId + ''" >
    <template slot="title"  >
      <icon-svg :name="menu.icon || ''" class="site-sidebar__menu-icon"></icon-svg>
      <el-badge :value="menu.messageNum" class="badgeItem" :max="99" :hidden="menu.messageNum > 0 ? false : true">
        <span class="pname">{{ menu.name }}</span>
      </el-badge>
    </template>
    <sub-menu
      v-for="item in menu.list"
      :key="item.menuId + ''"
      :index="item.menuId + ''"
      :zoom="zoom+1"
      :menu="item"
      :dynamicMenuRoutes="dynamicMenuRoutes" >
    </sub-menu>
  </el-submenu>
  <el-menu-item v-else-if="zoom == 1 && menu.type == 2"  :index="menu.menuId + ''"  @click="gotoRouteHandle(menu)">
    <template slot="title"  >
      <icon-svg :name="menu.icon || ''" class="site-sidebar__menu-icon"></icon-svg>
      <el-badge :value="menu.messageNum" class="badgeItem" :max="99" :hidden="menu.messageNum > 0 ? false : true">
        <span class="pname">{{ menu.name }}</span>
      </el-badge>
    </template>
  </el-menu-item>
  <el-menu-item  v-else style="padding-left: 22px;"  :index="menu.menuId + ''" @click="gotoRouteHandle(menu)">
  <!--   <icon-svg :name="menu.icon || ''" class="site-sidebar__menu-icon"></icon-svg> -->
    <span class="subPoint cname" >
      ·
    </span>
    <el-badge :value="menu.messageNum" class="badgeItem-children" :max="99" :hidden="menu.messageNum > 0 ? false : true">
      <span class="cname">{{ menu.name }}</span>
    </el-badge>
  </el-menu-item>
</template>

<script>
  import SubMenu from './main-sidebar-sub-menu'
  export default {
    name: 'sub-menu',
    data(){
      return {
        dynamicMenuRoutes:'',
      }
    },
    props: {
      menu: {
        type: Object,
        required: true
      },
      zoom: {
        type: Number,
        required: false,
        default: 1
      }

    },
    components: {
      SubMenu
    },
    computed: {
      menuActiveName: {
        get () { return this.$store.state.common.menuActiveName },
        set (val) { this.$store.commit('common/updateMenuActiveName', val) }
      },
      menuActiveId: {
        get () { return this.$store.state.common.menuActiveId },
        set (val) { this.$store.commit('common/updateMenuActiveId', val) }
      },
    },
    methods: {
      // 通过menuId与动态(菜单)路由进行匹配跳转至指定路由
      gotoRouteHandle (menu) {

        let url = menu.url;
         // if(url.indexOf('/') != 0) {
         //    url = '/' + url
         //  }
         //  this.menuActiveName = menu.name
         //  this.menuActiveId = menu.menuId + ''
         //  this.$router.push({ path: url })

         let name = url.replace(/\//g, '-')
          this.$router.push({ name: name })


      },

    }
  }
</script>
<style scoped>


  .pname{ 
    font-size: 14px;

    letter-spacing: 0;
    line-height: 16px;
    display: block;
    width: 70px;
  }
  .cname{ 
    font-size: 12px;

    letter-spacing: 0;
    line-height: 12px;
    display: block;
    width: 70px;
  }

  .subPoint{
    width: 26px;
    display: -moz-inline-box;
    display: inline-block;
    /* width: 150px; */
    text-align: center;
    padding-left: -20px;
    margin-right: 10px
  }
.el-menu-item, .el-submenu__title{
  padding-left: 12px!important;
}
</style>
<style>
  .badgeItem .el-badge__content.is-fixed{
    top: 7px !important;
    right: -5px !important;
  }
  .badgeItem-children .el-badge__content.is-fixed{
    top: 5px !important;
    right: -5px !important;
  }

</style>
