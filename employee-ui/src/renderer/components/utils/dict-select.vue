<template>
	<!--
	sample :  <sysDictSelect :form="form" field="sex" dictType="sex" />
	 其中form 必须为外部页面传递过来,
	 field是当前需要将选择的数据绑定到form中哪个字段
	 	dictType为数据字典中的类型

	-->

<el-tooltip class="item" effect="light" :content="dictForm.title" placement="top-start" :disabled="!dictForm.title">
	<el-select v-if="type == 'select'" v-model="dictForm.value" placeholder="请选择"  @change="changeSelect" clearable :disabled="disabled">
    <el-option
      v-for="item in dicts"
      :key="item.value"
      :label="item.dictName"
      :value="item.value">
    </el-option>
  </el-select>
  <el-radio-group v-else v-model="dictForm.value" placeholder="请选择"  @change="changeSelect" clearable :disabled="disabled">
   <!--  <el-radio :label="3">备选项</el-radio>
    <el-radio :label="6">备选项</el-radio>
    <el-radio :label="9">备选项</el-radio> -->
     <el-radio
      v-for="item in dicts"
      :key="item.value"
      :label="item.value" >
      {{item.dictName}}
    </el-radio>
  </el-radio-group>
</el-tooltip>
</template>
<script>
export default {
	name:'dict-select',
	data() {
		return {
			dicts: [] ,
			dictForm:{
				value: '',
				title: '' // 当前选中的title
      		}
		}
	},
  props: {
    form:null,
    field:null,
    dictType:null,
    disabled:{
      type: Boolean,
      default: false
    },
    type:{
      default: 'select'
    }
  },
	computed: {
	    getFieldValue: function() {
	    	return this.form[this.field]
	    }
	},
	watch: {
    getFieldValue: {//深度监听，可监听到对象、数组的变化
      handler (val, oldVal) {
        //console.log('watch val' , val)
        if(!val || val == ''  ) {
            this.dictForm.value = null;
            this.dictForm.title = null;
        }else {
            this.putSelect()
        }

      },
      deep: true
    }

  	},
    created(){
        if(this.dictType) {
            this.initData()
        }
    },
    activated(){
		// 根据类型查询数据
		// console.log('select' , this.form , this.field , this.dictType)
		if(this.dictType) {
			this.initData()
		}
	},
	methods:{
		initData() {
			this.$http({
	            url: this.$http.adornUrl(`/sys/sysdict/findByType`),
	            method: 'get',
	            params: this.$http.adornParams({
	            	'type': this.dictType
	            })
	          }).then(({data}) => {
	            if (data.code === 0) {
	               this.dicts = data.data
	               // 判断当前是否有值 有值回填
	               const select = this.form[this.field]
	               //console.log('select' ,this.dictType , select)
	               if(select) {
	               	for(var i in this.dicts) {
	               		// console.log(this.dicts , select , this.dicts[i].value == select)
	               		if(this.dicts[i].value == select) {
	               			this.dictForm.value = this.dicts[i].value ;
	               			this.dictForm.title = this.dicts[i].dictName ;
	               			return ;
	               		}

	               	}
	               	//console.log('#############')
	               	// 到这里了说明没选上,用当前值
	               	this.dictForm.value = select;
	               	this.dictForm.title = select;

	               }

	            }

	        })
		},
		// 选择回填
		putSelect() {

			if(!this.dicts || this.dicts.length == 0) {
				this.initData()
			} else {
				 // 判断当前是否有值 有值回填
	               const select = this.form[this.field]
	              // console.log('select' , select)
	               if(select) {
		               	for(var i in this.dicts) {
		               		if(this.dicts[i].value == select) {
		               			this.dictForm.value = this.dicts[i].value ;
		               			this.dictForm.title = this.dicts[i].dictName;
		               			return ;
		               		}
		               	}

		               	// 到这里了说明没选上,用当前值
	               		this.dictForm.value = select + '' ;
	               		this.dictForm.title = select + '' ;
	            	}

			}

		},
		// 选择回调
		changeSelect(value) {
			// console.log('select' , value)
			this.form[this.field] = value ;
			this.$emit('change' , value)

    },
  },
}

</script>
<style>

</style>
