const state = {
  id: ''
}

const getters = {
}

const mutations = {
  SET_ID (state, id) {
    state.id = id
  }
}

const actions = {
  updateId ({ commit }, memberId) {
    commit('SET_ID', memberId)
  }
}

export default {
  namespaced: true,
  state,
  getters,
  mutations,
  actions
}
