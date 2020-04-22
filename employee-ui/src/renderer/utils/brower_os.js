//获取当前登录的浏览器
export function GetCurrentBrowser(){
    let ua = navigator.userAgent.toLocaleLowerCase()
    let browserType = null
    let browserTypeChinese = null
    if (ua.match(/msie/) != null || ua.match(/trident/) != null) {
      browserType = 'IE'
      browserTypeChinese = 'IE浏览器'
    }else if (ua.match(/firefox/) != null) {
      browserType = 'firefox'
      browserTypeChinese = '火狐浏览器'
    }  else if (ua.match(/edge/) != null) {
      browserType = 'edge'
      browserTypeChinese = 'MicrosoftEdge'
    } else if (ua.match(/ucbrowser/) != null) {
      browserType = 'UC'
      browserTypeChinese = 'UC浏览器'
    } else if (ua.match(/opera/) != null || ua.match(/opr/) != null) {
      browserType = 'opera'
      browserTypeChinese = 'Opera浏览器'
    } else if (ua.match(/bidubrowser/) != null) {
      browserType = 'baidu'
      browserTypeChinese = '百度浏览器'
    } else if (ua.match(/metasr/) != null) {
      browserType = 'sougou'
      browserTypeChinese = '搜狗浏览器'
    } else if (ua.match(/tencenttraveler/) != null || ua.match(/qqbrowse/) != null) {
      browserType = 'QQ'
      browserTypeChinese = 'QQ浏览器'
    } else if (ua.match(/maxthon/) != null) {
      browserType = 'maxthon'
      browserTypeChinese = '遨游浏览器'
    } else if (ua.match(/chrome/) != null) {
      var is360 = _mime('type', 'application/vnd.chromium.remoting-viewer')
      if (is360) {
        browserType = '360'
        browserTypeChinese = '360浏览器'
      } else {
        browserType = 'chrome'
        browserTypeChinese = '谷歌浏览器'
      }
    } else if (ua.match(/safari/) != null) {
      browserType = 'Safari'
      browserTypeChinese = '苹果浏览器'
    } else {
      browserType = 'others'
      browserTypeChinese = '其他浏览器'
    }
    return browserTypeChinese
}
function _mime(option, value) {
  var mimeTypes = navigator.mimeTypes;
  for (var mt in mimeTypes) {
    if (mimeTypes[mt][option] == value) {
      return true;
    }
  }
  return false;
}

//获得当前登录操作系统
export function GetOs () {
    let sUserAgent = navigator.userAgent.toLocaleLowerCase()
    let isWin = (navigator.platform.toLocaleLowerCase() === 'win32') || (navigator.platform.toLocaleLowerCase() === 'windows')
    let isMac = (navigator.platform.toLocaleLowerCase() === 'mac68k')
                || (navigator.platform.toLocaleLowerCase() === 'macppc')
                || (navigator.platform.toLocaleLowerCase() === 'macintosh')
                || (navigator.platform.toLocaleLowerCase() === 'macintel')
    if (isMac) return 'Mac'
    var isUnix = (navigator.platform.toLocaleLowerCase() === 'x11') && !isWin && !isMac
    if (isUnix) return 'Unix'
    var isLinux = (String(navigator.platform.toLocaleLowerCase()).indexOf('linux') > -1)
    if (isLinux) return 'Linux'
    if (isWin) {

      var isWin2K = sUserAgent.indexOf('windows nt 5.0') > -1 || sUserAgent.indexOf('windows 2000') > -1
      if (isWin2K) return 'Win2000'
      var isWinXP = sUserAgent.indexOf('windows nt 5.1') > -1 || sUserAgent.indexOf('windows xp') > -1
      if (isWinXP) return 'WinXP'
      var isWin2003 = sUserAgent.indexOf('windows nt 5.2') > -1 || sUserAgent.indexOf('windows 2003') > -1
      if (isWin2003) return 'Win2003'
      var isWinVista = sUserAgent.indexOf('windows nt 6.0') > -1 || sUserAgent.indexOf('windows vista') > -1
      if (isWinVista) return 'WinVista'
      var isWin7 = sUserAgent.indexOf('windows nt 6.1') > -1 || sUserAgent.indexOf('windows 7') > -1
      if (isWin7) return 'Win7'
      var isWin10 = sUserAgent.indexOf('windows nt 10.0') > -1 || sUserAgent.indexOf('windows nt 10.0') > -1
      if (isWin10) return 'Win10'
    }
    if (sUserAgent.indexOf('android') > -1) return 'Android'
    if (sUserAgent.indexOf('iphone') > -1) return 'iPhone'
    if (sUserAgent.indexOf('symbianos') > -1) return 'SymbianOS'
    if (sUserAgent.indexOf('windows phone') > -1) return 'Windows Phone'
    if (sUserAgent.indexOf('ipad') > -1) return 'iPad'
    if (sUserAgent.indexOf('ipod') > -1) return 'iPod'
    return 'others'
}
