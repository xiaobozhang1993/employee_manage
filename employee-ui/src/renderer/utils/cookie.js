const ipcRenderer = require('electron').ipcRenderer;
const session     = require('electron').remote.session;


/**
 * 获得
 */
export function  getCookie(name,back) {

  console.log("进入获取cookie的方法")
    session.defaultSession.cookies.get({ url: "http://129.211.23.185:8081/employee-admin" }, (error, cookies)=>{
    
      console.log(cookies);
      if (cookies.length > 0) {
        var length = cookies.length;
        for(var i=0;i<length;i++){
         console.log(i);
         var _myName =  cookies[i].name;
         if(name == _myName ){
            back(cookies[i].value  );
         }
        }
      }     
    });

  };
  /**
   * 清空缓存
   */
  export function clearCookies () {
    session.defaultSession.clearStorageData({
      origin: "http://129.211.23.185:8081/employee-admin",
      storages: ['cookies']
    }, function (error) {
      if (error) console.error(error);
    })
  };
  
  /**
   * 保存cookie
   * @param name  cookie名称
   * @param value cookie值
   */
  export function setCookie (name, value) {
     console.log("进入获取setCookie的方法")

    
    let Days = 30;
    let exp = new Date();
    let date = Math.round(exp.getTime() / 1000) + Days * 24 * 60 * 60;
    const cookie = {
      url: "http://129.211.23.185:8081/employee-admin",
      name: name,
      value: value,
      expirationDate: date
    
    };
    session.defaultSession.cookies.set(cookie, (error) => {
      if (error) console.error(error);
    });
  };
