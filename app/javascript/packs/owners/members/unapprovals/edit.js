import MembersUnapprovalsEdit from 'components/owners/members/unapprovals/edit.vue'

Vue.use(ElementUI, { locale })

document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    el: '#members_unapprovals_edit',
    template: '<MembersUnapprovalsEdit/>',
    components: { MembersUnapprovalsEdit }
  })
})
