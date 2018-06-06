import ShiftSubmissionsEdit from 'components/users/shift_submissions/edit.vue'

Vue.use(ElementUI, { locale })

document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    el: '#shift_submissions_edit',
    template: '<ShiftSubmissionsEdit/>',
    components: { ShiftSubmissionsEdit }
  })
})
