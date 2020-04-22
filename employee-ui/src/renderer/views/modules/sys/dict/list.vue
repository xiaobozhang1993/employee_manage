<template>
  <div>
    <el-container class="menu-container" :height="asideHeight">
      <el-main :height="asideHeight" style="overflow-x: hidden !important;">
        <div class="div_block" :style="{'height':asideHeight*0.9-5+'px'}">
          <el-form :inline="true" :model="dataForm" @submit.native.prevent >
            <el-form-item>
              <el-input v-model="dataForm.description" placeholder="类型名称" clearable></el-input>
            </el-form-item>
            <el-form-item>
              <el-button class="my-button" size="mini" icon="el-icon-search" @click="search()" native-type="submit">查询</el-button>
              <el-button class="my-button" size="mini" icon="el-icon-document-add"
                         v-if="isAuth('sys:sysdict:save')" @click="addOrUpdateHandle()">新增</el-button>
              <el-button class="my-button" size="mini" icon="el-icon-delete"
                         v-if="isAuth('sys:sysdict:delete')" @click="deleteHandle()"
                         :disabled="dataListSelections.length <= 0">批量删除</el-button>
            </el-form-item>
          </el-form>
          <el-table
            :data="dataList"
            border
            :height="asideHeight*0.8"
            :row-class-name="rowClass"
            :highlight-current-row="true"
            v-loading="dataListLoading"
            @selection-change="selectionChangeHandle"
            style="width: 100%;">
            <el-table-column
              type="selection"
              header-align="center"
              align="center"
              width="50">
            </el-table-column>
            <el-table-column
              prop="description"
              header-align="center"
              align="center"
              label="类型名称">
            </el-table-column>
            <el-table-column
              prop="type"
              header-align="center"
              align="center"
              label="字典分类">
            </el-table-column>
            <el-table-column
              prop="value"
              header-align="center"
              align="center"
              width="80"
              label="值">
            </el-table-column>
            <el-table-column
              prop="dictName"
              header-align="center"
              align="center"
              label="标签">
            </el-table-column>
            
            <el-table-column
              prop="delFlag"
              width="80"
              header-align="center"
              align="center"
              label="状态">
              <template slot-scope="scope">
                <el-tag v-if="scope.row.delFlag === 0" size="small" type="success">可用</el-tag>
                <el-tag v-else-if="scope.row.delFlag === 1" size="small" type="info">不可用</el-tag>
              </template>
            </el-table-column>

            <el-table-column
              header-align="center"
              align="center"
              width="150"
              label="操作">
              <template slot-scope="scope">
                <el-button type="text" size="small" @click="addOrUpdateHandle(scope.row.dictId)">修改</el-button>
                <el-button type="text" size="small" @click="deleteHandle(scope.row.dictId)">删除</el-button>
              </template>
            </el-table-column>
          </el-table>
        </div>
        <!-- <el-pagination
       class="opt-footer"
        v-if="!dataListLoading"
        @size-change="sizeChangeHandle"
        @current-change="currentChangeHandle"
        :current-page="pageIndex"
        :page-sizes="[10, 20, 50, 100]"
        :page-size="pageSize"
        :total="totalPage"
        layout="total, sizes, prev, pager, next, jumper">
      </el-pagination> -->
      </el-main>
    </el-container>
  </div>
</template>

<script>
  export default {
    data () {
      return {
        dataForm: {
          description: null
        },
        types:[] , // 字典分类类型
        dataList: [],
        pageIndex: 1,
        pageSize: 10,
        totalPage: 0,
        dataListLoading: false,
        dataListSelections: [],
        selectRow:[],
        addOrUpdateVisible: false
      }
    },
    components: {
    },
    computed: {
      //计算内部元素的高度
      asideHeight: function () {
        return document.documentElement['clientHeight'] - 110 - 25-20
      }

    },
    activated () {
      this.dataForm.key = this.$route.query.key;
      let pageIndex = this.$route.query.pageIndex;

      if(pageIndex) {
        this.pageIndex = parseInt(pageIndex);
      }

      let pageSize = this.$route.query.pageSize;
      if(pageSize) {
        this.pageSize = parseInt(pageSize);
      }
      //this.getDataType()
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
      search(){
        this.getDataList();
      },
      // 获取分类类型
      getDataType () {
        this.$http({
          url: this.$http.adornUrl('/sys/sysdict/types'),
          method: 'get',
          params: this.$http.adornParams({

          })
        }).then(({data}) => {
          if (data && data.code === 0) {
            this.types = data.data
          } else {
            this.types = []
          }
        })
      },

      // 获取数据列表
      getDataList () {

        this.dataListLoading = true
        this.$http({
          url: this.$http.adornUrl('/sys/sysdict/list'),
          method: 'get',
          params: this.$http.adornParams({
            'description': this.dataForm.description
          })
        }).then(({data}) => {
          if (data && data.code === 0) {
            this.dataList = data.list
          } else {
            this.dataList = []
            this.totalPage = 0
          }

          this.dataListLoading = false
        })
      },
      // 每页数
      sizeChangeHandle (val) {
        this.pageSize = val
        this.pageIndex = 1
        this.getDataList()
        this.refresh()
      },
      // 当前页
      currentChangeHandle (val) {
        this.pageIndex = val
        this.getDataList()
        this.refresh()
      },
      // 多选
      selectionChangeHandle (val) {
        this.dataListSelections = val
      },
      // 新增 / 修改
      addOrUpdateHandle (id) {
        // this.addOrUpdateVisible = true
        // this.$nextTick(() => {
        //   this.$refs.addOrUpdate.init(id)
        // })

        if(id) {
          this.$router.push({name:'sys_dict_update',query: {id:id}});
        } else {
          this.$router.push({name:'sys_dict_add'});
        }
      },
      // 删除
      deleteHandle (id) {
        var ids = id ? [id] : this.dataListSelections.map(item => {
          return item.dictId
        })
        this.$confirm(`删除不可恢复, 是否删除?`, '提示', {
          confirmButtonText: '确定',
          cancelButtonText: '取消',
          type: 'warning'
        }).then(() => {
          this.$http({
            url: this.$http.adornUrl('/sys/sysdict/delete'),
            method: 'post',
            data: this.$http.adornData(ids, false)
          }).then(({data}) => {
            if (data && data.code === 0) {
              this.$message({
                message: '操作成功',
                type: 'success',
                duration: 500,
                onClose: () => {
                  this.getDataList()
                }
              })
            } else {
              this.$message.error(data.msg)
            }
          })
        })
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
    background-color: #F0F0F0;
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
