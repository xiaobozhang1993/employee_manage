export default {
  namespaced: true,
  state: {
    userId: null,
    name: '',
    orgId:'',
    headImage:'',
    titles:'',

  },
  mutations: {
    updateId (state, id) {
      state.userId = id
    },
    updateName (state, name) {
      state.name = name
    },
    updateOrgId(state,orgId){
      state.orgId = orgId
    },
    updateHeadImage(state,headImage){
      state.headImage = headImage
    },
    updateTitles(state,titles){
      state.titles = titles
    }
  }
}
