import { getShiftSubmission } from 'api/owners/shift_submissions.js'

const state = {
  id: '',
  submittedDate: '',
  startTime: '',
  endTime: ''
}

const getters = {
  submittedDate: ({ SubmittedDate }) => SubmittedDate,
  startTime: ({ startTime }) => startTime,
  endTime: ({ endTime }) => endTime,
}

const mutations = {
  SET_ID (state, id) {
    state.id = id
  },
  SET_SUBMITTED_DATE (state, date) {
    state.submittedDate = date
  },
  SET_START_TIME (state, time) {
    state.startTime = time
  },
  SET_END_TIME (state, time) {
    state.endTime = time
  }
}

const actions = {
  loadShiftSubmission ({ commit }, shiftSubmissionId) {
    getShiftSubmission(shiftSubmissionId).then((res) => {
      commit('SET_ID', shiftSubmissionId)
      commit('SET_SUBMITTED_DATE', res.submitted_date)
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
