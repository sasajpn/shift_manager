import ShiftRegistrationsEdit from 'components/owners/shift_registrations/edit.vue'
import store from '../../../store/owners/shift_registrations/'

Vue.use(ElementUI, { locale })

document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    el: '#shift_registrations_edit',
    template: '<ShiftRegistrationsEdit/>',
    components: { ShiftRegistrationsEdit },
    store
  })
})
