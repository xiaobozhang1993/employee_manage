<template>
 <!--  <el-dialog
    :title="!dataForm.dictId ? '新增' : '修改'"
    :close-on-click-modal="false"
    :lock-scroll="false"
    :visible.sync="visible"> -->
    <div class="mod-config" :style="{'overflow-y':'scroll','height':asideHeight-50-40+'px'}">
    <el-form v-loading="loading" :model="dataForm" :rules="dataRule" ref="dataForm"  class="alt_form" label-width="110px">
      <el-form-item label="类型名称" prop="description">
        <el-input v-model="dataForm.description" placeholder="类型名称"></el-input>
      </el-form-item>
      <el-form-item label="字典分类" prop="type">
        <el-input v-model="dataForm.type" placeholder="字典分类"></el-input>
      </el-form-item>
      <el-form-item label="值" prop="value">
        <el-input v-model="dataForm.value" placeholder="值"></el-input>
      </el-form-item>
      <el-form-item label="标签" prop="dictName">
        <el-input v-model="dataForm.dictName" placeholder="标签"></el-input>
      </el-form-item>
      

      <el-form-item label="序号" prop="seq">
        <el-input-number v-model="dataForm.seq" controls-position="right" :min="0" label="排序号"></el-input-number>
      </el-form-item>

      <el-form-item label="状态" prop="delFlag">
         <el-switch

              v-model="dataForm.enable"
              active-color="#13ce66"
              inactive-color="#ff4949"
              active-text="启用"
              inactive-text="不启用">
            </el-switch>
      </el-form-item>

    </el-form>
    <div  class="opt-footer">
      <el-button @click="back()">取消</el-button>
      <el-button :disabled="loading" type="primary" @click="dataFormSubmit()">确定</el-button>
    </div>
  </div>
  <!-- </el-dialog> -->
</template>

<script>
  export default {
    data () {
      return {
        loading: false,
        visible: false,
        dataForm: {
          dictId: 0,
          value: '',
          dictName: '',
          isDict: '',
          type: '',
          description: '',
          seq: '',
          createDate: '',
          updateDate: '',
          delFlag: '',
          createBy: '',
          updateBy: '',
          enable:true
        },
        dataRule: {
          value: [
            { required: true, message: '值不能为空', trigger: 'blur' }
          ],
          dictName: [
            { required: true, message: '标签不能为空', trigger: 'blur' }
          ],
          type: [
            { required: true, message: '字典分类不能为空', trigger: 'blur' }
          ],
          description: [
            { required: true, message: '类型名称不能为空', trigger: 'blur' }
          ],
          seq: [
            { required: true, message: '序号不能为空', trigger: 'blur' }
          ],

        }
      }
    },
    computed:{
      //计算内部元素的高度
      asideHeight:function(){
        return document.documentElement['clientHeight'] - 110 - 25
      }
    },
    activated () {

      let id= this.$route.query.id
      //console.log('id' , id)
      this.init(id)

    },
    methods: {
      init (id) {
        this.dataForm.dictId = id || 0
        this.loading = false
        this.$nextTick(() => {
          this.$refs['dataForm'].resetFields()
          if (this.dataForm.dictId) {
            this.$http({
              url: this.$http.adornUrl(`/sys/sysdict/info/${this.dataForm.dictId}`),
              method: 'get',
              params: this.$http.adornParams()
            }).then(({data}) => {
              if (data && data.code === 0) {
                this.dataForm.value = data.sysDict.value
                this.dataForm.dictName = data.sysDict.dictName
                this.dataForm.isDict = data.sysDict.isDict
                this.dataForm.type = data.sysDict.type
                this.dataForm.description = data.sysDict.description
                this.dataForm.seq = data.sysDict.seq
                this.dataForm.createDate = data.sysDict.createDate
                this.dataForm.updateDate = data.sysDict.updateDate
                this.dataForm.delFlag = data.sysDict.delFlag
                this.dataForm.createBy = data.sysDict.createBy
                this.dataForm.updateBy = data.sysDict.updateBy
                this.dataForm.enable = data.sysDict.delFlag == 0
              }
            })
          }
        })
      },
      // 表单提交
      dataFormSubmit () {
        this.$refs['dataForm'].validate((valid) => {
          if (valid) {
            this.loading = true
            this.$http({
              url: this.$http.adornUrl(`/sys/sysdict/${!this.dataForm.dictId ? 'save' : 'update'}`),
              method: 'post',
              data: this.$http.adornData({
                'dictId': this.dataForm.dictId || undefined,
                'value': this.dataForm.value,
                'dictName': this.dataForm.dictName,
                'isDict': this.dataForm.isDict,
                'type': this.dataForm.type,
                'description': this.dataForm.description,
                'seq': this.dataForm.seq,
                'createDate': this.dataForm.createDate,
                'updateDate': this.dataForm.updateDate,
                'delFlag': this.dataForm.enable ? 0 : 1,
                'createBy': this.dataForm.createBy,
                'updateBy': this.dataForm.updateBy
              })
            }).then(({data}) => {
              if (data && data.code === 0) {
                this.$message({
                  message: '操作成功',
                  type: 'success',
                  duration: 1000,
                  onClose: () => {
                    // this.visible = false
                    // this.$emit('refreshDataList')
                    this.back()
                  }
                })
              } else {
                this.loading = false
                this.$message.error(data.msg)
              }
            })
          }
        })
      }
    }
  }
</script>
