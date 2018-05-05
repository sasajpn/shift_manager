import Vue from 'vue/dist/vue.esm'
import TeamsEdit from 'components/admins/teams/edit.vue'
import ElementUI from 'element-ui'
import locale from 'element-ui/lib/locale/lang/ja'
import 'element-ui/lib/theme-chalk/index.css'

Vue.use(ElementUI, { locale })

document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    el: '#teams_edit',
    template: '<TeamsEdit/>',
    components: { TeamsEdit }
  })
})
