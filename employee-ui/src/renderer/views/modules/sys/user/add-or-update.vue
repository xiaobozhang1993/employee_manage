<template>
  <el-dialog
    :title="!dataForm.id ? '新增' : '修改'"
    :close-on-click-modal="false"
    :before-close="closeDialog"
    :visible.sync="visible">
    <el-form :model="dataForm" :rules="dataRule" ref="dataForm" @keyup.enter.native="dataFormSubmit()" label-width="90px">


      <el-row>
        <el-col :span="12">
          <div class="grid-content bg-purple">
            <el-form-item label="用户名" prop="userNo" :class="{ 'is-required': !dataForm.id }">
              <el-input v-model="dataForm.userNo" placeholder="登录账户" style="width: 200px"></el-input>
            </el-form-item>
            
          </div>
        </el-col>
      </el-row>

      <el-row>
        <el-col :span="12">
          <el-form-item v-if="this.usertype=='1'" label="所属部门" prop="depId" >
            <el-select v-model="dataForm.depId" filterable placeholder="请选择"  style="width: 200px">
              <el-option
                v-for="item in deptList"
                :key="item.depId"
                :label="item.name"
                :value="item.depId">
              </el-option>
            </el-select>
          </el-form-item>
        </el-col>
        <el-col :span="12">
          <el-form-item v-if="this.usertype=='1'" label="归属人" prop="name">
            <el-input v-model="dataForm.name" placeholder="归属人" style="width: 200px"></el-input>
          </el-form-item>
        </el-col>
      </el-row>

      <el-row>
        <el-col>
          <el-form-item v-if="this.usertype=='0'" label="归属人" prop="name">
            <el-input v-model="dataForm.name" placeholder="归属人" style="width: 200px"></el-input>
          </el-form-item>
        </el-col>
      </el-row>


      <el-form-item label="密码" prop="password" :class="{ 'is-required': !dataForm.id }">
        <el-input v-model="dataForm.password" type="password" placeholder="密码" style="width: 200px"></el-input>
      </el-form-item>
      <el-form-item label="确认密码" prop="comfirmPassword" :class="{ 'is-required': !dataForm.id }">
        <el-input v-model="dataForm.comfirmPassword" type="password" placeholder="确认密码" style="width: 200px"></el-input>
      </el-form-item>

      <el-form-item label="后台角色" size="mini" prop="roleId" :class="{ 'is-required': !dataForm.id }">
        <el-radio-group v-model="dataForm.roleId">
          <el-radio
            v-for="role in roleList"
            :key="role.roleId"
            :label="role.roleId"
          >{{ role.roleName }}</el-radio>
        </el-radio-group>
      </el-form-item>

      <el-form-item label="状态" size="mini" prop="status">
        <el-radio-group v-model="dataForm.status">
          <el-radio :label="0">禁用</el-radio>
          <el-radio :label="1">正常</el-radio>
        </el-radio-group>
      </el-form-item>
    </el-form>

    <div slot="footer" class="btn-footer">
      <el-button @click="goback()">取消</el-button>
      <el-button id="submit" type="primary" class="queding" @click="dataFormSubmit()" :disabled="btndisable">确定</el-button>
    </div>
  </el-dialog>

</template>

<script>
  import { isMobile } from "@/utils/validate";
  import { encrypt } from "@/utils/rsaCoder";
  import TableTreeColumn from "@/components/table-tree-column";
  import ProCityArea from "@/components/pro-city-area";

  export default {
    data() {
      var validatePassword = (rule, value, callback) => {
        if (!this.dataForm.id && !/\S/.test(value)) {
          callback(new Error("密码不能为空"));
        } else {
          callback();
        }
      };
      var validateComfirmPassword = (rule, value, callback) => {
        if (!this.dataForm.id && !/\S/.test(value)) {
          callback(new Error("确认密码不能为空"));

        } else if (this.dataForm.password !== value) {
          callback(new Error("确认密码与密码输入不一致"));
        } else {
          callback();
        }
      };
      var validateRole = (rule, value, callback) => {
        if (!this.dataForm.id && !/\S/.test(value)) {
          callback(new Error("角色不能为空"));
        } else {
          callback();
        }
      };
      var orgRole = (rule, value, callback) => {
        var urlOrgList = this.$http.adornUrl('/sys/user/getMainNum');
        this.$http.get(urlOrgList,{params:{orgId: this.dataForm.orgId,Id:this.dataForm.id}}).then((data)=>{
          if(data.data.num>0&&this.usertype!==1&&data.data.orgid!==this.dataForm.orgId){
            callback(new Error("账号已存在，请勿重复添加"));
          }else {
            callback();
          }
        })
      };
      var queryNo = (rule, value, callback) => {
        if(this.dataForm.id == ""){
            //查询用户名是否已存在
        this.$http({
            url: this.$http.adornUrl("/sys/user/getUserNoExist"),
            method: "get",
            params:this.$http.adornParams({
              userNo:this.dataForm.userNo
            })
          }).then(({ data }) => {
            if (data && data.code === 0) {
              if(data.isExist==true){
                  callback(new Error("该账号已存在"));
              }else{
                    callback();
              }
                  }
          });
        }else{
                    callback();
              }

      };
      return {
        /* provincevalue: "",
         cityvalue: "",
         districtvalue: "",*/
        url: this.$http.adornUrl(`/file/upload`),
        visible: false,
        usertype:'',
        roleList: [],
        deptList:[],
        orgList:[],
        org:"",
        userOrgId:'',
        userno:'',
        username:'',
        sgjId:'',
        dataForm: {
          id: 0,
          userName: "",
          password: "",
          orgId: "",
          userType: "",
          comfirmPassword: "",
          salt: "",
          userNo: "",
          roleIdList: [],
          administrativedivision: "",
          status: 1,
          deptList:[],
          depId:"",
          depName: "",
          name: "",
          typeCode:"",
          logo:"",
          roleId:""
        },
        btndisable:false,
        depReadonly:false,
        dataRule: {
          password: [
            { required: true, validator: validatePassword, trigger: "change" }
          ],
          comfirmPassword: [
            { required: true, validator: validateComfirmPassword, trigger: "change" }
          ],
          roleId: [
            { required: true, validator: validateRole, trigger: "change" }
          ],
          name: [
            { required: true, message: '归属人不能为空', trigger: "change" }
          ],
          depId: [
            { required: true, message: '所属部门不能为空', trigger: "change" }
          ],
          orgId: [
            { required: true, validator: orgRole, trigger: "change" }
          ],
          userNo: [
            { required: true, message: '该账号已存在',validator: queryNo, trigger: "blur" }
          ],
        }
      };
    },
      created(){
          this.getOrgList();
      },
    /*activated(){
       this.getOrgList();
    },*/
    methods: {
      init(id,orgId) {
        var urlUserType = this.$http.adornUrl('/sys/user/queryUserType');
        this.$http.post(urlUserType).then((data)=> {
          this.usertype = data.data.userType
          this.userno = data.data.userNo
          this.userOrgId = data.data.userOrgId
          this.sgjId = data.data.sgjId
          if (data.data.sgjId==data.data.userOrgId) {
            if(data.data.userType!=1){
              this.dataForm.userType = 1
            }else{
              this.dataForm.userType = 2;
            }
          }else{
            this.dataForm.userType = 2;
          }
          //如果新增子账号，默认当前单位
          if(""==orgId && data.data.userType==1){
                this.depReadonly=true
                this.dataForm.orgId=data.data.orgId;
                this.queryDept(data.data.orgId)
          }
        })
        this.dataForm.id = id;
        this.visible = true
        this.getOrgRoles(id,orgId)
            if (id) {
              this.$http({
                url: this.$http.adornUrl(`/sys/user/newinfo/${this.dataForm.id}`),
                method: "get",
                params: this.$http.adornParams()
              }).then(({ data }) => {
                if (data && data.code === 0) {
                  this.dataForm.orgId = data.user.orgId;
                  this.dataForm.userType = data.user.userType;
                  this.dataForm.salt = data.user.salt;
                  this.dataForm.userNo = data.user.userNo;
                  /* this.dataForm.roleIdList = data.user.roleIdList ? data.user.roleIdList : [];*/
                  this.dataForm.roleId = data.user.roleId;
                  this.dataForm.status = data.user.status;
                  this.dataForm.depId = data.user.depId;
                  this.dataForm.depName = data.user.depName;
                  if(data.user.userType==2){
                    this.depReadonly=true
                  };
                  this.dataForm.name = data.user.name;
                  this.dataForm.logo = data.user.logo
                }
                if (data.user.userType==1){
                  this.usertype=0
                }
                if (data.user.userType==2){
                  this.usertype=1
                }
                /*this.$nextTick(() => {
                  this.$refs.ProCityArea.init(data.user.orgId);
                });*/
                if(data.user.orgId){
                  this.queryDept(data.user.orgId)
                }
              });
            }
      },
      // 表单提交
      dataFormSubmit() {
        this.$refs["dataForm"].validate(valid => {
          if (valid) {
              this.btndisable = true
              //密码加密
              const n_pass = this.dataForm.password
                ? encrypt(this.dataForm.password)
                : null;
              const cn_pass = this.dataForm.comfirmPassword
                ? encrypt(this.dataForm.comfirmPassword)
                : null;


              let dept = ""
              if(this.dataForm.depId){
                dept = this.getDepInfo(this.dataForm.depId)
              }
              
              this.$http({
                url: this.$http.adornUrl(
                  `/sys/user/${!this.dataForm.id ? "save" : "update"}`
                ),
                method: "post",
                data: this.$http.adornData({
                  userId: this.dataForm.id || "",
                  userType: this.dataForm.userType,
                  password: n_pass,
                  comfirmPassword:cn_pass,
                  salt: this.dataForm.salt,
                  userNo: this.dataForm.userNo,
                  status: this.dataForm.status,
                  name:this.dataForm.name,
                  depId:dept.depId,
                  depName:dept.name,
                  roleId: this.dataForm.roleId,
                  logo:this.dataForm.logo,
                  userType:1
                })
              }).then(({ data }) => {
                if (data && data.code === 0) {
                  this.$message({
                    message: "操作成功",
                    type: "success",
                    duration: 500,
                    onClose: () => {
                      this.cleanSelect()
                      this.visible = false;
                      this.$emit("refreshCurrentOrgDepList");
                      this.btndisable = false
                    }
                  });
                } else {
                  this.$message.error(data.msg);
                  this.btndisable = false
                }
              });
          }
        });
      },
      cleanSelect(){
        this.deptList=null
        this.$refs['dataForm'].resetFields();
        this.dataForm.name=""
      },
      beforeAvatarUpload(file) {
        var imageType = /^image\/(jpeg|png|jpg)$/.test(file.type)
        if (!imageType) {
          this.$message.error('上传图片只能是‘jpg’‘jpeg’‘png’格式!')
          return
        }
        const isLt2M = file.size / 1024 / 1024 < 2;
        if (!isLt2M) {
          this.$message.error('上传头像图片大小不能超过 2MB!');
        }
        return imageType && isLt2M ;
      },
      handlSuccess(res, file, fileList) {
        console.log(res);
        if (res.code == 401) {
          this.$message.error("当前账号已在其他地方登陆或登录已失效,请重新登录!");
          this.$router.replace({ name: "login" });
          return;
        }
        if (res.code == "0") {
          this.dataForm.logo = res.url;
          this.dialogVisible = false;
          this.$message({
            type: "success",
            message: "上传成功！"
          });
        } else {
          this.$message({
            type: "error",
            message: res.msg
          });
        }
      },
      //获取组织机构列表
      getOrgList(){
        var urlOrgList = this.$http.adornUrl('/sys/org/getUserOrgAndSubordinate');
        this.$http.post(urlOrgList).then((data)=>{
          this.orgList = data.data.orgList;
          /*if(this.orgList.length=1){
             this.dataForm.orgId = this.orgList[0].id
           }*/
        })
      },
      //部门列表数据回显
      changeOrg(){
        this.dataForm.name=''
        this.dataForm.depId = ''
        //当前登录账号为省高级账号，选择本单位则账号状态为子账号，选择其他单位账号状态为账号
        if (this.sgjId==this.userOrgId){
          if(2!==this.userType){
            this.usertype=0
            this.dataForm.userType = 1
            }
         }
          else{
            this.usertype=1
            this.dataForm.userType = 2
            //如果子账号，要动态查询响应机构的权限
            this.getOrgRoles(this.dataForm.id,this.dataForm.orgId)
          }
        this.queryDept(this.dataForm.orgId);

      },
      //获取单位列表
      queryDept(orgid){
        this.$http({
          url:this.$http.adornUrl("/sys/sysdepartment/childList"),
          method:"post",
          params:this.$http.adornParams({
            orgid:orgid
          })
        }).then(({ data }) => {
          this.deptList = data.deptlist;
        });
      },
      //部门负责人数据回显
      changeDept(){
        this.dataForm.name = null
        this.queryName(this.dataForm.depId);
      },
      //获取部门负责人
      queryName(depid){
        this.$http({
          url:this.$http.adornUrl("/sys/sysdepartment/queryDeptPrincipal"),
          method:"post",
          params:this.$http.adornParams({
            depid:depid
          })
        }).then(({ data }) => {
          this.dataForm.name = data.principal;
        });
      },
      //获取单位选择框对象
      getDepInfo(id){
        let obj = {};
        obj = this.deptList.find((item)=>{
          return item.depId === id;
        });
        return obj;
      },
      //获取部门选择框对象
      getOrgInfo(id){
        let obj = {};
        obj = this.orgList.find((item)=>{
          return item.id === id;
        });
        return obj;
      },
      //取消
      goback(){
        this.cleanSelect()
        this.visible = false;
      },
      closeDialog(done){
        this.$confirm('确认关闭？')
          .then(_ => {
            done();
            this.cleanSelect()
            /*location.reload();*/
          })
          .catch(_ => { });
      },
      //获取用户单位对应的角色
      getOrgRoles(userId,orgId){
        this.$http({
          url: this.$http.adornUrl("/sys/role/getRolesByOrgId"),
          method: "get",
          params:this.$http.adornParams({
            orgId:orgId,
            userId:userId
          })
        }).then(({ data }) => {
          this.roleList = data && data.code === 0 ? data.roleList : [];
        });
      }
    }
  };
</script>
<style>
  /* 上传头像样式 */
  .avatar-uploader .el-upload {
    border: 1px dashed #d9d9d9;
    border-radius: 6px;
    cursor: pointer;
    position: relative;
    overflow: hidden;
  }

  .avatar-uploader .el-upload:hover {
    border-color: #409EFF;
  }

  .avatar-uploader-icon {
    font-size: 28px;
    color: #8c939d;
    width: 100px;
    height: 100px;
    line-height: 100px;
    text-align: center;
  }

  .avatar {
    width: 100px;
    height: 100px;
    display: block;
  }
  .btn-footer{
    text-align: center;
  }
</style>
