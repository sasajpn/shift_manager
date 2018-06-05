import ShiftRegistrationsEdit from 'components/users/full_timers/shift_registrations/edit.vue'
import store from '../../../../store/users/shift_registrations/'

Vue.use(ElementUI, { locale })

document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    el: '#shift_registrations_edit',
    template: '<ShiftRegistrationsEdit/>',
    components: { ShiftRegistrationsEdit },
    store
  })
})
