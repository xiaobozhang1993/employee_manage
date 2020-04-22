<template>
  <div :style="backgroundImage()" class="login">
    <div class="login_header" :style="{'height':clientHeight*0.2+'px'}">
      <img src="~@/assets/img/sysLogo.png" class="logo_img" />
      <span class="system_name">员工信息管理系统</span>
    </div>
    <div
      class="center_content"
      :style="{'height':clientHeight*0.7-80+'px'}"
    >
      <div class="loginbox loginbox3">
        <el-form
          label-position="left"
          class="login_form"
          :model="dataForm"
          :rules="dataRule"
          size="small"
          ref="dataForm"
          @submit.native.prevent
          status-icon
        >
          <el-form-item prop="userNo">
            <label slot="label">用 户 名:</label>
            <el-input
              class="input_bg login_input_zt"
              size="medium"
              v-model="dataForm.userNo"
            ></el-input>
          </el-form-item>
          <el-form-item prop="password" class="mima">
            <label slot="label">密&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;码:</label>
            <el-input
              class="input_bg login_input_zt"
              size="medium"
              v-model="dataForm.password"
              type="password"
            ></el-input>
          </el-form-item>
          <el-form-item prop="captcha" class="login-captcha-form-item">
            <label slot="label">验 证 码:</label>
            <el-row>
              <el-col class="captcha-sr">
                <el-input class="input_bg login_input_zt" v-model="dataForm.captcha"></el-input>
              </el-col>
              <el-col class="login-captcha">
                <img :src="captchaPath" @click="getCaptcha()" alt />
              </el-col>
            </el-row>
          </el-form-item>
          <el-form-item label-width="0px" class="login_button_form">
            <el-button
              :disabled="loging"
              class="login-btn-submit login_button"
              type="primary"
              @click="dataFormSubmit()"
              native-type="submit"
            >登&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;录</el-button>
            <el-button
              class="login_button"
              type="primary"
              native-type="reset"
            >清&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;空</el-button>
          </el-form-item>
        </el-form>
      </div>
    </div>
    <div>
      <ul class="contact">
        <li>个人开发使用</li>
        <li>Copyright © 2020 by zhangxiaobo All Rights Reserved.</li>
      
      </ul>
    </div>
  </div>
</template>
<script>
import Vue from "vue";
import { getUUID, setAuth } from "@/utils/index";
import { encrypt } from "@/utils/rsaCoder";

import Footer from "@/components/include/footer";

import { GetCurrentBrowser, GetOs } from "@/utils/brower_os";
//主进程通信
if (window.require) {
  var ipc = window.require("electron").ipcRenderer;
}
export default {
  data() {
    var validateCaptcha = (rule, value, callback) => {
      if (this.failCnt >= 2 && !this.captchaChcek) {
        callback(new Error("验证码不能为空"));
      } else {
        callback();
      }
    };
    return {
      loading: false,
      loging: false,
      captchaChcek: false,
      dataForm: {
        userNo: "",
        password: "",
        uuid: "",
        captcha: "",
        browser: "",
        os: ""
      },
      dataRule: {
        userNo: [{ required: true, message: "帐号不能为空", trigger: "blur" }],
        password: [
          { required: true, message: "密码不能为空", trigger: "blur" }
        ],
        captcha: [
          { required: true, validator: validateCaptcha, trigger: "change" }
        ]
      },
      captchaPath: ""
    };
  },
  components: {
    Footer
  },

  computed: {
    userId: {
      get() {
        return this.$store.state.user.userId;
      },
      set(val) {
        this.$store.commit("user/updateId", val);
      }
    },
    userName: {
      get() {
        return this.$store.state.user.name;
      },
      set(val) {
        this.$store.commit("user/updateName", val);
      }
    },
    orgId: {
      get() {
        return this.$store.state.user.orgId;
      },
      set(val) {
        this.$store.commit("user/updateOrgId", val);
      }
    },
    headImage: {
      get() {
        return this.$store.state.user.headImage;
      },
      set(val) {
        this.$store.commit("user/updateHeadImage", val);
      }
    },
    titles: {
      get() {
        return this.$store.state.user.titles;
      },
      set(val) {
        this.$store.commit("user/updateTitles", val);
      }
    },
    //计算内部元素的高度
    clientHeight: function() {
      return document.documentElement["clientHeight"];
    }
  },
  created() {
    // 判断当前是否真正登录了
    this.getUserInfo();
    this.getCaptcha();
    this.getCurrentBrowserAndOs();
    //判断应用是否正在下载更新
    //更新进度
    ipc.on("downloadProgress", (event, data) => {
      if (data.percent <= 100) {
        this.loging = true;
      }
    });
  },

  methods: {
    //计算背景图片
    backgroundImage() {
      return {
        height: this.clientHeight-31 + "px"
      };
    },
    //获取当前浏览器和操作系统s
    getCurrentBrowserAndOs() {
      this.dataForm.browser = GetCurrentBrowser();
      this.dataForm.os = GetOs();
    },

    // 提交表单
    dataFormSubmit() {
      this.$refs["dataForm"].validate(valid => {
        if (valid) {
          //加密密码
          const pass = encrypt(this.dataForm.password);
          this.loging = true;
          this.$http({
            url: this.$http.adornUrl("/sys/login"),
            method: "post",
            data: this.$http.adornData({
              userNo: this.dataForm.userNo,
              password: pass,
              uuid: this.dataForm.uuid,
              captcha: this.dataForm.captcha,
              browser: this.dataForm.browser,
              os: this.dataForm.os
            })
          }).then(({ data }) => {
            console.log("dddddddddddd");
            if (data && data.code == 0) {
              localStorage.setItem("token", data.token);
              // Vue.cookie.set("token",data.token);
              // 回填用户信息
              setAuth(data.perms);
              this.userName = data.user.username;
              this.userId = data.user.userId;
              this.orgId = data.user.orgId;
              this.headImage = data.user.logo;
              this.titles = data.user.title;
              this.toLoginUrl();
            } else {
              this.getCaptcha();
              this.loging = false;
              this.$message.error(data.msg);
            }
            this.dataForm.captcha = "";
          });
          /*.catch(({data})=>{
                            this.loging = false;
                           this.$message.error(data ? data : '登录异常,请稍后再试')
                           console.log('error' , data)

                       })*/
        }
        //
      });
    },

    toLoginUrl() {
      console.log("准备跳转到登录页面");
      // 判断是否需要跳转 如果需要跳转这里去跳转
      this.$router.replace({ name: "index" });
    },
    // 获取验证码
    getCaptcha() {
      this.dataForm.uuid = getUUID();
      this.captchaPath = this.$http.adornUrl(
        `/captcha.jpg?uuid=${this.dataForm.uuid}`
      );
    },
    getUserInfo() {
      //	this.loading = true
      this.$http({
        url: this.$http.adornUrl("/sys/user/info"),
        method: "get",
        params: this.$http.adornParams()
      })
        .then(({ data }) => {
          if (data && data.code === 0 && data.user && data.user.userNo) {
            this.userName = data.user.username;
            this.userId = data.user.userId;

            this.toLoginUrl();
          } else {
            this.loading = false;
          }
          //this.loading = false
        })
        .catch(({ data }) => {
          this.loading = false;
          console.log("error", data);
        });
    }
  }
};
</script>
<style lang="scss" scoped>
.center_content{
  display: flex;
  justify-content: center;
}
.login_header {
  text-align: center;
  padding-top: 80px;
}
.loginbox {
  display: flex;
}
.logo_img {
  width: 150px;
  vertical-align: middle;
}
.system_name {
  color: #ffffff;
  -webkit-text-fill-color: 12px black;
  text-align: center;
  font-family: STZhongsong;
  letter-spacing: 5px;
  font-weight: bold;
  text-align: center;
  vertical-align: middle;
}
.login {
  background: url(../../assets/img/bg1.png) no-repeat;
  background-size: 100% 100%;
}

// .loginbox3 {
//   background: url(../../assets/img/dl.png) no-repeat;
// }
.login_form {
  width: 481px;
  height: 246px;
  margin-top: 162px;
  margin-left: 90px;
}

.login-captcha {
  overflow: hidden;
}

.netopt-login .plogo {
  text-align: center;

  background: #fff;
  padding-bottom: 20px;

  display: inline-block;
}

.netopt-login .tip-box {
  width: 306px;
}

.netopt-login .icon-box {
  position: relative;
}

.netopt-login .succ-icon {
  display: block;
  width: 71px;
  height: 71px;
  margin: 0 auto;
  background: url(../../assets/img/qrcode-succ-2016.png) no-repeat;
}

.netopt-login .item-fore {
  text-align: center;
  margin: 0;
  padding-top: 30px;
}

.netopt-login .ftx-03 {
  padding-top: 14px;
}

.netopt-login .qrcode-succ h3 {
  color: #333;
  font-weight: 400;
  line-height: 1;
}

.netopt-login .el-form-item--mini .el-form-item__content,
.el-form-item--mini .el-form-item__label {
  line-height: 28px;
}

.netopt-login .el-carousel__container {
  position: relative;
  height: 500px;
}

.login-captcha {
  overflow: hidden;
}

.login-captcha img {
  width: 100%;
  cursor: pointer;
  padding-left: 5px;
}

.el-button--primary {
  height: 38px;
  width: 30%;
  background-color: #0e7ff9;
  border-color: #0e7ff9;
}

.contact {
  height: 220px;
  text-align: center;
  color: #fff;
  margin-top: -50px;
}

@media (max-width: 2540px) {
  .center_content{
    padding-left: 60px;
    padding-top: 10px;;
  }
  .logo_img {
    width: 120px;
  }

  .login_form {
    width: 100%;
    height: 300px;
    margin-top: 150px;
    margin-left: 60px;
  }

  .login_form /deep/ .el-form-item__label {
    font-size: 20px !important;
    width: 120px;
  }

  .login_form /deep/ .el-form-item__content {
    margin-left: 120px;
  }

  .login_form /deep/ .el-input {
    width: 70%;
  }
  .captcha-sr /deep/ .el-input {
    width: auto;
  }
  .captcha-sr {
    width: 45%;
  }

  .login-captcha {
    width: 23%;
  }

  .login-captcha-form-item {
    margin-bottom: 15px;
  }

  .login_button_form {
    width: 90%;
  }

  .login_button_form /deep/ .el-button--primary {
    width: 25% !important;
    height: 40px !important;
    font-size: 25px !important;
    background-size: 130px;
  }

  .loginbox3 {
    background-size: 100%;
  }

  .system_name {
    font-size: 80px;
    letter-spacing: 0px;
  }
}

@media (max-width: 1680px) {
   .center_content{
    padding-left: 50px;
    padding-top:0px;
  }
  .logo_img {
    width: 100px;
  }
  .login_form {
    width: 600px;
    height: 300px;
    margin-top: 130px;
    margin-left: 60px;
  }
  .loginbox3 {
    background-size: 600px;
  }
  .system_name {
    font-size: 70px;
    letter-spacing: 0px;
  }

  .login_button_form /deep/ .el-button--primary {
    width: 24% !important;
    height: 100%;
    font-size: 25px !important;
    background-size: 120px;
  }
}
@media (max-width: 1550px) {
  .center_content{
    padding-left: 80px;
    padding-top:0px;
  }
  .system_name {
    font-size: 60px;
    letter-spacing: 0px;
  }
}
//1440
@media (max-width: 1440px) {
  .center_content{
    padding-left: 50px;
    padding-top:0px;
  }
  .logo_img {
    width: 100px;
  }

  .login_form {
    width: 500px;
    margin-top: 110px;
    margin-left: 29px;
  }
  .contact {
    text-align: center;
    color: #fff;
    margin-top: -65px;
  }

  .login_form /deep/ .el-form-item__label {
    font-size: 16px !important;
    width: 90px;
  }

  .login_form /deep/ .el-form-item__content {
    margin-left: 90px;
  }

  .login_form /deep/ .el-input {
    width: auto;
  }

  .captcha-sr {
    width: 40%;
  }

  .login-captcha {
    width: 30%;
  }

  .login-captcha-form-item {
    margin-bottom: 0px;
  }

  .login_button_form {
    width: 80%;
  }

  .login_button_form /deep/ .el-button--primary {
    width: 26% !important;
    height: 38px !important;
    font-size: 20px !important;
    background-size: 106px;
  }
  .loginbox3 {
    background-size: 500px;
  }

  .system_name {
    font-size: 70px;
    letter-spacing: 0px;
  }
}

@media (max-width: 1366px) {
  .logo_img {
    width: 100px;
    vertical-align: middle;
  }
  .loginbox3 {
    background-size: 500px;
  }
  .system_name {
    font-size: 60px;
    letter-spacing: 0px;
  }
}
</style>
<style scope>
.el-form-item--small .el-form-item__error {
  padding-top: 2px;
  color: aqua;
}
</style>
