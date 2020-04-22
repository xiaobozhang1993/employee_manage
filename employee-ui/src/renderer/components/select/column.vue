<template>
<div>
  <span>{{this.name}}</span>
  </div>
</template>
<script>
export default {
  props: {
    val: {
      type: Number,
      default: 0
    },
    type: {
      type: String,
      default: ''
    },
  },
  data () {
      return {
        name: '',

      }
    },
  mounted () {
      this.getSelect()
    },
  methods: {
      // 获取数据列表
      getSelect () {
        this.$http({
          url: this.$http.adornUrl(`/sys/sysdict/findByTypeValue?type=` + this.type + '&value=' + this.val),
          method: 'get',
          params: this.$http.adornParams()
        }).then(({data}) => {
          if (data.code === 0) {
           this.name =  data.data.dictName
          }
        })
      }
    }
}
</script>
