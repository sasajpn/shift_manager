const state = {
  currentDate: '',
  formattedDate: ''
}

const getters = {
  currentDate: ({ currentDate }) => currentDate,
  formattedDate: ({ formattedDate }) => formattedDate
}

const mutations = {
  SET_CURRENT_DATE (state, date) {
    state.currentDate = date
    state.formattedDate = state.currentDate.format('YYYY/MM/DD')
  }
}

const actions = {
  updateCurrentDate ({ commit }, date) {
    commit('SET_CURRENT_DATE', date)
  }
}

export default {
  state,
  getters,
  mutations,
  actions
}
