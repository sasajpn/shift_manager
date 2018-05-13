import TeamsNew from 'components/admins/teams/new.vue'

Vue.use(ElementUI, { locale })

document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    el: '#teams_new',
    template: '<TeamsNew/>',
    components: { TeamsNew }
  })
})
