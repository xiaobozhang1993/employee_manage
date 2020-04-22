<template>
	<span>
    {{dictNames.join(",")}}
	</span>
</template>
<script>
  import {getDictName, putDict} from '@/utils/dict'

  export default {
    name: 'altDict',
    data () {
      return {
        dictName: '',
        dictNames: [],
      }
    },
    watch: {
      value: {//深度监听，可监听到对象、数组的变化
        handler (val, oldVal) {
          if (val != null && val != '' && val != undefined
            && val != 'undefined') {
            this.init(val)
          }

        },
        deep: true
      }
    },
    props: ['type', 'value'],
    created () {
      // 计算数据字典的名称
      this.init(this.value)
    },
    methods: {
      init (val) {
        if(val) {
          this.dictNames = [];
          if(typeof val=='number'){
            var vals = [val+""]
          }else{
            var vals = val.split(',')
          }
          for (var i in vals) {
            this.initData(vals[i])
          }
        } else {
          this.dictNames = []
        }

      },
      initData (val) {
        this.dictName = getDictName(this.type, val)
        //console.log('altDict name' , this.dictName)
        //还是空的话 ajax
        if ((this.dictName == null || this.dictName == '')
          && val != null && val != '' && val != undefined
          && val != 'undefined') {
          this.$http({
            url: this.$http.adornUrl(`/sys/sysdict/findByTypeValue?type=` + this.type + '&value=' + val),
            method: 'get',
            params: this.$http.adornParams()
          }).then(({data}) => {
            if (data.code === 0) {
              const dict = data.data
              if (dict != null) {
                this.dictName = dict.dictName
                this.dictNames.push(dict.dictName)
                // 回填此条数据
                putDict(this.type, dict.dictName, this.value)

              }

            }

          })
        } else {
          this.dictNames.push(this.dictName)
        }
      }
    }
  }
</script>
