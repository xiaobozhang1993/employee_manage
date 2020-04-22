<template>
  <div :style="{'height':contentHeight()+'px'}" class="bg">
    <el-header  class="el_head_bottom" :style="heightStyle()">
                    <h3>角色管理</h3>
    </el-header>
    <div class="mod-config" :style="{'height':asideHeight*0.94-20-40+'px'}">
    <el-form :inline="true" :model="dataForm" @submit.native.prevent>
      <el-form-item>
        <el-input v-model="dataForm.roleName" placeholder="角色名称" clearable></el-input>
      </el-form-item>
      <el-form-item>
        <el-button  class="my-button" size="mini" icon="el-icon-search"  native-type="submit" @click="search()">查询</el-button>
        <el-button  class="my-button" size="mini" icon="el-icon-document-add" v-if="isCanDo"  @click="addOrUpdateHandle()">新增</el-button>
        <el-button  class="my-button" size="mini" icon="el-icon-delete" v-if="isCanDo" @click="deleteHandle()" :disabled="dataListSelections.length <= 0">批量删除</el-button>
      </el-form-item>
    </el-form>
    <el-table
      :data="dataList"
      border
      :height="asideHeight*0.94-20-3-40-44"
      :row-class-name="rowClass"
      :highlight-current-row="true"
      v-loading="dataListLoading"
      @selection-change="selectionChangeHandle"
      style="width: 100%;">
      <el-table-column
        type="selection"
        header-align="center"
        align="center"
        width="50"
        v-id="isCanDo">
      </el-table-column>
      <el-table-column
        type="index"
        width="60"
        align="center"
        label="序号">
      </el-table-column>
      <el-table-column
        prop="roleName"
        header-align="center"
        align="center"
        label="角色名称">
      </el-table-column>
      <el-table-column
        prop="createTime"
        header-align="center"
        align="center"
        width="200"
        label="创建时间">
      </el-table-column>
      <el-table-column
        width="250"
        header-align="center"
        align="center"
        label="操作"
        v-if="isCanDo" >
        <template slot-scope="scope">
          <el-button type="text" size="small" @click="addOrUpdateHandle(scope.row.roleId)">修改</el-button>
          <el-button type="text" size="small" @click="deleteHandle(scope.row.roleId,scope.row.roleName)" >删除</el-button>
        </template>
      </el-table-column>
    </el-table>
    <add-or-update  v-if="addOrUpdateVisible"  ref="addOrUpdate" @refreshCurrentOrgDepList="getDataList"></add-or-update>
    </div>
  </div>
</template>

<script>
  import AddOrUpdate from './add-or-update'
  export default {
    data () {
      return {
        dataForm: {
          roleName: ''
        },
        dataList: [],
        dataListLoading: false,
        dataListSelections: [],
        selectRow:[],
        addOrUpdateVisible: false,
        //按钮是否可操作，账号和admin是可以的
        isCanDo:false
      }
    },
    computed:{
      //计算内部元素的高度
      asideHeight:function(){
        return document.documentElement['clientHeight'] - 97 - 30 - 31
      }
    },
    components: {
      AddOrUpdate
    },
    activated () {
      this.dataForm.roleName = this.$route.query.key;
      this.getDataList()
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
    methods: {
      rowClass({row,rowIndex}){
        if(this.selectRow.includes(rowIndex)){
          return 'select-row';
        }
      },
       refresh(){
         this.$router.push({name:'sys_role_list',query: {key:this.dataForm.roleName,pageIndex:this.pageIndex,pageSize:this.pageSize}});
      },
      search(){
         this.getDataList();
      },
      // 获取数据列表
      getDataList () {
        this.dataListLoading = true
        this.$http({
          url: this.$http.adornUrl('/sys/role/newlist'),
          method: 'get'
        }).then(({data}) => {
          if (data && data.code === 0) {
            this.dataList = data.roleList
            this.isCanDo = data.isCanDo
          } else {
            this.dataList = []
          }
          this.dataListLoading = false
        })
      },
      // 多选
      selectionChangeHandle (val) {
        this.dataListSelections = val
      },
      // 新增 / 修改
      addOrUpdateHandle (id) {
        this.addOrUpdateVisible = true
        this.$nextTick(() => {
          this.$refs.addOrUpdate.init(id)
        })

       /* if(id) {
          this.$router.push({name:'sys_role_update' , query:{id:id}})
        } else{
          this.$router.push({name:'sys_role_add'})
        }*/
      },
      // 删除
      deleteHandle (id,roleName) {
        var ids = id ? [id] : this.dataListSelections.map(item => {
          return item.roleId
        })
        var roleNames = roleName ? [roleName] : this.dataListSelections.map(item => {
          return item.roleName
        })
        this.$confirm(`删除不可恢复, 该角色下的相关用户都将删除，是否删除?`, '提示', {
          confirmButtonText: '确定',
          cancelButtonText: '取消',
          type: 'warning'
        }).then(() => {
          this.$http({
            url: this.$http.adornUrl('/sys/role/delete'),
            method: 'post',
            data: this.$http.adornData(ids, false)
          }).then(({data}) => {
            if (data && data.code === 0) {
              this.$message({
                message: '操作成功',
                type: 'success',
                duration: 1500,
                onClose: () => {
                  this.getDataList()
                }
              })
            } else {
              this.$message.error(data.msg)
            }
          })
        }).catch(() => {})
      }
    }
  }
</script>
