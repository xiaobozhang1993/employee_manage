<template>
  <div 
    class="titlebtn" 
    :style="style"
    @click="click"/>
</template>

<script>
    import {clearLoginInfo} from '@/utils'
    const {ipcRenderer: ipc} = require('electron');
    const style = {
        min: {
            backgroundColor: 'green',
            right:'80px'
        },
        max: {  
            right:'50px'
        },
        close: {
            backgroundColor: 'red',
            right:'15px'
        }
    };
    export default {
        name: 'titleButton',
        props: ['type'],
        computed: {
            style: function () {
                return style[this.type];
            }
        },
        methods: {
            click: function () {
                if(this.type=="close"){
                    this.$confirm('您确定要关闭当前系统, 是否继续?', '提示', {
                        confirmButtonText: '确定',
                        cancelButtonText: '取消',
                        type: 'warning'
                        }).then(() => {
                            this.$http({
                                    url:  this.$http.adornUrl('/sys/logout'),
                                    method: 'post',
                                    params:  this.$http.adornParams()
                                }).then(({data}) => {
                                    clearLoginInfo();
                                    ipc.send(this.type);
                                });
                        }).catch(() => {
                        });
                }else{
                    ipc.send(this.type);
                }
            }
        }
    }
</script>
    
<style>
.titlebtn {
    position: absolute;
    width: 15px;
    height: 15px;
    width: 30px;
    height: 30px;
    -webkit-app-region: no-drag;
    border-radius: 50%;
}
.titlebtn:hover{
    border: 1px solid rgba(248, 242, 242, 0.6);
    background-color:#ced1d6;
}
</style>