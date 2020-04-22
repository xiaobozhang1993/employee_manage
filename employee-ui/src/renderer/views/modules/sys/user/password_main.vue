<template>
        <el-container class="con">
            <el-header  class="info_main_header" :style="heightStyle()">
                <h3>密码修改</h3>
            </el-header>
            <el-main class="bg int_main">
                <el-row type="flex"  justify="space-around" class="int_main_form" >
                    <el-col :span="12">
                        <el-form :model="dataForm" @submit.native.prevent :rules="rules" label-position="left" label-width="27%">
                            <el-form-item label="原密码 ：" prop="password">
                            <el-input class="ei" type="password" v-model="dataForm.password" autocomplete="off"></el-input>
                            </el-form-item>
                            <el-form-item label="新密码 ：" prop="newPassword">
                            <el-input class="ei" type="password" v-model="dataForm.newPassword" autocomplete="off"></el-input>
                            </el-form-item>
                            <el-form-item label="新密码确认 ：" prop="checkPassword">
                            <el-input class="ei" type="password" v-model="dataForm.checkPassword" autocomplete="off"></el-input>
                            </el-form-item>
                            <el-form-item>
                            <el-button type="primary" @click="submitForm()" style="width: 30%;margin-left: 30%">修改</el-button>
                            </el-form-item>
                        </el-form>
                    </el-col>
                </el-row>
            </el-main>
        </el-container>
</template>
<script>
  import { encrypt } from "@/utils/rsaCoder";
export default {
    data(){
         var validatePass = (rule, value, callback) => {
        if (value === '') {
          callback(new Error('请输入原密码'));
        } else {
          if (this.dataForm.password !== '') {
            this.$refs.dataForm.validateField('password');
          }
          callback();
        }
      };
      var validatePass2 = (rule, value, callback) => {
        if (value === '') {
          callback(new Error('请输入新密码'));
        } else {
          if (this.dataForm.newPassword !== '') {
            this.$refs.dataForm.validateField('newPassword');
          }
          callback();
        }
      };
      var validatePass3 = (rule, value, callback) => {
        if (value === '') {
          callback(new Error('请再次输入密码'));
        } else if (value !== this.dataForm.newPassword) {
          callback(new Error('两次输入密码不一致!'));
        } else {
          callback();
        }
      };
        return{
            dataForm: {
                password: '',
                newPassword: '',
                checkPassword: ''
            },
            rules: {
                password: [
                    { validator: validatePass, trigger: 'blur' }
                ],
                newPassword: [
                    { validator: validatePass2, trigger: 'blur' }
                ],
                checkPassword: [
                { validator: validatePass3, trigger: 'blur' }
                ]
            }
        }
    },
    computed: {
         //计算内部元素的高度
        asideHeight:function(){
            return document.documentElement['clientHeight']  - 25 - 60
        }
    },
    methods:{
         submitForm(){

           const n_pass = this.dataForm.password
             ? encrypt(this.dataForm.password)
             : null;
           const n_newpass = this.dataForm.newPassword
             ? encrypt(this.dataForm.newPassword)
             : null;
           this.$http({
             url:this.$http.adornUrl(`/sys/user/password`),
             method:'post',
             data: this.$http.adornData({
               password: n_pass,
               newPassword: n_newpass,
             })
           }).then(({ data }) => {
             if (data && data.code === 0) {
               this.$message({
                 message: "操作成功",
                 type: "success",
                 duration: 500
               });

             } else {
               this.$message.error(data.msg);
             }
             this.dataForm.password=""
             this.dataForm.newPassword=""
             this.dataForm.checkPassword=""
           });
         }
    }
}
</script>
