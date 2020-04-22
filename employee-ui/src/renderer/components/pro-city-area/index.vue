<template>
  <div>
    <el-form label-width="150px" :model="dataForm">
      <el-select clearable v-model="dataForm.pro" placeholder="请选择份" style="width:30%" @change="changePro()">
        <el-option v-for="item in proList" :key="item.id" :label="item.name" :value="item.id"></el-option>
      </el-select>
      <el-select clearable
        v-model="dataForm.city"
        placeholder="请选择市"
        style="width:30%"
        @change="changeCity()"
      >
        <el-option v-for="item in cityList" :key="item.id" :label="item.name" :value="item.id"></el-option>
      </el-select>
      <el-select clearable v-model="dataForm.district" placeholder="请选择区(县)" style="width:30%">
        <el-option v-for="item in districtList" :key="item.id" :label="item.name" :value="item.id"></el-option>
      </el-select>
    </el-form>
  </div>
</template>
<script>
export default {
  name: "pro-city-area",
  data() {
    return {
      dataForm: {
        pro: "",
        city: "",
        district: ""
      },

      proList: [],
      cityList: [],
      districtList: []
    };
  },
  activated() {},
  methods: {
    // 设置回显
    init(proCityArea) {
      this.dataForm.pro = "";
      this.dataForm.city = "";
      this.dataForm.district = "";
      this.getProList(0, 0);
      if (proCityArea) {
        var strs = new Array(); //定义一数组
        strs = proCityArea.split(","); //字符分割
        if (strs.length == 1) {
          this.dataForm.pro = strs[0];
          this.changePro();
        } else if (strs.length == 2) {
          this.dataForm.pro = strs[0];
          this.dataForm.city = strs[1];
          this.changePro();
          this.changeCity();
        } else if (strs.length == 3) {
          this.dataForm.pro = strs[0];
          this.dataForm.city = strs[1];
          this.dataForm.district = strs[2];
          this.changePro();
          this.changeCity();
        }
      }
    },
    //获得下级组织架构的集合
    getProList(parentId, type) {
      this.$http({
        url: this.$http.adornUrl("/sys/org/childList"),
        method: "post",
        data: this.$http.adornData({
          parentId: parentId
        })
      }).then(({ data }) => {
        if (data && data.code === 0) {
          console.log(data);
          if (type == 0) {
            this.proList = data.list;
          } else if (type == 1) {
            this.cityList = data.list;
          } else if (type == 2) {
            this.districtList = data.list;
          }
        }
      });
    },

    //根据份id作为pid查询市
    changePro() {
      this.getProList(this.dataForm.pro, 1);
    },

    //根据市Id作为pid查询区县
    changeCity() {
      this.getProList(this.dataForm.city, 2);
    }
  },
  watch: {
    dataForm: {
      deep: true,
      handler: function(newVal, oldVal) {
        this.$emit("watchData", this.dataForm);
      }
    }
  }
};
</script>
