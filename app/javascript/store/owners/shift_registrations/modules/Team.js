import { getTeam } from 'api/owners/teams.js'

const state = {
  openTime: '',
  closeTime: ''
}

const getters = {
}

const mutations = {
  SET_OPEN_TIME (state, openTime) {
    state.openTime = openTime
  },
  SET_CLOSE_TIME (state, closeTime) {
    state.closeTime = closeTime
  }
}

const actions = {
  loadTeam ({ commit }, teamId) {
    getTeam(teamId).then((res) => {
      commit('SET_OPEN_TIME', res.open_time)
      commit('SET_CLOSE_TIME', res.close_time)
    })
  }
}

export default {
  namespaced: true,
  state,
  getters,
  mutations,
  actions
}
