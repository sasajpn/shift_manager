import ShiftSubmissionsNew from 'components/owners/shift_submissions/new.vue'

Vue.use(ElementUI, { locale })

document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    el: '#shift_submissions_new',
    template: '<ShiftSubmissionsNew/>',
    components: { ShiftSubmissionsNew }
  })
})
