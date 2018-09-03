import MembersNew from 'components/admins/members/new.vue'

Vue.use(ElementUI, { locale })

document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    el: '#members_new',
    template: '<MembersNew/>',
    components: { MembersNew }
  })
})
