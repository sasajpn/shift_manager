import TeamsShow from 'components/owners/teams/show.vue'

Vue.use(ElementUI, { locale })

document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    el: '#teams_show',
    template: '<TeamsShow/>',
    components: { TeamsShow }
  })
})
