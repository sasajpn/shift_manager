import Vue from 'vue/dist/vue.esm'
import TeamsNew from 'components/admins/teams/new.vue'
import ElementUI from 'element-ui'
import locale from 'element-ui/lib/locale/lang/ja'
import 'element-ui/lib/theme-chalk/index.css'

Vue.use(ElementUI, { locale })

document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    el: '#teams_new',
    template: '<TeamsNew/>',
    components: { TeamsNew }
  })
})