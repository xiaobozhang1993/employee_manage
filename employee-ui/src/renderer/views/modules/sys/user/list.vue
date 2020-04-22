<template>
  <div :style="{'height':contentHeight()+'px'}" class="bg">
    <el-header class="el_head_bottom" :style="heightStyle()">
          <h3>账号管理</h3>
    </el-header>
    <div class="mod-config" :style="{'height':asideHeight*0.94-40-3+'px'}">
      <el-form :inline="true" :model="dataForm" @submit.native.prevent >
        
        <el-form-item>
          <el-button class="my-button"  size="mini" icon="el-icon-document-add" @click="addOrUpdateHandle()" v-if="isCanDo">新增</el-button>
          <el-button class="my-button"
            size="mini" icon="el-icon-delete"
            @click="deleteHandle()"
            :disabled="dataListSelections.length <= 0"
            v-if="isCanDo"
          >批量删除</el-button>
          <el-button class="my-button" size="mini" icon="el-icon-minus" :loading="isLoading" @click="expertUser()" v-if="isCanDo">导出</el-button>
        </el-form-item>
      </el-form>
      <el-table
        :data="dataList"
        border
        v-loading="dataListLoading"
        :highlight-current-row="true"
        :height="asideHeight*0.94-3-40-44"
        :row-class-name="rowClass"
        @selection-change="selectionChangeHandle"
        style="width: 100%;"
      >
        <el-table-column type="selection" header-align="center" align="center" width="50"></el-table-column>
        <el-table-column type="index" width="100" header-align="center" align="center" label="序号"></el-table-column>
        <el-table-column  prop="userNo" header-align="center" align="center" label="用户名"></el-table-column>
        
        <el-table-column width="100" prop="status" header-align="center" align="center" label="状态">
          <template slot-scope="scope">
            <el-tag v-if="scope.row.status === 0" size="small" type="danger">禁用</el-tag>
            <el-tag v-else size="small">正常</el-tag>
          </template>
        </el-table-column>
        <el-table-column
          prop="createTime"
          header-align="center"
          align="center"
          label="创建时间"
        ></el-table-column>
        <el-table-column header-align="center" align="center" label="操作" v-if="isCanDo">
          <template slot-scope="scope">
            <el-button type="text" size="small" @click="addOrUpdateHandle(scope.row.userId,scope.row.orgId)">修改</el-button>
            <el-button
              type="text"
              size="small"
              @click="deleteHandle(scope.row.userId,scope.row.userNo)"
            >删除</el-button>
            <el-button type="text" size="small" @click="resetPassHandle(scope.row.userId)">密码重置</el-button>
          </template>
        </el-table-column>
      </el-table>
      <add-or-update
        v-if="addOrUpdateVisible"
        ref="addOrUpdate"
        @refreshCurrentOrgDepList="getDataList"
      ></add-or-update>
    </div>
  </div>
</template>

<script>
import AddOrUpdate from "./add-or-update";
import { encrypt } from "@/utils/rsaCoder";
export default {
  data() {
    return {
      isRouterAlive: true,
      dataForm: {
        userName: "",
        userType:""
      },
      dataList: [],
      dataListLoading: false,
      dataListSelections: [],
      selectRow:[],
      addOrUpdateVisible: false,
      //账号及admin可以操作按钮
      isCanDo:false,
      //导出按钮加载
      isLoading: false
    };
  },
  computed: {
    //计算内部元素的高度
    asideHeight: function() {
      return document.documentElement["clientHeight"] - 31 - 97 - 20 - 30;
    }
  },
  components: {
    AddOrUpdate
  },
  activated() {
    this.dataForm.userName = this.$route.query.key;
    this.dataForm.userType = "";
    this.getDataList();
  },
  watch: {
    dataListSelections(data) {
      this.selectRow = [];
      if (data.length > 0) {
        data.forEach((item, index) => {
          this.selectRow.push(this.dataList.indexOf(item));
        })
      }
    }
  },
  /* watch: {
       '$route' () {
         // 此处写router变化时，想要初始化或者是执行的方法......
         this.$nextTick(() => {
           this.$router.go(0)
         })
       }
     },*/
  methods: {
    rowClass({row,rowIndex}){
          if(this.selectRow.includes(rowIndex)){
            return 'select-row';
          }
    },
    refresh() {
      this.$router.push({
        name: "sys_user_list",
        query: {
          key: this.dataForm.userName,
          pageIndex: this.pageIndex,
          pageSize: this.pageSize
        }
      });
    },
    search() {
      this.dataListLoading = true;
      this.$http({
        url: this.$http.adornUrl("/sys/user/queryList"),
        method: "post",
        data: this.$http.adornData({
          username: this.dataForm.userName,
          userTypeValue: this.dataForm.userType
        })
      }).then(({ data }) => {
        if (data && data.code === 0) {
          this.dataList = data.list;
        } else {
          this.dataList = [];
        }
        this.dataListLoading = false;
      });
    },
    // 获取数据列表
    getDataList() {
      this.dataListLoading = true;
      this.$http({
        url: this.$http.adornUrl("/sys/user/newList"),
        method: "get"
      }).then(({ data }) => {
        if (data && data.code === 0) {
          this.dataList = data.list;
          this.isCanDo = data.isCanDo
        } else {
          this.dataList = [];
        }
        this.dataListLoading = false;
      });
    },
    // 多选
    selectionChangeHandle(val) {
      this.dataListSelections = val;
    },
    // 新增 / 修改
    addOrUpdateHandle(id,orgId) {
      var id;
      var orgId;
      if(undefined!=id && undefined!=orgId){
        id = id;
        orgId = orgId;
      }else{
        id="";
        orgId=""
      }
      this.$http({
        url: this.$http.adornUrl("/sys/role/isCreateRoles"),
        method: "get"
      }).then(({ data }) => {
        if (data && data.code === 0) {
          if(data.isCreateRoles==false){
            return this.$message.error("您当前未设置角色，请先设置");
          }else{
            this.addOrUpdateVisible = true;
            this.$nextTick(() => {
              this.$refs.addOrUpdate.init(id,orgId);
            });
          }
        }
      });
    },
    /*beforeRouteEnter(to, from, next) {
        next(vm => {
          vm.$router.replace(from.path)
        });
      },*/
    //用户密码重置
    resetPassHandle(id) {
      this.$prompt("请输入新密码", "提示", {
        confirmButtonText: "确定",
        cancelButtonText: "取消",
        inputPattern: /\S/,
        inputErrorMessage: "密码不能为空"
      })
        .then(({ value }) => {
          const n_pass = encrypt(value);

          this.$http({
            url: this.$http.adornUrl(`/sys/user/resetPass`),
            method: "get",
            params: this.$http.adornParams({
              userId: id,
              newPass: n_pass
            })
          }).then(({ data }) => {
            if (data && data.code === 0) {
              this.$message({
                message: "操作成功",
                type: "success",
                duration: 1000
              });
            } else {
              this.$message.error(data.msg);
            }
          });
        })
        .catch(() => {});
    },
    sexFormatter(row, column, cellValue, index) {
      if (cellValue === 1) {
        return "男";
      }
      return "女";
    },
    // 删除
    deleteHandle(id, userno) {
      var userIds = id
        ? [id]
        : this.dataListSelections.map(item => {
            return item.userId;
          });
      var usernos = userno
        ? [userno]
        : this.dataListSelections.map(item => {
            return item.userNo;
          });
      this.$confirm(
        `删除不可以恢复，删除后该用户无法登陆系统，是否删除?`,
        "提示",
        {
          confirmButtonText: "确定",
          cancelButtonText: "取消",
          type: "warning"
        }
      )
        .then(() => {
          this.$http({
            url: this.$http.adornUrl("/sys/user/delete"),
            method: "post",
            data: this.$http.adornData(userIds, false)
          }).then(({ data }) => {
            if (data && data.code === 0) {
              this.$message({
                message: "操作成功",
                type: "success",
                duration: 1500,
                onClose: () => {
                  this.getDataList();
                }
              });
            } else {
              this.$message.error(data.msg);
            }
          });
        })
        .catch(() => {});
    },
    tableHeaderColor({ row, column, rowIndex, columnIndex }) {
      if (rowIndex === 0) {
        return "background-color: #F0F0F0;color: #000;font-weight: 500;border:0.5px solid #8D8D8D;";
      }
    },
        //导出账号
      expertUser() {
        this.isDisabled=true
        this.isLoading=true
        var url = this.$http.adornUrl('/sys/user/exportUser?token=' + this.$cookie.get('token'))
        this.$http({
           url:url,
           method:'get',
         /*  params:{
            orgId:this.queryDataForm.orgId
          }, */
           responseType:'blob',
        }).then((res)=>{
          const content = res.data;
          //type: Blob 格式 Excel 文件下载
          const blob    = new Blob([content], { type: 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet;charset=utf-8' });

          const fileName = '账号信息'+this.dateFormat()+'.xlsx';
          if('download' in document.createElement('a')){
            const link  = document.createElement('a');
            link.download =fileName;
            var href = window.URL.createObjectURL(blob);
            link.href = href;
            link.style.display = 'none';
            document.body.appendChild(link);
            link.click();
            URL.revokeObjectURL(link.href);
            document.body.removeChild(link);
          }else{
            // 其他浏览器
            navigator.msSaveBlob(blob, fileName)
          }
          this.isDisabled=false
          this.isLoading=false
        }).catch((error) => {
          console.log(error)
          this.isDisabled=false
          this.isLoading=false
          }
          );
      },
            //获得文件时间
      dateFormat:function() {
          var date=new Date();
          var year=date.getFullYear();
          /* 在日期格式中，月份是从0开始的，因此要加0
          * 使用三元表达式在小于10的前面加0，以达到格式统一  如 09:11:05
          * */
          var month= date.getMonth()+1<10 ? "0"+(date.getMonth()+1) : date.getMonth()+1;
          var day=date.getDate()<10 ? "0"+date.getDate() : date.getDate();
          var hours=date.getHours()<10 ? "0"+date.getHours() : date.getHours();
          var minutes=date.getMinutes()<10 ? "0"+date.getMinutes() : date.getMinutes();
          var seconds=date.getSeconds()<10 ? "0"+date.getSeconds() : date.getSeconds();
          // 拼接
          return year+month+day+hours+minutes+seconds;
      },
  }
};
</script>
