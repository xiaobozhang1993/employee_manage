<template>
    <div :style="{'height':asideHeight+'px'}">
        <div class="mod-config" :style="{'overflow-y':'scroll','height':asideHeight-30-48+'px'}">
            <el-form :model="dataForm" :rules="dataRule" ref="dataForm" @keyup.enter.native="dataFormSubmit()"
                     label-width="100px">
                <el-form-item label="类型" prop="type">
                    <el-radio-group v-model="dataForm.type">
                        <el-radio v-for="(type, index) in dataForm.typeList" :label="index" :key="index">{{ type }}
                        </el-radio>
                    </el-radio-group>
                </el-form-item>
                <el-form-item :label="dataForm.typeList[dataForm.type] + '名称'" prop="name">
                    <el-input v-model="dataForm.name" :placeholder="dataForm.typeList[dataForm.type] + '名称'"></el-input>
                </el-form-item>
                <el-form-item label="上级菜单" prop="parentName">
                    <el-popover
                            ref="menuListPopover"
                            placement="bottom-start"
                            trigger="click">
                        <el-tree
                                :data="menuList"
                                :props="menuListTreeProps"
                                node-key="menuId"
                                ref="menuListTree"
                                @current-change="menuListTreeCurrentChangeHandle"
                                :default-expand-all="false"
                                :highlight-current="true"
                                :expand-on-click-node="false">
                        </el-tree>
                    </el-popover>
                    <el-input v-model="dataForm.parentName" v-popover:menuListPopover :readonly="true"
                              placeholder="点击选择上级菜单" class="menu-list__input"></el-input>
                </el-form-item>
                <el-form-item v-if="dataForm.type === 1" label="路由名称" prop="routeName">
                    <el-input v-model="dataForm.routeName" placeholder="路由名称"></el-input>
                </el-form-item>
                <el-form-item v-if="dataForm.type === 1" label="文件地址" prop="componentUrl">
                    <el-input v-model="dataForm.componentUrl" placeholder="文件地址,相对于modules路径开始"></el-input>
                </el-form-item>
                <el-form-item v-if="dataForm.type === 1" label="菜单路径" prop="url">
                    <el-input v-model="dataForm.url" placeholder="菜单路径"></el-input>
                </el-form-item>
                <el-form-item v-if="dataForm.type === 1" label="是否单路由">
                    <el-switch
                            v-model="dataForm.routeOnly"
                            :active-value="2"
                            :inactive-value="1"
                            active-text="是"
                            inactive-text="否">
                    </el-switch>
                </el-form-item>
                <el-form-item v-if="dataForm.type !== 0" label="授权标识" prop="perms">
                    <el-input v-model="dataForm.perms" placeholder="多个用逗号分隔, 如: user:list,user:create"></el-input>
                </el-form-item>
                <el-form-item v-if="dataForm.type !== 2" label="排序号" prop="orderNum">
                    <el-input-number v-model="dataForm.orderNum" controls-position="right" :min="0"
                                     label="排序号"></el-input-number>
                </el-form-item>

                <el-form-item v-if="dataForm.type === 1" label="是否启用">
                    <el-switch
                            v-model="dataForm.enabled"
                            :active-value="1"
                            :inactive-value="0"
                            active-text="启用"
                            inactive-text="禁用">
                    </el-switch>
                </el-form-item>
                <el-form-item v-if="dataForm.type < 2" label="菜单图标" prop="icon">
                    <el-row>
                        <el-col :span="22">
                            <el-popover
                                    ref="iconListPopover"
                                    placement="bottom-start"
                                    trigger="click"
                                    popper-class="mod-menu__icon-popover">
                                <div class="mod-menu__icon-list">
                                    <el-button
                                            v-for="(item, index) in iconList"
                                            :key="index"
                                            @click="iconActiveHandle(item)"
                                            :class="{ 'is-active': item === dataForm.icon }">
                                        <icon-svg :name="item"></icon-svg>
                                    </el-button>
                                </div>
                            </el-popover>
                            <el-input v-model="dataForm.icon" v-popover:iconListPopover placeholder="菜单图标名称"
                                      class="icon-list__input"></el-input>
                        </el-col>
                        <el-col :span="2" class="icon-list__tips">
                            <el-tooltip placement="top" effect="light">
                                <div slot="content">全站推荐使用SVG Sprite, 详细请参考:<a
                                        href="//github.com/daxiongYang/renren-fast-vue/blob/master/src/icons/index.js"
                                        target="_blank">icons/index.js</a>描述
                                </div>
                                <i class="el-icon-warning"></i>
                            </el-tooltip>
                        </el-col>
                    </el-row>
                </el-form-item>
            </el-form>
            <div class="opt-footer">
                <el-button @click="back()">取消</el-button>
                <el-button type="primary" :disabled="loading" @click="dataFormSubmit()">确定</el-button>
            </div>
        </div>
    </div>
</template>

<script>
    import {treeDataTranslate} from '@/utils'
    import Icon from '@/icons'

    export default {
        data() {
            var validateUrl = (rule, value, callback) => {
                if (this.dataForm.type === 1 && !/\S/.test(value)) {
                    callback(new Error('菜单URL不能为空'))
                } else {
                    callback()
                }
            }
            var validateRouteName = (rule, value, callback) => {
                if (this.dataForm.type === 1 && !/\S/.test(value)) {
                    callback(new Error('路由名称不能为空'))
                } else {
                    callback()
                }
            }
            var validateComponentUrl = (rule, value, callback) => {
                if (this.dataForm.type === 1 && !/\S/.test(value)) {
                    callback(new Error('文件地址不能为空'))
                } else {
                    callback()
                }
            }
            return {
                loading: false,
                dataForm: {
                    id: 0,
                    type: 1,
                    typeList: ['目录', '菜单', '按钮'],
                    name: '',
                    parentId: 0,
                    parentName: '',
                    url: '',
                    perms: '',
                    orderNum: 0,
                    icon: '',
                    enabled: 1,
                    routeName: '',
                    componentUrl: '',
                    locationType: 1,
                    routeOnly: 1,
                    iconList: []
                },
                dataRule: {
                    name: [
                        {required: true, message: '菜单名称不能为空', trigger: 'blur'}
                    ],
                    parentName: [
                        {required: true, message: '上级菜单不能为空', trigger: 'change'}
                    ],
                    url: [
                        {validator: validateUrl, trigger: 'blur'}
                    ],
                    componentUrl: [
                        {validator: validateComponentUrl, trigger: 'blur'}
                    ],
                    routeName: [
                        {validator: validateRouteName, trigger: 'blur'}
                    ]
                },
                menuList: [],
                menuListTreeProps: {
                    label: 'name',
                    children: 'children'
                }
            }
        },
        computed: {
            //计算内部元素的高度
            asideHeight: function () {
                return document.documentElement['clientHeight'] - 31 - 97 - 20 - 30
            }
        },
        activated() {
            const id = this.$route.query.id
            this.dataForm.locationType = this.$route.query.locationType
            this.init(id)
            this.loading = false
        },
        created() {
            this.iconList = Icon.getNameList()
        },
        methods: {
            init(id) {
                this.dataForm.id = id
                this.$http({
                    url: this.$http.adornUrl('/sys/menu/select'),
                    method: 'get',
                    params: this.$http.adornParams()
                }).then(({data}) => {
                    // 判断当前是菜单还是工具栏
                    if (this.dataForm.locationType == 1) {
                        this.menuList = treeDataTranslate(data.menuList, 'menuId')
                    } else {
                        this.menuList = treeDataTranslate(data.toolList, 'menuId')
                    }


                }).then(() => {
                    this.visible = true
                    this.$nextTick(() => {
                        this.$refs['dataForm'].resetFields()
                    })
                }).then(() => {
                    if (!this.dataForm.id) {
                        // 新增
                        this.menuListTreeSetCurrentNode()
                    } else {
                        // 修改
                        this.$http({
                            url: this.$http.adornUrl(`/sys/menu/info/${this.dataForm.id}`),
                            method: 'get',
                            params: this.$http.adornParams()
                        }).then(({data}) => {
                            this.dataForm.id = data.menu.menuId
                            this.dataForm.type = data.menu.type
                            this.dataForm.name = data.menu.name
                            this.dataForm.parentId = data.menu.parentId
                            this.dataForm.url = data.menu.url
                            this.dataForm.perms = data.menu.perms
                            this.dataForm.orderNum = data.menu.orderNum
                            this.dataForm.icon = data.menu.icon
                            this.dataForm.enabled = data.menu.enabled
                            this.dataForm.componentUrl = data.menu.componentUrl
                            this.dataForm.routeName = data.menu.routeName

                            this.dataForm.locationType = data.menu.locationType

                            this.menuListTreeSetCurrentNode()
                        })
                    }
                })
            },
            // 菜单树选中
            menuListTreeCurrentChangeHandle(data, node) {
                this.dataForm.parentId = data.menuId
                this.dataForm.parentName = data.name
            },
            // 菜单树设置当前选中节点
            menuListTreeSetCurrentNode() {
                this.$refs.menuListTree.setCurrentKey(this.dataForm.parentId)
                this.dataForm.parentName = (this.$refs.menuListTree.getCurrentNode() || {})['name']
            },
            // 图标选中
            iconActiveHandle(iconName) {
                this.dataForm.icon = iconName
            },
            // 表单提交
            dataFormSubmit() {
                this.$refs['dataForm'].validate((valid) => {
                    if (valid) {
                        this.loading = true;
                        this.$http({
                            url: this.$http.adornUrl(`/sys/menu/${!this.dataForm.id ? 'save' : 'update'}`),
                            method: 'post',
                            data: this.$http.adornData({
                                'menuId': this.dataForm.id || undefined,
                                'type': this.dataForm.type,
                                'name': this.dataForm.name,
                                'parentId': this.dataForm.parentId,
                                'url': this.dataForm.url,
                                'perms': this.dataForm.perms,
                                'enabled': this.dataForm.enabled,
                                'orderNum': this.dataForm.orderNum,
                                'routeName': this.dataForm.routeName,
                                'componentUrl': this.dataForm.componentUrl,
                                'icon': this.dataForm.icon,
                                'locationType': this.dataForm.locationType,
                                'routeOnly': this.dataForm.routeOnly
                            })
                        }).then(({data}) => {
                            if (data && data.code === 0) {
                                this.$message({
                                    message: '操作成功',
                                    type: 'success',
                                    duration: 500,
                                    onClose: () => {
                                        this.loading = false
                                        this.back()
                                    }
                                })
                            } else {
                                this.$message.error(data.msg)
                            }
                        })
                    }
                })
            }
        }
    }
</script>

<style lang="scss">
    .mod-menu {

    .menu-list__input,
    .icon-list__input {

    > .el-input__inner {
        cursor: pointer;
    }

    }
    &
    __icon-popover {
        max-width: 370px;
    }

    &
    __icon-list {
        max-height: 180px;
        padding: 0;
        margin: -8px 0 0 -8px;

    > .el-button {
        padding: 8px;
        margin: 8px 0 0 8px;

    > span {
        display: inline-block;
        vertical-align: middle;
        width: 18px;
        height: 18px;
        font-size: 18px;
    }

    }
    }
    .icon-list__tips {
        font-size: 18px;
        text-align: center;
        color: #e6a23c;
        cursor: pointer;
    }

    }
</style>
