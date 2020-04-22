<template>
  <div class="mod-config">
    
    <el-table
      :data="dataList"
      border
      v-loading="dataListLoading" 
      style="width: 100%;">
       <el-table-column
        prop="name"
        header-align="center"
        align="center"
        label="公司名称">
      </el-table-column>
      <el-table-column
         
        header-align="center"
        align="center"
       	v-for="item in dataColumns"
       	:key="item.index"
        width="100" 
        :label="item.name">
           <template slot-scope="scope">
           	   {{scope.row.data[item.index].value}}
           </template>
      
      </el-table-column>  
       
      <el-table-column
        fixed="right"
        header-align="center"
        align="center"
        width="150"
        label="操作">
        <template slot-scope="scope">
          <el-button type="text" size="small" @click="addOrUpdateHandle(scope.row.id)">修改</el-button>
          <el-button type="text" size="small" @click="deleteHandle(scope.row.id)">删除</el-button>
        </template>
      </el-table-column>
    </el-table>
   
  </div>
</template>

<script> 
  export default {
    data () {
      return {
        
        dataList: [],
        dataColumns: [],
        dataListLoading: false, 
      }
    },
   
    activated () {
      
     
      this.getDataList()



    },
    methods: {
      
      // 获取数据列表
      getDataList () {
        this.dataListLoading = true


        let datas = '[{"name":"公司3","data":[{"day" : "2019-10-01", "value" : 9}, {"day" : "2019-10-02", "value" : 10}, {"day" : "2019-10-03", "value" : 6}, {"day" : "2019-10-04", "value" : 6}, {"day" : "2019-10-05", "value" : 3}, {"day" : "2019-10-06", "value" : 4}, {"day" : "2019-10-07", "value" : 5}, {"day" : "2019-10-08", "value" : 3}, {"day" : "2019-10-09", "value" : 6}, {"day" : "2019-10-10", "value" : 6}]}, {"name":"公司10","data":[{"day" : "2019-10-01", "value" : 9}, {"day" : "2019-10-02", "value" : 9}, {"day" : "2019-10-03", "value" : 10}, {"day" : "2019-10-04", "value" : 0}, {"day" : "2019-10-05", "value" : 2}, {"day" : "2019-10-06", "value" : 5}, {"day" : "2019-10-07", "value" : 4}, {"day" : "2019-10-08", "value" : 2}, {"day" : "2019-10-09", "value" : 6}, {"day" : "2019-10-10", "value" : 5}]}, {"name":"公司8","data":[{"day" : "2019-10-01", "value" : 1}, {"day" : "2019-10-02", "value" : 8}, {"day" : "2019-10-03", "value" : 0}, {"day" : "2019-10-04", "value" : 7}, {"day" : "2019-10-05", "value" : 7}, {"day" : "2019-10-06", "value" : 1}, {"day" : "2019-10-07", "value" : 8}, {"day" : "2019-10-08", "value" : 5}, {"day" : "2019-10-09", "value" : 3}, {"day" : "2019-10-10", "value" : 4}]}, {"name":"公司4","data":[{"day" : "2019-10-01", "value" : 0}, {"day" : "2019-10-02", "value" : 0}, {"day" : "2019-10-03", "value" : 2}, {"day" : "2019-10-04", "value" : 9}, {"day" : "2019-10-05", "value" : 4}, {"day" : "2019-10-06", "value" : 1}, {"day" : "2019-10-07", "value" : 3}, {"day" : "2019-10-08", "value" : 2}, {"day" : "2019-10-09", "value" : 7}, {"day" : "2019-10-10", "value" : 7}]}, {"name":"公司9","data":[{"day" : "2019-10-01", "value" : 7}, {"day" : "2019-10-02", "value" : 4}, {"day" : "2019-10-03", "value" : 9}, {"day" : "2019-10-04", "value" : 5}, {"day" : "2019-10-05", "value" : 0}, {"day" : "2019-10-06", "value" : 4}, {"day" : "2019-10-07", "value" : 8}, {"day" : "2019-10-08", "value" : 7}, {"day" : "2019-10-09", "value" : 9}, {"day" : "2019-10-10", "value" : 3}]}, {"name":"公司1","data":[{"day" : "2019-10-01", "value" : 1}, {"day" : "2019-10-02", "value" : 2}, {"day" : "2019-10-03", "value" : 4}, {"day" : "2019-10-04", "value" : 4}, {"day" : "2019-10-05", "value" : 6}, {"day" : "2019-10-06", "value" : 9}, {"day" : "2019-10-07", "value" : 4}, {"day" : "2019-10-08", "value" : 10}, {"day" : "2019-10-09", "value" : 4}, {"day" : "2019-10-10", "value" : 8}]}, {"name":"公司2","data":[{"day" : "2019-10-01", "value" : 4}, {"day" : "2019-10-02", "value" : 0}, {"day" : "2019-10-03", "value" : 0}, {"day" : "2019-10-04", "value" : 9}, {"day" : "2019-10-05", "value" : 4}, {"day" : "2019-10-06", "value" : 1}, {"day" : "2019-10-07", "value" : 2}, {"day" : "2019-10-08", "value" : 10}, {"day" : "2019-10-09", "value" : 1}, {"day" : "2019-10-10", "value" : 3}]}, {"name":"公司7","data":[{"day" : "2019-10-01", "value" : 5}, {"day" : "2019-10-02", "value" : 5}, {"day" : "2019-10-03", "value" : 9}, {"day" : "2019-10-04", "value" : 6}, {"day" : "2019-10-05", "value" : 8}, {"day" : "2019-10-06", "value" : 2}, {"day" : "2019-10-07", "value" : 3}, {"day" : "2019-10-08", "value" : 5}, {"day" : "2019-10-09", "value" : 4}, {"day" : "2019-10-10", "value" : 10}]}, {"name":"公司6","data":[{"day" : "2019-10-01", "value" : 6}, {"day" : "2019-10-02", "value" : 4}, {"day" : "2019-10-03", "value" : 5}, {"day" : "2019-10-04", "value" : 0}, {"day" : "2019-10-05", "value" : 10}, {"day" : "2019-10-06", "value" : 8}, {"day" : "2019-10-07", "value" : 6}, {"day" : "2019-10-08", "value" : 5}, {"day" : "2019-10-09", "value" : 3}, {"day" : "2019-10-10", "value" : 6}]}, {"name":"公司5","data":[{"day" : "2019-10-01", "value" : 7}, {"day" : "2019-10-02", "value" : 7}, {"day" : "2019-10-03", "value" : 6}, {"day" : "2019-10-04", "value" : 8}, {"day" : "2019-10-05", "value" : 9}, {"day" : "2019-10-06", "value" : 6}, {"day" : "2019-10-07", "value" : 9}, {"day" : "2019-10-08", "value" : 1}, {"day" : "2019-10-09", "value" : 1}, {"day" : "2019-10-10", "value" : 8}]}]';

        
        	const jsonData = JSON.parse(datas);
        	

        	// 获取第一条数据拿到所有key
        	if(jsonData && jsonData.length > 0) {

        		let columns = []
        		const firstData = jsonData[0].data;
        		// 循环所有日期
        		for(let i in firstData){
        			columns.push({index:i , name: firstData[i].day  })
        		}

        		this.dataColumns = columns;
        		this.dataList = jsonData
        	}

          this.dataListLoading = false
       
      },
      
    }
  }
</script>
