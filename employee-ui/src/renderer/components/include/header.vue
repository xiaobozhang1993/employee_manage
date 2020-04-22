<template>
  <div>
    <div class="header-menu" style="border-bottom: solid 1px #e6e6e6;padding: 3px;background-color: rgb(240,240,240)">
      <el-row class="menu-context">
        <el-menu :default-active="activeIndex" menu-trigger="hover" class="el-menu-demo "  mode="horizontal"
                 @select="handleSelect"
                 text-color="#000"
        >
          <div class=" header_tc" ></div>
          <template v-for="(item,index)  in menus" v-if="item.locationType === 1">

            <el-submenu :index="item.menuId" :key="'one'+index" class="worlin"
                        v-if="item.list && item.list.length > 0 && item.routeOnly == 1">
              <template slot="title">
                <icon-svg v-if="item.icon" :name="item.icon"></icon-svg>
                <span>  {{item.name}}  </span>
              </template>
              <el-menu-item :index="i2.menuId" v-if="i2.routeOnly === 1" v-for="i2 in item.list" :key="i2.menuId"
                            @click="gotoRouteHandle(i2)">
                <icon-svg v-if="i2.icon" :name="i2.icon"></icon-svg>
                <span>  {{i2.name}}   </span>
              </el-menu-item>

            </el-submenu>
            <el-menu-item :index="item.menuId" :key="'two'+index" v-else-if="item.routeOnly == 1"  class="worlin"
                          @click="gotoRouteHandle(item)">
              <icon-svg :name="item.icon"></icon-svg>
              {{item.name}}
            </el-menu-item>
          </template>
        </el-menu>
      </el-row>

    </div>
    <el-row class="menu-context tool-context">
      <ul class="icon-list" style="background-color: rgb(240,240,240)">
        <li @click="goBack()">
          <span>
             <span class="el-popover__reference" aria-describedby="el-popover-4200" tabindex="0">
               <icon-svg name="back" className="tool-icon"></icon-svg>
              <span class="icon-name">&nbsp;&nbsp;返&nbsp;&nbsp;回&nbsp;&nbsp;</span>
            </span>
          </span>
        </li>

      </ul>
    </el-row>


  </div>

</template>

<script>
  import {isURL} from '@/utils/validate'
  import {clearLoginInfo} from '@/utils'
  import $ from 'jquery'

  export default {
      inject: ['reload'],//刷新当前页面
    data() {
      return {
        //是离职
        isDimission: false,
        //离职工具栏
        dimissionMenu: [],
        isBack: false,
        visibleTool: false,
        activeIndex: '1',
        menus: [ // 第一层和第二层得菜单

        ]
      }
    },
    computed: {

      userId: {
        get() {
          return this.$store.state.user.userId
        },
        set(val) {
          this.$store.commit('user/updateId', val)
        }
      },
      userName: {
        get() {
          return this.$store.state.user.name
        },
        set(val) {
          this.$store.commit('user/updateName', val)
        }
      },
      orgId: {
        get() {
          return this.$store.state.user.orgId
        },
        set(val) {
          this.$store.commit('user/updateOrgId', val)
        }
      },
      headImage: {
        get() {
          return this.$store.state.user.headImage
        },
        set(val) {
          this.$store.commit('user/updateHeadImage', val)
        }
      },


    },
    watch: {
      "$route": function (to, from) {
        var path = to.path;
        if (path.indexOf('/employee/dimission') !== -1) {
          this.isDimission = true;
        } else {
          this.isDimission = false;
        }
      }
    },
    created() {
      this.initMenus()
      this.initUser()
    },
    methods: {
      initMenus() {
        this.$http({
          url: this.$http.adornUrl('/sys/menu/nav'),
          method: 'get',
          params: this.$http.adornParams()
        }).then(({data}) => {
          if (data && data.code === 0) {
            var menus = [];
            var dimissionMenu = []
            menus = data.menuList
            //离职人员工具栏
            dimissionMenu = data.departingTools;

            console.log(this.dimissionMenu);
            for (var i = 0; i < menus.length; i++) {
              menus[i].visibleTool = false
              this.menus.push(menus[i])
            }
            for (var i = 0; i < dimissionMenu.length; i++) {
              dimissionMenu[i].visibleTool = false
              this.dimissionMenu.push(dimissionMenu[i])
            }
            this.activeIndex = this.menus[0].menuId

            console.log(this.menus);
          }
        });


      },
      handleSelect(key, keyPath) {
        console.log(key, keyPath);

      },
      initUser() {
        this.$http({
          url: this.$http.adornUrl('/sys/api/user/info'),
          method: 'get',
          params: this.$http.adornParams()
        }).then(({data}) => {
          if (data && data.code === 0) {
            this.userId = data.user.userId
            this.userName = data.user.userName
            this.orgId = data.user.orgId
            this.headImage = data.user.logo
          }
        });

      },
      
      //路由跳转方法e
      gotoRouteHandle(menu, index) {
        //激活当前菜单栏
        this.activeIndex = menu.menuId
        console.log('click menu', menu)
        let name = menu.routeName
        this.clickCloseAllToolMenu();
        menu.visibleTool = true
        this.$router.push({name: name})
      },
      //点击信息栏,跳转到首页
      clickToIndexPage() {
        //清除菜单栏选中效果
        this.activeIndex = undefined
        this.clickCloseAllToolMenu();
        this.toRoute('/index', 'this')
        setTimeout(() => {
          this.isA = false
        }, 500)
      },
      //点击工具栏,关闭其他的弹出页面
      clickCloseAllToolMenu() {
        for (var i = 0; i < this.menus.length; i++) {
          this.menus[i].visibleTool = false
        }
      },
      //工具栏菜单点击后关闭展开的列表
      gotoRouteHandleTool(menu, item) {
        //清除菜单栏选中效果
        this.activeIndex = undefined
        console.log(menu)
        let name = menu.routeName
        item.visibleTool = false;
        this.$router.push({name: name})
      },
      goBack() {
        this.isBack = true;
        setTimeout(() => {
          this.isBack = false;
        }, 500);
        this.back();
      },
     /* reload(){
            this.$emit('reload');
      }*/
    }
  }


</script>
<style>

  .el-menu {

  }

  .el-menu.el-menu--horizontal{
        border-bottom: solid 0px #e6e6e6;
  }
  .el-menu-demo {
    /* background-color: #F4F4F4 */
    background-color: rgb(240,240,240);
  }

  .el-menu-item {
    font-size: 12px;
    height: 24px !important;
    line-height: 24px !important;

  }

  .el-submenu__title {
    height: 24px !important;
    line-height: 24px !important;
  }

  .header-div {
    font-size: 12px;
    /* color: #FFFFFF; */
    line-height: 24px;
    height: 24px;
    padding-left: 10px;
    padding-right: 50px;
  }

  .header-div a:hover {
    text-decoration: none;
  }

  .header-menu .menu-context {
    line-height: 24px;
    height: 24px;
    background-color: #F4F4F4
  }

  .header-menu ul li {
    line-height: 24px;
    height: 24px;
  }

  .header-menu .el-submenu__title {
    line-height: 24px;
    height: 24px;
    padding: 0 10px !important;
  }

  .header-menu .el-menu-item {
    font-size: 12px !important;
  }

  .header-menu .el-menu.el-menu--horizontal {
    line-height: 24px;
    height: 24px;
  }

  .header-menu .el-menu--horizontal > .el-menu-item {
    line-height: 24px;
    height: 24px;
    padding: 0 10px;
  }

  .header-menu .el-submenu__title {
    line-height: 24px !important;
    height: 24px !important;
    font-size: 12px;
  }

  .el-menu--popup {
    min-width: 110px;
    /* padding-left: 10px;*/
  }

  .el-menu-item [class^=el-icon-] {
    margin-right: 0px;
    width: 18px;
  }

  .header-menu .el-menu--horizontal .el-submenu__title {
    line-height: 24px !important;
    height: 24px !important;
    font-size: 12px !important;
  }

  el-submenu {
    padding: 2px;
  }

  .el-menu--horizontal > .el-submenu .el-submenu__title:hover {
    background-color: #F4F4F4;
    border-bottom: none;
    box-shadow:
      -1px 0px 1px white,   /*左边阴影*/
      0px -1px  1px white,  /*上边阴影*/
      1px 0px  1px #888888,  /*右边阴影*/
      0px 1px 1px #888888; /*下边阴影*/
  }

  .el-menu--horizontal > .el-menu-item:not(.is-disabled):hover {
    background-color: #F4F4F4;
  }

  /*horizontal>.el-submenu.is-active .el-submenu__title{*/
  /*background-color: #F4F4F4;*/
  /*border-bottom: none;*/
  /*}*/

  /*第一层工具栏鼠标悬浮放置效果*/
  .header-menu div ul li:hover {
    background-color: white;
    box-shadow:
      -1px 0px 1px white,   /*左边阴影*/
      0px -1px  1px white,  /*上边阴影*/
      1px 0px  1px #888888,  /*右边阴影*/
      0px 1px 1px #888888; /*下边阴影*/
  }

  .el-menu--horizontal > .el-menu-item.is-active {
    border-bottom: none;
    background-color: #F4F4F4;
  }

  /*第二层工具栏鼠标悬浮放置效果*/
  .icon-list li > span {
    margin: 5px;
    margin-top: 0px;
    margin-bottom: 0px;
  }

  .icon-list li > span:active {
    border-style:inset;
    border-color:white #888888 #888888  white;
  }



  .el-popover {
    min-width: 70px !important;

  }

  .el-menu-item:hover{
     background-color: #3D96D8 !important;
     color: #fff !important;
  }
  .el-submenu__title:hover{
      background-color: #3D96D8 !important;
         color: #fff !important;
  }
</style>



<style scoped>
  .page-component .content > ul:not(.timeline) {
    margin: 10px 0;
    padding: 0 0 0 20px;
    font-size: 16px;
    color: #5e6d82;
    line-height: 2em;
  }



  .page-component .content > ul.icon-list {

    overflow: hidden;
    list-style: none;
    padding: 0 !important;
    border: 1px solid #eaeefb;
    border-radius: 4px;
  }

  .icon-list {
    list-style-type: none;
  }

  .icon-list li {
    display: inline-flex;
    width: 95px;
    text-align: center;
    justify-content: center;
    align-items: center;
    height: 60px;
    line-height: 60px;
    color: #000;
    font-size: 12px;
    cursor: pointer;
    border-right-style: ridge;
    border-right: 1px solid #DDDDDD;
    /* margin-right: 5px;
    margin-left: 5px; */
  }



  .icon-list li i {
    display: block;
    font-size: 32px;
    /* margin-bottom: 15px;*/
    color: #606266;
    transition: color .15s linear;
  }

  [class*=" el-icon-"], [class^=el-icon-] {
    font-family: element-icons !important;
    speak: none;
    font-style: normal;
    font-weight: 400;
    font-variant: normal;
    text-transform: none;
    line-height: 1;
    vertical-align: baseline;
    display: inline-block;
    -webkit-font-smoothing: antialiased;
    -moz-osx-font-smoothing: grayscale;
  }

  .icon-list li .icon-name {
    display: inline-block;
    padding: 3px 3px;
    height: 1em;
    line-height: 1em;
    color: #000;
  }

  .icon-list li span {
    line-height: normal;
    color: #99a9bf;
    transition: color .15s linear;
  }

  .icon-list li:after, .icon-list li span {
    display: inline-block;
    vertical-align: middle;
  }

  .icon-list li:after {
    content: "";
    height: 100%;
  }

  .el-popover .el-menu {
    border-right: none !important;
  }

  .el-popover .el-menu-item {
    padding-left: 5px !important;
  }

  .header-menu .el-menu--horizontal > .el-submenu .el-submenu__icon-arrow {
    margin-left: 1px;
  }

  .header-menu .el-submenu [class^=el-icon-] {

    margin-right: 0px;
    width: 18px;
    text-align: center;
  }

  .tool-icon {
    width: 30px !important;
    height: 30px !important;
  }

  .header-menu .el-menu--horizontal .el-menu .el-menu-item, .el-menu--horizontal .el-menu .el-submenu__title {
    padding: 0 5px;
  }

  ._system_exit:hover{
    background-color: red !important;
    color: black !important;
  }


</style>
