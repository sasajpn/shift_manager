import ShiftRegistrationsNew from 'components/users/shift_registrations/new.vue'

Vue.use(ElementUI, { locale })

document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    el: '#shift_registrations_new',
    template: '<ShiftRegistrationsNew/>',
    components: { ShiftRegistrationsNew }
  })
})
