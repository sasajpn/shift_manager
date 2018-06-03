import Team from './modules/Team'
import Member from './modules/Member'
import ShiftRegistration from './modules/ShiftRegistration'

Vue.use(Vuex)

export default new Vuex.Store({
  modules: {
    Team,
    Member,
    ShiftRegistration
  }
})
