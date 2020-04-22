import Vue from 'vue'
import App from '@/App'
import router from '@/router'                 // api: https://github.com/vuejs/vue-router
import store from '@/store'                   // api: https://github.com/vuejs/vuex
import VueCookie from 'vue-cookie'            // api: https://github.com/alfhen/vue-cookie
import '@/element-ui'                         // api: https://github.com/ElemeFE/element
import '@/icons'                              // api: http://www.iconfont.cn/
//import '@/element-ui-theme'
import 'element-ui/lib/theme-chalk/index.css'
import '@/assets/scss/index.scss'
import httpRequest from '@/utils/httpRequest' // api: https://github.com/axios/axios
import { isAuth,toRoute ,back} from '@/utils'
import { tableRowClassName} from '@/utils/elementTable'
import cloneDeep from 'lodash/cloneDeep'
import dict from '@/components/utils/dict.vue'
import dictSelect from '@/components/utils/dict-select.vue'
import echarts from 'echarts'
import {headerStryle,contentHeight} from  '@/utils/styleHeight'

const dictComponent={
    install:function(Vue){
        Vue.component('dict',dict)
    }  //'Loading'这就是后面可以使用的组件的名字，install是默认的一个方法
};


const dictSelectComponent={
    install:function(Vue){
        Vue.component('dict-select',dictSelect)
    }  //'Loading'这就是后面可以使用的组件的名字，install是默认的一个方法
};

Vue.use(VueCookie)
Vue.config.productionTip = false


// 挂载全局
Vue.prototype.$http = httpRequest // ajax请求方法
Vue.prototype.isAuth = isAuth     // 权限方法
Vue.prototype.toRoute = toRoute     // 权限方法 toRoute
Vue.prototype.back = back     // 权限方法 toRoute
Vue.prototype.$echarts = echarts //echarts
Vue.prototype.heightStyle    = headerStryle
Vue.prototype.contentHeight  = contentHeight
Vue.prototype.tableRowClassName  = tableRowClassName



Vue.use(dictComponent)
Vue.use(dictSelectComponent)

// 保存整站vuex本地储存初始状态
window.SITE_CONFIG['storeState'] = cloneDeep(store.state)
// main.js里面使用
import VueCropper from 'vue-cropper'
Vue.use(VueCropper)
Vue.directive('loadmore', {
  bind(el, binding) {
    const selectWrap = el.querySelector('.el-table__body-wrapper')
    selectWrap.addEventListener('scroll', function() {
      let sign = 0
      const scrollDistance = this.scrollHeight - this.scrollTop - this.clientHeight-33
      if (scrollDistance <= sign) {
        binding.value()
      }
    })
  }
})
/* eslint-disable no-new */
new Vue({
  el: '#app',
  router,
  store,
  template: '<App/>',
  components: { App }
})