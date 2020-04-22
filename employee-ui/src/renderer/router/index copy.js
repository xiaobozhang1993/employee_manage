/**
 * 全站路由配置
 *
 * 建议:
 * 1. 代码中路由统一使用name属性跳转(不使用path属性)
 */
import Vue from 'vue'
import Router from 'vue-router'
import http from '@/utils/httpRequest'
import {isURL} from '@/utils/validate'
import {clearLoginInfo, getQueryString} from '@/utils'

const session     = require('electron').remote.session;

Vue.use(Router)

// 开发环境不使用懒加载, 因为懒加载页面太多的话会造成webpack热更新太慢, 所以只有生产环境使用懒加载
const _import = require('./import-' + process.env.NODE_ENV)

// 全局路由(无需嵌套上左右整体布局)
const globalRoutes = [
  {path: '/404', component: _import('common/404'), name: '404', meta: {title: '404未找到', isLogin: false}},
  {path: '/login', component: _import('common/login'), name: 'login', meta: {title: '登录', isLogin: false}},

]


// 后端整体嵌套路由
const userRoutes = {
  path: '/',
  component: _import('main'),
  name: 'user_main',
  redirect: {name: 'index'},
  meta: {title: '首页', breadcrumb: false},
  children: [
    {
      path: '/index',
      component: _import('modules/index'),
      name: 'index',
      meta: {title: '信息概览', isTab: false, isLogin: true}
    }
  ],
  beforeEnter(to, from, next) {
    let token = Vue.cookie.get('token')
    if (!token || !/\S/.test(token)) {
      clearLoginInfo()
      next({name: 'login'})
    }
    next()
  }
}


const router = new Router({
  mode: 'hash',
//  base: '/netopt',
  scrollBehavior: () => ({y: 0}),
  isAddDynamicMenuRoutes: false, // 是否已经添加动态(菜单)路由
  routes: globalRoutes.concat(userRoutes)
})


/*
router.beforeEach((to, from, next) => {
  //   判断目的路由是否需要登录,如果不需要登录则直接next
  //console.log('to' , to)
  //console.log('from' , from)
  //console.log('store' , store.state.user)
  // 判断是否登录
  if(!to.meta.isLogin) {
     next() ;
     return ;
  }

  let token = Vue.cookie.get('token') ;

  // 判断url里是否有token
  if(!token) {
    const tk_ = getQueryString('token')
    //console.log('tk_' , tk_)
    if(tk_){
      token = tk_
      Vue.cookie.set('token',token) ;
    }

  }

  // 判断账号是否已经登录
  if( token && token.length > 0){
     next() ;
     return ;
  }

  // 跳转登录页

    next({name:'login',query: {redirect: to.fullPath} })


})
*/

router.beforeEach((to, from, next) => {
  // next() ;
  // 添加动态(菜单)路由
  // 1. 已经添加 or 全局路由, 直接访问
  // 2. 获取菜单列表, 添加并保存本地存储
  console.log('isAddDynamicMenuRoutes', router.options.isAddDynamicMenuRoutes)
  console.log('to', to)
  console.log("进入了beforEach")
  if (router.options.isAddDynamicMenuRoutes || (to.meta && to.meta.isLogin != null && to.meta.isLogin == false)) {
    console.log("进入了beforEachrouter.options.isAddDynamicMenuRoutes "+router.options.isAddDynamicMenuRoutes )
    next()
  } else {
    session.defaultSession.cookies.get({ url: this.webApi }, function (error, cookies) {
      console.log(cookies);
      if (cookies.length > 0) {
        _this.logText = cookies[0].value;
        if(cookies.length>1)
        {
          _this.pwdText = cookies[1].value;
          _this.checkState=true;       
          $(".layui-unselect").addClass("layui-form-checked"); 
        }
      }
    });
    session.defaultSession.cookies.get({ url: "http://www.github.com" }, (error, cookies)=>{
      console.log(cookies);
      if (cookies.length > 0) {
        var length = cookies.length;
        for(var i=0;i<length;i++){
         console.log(i);
         var _myName =  cookies[i].name;
         console.log("获取到name",_myName)
         if(name == "token" ){
            var token =  cookies[i].value;
            if (!token || token.length < 1) {
              console.log("token.length1",token )
              next({name: 'login'})
              return;
            }
            console.log("开始请求/sys/menu/nav")
            http({
              url: http.adornUrl('/sys/menu/nav'),
              method: 'get',
              params: http.adornParams()
            }).then(({data}) => {
              console.log("请求/sys/menu/nav结果",data)
              if (data && data.code === 0) {
                console.log("请求/sys/menu/nav成功",data)
                fnAddDynamicMenuRoutes(data.menuList)
                router.options.isAddDynamicMenuRoutes = true
                sessionStorage.setItem('menuList', JSON.stringify(data.menuList || '[]'))
                sessionStorage.setItem('permissions', JSON.stringify(data.permissions || '[]'))
                next({...to, replace: true})
              } else {
                console.log("请求/sys/menu/nav失败",data)
                sessionStorage.setItem('menuList', '[]')
                sessionStorage.setItem('permissions', '[]')
                next({name: 'login'})
        
              }
            }).catch(err => {
                
                console.log('error' , err)
                  clearLoginInfo()
                next({ name: 'login' })
                //  reject(err)
              })
         }
        }
      }     
    });


    let token = Vue.cookie.get('token');
    console.log("token.length",token )
    // 判断账号是否已经登录
    if (!token || token.length < 1) {
      console.log("token.length1",token )
      next({name: 'login'})
      return;
    }
    console.log("开始请求/sys/menu/nav")
    http({
      url: http.adornUrl('/sys/menu/nav'),
      method: 'get',
      params: http.adornParams()
    }).then(({data}) => {
      console.log("请求/sys/menu/nav结果",data)
      if (data && data.code === 0) {
        console.log("请求/sys/menu/nav成功",data)
        fnAddDynamicMenuRoutes(data.menuList)
        router.options.isAddDynamicMenuRoutes = true
        sessionStorage.setItem('menuList', JSON.stringify(data.menuList || '[]'))
        sessionStorage.setItem('permissions', JSON.stringify(data.permissions || '[]'))
        next({...to, replace: true})
      } else {
        console.log("请求/sys/menu/nav失败",data)
        sessionStorage.setItem('menuList', '[]')
        sessionStorage.setItem('permissions', '[]')
        next({name: 'login'})

      }
    }).catch(err => {
        
        console.log('error' , err)
        clearLoginInfo()
        next({ name: 'login' })
        //  reject(err)
      })
  }
})

/**
 * 根据菜单生产路由
 */
function createRoutes(menuList = [], routes = []) {

  for (var i = 0; i < menuList.length; i++) {

    const menu = menuList[i];

    // 类型不是菜单和按钮得直接跳过去
    if (menu.type < 1) {
      if (menu.list && menu.list.length > 0) {
        createRoutes(menu.list, routes)

      }

      continue

    }

    if (menu.type == 2) continue

    // 菜单和按钮级别必然要添加路由
    console.log('menu', menu)
    let route = {
      path: menu.url ? menu.url : menu.routeName,
      component: null,
      name: menu.routeName,
      meta: {
        menuId: menu.menuId,
        title: menu.name,
        componentUrl: menu.componentUrl,
        isDynamic: true,
        isTab: false,
        iframeUrl: ''
      }
    }

    // 如果有url则挂载组件
    if (menu.url) {
      let url = menu.url;
      /* if(url && url.indexOf('/') != 0) {
         url = '/' + url
       }*/


      // 判断是否有下一级,如果有则挂载子路由，当前路由指向默认创建得子路由
      if (menu.list && menu.list.length > 0) {
        console.log('#################')
        route['component'] = _import(`modules/` + menu.componentUrl)
        // route['redirect'] =  {name : menu.routeName + '_list'}
        //route['children'] = []

        // 2019-11-11 从下一级菜单中获取第一个作为默认跳转

        /*  try {
            let c = {
                path: url + '/list',
                component: _import(`modules/${menu.componentUrl}`) || null,
                name: menu.routeName + '_list',
                meta: { title: '列表',isTab:false,isLogin:true ,breadcrumb: false}
              }
              console.log('cddddd' , c)
            route['children'].push(c)
          } catch (e) {
              console.log('load component ddddd ' , e)

          }*/
        let childRoutes = []
        // 循环下一级
        createRoutes(menu.list, childRoutes)


        if (childRoutes && childRoutes.length > 0) {
          route['redirect'] = {name: menu.list[0].routeName}
          route['children'] = childRoutes

        }


      } else {
        if (isURL(menu.url)) {
          route['path'] = `i-${menu.menuId}`
          route['name'] = `i-${menu.menuId}`
          route['meta']['iframeUrl'] = menu.url
        } else {
          try {
            console.log('url', menu.url)
            route['component'] = _import(`modules/${menu.componentUrl}`) || null
          } catch (e) {
            console.log('error', menu)
            console.log('load component ', e)

          }
        }
      }

    }

    console.log('route', route)
    routes.push(route)

  }

}


/**
 * 添加动态(菜单)路由
 * @param {*} menuList 菜单列表
 * @param {*} routes 递归创建的动态(菜单)路由
 */
function fnAddDynamicMenuRoutes(menuList = [], routes = []) {

  createRoutes(menuList, routes)
  // if (temp.length >= 1) {
  //   fnAddDynamicMenuRoutes(temp, routes)
//  } else {
  // mainRoutes.name = 'main-dynamic'

  console.log('routes', routes)
  userRoutes.children = routes
  router.addRoutes([
    userRoutes,
    {path: '*', redirect: {name: '404'}}
  ])
  sessionStorage.setItem('dynamicMenuRoutes', JSON.stringify(userRoutes.children || '[]'))
  console.log('\n')
  console.log('%c!<-------------------- 动态(菜单)路由 s -------------------->', 'color:blue')
  console.log(userRoutes.children)
  console.log('%c!<-------------------- 动态(菜单)路由 e -------------------->', 'color:blue')
}

//}


export default router
