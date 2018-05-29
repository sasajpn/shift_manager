import ShiftRegistersNew from 'components/users/shift_registers/new.vue'

Vue.use(ElementUI, { locale })

document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    el: '#shift_registers_new',
    template: '<ShiftRegistersNew/>',
    components: { ShiftRegistersNew }
  })
})
