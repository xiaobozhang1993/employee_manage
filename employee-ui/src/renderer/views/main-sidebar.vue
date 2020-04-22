<template>
  <div class="netopt-menu site-sidebar__inner sidebar">
    
   <el-menu
        :default-active="menuActiveId || 'home'"
        :default-expanded-keys="[0]"
        :collapseTransition="true"
        :default-expand-all="true"
        class="site-sidebar__menu">
        <sub-menu
          v-for="menu in menus"
          :key="menu.menuId"
          :menu="menu" >
        </sub-menu>
      </el-menu>
  </div>
</template>
<script>
   import SubMenu from './main-sidebar-sub-menu'
  import { isURL } from '@/utils/validate'
export default {
  data(){
    return{
        sysId:'' ,
         menus: [],
          opens:[], // 默认展开所有菜单
          //menuActiveName:'',
          dynamicMenuRoutes:'',
          noChildMenu:[] , // 没有父子关系的menu
    }
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

   components: {
      SubMenu
    },
    watch: {
      $route: 'routeHandle'
    },
  created(){
 
    this.init() 
 
  },
  methods:{
     // 初始化数据
      init() {
       // this.sysId=sessionStorage.getItem("sysId");
        // /nav/{sysT ype}
        this.$http({
            url: this.$http.adornUrl('/sys/menu/nav'),
            method: 'get',
            params: this.$http.adornParams()
          }).then(({data}) => {
            if (data && data.code === 0) {
              const menus = data.menuList
              //const permissions = data.permissions
              if(menus != null && menus.length > 0) {
                 // 判断菜单几层
                if(menus.length == 1 && menus[0].type < 1) {
                  const ms = menus[0].list
                   // if(ms.length == 1) {
                   //  this.menus = ms[0].list
                   // } else {
                    this.menus = ms
                  // }
                 } else {
                  this.menus = menus;
                 }
              }

              // 展开菜单
              for(var i in this.menus) {
                this.opens.push(this.menus[i].menuId + '')
              }

              //console.log('opens' , this.opens)

              this.$nextTick(() => {
                 this.iteratorNoChildMenu(this.menus , this.noChildMenu)
                 this.routeHandle(this.$route)
              })

              // console.log('this.menus' , this.menus)

            /*   sessionStorage.setItem('permissions', JSON.stringify(data.permissions || '[]'))*/


               this.$nextTick(function(){

                // 取消padding
                let ms = document.getElementsByClassName('el-submenu__title');

                for(var i in ms) {
                  if(typeof ms[i] == 'object')
                    ms[i].removeAttribute('style')

                }

                let ms2 = document.getElementsByClassName('el-menu-item');

                for(var i in ms2) {
                //  console.log('ms2' , ms2[i])
                  if(typeof ms2[i] == 'object')
                    ms2[i].removeAttribute('style')

                }



              })
/*
              this.userId = data.user.userId
              this.userName = data.user.username ? data.user.username : data.user.userNo*/
            }
          })
    },
    routeHandle (route) {
     // console.log('meta' , route)

      // 判断当前是否有选中
      if(!this.menuActiveId) {

        // 根据当前的path 找到具体的menu 拿到name和menuid
        let path = route.path ;

        if(path.indexOf('/') != 0) {
          path = '/' + path;
        }
        const m = this.getMenu(path)
        //console.log('find menu' , m )
        if(m != null) {
          this.menuActiveId = m.menuId + ''
          this.menuActiveName = m.name
        }

      }

       if(!this.menuActiveId) {
            // 筛选当前路由路径  根据顶级路由名称修改 menuActiveId
          let matched = this.$route.matched.filter(item => item.meta && item.meta.title);
          let levelList = matched.filter(item => item.meta && item.meta.title);
          let current=levelList[1];
          let title=current.meta.title;
          let currentMenu=this.noChildMenu.filter(item=>{
            return item.name==title
          });

          if(currentMenu && currentMenu.length > 0 ) {
//            console.log('dd' , currentMenu[0])
            this.menuActiveId = currentMenu[0].menuId.toString();
            this.menuActiveName = currentMenu[0].name;
//            console.log(' this.menuActiveId', this.menuActiveId)
//            console.log(' this.menuActiveName', this.menuActiveName)
          }

       }
      if(route.matched[1]){
       // console.log(1222222)
        let current=this.menus.filter(item=>{
          return item.name==route.matched[1].meta.title
        });
      //  console.log(this.menus)
      //  console.log(current)
        if(current.length>0){
          this.menuActiveId = current[0].menuId.toString();
          this.menuActiveName = current[0].name;
        }
      }


    } ,
    // 生成没有child级别的菜单列表
    iteratorNoChildMenu(menus , noChildMenu) {
      for(let i in  menus) {
        const m =  menus[i];
        noChildMenu.push({menuId: m.menuId , name:m.name , url:m.url ,messageNum:m.messageNum });

        if(m.list && m.list.length > 0) {
          const mlist = m.list
          this.iteratorNoChildMenu(mlist , noChildMenu)
        }

      }
    },
    // 根据path找到menu
    getMenu(path) {

      if(this.noChildMenu == null || this.noChildMenu.length == 0) {
        return null ;
      }

      for(let i in this.noChildMenu) {
        const m = this.noChildMenu[i];
        let url = m.url ;
        if(!url) continue ;
        if(url.indexOf('/') != 0) {
          url = '/' + url
        }
        if(url == path) {
          return m
        }
      }
      return null
    },
   

  }
}

</script>

<style  scoped>
.netopt-menu {
   min-height: 602px;
   background: white;
}
.netopt-menu  .el-menu{
   
    overflow: hidden;
  }

.netopt-menu .el-submenu .el-menu-item {
    height: 35px;
    line-height: 35px;
    padding: 0 30px;
    min-width: 200px;
}

.netopt-menu .el-menu-item, .el-submenu__title {
    height: 50px;
    line-height: 50px;
   
}
</style>
