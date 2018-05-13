import TeamsEdit from 'components/owners/teams/edit.vue'

Vue.use(ElementUI, { locale })

document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    el: '#teams_edit',
    template: '<TeamsEdit/>',
    components: { TeamsEdit }
  })
})
