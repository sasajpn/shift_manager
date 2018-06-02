const state = {
  registeredDate: '',
  startTime: '',
  endTime: '',
  errorMessages: []
}

const getters = {
  registeredDate: ({ registeredDate }) => registeredDate,
  startTime: ({ startTime }) => startTime,
  endTime: ({ endTime }) => endTime,
  errorMessages: ({ errorMessages }) => errorMessages
}

const mutations = {
  SET_REGISTERED_DATE (state, date) {
    state.registeredDate = date
  },
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
  updateRegisteredDate ({ commit }, date) {
    commit('SET_REGISTERED_DATE', date)
  },
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
  state,
  getters,
  mutations,
  actions
}
