<template>
 <div class="mod-config">
    <el-form :model="dataForm" :rules="dataRule" ref="dataForm" @keyup.enter.native="dataFormSubmit()" label-width="80px">
      <el-form-item label="类型" prop="paramType">
        <el-radio-group v-model="dataForm.paramType">
          <el-radio v-for="item in paramTypes" :key="item.value" :label="item.value">{{item.label}}</el-radio>
        </el-radio-group>
      </el-form-item>

      <el-form-item label="参数名" prop="paramKey">
        <el-input v-model="dataForm.paramKey" placeholder="参数名"></el-input>
      </el-form-item>
      <el-form-item label="参数值" prop="paramValue" v-if="dataForm.paramType == 1">
        <el-input v-model="dataForm.paramValue" type="textarea" placeholder="参数值"></el-input>
      </el-form-item>
      <el-form-item label="参数数组" prop="paramValue" v-if="dataForm.paramType == 2">

         <el-row >
              <el-col :span="20">

                  <el-row>
                    <template v-for="(item , index) in dataForm.paramList" >
                      <el-col :span="15">
                        <el-input  v-model="dataForm.paramList[index]" >{{item}}</el-input>
                      </el-col>
                      <el-col :span="4">
                         <el-button type="text" size="small" @click="deleteListHandle(index)" >删除</el-button>
                      </el-col>

                    </template>

                  </el-row>
              </el-col>
              <el-col :span="4">
                    <el-button type="primary" @click="addListCol" size="mini">添加值</el-button>
              </el-col>
          </el-row>

      </el-form-item>
        <el-form-item label="参数表" prop="paramValue" v-if="dataForm.paramType == 3">
          <el-row >
            <el-col  :span="20">
                <el-checkbox-group
                  v-model="deleteRows">
                  <el-checkbox v-for="item in dataForm.paramTableKyes" :label="item" :key="item">{{item}}</el-checkbox>
                </el-checkbox-group>
            </el-col>
            <el-col  :span="4">
                 <el-button   v-if="dataForm.paramTableKyes.length > 0"  type="danger" @click="delCol" size="mini">删除列</el-button>
            </el-col>

          </el-row>
          <el-row >
              <el-col :span="20">
                 <el-table
                    :data="dataForm.paramTable"
                    border
                    height="250"
                    fixed
                    style="width: 100%">
                      <el-table-column  :show-overflow-tooltip="true" v-for="item in dataForm.paramTableKyes"  :prop="item" :key="item" :label="item"  >
                        <template slot-scope="scope">
                          <el-input  v-model="scope.row[item]" ></el-input>
                        </template>
                      </el-table-column>
                       <el-table-column
                        fixed="right"
                        header-align="center"
                        align="center"
                        label="操作">
                        <template slot-scope="scope">
                          <el-button type="text" size="small" @click="deleteTableHandle(scope.$index)">删除</el-button>
                        </template>
                      </el-table-column>
                  </el-table>
              </el-col>
              <el-col :span="4">
                  <el-row>
                      <el-button type="primary" @click="addCol" size="mini">添加列</el-button>
                  </el-row>

                  <el-row>
                     <el-button type="primary" @click="addRow" size="mini">添加行</el-button>
                  </el-row>

              </el-col>
          </el-row>


      </el-form-item>
      <el-form-item label="备注" prop="remark">
        <el-input v-model="dataForm.remark" placeholder="备注"></el-input>
      </el-form-item>
    </el-form>
    <div  class="opt-footer">
      <el-button @click="back()">取消</el-button>
     <!--  <el-button @click="test()">TEST</el-button>-->
      <el-button type="primary" :disabled="loading" @click="dataFormSubmit()">确定</el-button>
    </div>
  </div>




</template>

<script>
  export default {
    data () {
      var validateValue = (rule, value, callback) => {
        if (this.dataForm.paramType == 1 && !/\S/.test(this.dataForm.paramValue)) {
          callback(new Error('参数不能为空'))
        } else if(this.dataForm.paramType == 2 && !this.dataForm.paramList){
          callback(new Error('参数数组不能为空'))

        } else if(this.dataForm.paramType == 3 && (!this.dataForm.paramTable || !this.dataForm.paramTableKyes || this.dataForm.paramTableKyes.length < 1)){
           callback(new Error('参数表格不能为空'))
        }

        callback()
      }
      return {
        paramTypes: [
          {"label":'字符串' , value:1},
          {"label":'数组' , value:2},
          {"label":'表格' , value:3}
        ],
        deleteRows:[],
        loading: false,
        dataForm: {
          id: 0,
          paramKey: '',
          paramValue: '',
          paramList:[],
          paramTable:[],
          paramTableKyes:[],
          remark: '',
          paramType:1,
          configType:1//1：配置管理2:编制介绍；3：员工介绍
        },
        dataRule: {
          paramKey: [
            { required: true, message: '参数名不能为空', trigger: 'blur' }
          ],
          paramValue: [
            {validator: validateValue , trigger: 'blur' }
          ]
        }
      }
    },
    activated () {
      const id = this.$route.query.id
      this.init(id)
      this.loading = false
    },
    methods: {
      init (id) {
        this.dataForm.id = id || 0
        this.visible = true
        this.$nextTick(() => {
          this.$refs['dataForm'].resetFields()
          if (this.dataForm.id) {
            this.$http({
              url: this.$http.adornUrl(`/sys/config/info/${this.dataForm.id}`),
              method: 'get',
              params: this.$http.adornParams()
            }).then(({data}) => {
              if (data && data.code === 0) {
                this.dataForm.paramKey = data.config.paramKey
                this.dataForm.paramType = data.config['paramType']
                this.dataForm.remark = data.config.remark
                this.dataForm.paramValue = data.config.paramValue
                if(!this.dataForm.paramType || this.dataForm.paramType == 1 ){
                  // 字符串
                   this.dataForm.paramValue = data.config.paramValue
                } else if(this.dataForm.paramType == 2){
                  // 数组
                  this.dataForm.paramList = JSON.parse(data.config.paramValue);
                } else if(this.dataForm.paramType == 3) {
                  // 表格
                  this.dataForm.paramTable = JSON.parse(data.config.paramValue);
                  // keys
                  this.dataForm.paramTableKyes = [];
                  if(this.dataForm.paramTable && this.dataForm.paramTable.length > 0){
                    const zeroIndexTable = this.dataForm.paramTable[0]
                    for(let key in zeroIndexTable){
                      this.dataForm.paramTableKyes.push(key)
                    }

                  }

                }
              }
            })
          }
        })
      },
      // 表单提交
      dataFormSubmit () {
        this.$refs['dataForm'].validate((valid) => {
          if (valid) {
            let paramValue = this.dataForm.paramValue;
            if(this.dataForm.paramType == 2){
              // 数组
              paramValue = JSON.stringify(this.dataForm.paramList)
            } else if(this.dataForm.paramType == 3){
              // 表格
              paramValue = JSON.stringify(this.dataForm.paramTable)
            }

            this.loading = true
            this.$http({
              url: this.$http.adornUrl(`/sys/config/${!this.dataForm.id ? 'save' : 'update'}`),
              method: 'post',
              data: this.$http.adornData({
                'id': this.dataForm.id || undefined,
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
                    this.loading = false
                    this.back()
                  }
                })
              } else {
                this.$message.error(data.msg)
              }
            })
          }
        })
      },
      addCol() {
        this.$prompt('请输入新增字段名', '提示', {
          confirmButtonText: '确定',
          cancelButtonText: '取消',
          inputPattern: /\S/,
          inputErrorMessage: '不能为空'
        }).then(({ value }) => {
          this.dataForm.paramTableKyes.push(value);
          for(let i in this.dataForm.paramTable){
            this.dataForm.paramTable[i][value] = '' ;
          }


        }).catch(() => {

        });
      },
      deleteTableHandle(index) {
        this.dataForm.paramTable.splice(index , 1)
      },
      deleteListHandle(index) {
        this.dataForm.paramList.splice(index , 1)
      },
      addRow() {
        this.dataForm.paramTable.push({});
      },
      delCol() {

        this.deleteRows.forEach(row=>{
          this.delCol_bylabel(row)
        })

        this.deleteRows = [];

      } ,
      delCol_bylabel(label) {
        for(let i in this.dataForm.paramTableKyes){
          const key = this.dataForm.paramTableKyes[i];
          if(key == label){
            this.dataForm.paramTableKyes.splice(i , 1);
            for(let i in this.dataForm.paramTable){
              delete  this.dataForm.paramTable[i][label]
            }
            break ;
          }
        }

      },
      test(){
        this.$router.push({name:'test'})
      },
      addListCol() {
        this.$prompt('请输入数组新增值', '提示', {
          confirmButtonText: '确定',
          cancelButtonText: '取消',
          inputPattern: /\S/,
          inputErrorMessage: '不能为空'
        }).then(({ value }) => {

           this.dataForm.paramList.push(value)

        }).catch(() => {

        });
      }
    }
  }
</script>
