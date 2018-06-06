import MembersUnapprovalsNew from 'components/users/members/unapprovals/new.vue'

Vue.use(ElementUI, { locale })

document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    el: '#members_unapprovals_new',
    template: '<MembersUnapprovalsNew/>',
    components: { MembersUnapprovalsNew }
  })
})
