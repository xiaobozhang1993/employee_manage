<template>
  <div id="app">
    <div id="mytitle">
      <div class="_array_button">
            <TitleButton type="min" class="sysMin_button"/>
        <TitleButton type="max" class="sysMax_button"/>
        <TitleButton type="close" class="sysClose_button"/>
      </div>
      
    </div>
    <!-- <button @click="updateApp" style="width:100px;height: 40px;">更新</button> -->
    <Update :show.sync="show" v-bind:percent="percent"></Update>
    <transition name="fade">
      <router-view v-if="isRouterAlive"></router-view>
    </transition>
  </div>
</template>

<script>
import TitleButton from "@/components/myTitle/titleButton.vue";
import Update from "@/components/update/update.vue";
//主进程通信
if (window.require) {
  var ipc = window.require("electron").ipcRenderer;
}

export default {
  name: "App",
  provide() {
    return {
      reload: this.reload
    };
  },
  data() {
    return {
      isRouterAlive: true,
      show: false,
      percent: 0,
      onLineStatus: true
    };
  },
  components: {
    TitleButton,
    Update
  },
  created() {
    //先判断有网再检查更新
    if (false == navigator.onLine) {
      this.onLineStatus = false;
      this.$message({
        showClose: true,
        message: "网络不可用，请连接网络后重新打开",
        type: "error"
        });
    }

    if (navigator.onLine) {
      ipc.send("checkForUpdate", "asdad");
    }
  },
  mounted() {
    window.addEventListener("online", this.updateOnlineStatus);
    window.addEventListener("offline", this.updateOnlineStatus);
    //更新进度
    ipc.on("downloadProgress", (event, data) => {
      this.percent = parseFloat(data.percent.toFixed(2));
      if (data.percent >= 100) {
        this.$message("下载完成");
        this.show = false;
      }
    });

    /**
     * 主进程返回的检测状态
     */
    ipc.on("message", (event, data) => {
      switch (data.status) {
        case -1:
          this.show = false;
          this.$message(data.msg);
          break;
        case 0:
          this.show = false;
          this.$message(data.msg);
          break;
        case 1:
          this.show = true;
          break;
      }
    });
  },

  beforeDestroy() {
    window.removeEventListener("online", this.updateOnlineStatus());
    window.removeEventListener("offline", this.updateOnlineStatus());
  },
  methods: {
    reload() {
      this.isRouterAlive = false;
      this.$nextTick(function() {
        this.isRouterAlive = true;
      });
    },
    // updateApp() {
    //         ipc.send('checkForUpdate', 'asdad')
    //     },
    updateOnlineStatus(e) {
      if ("offline" == e.type) {
        this.onLineStatus = false;
        this.showoffLineMsg();
      }
      if ("online" == e.type) {
        this.onLineStatus = true;
        ipc.send("checkForUpdate", "asdad");
      }

      //发送主进程
      if (window.require) {
        ipc.send(
          "online-status-changed",
          navigator.onLine ? "online" : "offline"
        );
      }
    },
    showoffLineMsg() {
      this.$message({
        showClose: true,
        message: "网络不可用，检查您的网络设置",
        type: "error"
        });
    }
  }
};
</script>
<style>
html,
body {
  padding: 0px;
  margin: 0px;
  border: 0px;
  width: 100%;
  height: 100%;
}
#mytitle {
  width: 100%;
  height: 30px;
  -webkit-app-region: drag;
  background-color: rgb(50, 140, 243);
  color: white;
  border-bottom: 1px solid #606266;
}
#sysName {
    position: absolute;
    top: 10px;
    width: 200px;
    left:10px;
    left:25px;
    -webkit-app-region: drag;
}
.sysMax_button {
  background: url("../renderer/assets/img/sysMax_btn.svg")center no-repeat;
  right:'40px'
}
.sysMin_button {
  background: url("../renderer/assets/img/sysMin_btn.svg")center no-repeat;
  right:'65px';
  margin-top: '7px';
}
.sysClose_button {
  background: url("../renderer/assets/img/sysClose_btn.svg")center no-repeat;
  right:'15px'
}
.sys_img{
    height: 20px;
    position: absolute;
    top: 5px;
    left: 5px;
}

/* CSS */
</style>
