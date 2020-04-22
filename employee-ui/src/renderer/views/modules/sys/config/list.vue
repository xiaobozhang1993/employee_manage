<template>
  <div>
    <el-container class="menu-container" :height="asideHeight">
      <el-main :height="asideHeight" style="overflow-x: hidden !important;">
        <div class="div_block" :style="{'height':asideHeight*0.9-5+'px'}">
    <el-form :inline="true" :model="dataForm" @submit.native.prevent>
      <el-form-item>
        <el-input v-model="dataForm.paramKey" placeholder="参数名" clearable></el-input>
      </el-form-item>
      <el-form-item>
        <el-button class="my-button" size="mini" icon="el-icon-search" @click="search()">查询</el-button>
        <el-button class="my-button" size="mini" icon="el-icon-document-add" @click="addOrUpdateHandle()">新增</el-button>
        <el-button class="my-button" size="mini" icon="el-icon-delete" @click="deleteHandle()"
                   :disabled="dataListSelections.length <= 0">批量删除</el-button>
      </el-form-item>
    </el-form>
    <el-table
      :data="dataList"
      border
      :row-class-name="rowClass"
      :highlight-current-row="true"
      v-loading="dataListLoading"
      :height="asideHeight*0.8"
      @selection-change="selectionChangeHandle"
      style="width: 100%;">
      <el-table-column
        type="selection"
        header-align="center"
        align="center"
        width="50">
      </el-table-column>
      <el-table-column
        prop="paramKey"
        header-align="center"
        align="center"
        label="参数名">
      </el-table-column>
      <el-table-column
        prop="paramValue"
        header-align="center"
        align="center"
        label="参数值">
      </el-table-column>
      <el-table-column
        prop="remark"
        header-align="center"
        align="center"
        label="备注">
      </el-table-column>
      <el-table-column
        header-align="center"
        align="center"
        width="150"
        label="操作">
        <template slot-scope="scope">
          <el-button type="text" size="small" @click="addOrUpdateHandle(scope.row.paramKey)">修改</el-button>
          <el-button type="text" size="small" @click="deleteHandle(scope.row.paramKey)">删除</el-button>
        </template>
      </el-table-column>
    </el-table>
        </div>
      </el-main>
    </el-container>
  </div>
</template>

<script>
  export default {
    data () {
      return {
        dataForm: {
          paramKey: ''
        },
        dataList: [],
        dataListLoading: false,
        dataListSelections: [],
        selectRow:[],
        addOrUpdateVisible: false
      }
    },

    activated () {
      this.dataForm.paramKey = this.$route.query.key;

      this.getDataList()
    },
    computed: {
      //计算内部元素的高度
      asideHeight: function () {
        return document.documentElement['clientHeight'] - 110 - 25-20
      }

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
         this.$router.push({name:'sys_config_list',query: {key:this.dataForm.paramKey,pageIndex:this.pageIndex,pageSize:this.pageSize}});
      },
      search(){
         this.pageIndex = 1 ;
         this.getDataList();
         this.refresh()
      },
      // 获取数据列表
      getDataList () {
        this.dataListLoading = true
        this.$http({
          url: this.$http.adornUrl('/sys/config/list'),
          method: 'get',
          params: this.$http.adornParams({
            'paramKey': this.dataForm.paramKey,
            'configType':1
          })
        }).then(({data}) => {
          if (data && data.code === 0) {
            this.dataList = data.page.list
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
        if(id) {
          this.$router.push({name:'sys_config_update' , query:{id:id}})
        } else{
          this.$router.push({name:'sys_config_add'})
        }
      },
      // 删除
      deleteHandle (id) {
        var ids = id ? [id] : this.dataListSelections.map(item => {
          return item.paramKey
        })
        this.$confirm(`删除不可恢复, 是否删除?`, '提示', {
          confirmButtonText: '确定',
          cancelButtonText: '取消',
          type: 'warning'
        }).then(() => {
          this.$http({
            url: this.$http.adornUrl('/sys/config/delete'),
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
<style scope="this api replaced by slot-scope in 2.5.0+">
  .operation {
    padding:0px;
    background-color: #ffffff;

  }
  .el-card-backgorup{
    background-color: #FAFAFA;
  }
  .photo{
    display: flex;
    justify-content: center;
    align-items: center;
  }
  .div_block{
    background-color: #ffffff;
    padding: 10px;
  }
  .el-button--mini, .el-button--mini.is-round {
    padding: 3px 10px;
  }
  input,
  textarea {
    font-size: 24px;
    padding: 10px;
    color: red;
    text-shadow: 0px 0px 0px #000;
    -webkit-text-fill-color: transparent;
  }
  input::-webkit-input-placeholder,
  textarea::-webkit-input-placeholder{
    color:#cccccc;
    text-shadow: none;
    -webkit-text-fill-color : initial; }
</style>
