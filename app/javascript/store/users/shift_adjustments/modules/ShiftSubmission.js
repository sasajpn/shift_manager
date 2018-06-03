import { getShiftSubmission } from 'api/users/shift_submissions.js'

const state = {
  submissionSubmittedDate: '',
  submissionStartTime: '',
  submissionEndTime: ''
}

const getters = {
  submissionSubmittedDate: ({ submissionSubmittedDate }) => submissionSubmittedDate,
  submissionStartTime: ({ submissionStartTime }) => submissionStartTime,
  submissionEndTime: ({ submissionEndTime }) => submissionEndTime,
}

const mutations = {
  SET_SUBMISSION_SUBMITTED_DATE (state, date) {
    state.submissionSubmittedDate = date
  },
  SET_SUBMISSION_START_TIME (state, time) {
    state.submissionStartTime = time
  },
  SET_SUBMISSION_END_TIME (state, time) {
    state.submissionEndTime = time
  }
}

const actions = {
  loadShiftSubmission ({ commit }, shiftSubmissionId) {
    getShiftSubmission(shiftSubmissionId).then((res) => {
      commit('SET_SUBMISSION_SUBMITTED_DATE', res.submitted_date)
      commit('SET_SUBMISSION_START_TIME', res.start_time)
      commit('SET_SUBMISSION_END_TIME', res.end_time)
    })
  }
}

export default {
  state,
  getters,
  mutations,
  actions
}
