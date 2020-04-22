/**计算头部高度 */
export function headerStryle(){
    /**可视化高度 */
     var visualheight  =  document.documentElement['clientHeight']  -31-97-20-30
     return {'height':visualheight*0.06+'px','line-height':visualheight*0.06+'px'}
}

/**计算内容高度 */
export function contentHeight(){
    /**可视化高度 */-31-97-20-30
     var contentHeight  =  document.documentElement['clientHeight'] -31-97-20-30
     window.onresize = () => {
        contentHeight = document.documentElement['clientHeight'] -31-97-20-30
      }    
     return contentHeight;
}