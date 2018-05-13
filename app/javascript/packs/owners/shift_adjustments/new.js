import ShiftAdjustmentsNew from 'components/owners/shift_adjustments/new.vue'

Vue.use(ElementUI, { locale })

document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    el: '#shift_adjustments_new',
    template: '<ShiftAdjustmentsNew/>',
    components: { ShiftAdjustmentsNew }
  })
})
