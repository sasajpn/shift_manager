const state = {
  startTime: '',
  endTime: '',
  errorMessages: []
}

const getters = {
  startTime: ({ startTime }) => startTime,
  endTime: ({ endTime }) => endTime,
  errorMessages: ({ errorMessages }) => errorMessages
}

const mutations = {
  SET_START_TIME (state, time) {
    state.startTime = time
  },
  SET_END_TIME (state, time) {
    state.endTime = time
  },
  SET_ERROR_MESSAGES (state, errorMessages) {
    state.errorMessages = errorMessages
  }
}

const actions = {
  updateStartTime ({ commit }, time) {
    commit('SET_START_TIME', time)
  },
  updateEndTime ({ commit }, time) {
    commit('SET_END_TIME', time)
  },
  setErrorMessages ({ commit }, errorMessages) {
    commit('SET_ERROR_MESSAGES', errorMessages)
  }

}

export default {
  namespaced: true,
  state,
  getters,
  mutations,
  actions
}
