import Vue from 'vue/dist/vue.esm'
import MembersEdit from 'components/users/members/edit.vue'
import ElementUI from 'element-ui'
import locale from 'element-ui/lib/locale/lang/ja'
import 'element-ui/lib/theme-chalk/index.css'

Vue.use(ElementUI, { locale })

document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    el: '#members_edit',
    template: '<MembersEdit/>',
    components: { MembersEdit }
  })
})
