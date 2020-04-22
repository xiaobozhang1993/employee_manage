<template>
    <el-dialog
            title="办理离职"
            :visible.sync="dialogVisible"
            width="40%"
            :show-close="false"
    >
        <div style="width:95%;margin:0 auto">
            <el-form
                    :model="dataForm"
                    :rules="rules"
                    ref="dataForm"
                    label-width="90px"
                    status-icon
                    @submit.native.prevent
                    center
            >
                <el-form-item label="离职时间" prop="dimissionTime">
                    <el-date-picker
                            v-model="dataForm.dimissionTime"
                            type="date"
                            placeholder="请选择日期"
                            value-format="yyyy-MM-dd"
                            style="width:100%">
                    </el-date-picker>
                </el-form-item>
                <el-form-item label="离职原因" prop="dimissionReason">
                    <el-input
                            type="textarea"
                            placeholder="离职原因"
                            v-model="dataForm.dimissionReason"
                            maxlength="110"
                            size="3"
                    ></el-input>
                </el-form-item>
                
                <el-form-item>
                    <el-checkbox v-model="checked">相关的物品及相关手续是否已办结？</el-checkbox>
                </el-form-item>
            </el-form>
        </div>
        <span slot="footer" class="dialog-footer">
      <el-button @click="backList()">取消</el-button>
      <el-button :disabled="!checked" type="primary" @click="confirm()">确定</el-button>
    </span>
    </el-dialog>
</template>

<script>
    export default {
        data() {
            return {
                dialogVisible: false,
                checked: false,
                dataForm: {
                    baseId: '',
                    dimissionTime: '',
                    dimissionReason: '',
                    leaveTo: '',
                },
                rules: {
                    dimissionTime: [
                        {required: true, message: "请选择离职时间", trigger: "change"}
                    ],
                    dimissionReason: [
                        {required: true, message: "请输入离职原因", trigger: "blur"}
                    ]
                }
            }
        },

        created() {

        },
        methods: {
            init(baseId) {
                this.resetForm("dataForm")
                this.dataForm.baseId = baseId
                this.dialogVisible = true
            },

            confirm() {
                this.$refs["dataForm"].validate(valid => {
                    if (valid) {
                        this.$http({
                            url: this.$http.adornUrl("/employee/employeebaseinfo/transactLeave"),
                            method: "post",
                            data: this.$http.adornData(this.dataForm, false)
                        }).then(({data}) => {
                            if (data && data.code === 0) {
                                this.$message({
                                    message: "办理离职成功!",
                                    type: "success"
                                });
                                this.dialogVisible = false
                                this.$emit("refreshDataList");
                            } else {
                                this.$message.error(data.msg);
                            }
                        });
                    } else {
                        console.log("error submit!!");
                        return false;
                    }
                });
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
