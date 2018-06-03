import ShiftAdjustmentsNew from 'components/users/part_timers/shift_adjustments/new.vue'
import store from '../../../../store/users/shift_adjustments/'

Vue.use(ElementUI, { locale })

document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    el: '#shift_adjustments_new',
    template: '<ShiftAdjustmentsNew/>',
    components: { ShiftAdjustmentsNew },
    store
  })
})
