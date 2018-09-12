import { getShiftAdjustment } from 'api/owners/shift_adjustments.js'

const state = {
  id: '',
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
  },
  loadShiftAdjustment ({ commit }, shiftAdjustmentId) {
    getShiftAdjustment(shiftAdjustmentId).then((res) => {
      commit('SET_ID', shiftAdjustmentId)
      commit('SET_START_TIME', res.start_time)
      commit('SET_END_TIME', res.end_time)
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
