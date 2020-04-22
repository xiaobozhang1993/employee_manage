<template>
    <div>
        <el-dialog
                title="新增人员"
                :visible.sync="dialogVisible"
                width="40%"
                :close-on-click-modal="false"
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
                    <el-form-item label="编号" prop="baseNo">
                        <el-input
                                placeholder="编号"
                                v-model="dataForm.baseNo"
                                maxlength="25"
                        ></el-input>
                    </el-form-item>
                    <el-form-item label="姓名" prop="name">
                        <el-input
                                placeholder="人员姓名"
                                v-model="dataForm.name"
                                maxlength="50"
                        ></el-input>
                    </el-form-item>
                    <el-form-item label="性别" prop="gender">
                        <dict-select :form="dataForm" field="gender" dictType="gender"/>
                    </el-form-item>
                    <el-form-item label="身份证号" prop="idCard">
                        <el-input @input="changeCard"
                                  v-model="dataForm.idCard"
                                  placeholder="身份证号"
                                  maxlength="18"
                        ></el-input>
                    </el-form-item>
                    
                </el-form>
            </div>
            <span style="font-size: 12px;color: red">{{errorMsg}}</span>
            <span slot="footer" class="dialog-footer">
      <el-button @click="backList()">取消</el-button>
      <el-button type="primary" @click="nextStep()">下一步</el-button>
    </span>
        </el-dialog>

       
    </div>
</template>

<script>
    export default {
        data() {
            return {
                dialogVisible: false,
                leaveVisible: false,
                dataForm: {
                    name: '',
                    gender: '',
                    idCard: '',
                    orgId: '',
                    department: '',
                    baseNo: '',
                    entryTime: '',
                    positiveTime: '',
                    birthday: '',
                    age: ''
                },
                dimission: [],
                orgList: [],
                deptList: [],
                errorMsg: '',
                // 开始时间
                pickerBeginDateBefore: {
                    disabledDate: (time) => {
                        let beginDateVal = this.dataForm.positiveTime;
                        if (beginDateVal) {
                            return time.getTime() > beginDateVal;
                        }
                    }
                },
                // 结束时间
                pickerBeginDateAfter: {
                    disabledDate: (time) => {
                        let beginDateVal = this.dataForm.entryTime;
                        if (beginDateVal) {
                            return time.getTime() < beginDateVal;
                        }
                    }
                },
                rules: {
                    baseNo: [
                        {required: true, message: "请输入编号", trigger: "blur"}
                    ],
                    name: [
                        {required: true, message: "请输入姓名", trigger: "blur"}
                    ],
                    idCard: [
                        {required: true, message: "请输入身份证号!", trigger: "blur"},
                        {
                            pattern: /(^[1-9]\d{5}(18|19|([23]\d))\d{2}((0[1-9])|(10|11|12))(([0-2][1-9])|10|20|30|31)\d{3}[0-9Xx]$)|(^[1-9]\d{5}\d{2}((0[1-9])|(10|11|12))(([0-2][1-9])|10|20|30|31)\d{2}$)/,
                            message: "身份证号码格式有误！",
                            trigger: "blur"
                        }
                    ],
                    entryTime: [
                        {required: true, message: "请选择入职时间", trigger: "change"}
                    ],
                    positiveTime: [
                        {required: true, message: "请选择转正时间", trigger: "change"}
                    ],
                }
            }
        },
        computed: {
            orgId: {
                get() {
                    return this.$store.state.user.orgId
                },
                set(val) {
                    this.$store.commit('user/updateOrgId', val)
                }
            },
        },
        created() {
            this.getOrg()
        },
        methods: {
            //获取员工单位信息
            getOrg() {
                var urlOrgList = this.$http.adornUrl('/sys/org/listAll');
                this.$http.post(urlOrgList).then((data) => {
                    this.orgList = data.data.orgList;
                    this.dataForm.orgId = this.orgId
                    this.queryDept(this.dataForm.orgId)
                })
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

            init() {
                this.errorMsg = ''
                this.resetForm("dataForm")
                this.dialogVisible = true
            },
            nextStep() {
                this.$refs["dataForm"].validate((valid) => {
                    if (valid) {
                        var idCard = this.dataForm.idCard
                        this.$http({
                            url: this.$http.adornUrl(`/employee/employeebaseinfo/getInfo/${idCard}`),
                            method: "get",
                            params: this.$http.adornParams()
                        })
                            .then(({data}) => {
                                if (data && data.code === 0) {
                                    if (data.list.length == 0) {
                                        this.dialogVisible = false
                                        this.$emit('transfer', this.dataForm)//将值绑定到transfer上传递过去
                                        this.$alert("请添加相应具体信息", "提示", {
                                            confirmButtonText: "确定"
                                        })
                                    } 
                                } else {
                                    this.errorMsg = data.msg
                                    /*  this.$message({
                                          type: "warning",
                                          message: data.msg
                                      });*/
                                }
                            })
                            .catch(err => {
                                console.log(err);
                                this.$message({
                                    type: "error",
                                    message: "网络异常"
                                });
                            });
                    } else {
                        return false;
                    }
                });

            },

            //查询离职记录
            getDataListByBaseId(baseId) {
                this.$http({
                    url: this.$http.adornUrl("employee/employeedimissionrecord/listByBaseId"),
                    methods: "get",
                    params: this.$http.adornParams({
                        baseId: baseId
                    })
                }).then(data => {
                    console.log(data);
                    if (data && data.data.code === 0) {
                        this.dimission = data.data.list;

                    } else {
                        this.dimission = [];
                    }
                });
            },
            //选择开始时间，清空结束时间
            changeTime(date) {
                this.dataForm.positiveTime = "";

                this.pickerBeginDateAfter = {
                    disabledDate(time) {  //开始时间-结束时间
                        return (time.getTime() < new Date(date).getTime());
                    }
                }
            },
            goAdd() {


                this.$http({
                    url: this.$http.adornUrl("/employee/employeebaseinfo/againSaveOrUpdate"),
                    methods: "get",
                    params: this.$http.adornParams({
                        baseId: this.dimission[0].baseId
                    })
                }).then(data => {
                    if (data && data.data.code === 0) {
                        this.leaveVisible = false
                        this.dialogVisible = false
                        this.$alert('<span style="color: red">该人员信息已导入到当前员工在职人员信息库中，请对该人员有关信息进行“重新修改并保存”</span>', '提示信息', {
                            dangerouslyUseHTMLString: true
                        });
                        this.$emit('refreshDataList')
                    } else {
                        this.$message.error(data.data.msg);
                        this.leaveVisible = false
                        this.dialogVisible = false
                    }
                });

                this.$emit("refreshDataList");
            },
            backList() {
                this.dialogVisible = false
            },
            leaveClose() {
                this.leaveVisible = false
            },
            // 重置表单
            resetForm(formName) {
                if (this.$refs[formName] !== undefined) {
                    this.$refs[formName].resetFields();
                }
            },
            formatterOrgId(row, column) {
                for (let index in this.orgList) {
                    if (row.orgId == this.orgList[index].id) {
                        return this.orgList[index].name
                    }
                }
            },

            //计算年龄
            getAge() {
                if (this.dataForm.birthday) {
                    var returnAge;
                    var strBirthdayArr = this.dataForm.birthday.split("-");
                    var birthYear = strBirthdayArr[0];
                    var birthMonth = strBirthdayArr[1];
                    var birthDay = strBirthdayArr[2];

                    var date = new Date();
                    var nowYear = date.getFullYear();
                    console.log(nowYear)
                    var nowMonth = date.getMonth() + 1;
                    var nowDay = date.getDate();

                    if (nowYear == birthYear) {
                        returnAge = 0;//同年 则为0岁
                    } else {
                        var ageDiff = nowYear - birthYear; //年之差
                        if (ageDiff > 0) {
                            if (nowMonth == birthMonth) {
                                var dayDiff = nowDay - birthDay;//日之差
                                if (dayDiff < 0) {
                                    returnAge = ageDiff - 1;
                                } else {
                                    returnAge = ageDiff;
                                }
                            } else {
                                var monthDiff = nowMonth - birthMonth;//月之差
                                if (monthDiff < 0) {
                                    returnAge = ageDiff - 1;
                                } else {
                                    returnAge = ageDiff;
                                }
                            }
                        } else {
                            returnAge = -1;//返回-1 表示出生日期输入错误 晚于今天
                        }
                    }
                    this.dataForm.age = returnAge
                } else {
                    this.dataForm.age = ''
                }

            },
            //根据身份证号计算出生年月
            getBirthdayByIdCard() {
                let birthday = "";
                if (this.dataForm.idCard.length == 18) {
                    birthday = this.dataForm.idCard.substr(6, 8)
                    this.dataForm.birthday = birthday.replace(/(.{4})(.{2})/, "$1-$2-")
                } else if (this.dataForm.idCard.length == 15) {
                    birthday = "19" + this.dataForm.idCard.substr(6, 6)
                    this.dataForm.birthday.replace(/(.{4})(.{2})/, "$1-$2-")
                } else {
                    this.dataForm.birthday = ""
                }
                this.getAge()
            },
            changeCard() {
                this.getBirthdayByIdCard()
            }
        },
    }
</script>

<style>

</style>
