import Vue from 'vue'
import router from '@/router'
import store from '@/store'
import {isURL} from './gis/validate'
const root = process.env.API_ROOT

export default root;

/**
 * 获取uuid
 */
export function getUUID () {
  return 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, c => {
    return (c === 'x' ? (Math.random() * 16 | 0) : ('r&0x3' | '0x8')).toString(16)
  })
}


export function endWith(s1 , s2){
  if(s2==null||s2==""||s1.length==0||s2.length>s1.length)
     return false;
  if(s1.substring(s1.length-s2.length)==s2)
     return true;
  else
     return false;
  return true;
 }

export function getFileSize(fileByte) {
    let fileSizeByte = fileByte;
    let fileSizeMsg = "";
    if (fileSizeByte < 1048576) fileSizeMsg = (fileSizeByte / 1024).toFixed(2) + "KB";
    else if (fileSizeByte == 1048576) fileSizeMsg = "1MB";
    else if (fileSizeByte > 1048576 && fileSizeByte < 1073741824) fileSizeMsg = (fileSizeByte / (1024 * 1024)).toFixed(2) + "MB";
    else if (fileSizeByte > 1048576 && fileSizeByte == 1073741824) fileSizeMsg = "1GB";
    else if (fileSizeByte > 1073741824 && fileSizeByte < 1099511627776) fileSizeMsg = (fileSizeByte / (1024 * 1024 * 1024)).toFixed(2) + "GB";
    else fileSizeMsg = "文件超过1TB";
    return fileSizeMsg;
}

export function getQueryString(name)
{
    //console.log('url' , window.location.search)
     var reg = new RegExp("(^|&)"+ name +"=([^&]*)(&|$)");
     var r = window.location.search.substr(1).match(reg);//search,查询？后面的参数，并匹配正则
     if(r!=null)return  unescape(r[2]); return null;

 }

export function back(){
  history.go(-1)
}

/**
 * 是否有权限
 * @param {*} key
 */
export function isAuth (key) {
  return JSON.parse(localStorage.getItem('permissions') || '[]').indexOf(key) !== -1 || false
}

/**
* 登录后赋权
* @param {*} perms 权限码集合 数组
*/
export function setAuth(perms) {
  localStorage.setItem('permissions', JSON.stringify(perms || '[]'))
}

/**
 * 树形数据转换
 * @param {*} data
 * @param {*} id
 * @param {*} pid
 */
export function treeDataTranslate (data, id = 'id', pid = 'parentId') {
  var res = []
  var temp = {}
  for (var i = 0; i < data.length; i++) {
    temp[data[i][id]] = data[i]
  }
  for (var k = 0; k < data.length; k++) {
    if (temp[data[k][pid]] && data[k][id] !== data[k][pid]) {
      if (!temp[data[k][pid]]['children']) {
        temp[data[k][pid]]['children'] = []
      }
      if (!temp[data[k][pid]]['_level']) {
        temp[data[k][pid]]['_level'] = 1
      }
      data[k]['_level'] = temp[data[k][pid]]._level + 1
      temp[data[k][pid]]['children'].push(data[k])
    } else {
      res.push(data[k])
    }
  }
  return res
}


export function toRoute(url , target) {
  if(isURL( url)) {
        // 加参
        /*if(url.indexOf('?') > 0) {
          url = url
        } else {
          url = url
        }*/
        if(target && target == 'this') {
          this.$router.push({name: index})
        } else {
           window.open( url , target ? target : '_blank')
        }


      } else {

        if(url.indexOf('/') != 0) {
          url = '/' + url ;
        }

        // 判断路由中是否存在
        if(target && target == 'this') {
           this.$router.push({path:url})
        } else {
          let routeUrl = this.$router.resolve({
              path: url,
              //params: {id:menu.menuId}
          });
          window.open(routeUrl.href, target ? target : '_blank');
        }


      }
}

/**
 * 清除登录信息
 */
export function clearLoginInfo () {
      localStorage.removeItem('token')
      //Vue.cookie.delete('token')
      store.commit('resetStore')
      router.options.isAddDynamicMenuRoutes = false
}
