import { getTeam } from 'api/users/teams.js'

const state = {
  openTime: '',
  closeTime: ''
}

const getters = {
  openTime: ({ openTime }) => openTime,
  closeTime: ({ closeTime }) => closeTime
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
  state,
  getters,
  mutations,
  actions
}
