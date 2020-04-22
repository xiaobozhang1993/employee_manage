/**
 * 邮箱
 * @param {*} s
 */
export function isEmail (s) {
  return /^([a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+((.[a-zA-Z0-9_-]{2,3}){1,2})$/.test(s)
}

/**
 * 手机号码
 * @param {*} s
 */
export function isMobile (s) {
  return /^1[0-9]{10}$/.test(s)
}

/**
 * 精确手机号码
 * @param {*} s
 */
export function isNicetyMobile(s) {
  return /^(1(([38]\d)|(4[57])|(5[0-35-9])|66|(7[0135-8])|(9[89]))\d{8})$/.test(s)
}

/**
 * 电话号码
 * @param {*} s
 */
export function isPhone (s) {
  return /^([0-9]{3,4}-)?[0-9]{7,8}$/.test(s)
}

/**
 * 精确电话号码
 * @param {*} s
 */
export function isNicetyPhone(s) {
  return /^((0\d{2,3}[ -]?)?[2-9]\d{6,7})$/.test(s)
}
/**
 * URL地址
 * @param {*} s
 */
export function isURL (s) {
  return /^http[s]?:\/\/.*/.test(s)
}
/**
 * 网址校验
 * @param {*} s
 */
export function isFURL(s){
  return /^(https?:\/\/)?.+\..+/.test(s)
}
/**
 * 整数
 * @param {*} s
 */
export function isInteger (s) {
  return /^\d+$/.test(s)
}

/**
 * 数字，含小数
 * @param {*} s
 */
export function isNumber (s) {
  return /^\d+(\.\d+)?$/.test(s)
}

/**
 * 数字，含小数(含负数)
 * @param {*} s
 */
export function isFNumber (s) {
  return /^[+-]?\d+(\.\d+)?$/.test(s)
}

/**
 * 身份证验证
 * @param {*} s
 */
export function isCardId (s){
  // return /^[1-9][0-7]\d{4}((19\d{2}(0[13-9]|1[012])(0[1-9]|[12]\d|30))|(19\d{2}(0[13578]|1[02])31)|(19\d{2}02(0[1-9]|1\d|2[0-8]))|(19([13579][26]|[2468][048]|0[48])0229))\d{3}(\d|X|x)?$/.test(s)
  return /^[1-9][0-7]\d{4}(((19|20|21)\d{2}(((0[13578]|1[02])(0[1-9]|([12]\d)|3[0-1]))|(02([01]\d|2[0-8]))|((0[469]|11)([0-2]\d|30))))|(((19(09|17|28|47))|(20(04|23|42|99))|(21(37|86)))0229))\d{3}(\d|X|x)$/.test(s)
}

/**
 * 统一社会信用代码简单校验
 * @param {*} s
 */
export function isCrtcode (s){
  return /^[1-9ANY][1-59]\d{6}[0-9A-Z]{10}$/.test(s)
}

/**
 * 银行卡号简单校验（16位、17位、19）
 * @param {*} s
 */
export function isBackId (s){
  return /^\d{16}(\d(\d{2})?)?$/.test(s)
}

/**
 * 邮编
 * @param {*} s
 */
export function isPostcode (s){
  return /^\d{6}$/.test(s)
}

/**
 * 比例：[0-100]（含小数）
 * @param {*} this_
 */
export function isScale(s) {
  return /^(\d?\d(\.\d*)?|100)$/.test(s)
}
/**
* 验证tabs下的各个form
*/
/*
export function validatorForm(this_ , tabs , cb) {
          let valids = []
          let names = []
          for (let i in tabs) {
            const vali = this_.$refs[tabs[i].componentName][0].sumbitValidate()
            console.log('valid ' , tabs[i].tabName  , this_.$refs[tabs[i].componentName][0].validateState , vali)
            if(vali && typeof vali == 'object') {
              valids.push(vali);
              names.push(tabs[i].tabName)
            } else if(vali == false){
              valids.push(new Promise((resolve, reject)=>{

                  if(vali) {

                    resolve(vali) ;
                  } else {
                    reject(vali) ;
                  }
                })
              )
              names.push(tabs[i].tabName)
              // break;
            }



          //  console.log('valid ' , tabs[i].tabName  , this_.$refs[tabs[i].componentName][0].validateState , vali)
            // 获取校验结果
           /!* if (!this.$refs[this.tabs[i].componentName][0].validateState) {
              return
            }*!/
          }
           console.log('valids' , valids , valids.length)
          if(!valids || valids.length == 0) {

               console.log('执行操作')
                cb()

                return ;


          }
          console.log('valids' , valids)
          for(var i in valids) {
             console.log(i , valids[i] , names[i])
          }

          let valid_primase = async (v , index)=>{
             let p =   new Promise(function(resolve, reject){

               v.then((d )=>{
                 console.log('valiate data : ' + index  , d)
                if(d == null || d == false) {
                  this_.$notify({
                    title: '提示',
                     offset: 100,
                    message: '请确保[' + names[index] + ']页面内容填写完整',
                    position: 'bottom-right'
                  });
                  reject(false)

                } else {
                  resolve(true)

                }
              }).catch((e )=>{
                  // console.log('error' ,index,names[index], e)
                  setTimeout(function(){
                    this_.$notify({
                      title: '提示',
                       offset: 100,
                       type:'error',
                      message: '请确保[' + names[index] + ']页面内容填写完整',
                      position: 'bottom-right'
                    });
                  } , index * 50)
                reject(false)


              })
          })
          return p ;

        }

          let fun = ()=>{
            let f ;
             for(var i in valids) {
              const index = i ;
              if(i == 0) {
                f = valid_primase(valids[index] , index);
              } else {
                const f_ =  valid_primase(valids[index] , index);
                f = f.then( function(dat){
                  return f_
                })

              }


             }

             f.then(function(data){
               console.log('data@@@' , data)
              if(data && data == true) {
                 console.log('执行操作')
                cb()
              } else {

              }
             })


            return f;

          }

          fun();

          return  ;

          /!*for(var i in valids) {
            console.log(i + ' : '  , valids[i])
            const index = i ;
            valids[i].then((d )=>{
                console.log('valiate data : ' + i  , d)
                if(!d) {

                this_.$notify({
                  title: '提示',
                   offset: 100,
                  message: '请确保[' + names[index] + ']页面内容填写完整',
                  position: 'bottom-right'
                });
                }
            }).catch((e )=>{
                console.log('error' ,index, e)
                setTimeout(function(){
                  this_.$notify({
                    title: '提示',
                     offset: 100,
                     type:'error',
                    message: '请确保[' + names[index] + ']页面内容填写完整',
                    position: 'bottom-right'
                  });
                } , index * 10)


            })
          }  *!/

/!*
         Promise.all(valids).then(data=>{
              console.log('valiate data : '  , data)

              let result = true ;
              for(let i in data) {
                result &= data[i];
                console.log( i , tabs[i].tabName , data[i])
                if(!result) {
                  this_.$alert("请确保11[" + tabs[i].tabName + "]页面内容填写完整", "提示", {
                    confirmButtonText: "确定"
                  });
                  return ;
                }
              }

              if(result) {
                 console.log('执行操作')
                callback()
              } else {
                 console.log('验证没通过 不执行操作')
              }

          }) .catch(e=>{
            console.log('error' , e)
          })
*!/


}

export function validatorFormA(this_ , tabs , cb) {
  let valids = []
  let names = []
  for (let i in tabs) {
    const vali = this_.$refs[tabs[i].componentName].sumbitValidate()
    if(vali && typeof vali == 'object') {
      valids.push(vali);
      names.push(tabs[i].tabName)
    } else if(vali == false){
      valids.push(new Promise((resolve, reject)=>{

          if(vali) {

            resolve(vali) ;
          } else {
            reject(vali) ;
          }
        })
      )
      names.push(tabs[i].tabName)
      // break;
    }
  }
  if(!valids || valids.length == 0) {
        cb()
        return ;
  }
  for(var i in valids) {
  }

  let valid_primase = async (v , index)=>{
     let p =   new Promise(function(resolve, reject){

       v.then((d )=>{
        if(d == null || d == false) {
          this_.$notify({
            title: '提示',
             offset: 100,
            message: '请确保[' + names[index] + ']页面内容填写完整',
            position: 'bottom-right'
          });
          reject(false)

        } else {
          resolve(true)

        }
      }).catch((e )=>{
          setTimeout(function(){
            this_.$notify({
              title: '提示',
               offset: 100,
               type:'error',
              message: '请确保[' + names[index] + ']页面内容填写完整',
              position: 'bottom-right'
            });
          } , index * 50)
        reject(false)
      })
  })
  return p ;
}
  let fun = ()=>{
    let f ;
     for(var i in valids) {
      const index = i ;
      if(i == 0) {
        f = valid_primase(valids[index] , index);
      } else {
        const f_ =  valid_primase(valids[index] , index);
        f = f.then( function(dat){
          return f_
        })

      }
     }
     f.then(function(data){
      if(data && data == true) {
        cb()
      } else {

      }
     })
    return f;
  }
  fun();
  return  ;
}*/
