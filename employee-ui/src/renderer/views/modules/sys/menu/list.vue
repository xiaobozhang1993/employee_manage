<template>
  <div>
    <el-container class="menu-container" :height="asideHeight">
      <el-main :height="asideHeight" style="overflow-x: hidden !important;">
        <div class="div_block" :style="{'height':asideHeight*0.9-5+'px'}">
    <el-form :inline="true" :model="dataForm" @submit.native.prevent>
        <el-form-item>
       <el-select v-model="dataForm.locationType" filterable  placeholder="字典分类" @change="search">
           <el-option
              v-for="item in locationTypes"
              :key="item.id"
              :label="item.label"
              :value="item.id">
            </el-option>
        </el-select>
      </el-form-item>
      <el-form-item>
      <!--   <el-button @click="search()" native-type="submit">查询</el-button> -->
        <el-button class="my-button" size="mini" icon="el-icon-document-add"
                   v-if="isAuth('sys:menu:save')" @click="addOrUpdateHandle()">新增</el-button>
      </el-form-item>
    </el-form>
    <el-table
      :data="dataList"
      :highlight-current-row="true"
      border
      :height="asideHeight*0.8"
      style="width: 100%;">
     <!--  <el-table-column
        prop="menuId"
        header-align="center"
        align="center"
        width="80"
         :show-overflow-tooltip="true"
        label="ID">
      </el-table-column> -->
      <table-tree-column
        prop="name"
        header-align="center"
        treeKey="menuId"
        width="150"
        label="名称">
      </table-tree-column>
      <el-table-column
        prop="parentName"
        header-align="center"
        align="center"
        width="120"
        label="上级菜单">
      </el-table-column>
      <el-table-column
        header-align="center"
        align="center"
        width="80"
        label="图标">
        <template slot-scope="scope">
          <icon-svg :name="scope.row.icon || ''"></icon-svg>
        </template>
      </el-table-column>
       <el-table-column
        prop="locationType"
        header-align="center"
        align="center"
        width="100"
        :show-overflow-tooltip="true"
        label="位置">
        <template slot-scope="scope">
          <el-tag v-if="scope.row.locationType == 1" size="small" type="success">菜单栏</el-tag>
          <el-tag v-else size="small"  type="primary" >工具栏</el-tag>
        </template>
      </el-table-column>
      <el-table-column
        prop="type"
        header-align="center"
        align="center"
        width="80"
        label="类型">
        <template slot-scope="scope">
          <el-tag v-if="scope.row.type === 0" size="small">目录</el-tag>
          <el-tag v-else-if="scope.row.type === 1" size="small" type="success">菜单</el-tag>
          <el-tag v-else-if="scope.row.type === 2" size="small" type="info">按钮</el-tag>
        </template>
      </el-table-column>
      <el-table-column
        prop="orderNum"
        header-align="center"
        align="center"
        width="80"
        label="排序号">
      </el-table-column>
      <el-table-column
        prop="url"
        header-align="center"
        align="center"
        width="100"
        :show-overflow-tooltip="true"
        label="菜单URL">
      </el-table-column>

      <el-table-column
        prop="perms"
        header-align="center"
        align="center"
        width="100"
        :show-overflow-tooltip="true"
        label="授权标识">
      </el-table-column>
        <el-table-column
        prop="enabled"
        header-align="center"
        align="center"
        width="70"
        :show-overflow-tooltip="true"
        label="启用">
         <template slot-scope="scope">
          <el-tag v-if="scope.row.enabled === 1" size="small" type="success">启用</el-tag>
          <el-tag v-else size="small" type="info">禁用</el-tag>
        </template>
      </el-table-column>
      <el-table-column
        header-align="center"
        align="center"

        label="操作">
        <template slot-scope="scope">
          <el-button  type="text" size="small" @click="addOrUpdateHandle(scope.row.menuId)">修改</el-button>
          <el-button  type="text" size="small" @click="deleteHandle(scope.row.menuId)">删除</el-button>
        </template>
      </el-table-column>
    </el-table>
        </div>
      </el-main>
    </el-container>
  </div>
</template>

<script>
  import TableTreeColumn from '@/components/table-tree-column'

  import { treeDataTranslate } from '@/utils'
  export default {
    data () {
      return {
        locationTypes: [
          {id:1 , label: '菜单栏'},
          {id:2 , label: '工具栏'}
        ],
        dataForm: {
          locationType: 1 ,
        },
        menuList: [],
        toolList: [],
        dataList: [],
        dataListLoading: false
      }
    },
    components: {
      TableTreeColumn
    },
    activated () {
      this.getDataList()
    },
    computed: {
      //计算内部元素的高度
      asideHeight: function () {
        return document.documentElement['clientHeight'] - 110 - 25-20
      }

    },
    methods: {

      search(locationType) {
        if(locationType) {
          this.dataForm.locationType = locationType
        }

            if(this.dataForm.locationType == 1) {
              this.dataList = this.menuList
            }else {
              this.dataList = this.toolList
            }
      },
      // 获取数据列表
      getDataList () {
        this.dataListLoading = true
        this.$http({
          url: this.$http.adornUrl('/sys/menu/list'),
          method: 'get',
          params: this.$http.adornParams()
        }).then(({data}) => {
          if(data && data.code == 0) {
            const menuList = data.mlist
            const toolList = data.tlist

            this.menuList = treeDataTranslate(menuList, 'menuId')
            this.toolList = treeDataTranslate(toolList, 'menuId')

            if(this.dataForm.locationType == 1) {
              this.dataList = this.menuList
            }else {
              this.dataList = this.toolList
            }

          }

          this.dataListLoading = false
        })
      },
      // 新增 / 修改
      addOrUpdateHandle (id) {
        if(id) {
          this.$router.push({name:'sys_menu_update' , query:{id:id,locationType: this.dataForm.locationType}})
        } else{
          this.$router.push({name:'sys_menu_add' , query:{locationType: this.dataForm.locationType}})
        }
      },
      // 删除
      deleteHandle (id) {
        this.$confirm(`删除不可恢复, 是否删除?`, '提示', {
          confirmButtonText: '确定',
          cancelButtonText: '取消',
          type: 'warning'
        }).then(() => {
          this.$http({
            url: this.$http.adornUrl(`/sys/menu/delete/${id}`),
            method: 'post',
            data: this.$http.adornData()
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
