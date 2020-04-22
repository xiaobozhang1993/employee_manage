
let dicts = [];
 

//从local中获取当前已有的列表
var sessionDicts_ = window.sessionStorage.getItem('dicts');
if (sessionDicts_ != null && sessionDicts_ != '') {
  //console.log('sessionDicts_' , sessionDicts_)
  try {
     dicts =  JSON.parse(sessionDicts_);
   }catch(error) {
    dicts = []
   }
 
}


/**
* dict 数据字典根据类型和值翻译为名称
* @param {dictType} dictType
* @param {dictValue} dictValue
*/
export function getDictName(dictType , dictValue) {

  // 尝试 获取
  let name = getDict(dictType , dictValue);

  return name ;

}

export function putDict(dictType , name , value) {
 // console.log('dicts  q1 ' , dicts)
  dicts.push({'dictType': dictType , 'value': value,'name': name})
  const json_ = JSON.stringify(dicts)
   window.sessionStorage.setItem('dicts' , json_);
  //console.log('dicts2 ' , dicts)
}

function getDict(dictType , value) {
 // console.log('dicts' , dicts)
  if(dicts != null && dicts.length > 0) {
    for(var i in dicts) {
        if(dicts[i].value == value && 
          dicts[i].dictType == dictType) {
          return dicts[i].name;
        }
      }
  }

  return null;
}
