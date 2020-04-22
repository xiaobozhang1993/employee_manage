<template>
  <el-dialog
    :title="!dataForm.id ? '新增' : '修改'"
    :close-on-click-modal="false"
    :before-close="closeDialog"
    :visible.sync="visible">

    <el-form :model="dataForm" :rules="dataRule" ref="dataForm" @keyup.enter.native="dataFormSubmit()" label-width="100px">
      <el-form-item label="角色名称" prop="roleName">
        <el-input v-model="dataForm.roleName" placeholder="角色名称"></el-input>
      </el-form-item>
      <el-form-item label="备注" prop="remark">
        <el-input v-model="dataForm.remark" placeholder="备注"></el-input>
      </el-form-item>
      <el-row>
        <el-col :span="12">
          <el-form-item size="mini" label="菜单栏授权">
            <el-tree
              :data="menuList"
              :props="menuListTreeProps"
              node-key="menuId"
              ref="menuListTree"
              :default-expand-all="true"
              show-checkbox>
            </el-tree>
          </el-form-item>
        </el-col>
        <el-col  :span="12">
          <el-form-item size="mini" label="工具栏授权">
            <el-tree
              :data="tmenuList"
              :props="menuListTreeProps"
              node-key="menuId"
              ref="tmenuListTree"
              :default-expand-all="true"
              show-checkbox>
            </el-tree>
          </el-form-item>
        </el-col>
      </el-row>
    </el-form>

    <div  class="opt-footer">
      <el-button @click="goback()">取消</el-button>
      <el-button type="primary" @click="dataFormSubmit()" :disabled="btndisable">确定</el-button>
    </div>

  </el-dialog>
</template>

<script>
  import { treeDataTranslate } from '@/utils'
  export default {
    data () {
      return {
        visible: false,
        menuList: [],
        tmenuList:[],
        menuListTreeProps: {
          label: 'name',
          children: 'children'
        },
        dataForm: {
          id: 0,
          roleName: '',
          remark: ''
        },
        dataRule: {
          roleName: [
            { required: true, message: '角色名称不能为空', trigger: 'blur' }
          ]
        },
        btndisable:false
       /* tempKey: -666666 */// 临时key, 用于解决tree半选中状态项不能传给后台接口问题. # 待优化
      }
    },
    methods: {
      init (id) {
        this.dataForm.id = id
        this.$http({
          url: this.$http.adornUrl('/sys/menu/newlist'),
          method: 'get',
          params: this.$http.adornParams()
        }).then(({data}) => {
          this.menuList = treeDataTranslate(data.mlist, 'menuId')
          this.tmenuList = treeDataTranslate(data.tlist, 'menuId')
        }).then(() => {
          this.visible = true
          this.$nextTick(() => {
            this.$refs['dataForm'].resetFields()
            this.$refs.menuListTree.setCheckedKeys([])
            this.$refs.tmenuListTree.setCheckedKeys([])
          })
        }).then(() => {
          if (this.dataForm.id) {
            this.$http({
              url: this.$http.adornUrl(`/sys/role/info/${this.dataForm.id}`),
              method: 'get',
              params: this.$http.adornParams()
            }).then(({data}) => {
              if (data && data.code === 0) {

                this.dataForm.roleName = data.role.roleName
                this.dataForm.remark = data.role.remark
                this.$refs.menuListTree.setCheckedKeys(data.role.menuIdList)
                this.$refs.tmenuListTree.setCheckedKeys(data.role.menuIdList)
              }
            })
          }
        })
      },
      // 表单提交
      dataFormSubmit () {
        this.$refs['dataForm'].validate((valid) => {
          if (valid) {
            this.btndisable = true
            this.$http({
              url: this.$http.adornUrl(`/sys/role/${!this.dataForm.id ? 'save' : 'update'}`),
              method: 'post',
              data: this.$http.adornData({
                'roleId': this.dataForm.id || undefined,
                'roleName': this.dataForm.roleName,
                'remark': this.dataForm.remark,
                'menuIdList': [].concat(this.$refs.menuListTree.getCheckedKeys())
                                .concat(this.$refs.tmenuListTree.getCheckedKeys())
              })
            }).then(({data}) => {
              if (data && data.code === 0) {
                this.$message({
                  message: '操作成功',
                  type: 'success',
                  duration: 500,
                  onClose: () => {
                    this.$refs['dataForm'].resetFields()
                    this.visible = false;
                    this.$emit("refreshCurrentOrgDepList");
                    this.btndisable = false
                  }
                })
              } else {
                this.$message.error(data.msg)
                this.btndisable = false
              }
            })
          }
        })
      },
   /*   // 遍历找出所有子节点
      findAllChildren(data, arr) {
        data.forEach((item, index) => {
          if(item.children.length !== 0) {
            this.findAllChildren(item.children, arr);
          }else if(item.validSign == '1'){

            arr.push(item.id);
          }
        })
      },*/
      closeDialog(done){
        this.$confirm('确认关闭？')
          .then(_ => {
            done();
            this.$refs['dataForm'].resetFields()
            /*location.reload();*/
          })
          .catch(_ => { });
      },
      //取消
      goback(){
        this.$refs['dataForm'].resetFields()
        this.visible = false;
      },
    }
  }
</script>
