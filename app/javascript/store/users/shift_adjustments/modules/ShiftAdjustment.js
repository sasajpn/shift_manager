const state = {
  adjustmentStartTime: '',
  adjustmentEndTime: '',
  errorMessages: []
}

const getters = {
  adjustmentStartTime: ({ adjustmentStartTime }) => adjustmentStartTime,
  adjustmentEndTime: ({ adjustmentEndTime }) => adjustmentEndTime,
  errorMessages: ({ errorMessages }) => errorMessages
}

const mutations = {
  SET_ADJUSTMENT_START_TIME (state, time) {
    state.adjustmentStartTime = time
  },
  SET_ADJUSTMENT_END_TIME (state, time) {
    state.adjustmentEndTime = time
  },
  SET_ERROR_MESSAGES (state, errorMessages) {
    state.errorMessages = errorMessages
  }
}

const actions = {
  updateAdjustmentStartTime ({ commit }, time) {
    commit('SET_ADJUSTMENT_START_TIME', time)
  },
  updateAdjustmentEndTime ({ commit }, time) {
    commit('SET_ADJUSTMENT_END_TIME', time)
  },
  setErrorMessages ({ commit }, errorMessages) {
    commit('SET_ERROR_MESSAGES', errorMessages)
  }

}

export default {
  state,
  getters,
  mutations,
  actions
}
