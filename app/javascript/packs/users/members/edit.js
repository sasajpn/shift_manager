import MembersEdit from 'components/users/members/edit.vue'

Vue.use(ElementUI, { locale })

document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    el: '#members_edit',
    template: '<MembersEdit/>',
    components: { MembersEdit }
  })
})
