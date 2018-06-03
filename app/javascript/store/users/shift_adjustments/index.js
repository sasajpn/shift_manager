import ShiftSubmission from './modules/ShiftSubmission'
import ShiftAdjustment from './modules/ShiftAdjustment'

Vue.use(Vuex)

export default new Vuex.Store({
  modules: {
    ShiftSubmission,
    ShiftAdjustment
  }
})
