<template>
  <div class="mod-config">
    <el-form :model="dataForm" :rules="dataRule" ref="dataForm" @keyup.enter.native="dataFormSubmit()" label-width="120px">
      <el-form-item label="编制介绍" prop="paramValue">
        <el-input v-model="dataForm.paramValue" type="textarea" placeholder="编制介绍"></el-input>
      </el-form-item>
    </el-form>
    <div  class="opt-footer">
      <el-button type="primary" @click="dataFormSubmit()">确定</el-button>
      <el-button type="warning" @click="deleteHandle()">清空</el-button>
    </div>
  </div>




</template>

<script>
  export default {
    data () {
      return {
        loading: false,
        dataForm: {
          paramKey: '',
          paramValue: '',
          remark: '',
          paramType:1,
          configType:3,//1：配置管理2:编制介绍；3：员工介绍
        },
        dataRule: {
          paramValue: [
            {required: true, message: '编制介绍不能为空',  trigger: 'blur' }
          ]
        }
      }
    },
    activated () {
      this.init()
      this.loading = false
    },
    methods: {
      init () {
        this.dataForm.paramKey=''
        this.visible = true
        this.$nextTick(() => {
          this.$refs['dataForm'].resetFields()
            this.$http({
              url: this.$http.adornUrl(`/sys/config/newInfo/3`),
              method: 'get',
              params: this.$http.adornParams()
            }).then(({data}) => {
              if (data && data.code === 0) {
                this.dataForm.paramKey = data.config.paramKey
                this.dataForm.remark = data.config.remark
                this.dataForm.paramValue = data.config.paramValue
              }
            })
        })
      },
      // 表单提交
      dataFormSubmit () {
        this.$refs['dataForm'].validate((valid) => {
          if (valid) {
            let paramValue = this.dataForm.paramValue;

            this.loading = true
            this.$http({
              url: this.$http.adornUrl(`/sys/config/${!this.dataForm.paramKey ? 'save' : 'update'}`),
              method: 'post',
              data: this.$http.adornData({
                'paramKey': this.dataForm.paramKey,
                'paramValue': paramValue,
                'remark': this.dataForm.remark,
                'paramType': this.dataForm.paramType,
                'configType':this.dataForm.configType
              })
            }).then(({data}) => {
              if (data && data.code === 0) {
                this.$message({
                  message: '操作成功',
                  type: 'success',
                  duration: 500,
                  onClose: () => {
                    this.init()
                  }
                })
              } else {
                this.$message.error(data.msg)
              }
            })
          }
        })
      },
      // 清空
      deleteHandle () {
        this.$confirm(`删除不可恢复, 是否删除?`, '提示', {
          confirmButtonText: '确定',
          cancelButtonText: '取消',
          type: 'warning'
        }).then(() => {
          this.$http({
            url: this.$http.adornUrl('/sys/config/newDelete'),
            method: 'post',
            data: this.$http.adornData({
              'configType':this.dataForm.configType
            })
          }).then(({data}) => {
            if (data && data.code === 0) {
              this.$message({
                message: '操作成功',
                type: 'success',
                duration: 1500,
                onClose: () => {
                  this.init()
                },

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
