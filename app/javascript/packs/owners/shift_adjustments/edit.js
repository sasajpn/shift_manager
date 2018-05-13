import ShiftAdjustmentsEdit from 'components/owners/shift_adjustments/edit.vue'

Vue.use(ElementUI, { locale })

document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    el: '#shift_adjustments_edit',
    template: '<ShiftAdjustmentsEdit/>',
    components: { ShiftAdjustmentsEdit }
  })
})
