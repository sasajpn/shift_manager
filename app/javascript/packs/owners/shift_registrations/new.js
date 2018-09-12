import ShiftRegistrationsNew from 'components/owners/shift_registrations/new.vue'
import store from '../../../store/owners/shift_registrations/'

Vue.use(ElementUI, { locale })

document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    el: '#shift_registrations_new',
    template: '<ShiftRegistrationsNew/>',
    components: { ShiftRegistrationsNew },
    store
  })
})
