import Team from './modules/Team'
import ShiftRegistration from './modules/ShiftRegistration'

Vue.use(Vuex)

export default new Vuex.Store({
  modules: {
    Team,
    ShiftRegistration
  }
})
