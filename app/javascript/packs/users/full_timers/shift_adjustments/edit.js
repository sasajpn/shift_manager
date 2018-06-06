import ShiftAdjustmentsEdit from 'components/users/full_timers/shift_adjustments/edit.vue'
import store from '../../../../store/users/shift_adjustments/'

Vue.use(ElementUI, { locale })

document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    el: '#shift_adjustments_edit',
    template: '<ShiftAdjustmentsEdit/>',
    components: { ShiftAdjustmentsEdit },
    store
  })
})
