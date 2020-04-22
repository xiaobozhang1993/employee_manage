<template>
    <div class="main-info" :style="{'height':asideHeight+'px'}">
    </div>
</template>
<script>
    export default {}
        
</script>
<style scoped>
    .new_icon {
        border-radius: 50%;
        background-image: linear-gradient(-124deg, rgb(141, 215, 243) 0%, rgb(61, 150, 216) 100%);
        background-image: -moz-linear-gradient(-124deg, rgb(141, 215, 243) 0%, rgb(61, 150, 216) 100%);
        background-image: -webkit-linear-gradient(-124deg, rgb(141, 215, 243) 0%, rgb(61, 150, 216) 100%);
        background-image: -ms-linear-gradient(-124deg, rgb(38, 76, 90) 0%, rgb(61, 150, 216) 100%);

    }

    .el-divider--horizontal {
        margin: 0px 0;
    }

    .el-divider-fxxm {
        margin: 6px 0;
    }

    .el-tree-node__content:hover {
        background-color: #ffffff !important;
    }

    .el-form-item--mini.el-form-item {
        margin-bottom: 0px;
    }

    .h3_height {
        height: 36px;
    }

    .h3_height_title {
        height: 36px;
        line-height: 36px;
        padding-left: 15px;
        background-color: #FAFAFA;
        border-bottom: 1px solid #cfcfcf;
        cursor: move;
    }
</style>
<style>
    .main-info {
        height: 100%;
        background: url(../../assets/img/welcome.jpg) no-repeat;
        background-size: 100%;
    }

   
</style>



