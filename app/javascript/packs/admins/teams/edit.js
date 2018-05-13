import TeamsEdit from 'components/admins/teams/edit.vue'

Vue.use(ElementUI, { locale })

document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    el: '#teams_edit',
    template: '<TeamsEdit/>',
    components: { TeamsEdit }
  })
})
