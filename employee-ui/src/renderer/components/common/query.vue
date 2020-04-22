<template>
    <el-dialog
            title="查询条件"
            :visible="dialogVisible"
            width="40%"
            :close-on-click-modal="false"
            :show-close="false"
    >
        <div style="width:95%;margin:0 auto">
            <el-form
                    :model="dataForm"
                    ref="dataForm"
                    label-width="80px"
                    status-icon
                    @submit.native.prevent
                    center
            >
                <el-row>
                    <el-col :span="12">
                        <el-form-item label="工作ID" prop="baseNo">
                            <el-input placeholder="工作ID" v-model="dataForm.baseNo"></el-input>
                        </el-form-item>
                    </el-col>
                    <el-col :span="12">
                        <el-form-item label="姓名" prop="name">
                            <el-input placeholder="姓名" v-model="dataForm.name"></el-input>
                        </el-form-item>
                    </el-col>
                </el-row>

                <el-row>
                    <el-col :span="12">
                        <el-form-item label="身份证号" prop="idCard">
                            <el-input placeholder="身份证号" v-model="dataForm.idCard"></el-input>
                        </el-form-item>
                    </el-col>
                    <el-col :span="12">
                        <el-form-item label="所在部门">
                            <el-select v-model="dataForm.department" placeholder="请选择" style="width:100%" clearable>
                                <el-option
                                        v-for="item in deptList"
                                        :key="item.depId"
                                        :value="item.depId"
                                        :label="item.name"></el-option>
                            </el-select>
                        </el-form-item>
                    </el-col>
                </el-row>
                <el-row>
                    <el-col :span="12">
                        <el-form-item label="性别">
                            <dict-select :form="dataForm" field="gender" dictType="gender" style="width:100%"/>
                        </el-form-item>
                    </el-col>
                    <el-col :span="12">
                        <el-form-item label="年齡">
                            <el-input placeholder="请输入" v-model="dataForm.age"></el-input>
                        </el-form-item>
                    </el-col>
                </el-row>
                <el-row>
                    <el-col :span="12">
                        <el-form-item label="学历">
                            <dict-select :form="dataForm" field="education" dictType="edu_rank_mgt"
                                         style="width:100%"/>
                        </el-form-item>
                    </el-col>
                    
                </el-row>
                <el-row>
                    <el-col :span="12">
                        <el-form-item label="婚姻状况">
                            <dict-select :form="dataForm" field="marriageState" dictType="marriageState"
                                         style="width:100%"/>
                        </el-form-item>
                    </el-col>
                    <el-col :span="12">
                        <el-form-item label="所学专业">
                            <dict-select :form="dataForm" field="specialty" dictType="specialty"
                                         style="width:100%"/>
                        </el-form-item>
                    </el-col>
                </el-row>
                <el-row>
                    
                    <el-col :span="12" v-if="panl == 1">
                        <el-form-item label="离职时间">
                            <el-date-picker
                                    style="width:100%"
                                    v-model="dataForm.year"
                                    type="year"
                                    format="yyyy"
                                    value-format="yyyy"
                                    placeholder="选择年">
                            </el-date-picker>
                        </el-form-item>
                    </el-col>
                </el-row>
            </el-form>
        </div>
        <span slot="footer" class="dialog-footer">
      <el-button @click="backList()">取消</el-button>
      <el-button type="primary" @click="confirm()">确定</el-button>
    </span>
    </el-dialog>
</template>

<script>
    export default {
        props: {
            panl: {
                type: Number,
                default: 0
            }
        },
        data() {
            return {
                dialogVisible: false,
                dataForm: {
                    baseNo: '',
                    name: '',
                    idCard: '',
                    department: '',
                    age: '',
                    gender: '',
                    education: '',
                    marriageState: '',
                    level:'',
                    specialty:'',
                    year:''
                },
                deptList: [],
            }
        },
        created() {
        },
        methods: {
            init(orgId) {
                this.dataForm.department = ''
                this.dialogVisible = true
                if (!orgId) {
                    this.initUser()
                } else {
                    this.queryDept(orgId)
                }

            },
            initUser() {
                this.$http({
                    url: this.$http.adornUrl('/sys/user/getuser'),
                    method: 'get',
                    params: this.$http.adornParams({})
                }).then(({data}) => {
                    if (data && data.code === 0) {
                        this.queryDept(data.user.orgId)
                    }
                });

            },
            //获取单位列表
            queryDept(orgid) {
                this.$http({
                    url: this.$http.adornUrl("/sys/sysdepartment/childList"),
                    method: "post",
                    params: this.$http.adornParams({
                        orgid: orgid
                    })
                }).then(({data}) => {
                    this.deptList = data.deptlist;
                });
            },
            confirm() {
                this.dialogVisible = false
                this.$emit('queryData', this.dataForm)//将值绑定到queryData上传递过去
            },

            backList() {
                this.dialogVisible = false
                this.$emit("refreshDataList");
            },
            // 重置表单
            resetForm(formName) {
                if (this.$refs[formName] !== undefined) {
                    this.$refs[formName].resetFields();
                }
            }
        },
    }
</script>

<style>

</style>
