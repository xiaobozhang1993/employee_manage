<template>
<div>
  <el-dialog
    title=""
    :visible.sync="dialogVisible"
    width="70%">
    <el-row style="margin-bottom: 10px">
      <el-row>
        <el-col :span="2">
          <el-upload
            :multiple="false"
            class="upload-demo"
            action
            :before-upload="beforeUpload"
            :on-preview="handlePreview"
            :on-remove="handleRemove"
            :auto-upload="true"
            :show-file-list="false">
            <el-button size="small" icon="el-icon-upload" title="建议上传2寸照片">上传</el-button>
          </el-upload>
        </el-col>
        <el-col :span="6">
          <el-button style="margin-left: 10px;" size="small" icon="el-icon-finished" @click="submitUpload">使用</el-button>
        </el-col>
      </el-row>

    </el-row>
    <el-row>
      <el-col :span="8">
        <div>
          <vueCropper style="width:3.5cm;height:5.3cm"
                      ref="cropper"
                      :img="option.img"
                      :outputSize="option.size"
                      :outputType="option.outputType"
                      :info="true"
                      :full="option.full"
                      :canMove="option.canMove"
                      :canMoveBox="option.canMoveBox"
                      :original="option.original"
                      :autoCrop="option.autoCrop"
                      :autoCropWidth="option.autoCropWidth"
                      :autoCropHeight="option.autoCropHeight"
                      :fixedBox="option.fixedBox"
                      @realTime="realTime"
                      @imgLoad="imgLoad"
          ></vueCropper>
        </div>
      </el-col>
       
    </el-row>
  </el-dialog>
</div>
</template>
<script>
  import {VueCropper} from "vue-cropper"
  export default {
    data() {
      return {
        dialogVisible: false,
        dataForm: {
          photoPath: '',
          fileId: '',
        },
        previews: {},
        option: {
          img: '',
          size: 1,
          full: false,
          outputType: 'png',
          canMove: true,
          original: false,
          canMoveBox: true,
          autoCrop: false,
          autoCropWidth:132,
          autoCropHeight:200,
          maxImgSize:['3.5cm','5.3cm'],
          fixedBox: false,
          mode:'contain'
        },
      }
    },
    components: {
      VueCropper    },
    created() {

    },
    methods: {
      init() {
        this.dataForm.photoPath = ''
        this.option.img = ''
        this.dialogVisible = true
      },
      scanning(){
        this.$nextTick(() => {
          this.$refs.scanning.init()
        })
      },
      photographs(){
        this.$nextTick(() => {
          this.$refs.photographs.init()
        })
      },
      submitUpload(file) {
        this.finish("blob");
      },
      handleRemove(file, fileList) {
      },
      handlePreview(file) {
      },
      beforeUpload(file) {
        var imageType = /^image\/(jpeg|png|jpg)$/.test(file.type)
        if (!imageType) {
          this.$message.error('上传图片只能是‘jpg’‘jpeg’‘png’格式!')
          return
        }
        const isLt2M = file.size / 1024 / 1024 < 2;
        if (!isLt2M) {
          this.$message.error('上传头像图片大小不能超过 2MB!');
        }
        let data = window.URL.createObjectURL(new Blob([file]));
        this.fileName = file.name;
        this.option.img = data;
        return imageType && isLt2M;
      },

      //上传图片（点击上传按钮）
      finish(type) {
        let _this = this;
        let formData = new FormData();
        // 输出
        if (type === "blob") {
          this.$refs.cropper.getCropBlob(data => {
            let img = window.URL.createObjectURL(data);
            this.model = true;
            this.modelSrc = img;
            if(!this.fileName){
                 this.fileName='123.jpg'
            }
            formData.append("file", data, this.fileName);
            this.$http
              .post(this.$http.adornUrl(`/file/upload`), formData, {
                withCredentials: true
              })
              .then(res => {
                console.log(res)
                if (res.data.code == '0') {
                  this.dataForm.photoPath = res.data.url;
                  this.dialogVisible = false;
                  this.$message({
                    type: "success",
                    message: "上传成功！"
                  });
                  this.$emit('getPhoto', this.dataForm)//将值绑定到queryData上传递过去
                } else {
                  this.$message({
                    type: "error",
                    message: res.msg
                  });
                }
              });
          });
        } else {
          alert(1)
          this.$refs.cropper.getCropData(data => {
            this.model = true;
            this.modelSrc = data;
          });
        }
      },
      // 实时预览函数
      realTime(data) {
        console.log("realTime");
        this.previews = data;
      },
      imgLoad(msg) {
        console.log("imgLoad");
        console.log(msg);
      },
      scanningRes(data){
         this.option.img = data;
      },
      //自动裁剪
      showCut(){
        this.option.autoCrop=true
      }
    },
  }
</script>

<style>
  .upload-demo {
    align: center
  }
  .el-dialog__body {
    padding: 10px 20px;
    color: #606266;
    font-size: 14px;
    word-break: break-all;
}
</style>
