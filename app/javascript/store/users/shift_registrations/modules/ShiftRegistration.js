import { getShiftRegistration } from 'api/users/shift_coordinators/shift_registrations.js'

const state = {
  id: '',
  registeredDate: '',
  startTime: '',
  endTime: '',
  errorMessages: []
}

const getters = {
}

const mutations = {
  SET_ID (state, id) {
    state.id = id
  },
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
  loadShiftRegistration ({ commit }, shiftRegistrationId) {
    getShiftRegistration(shiftRegistrationId).then((res) => {
      commit('SET_ID', shiftRegistrationId)
      commit('SET_REGISTERED_DATE', res.registered_date)
      commit('SET_START_TIME', res.start_time)
      commit('SET_END_TIME', res.end_time)
    })
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
