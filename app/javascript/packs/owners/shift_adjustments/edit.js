import ShiftAdjustmentsEdit from 'components/owners/shift_adjustments/edit.vue'
import store from '../../../store/owners/shift_adjustments/'

Vue.use(ElementUI, { locale })

document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    el: '#shift_adjustments_edit',
    template: '<ShiftAdjustmentsEdit/>',
    components: { ShiftAdjustmentsEdit },
    store
  })
})
