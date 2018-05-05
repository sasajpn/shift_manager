import Vue from 'vue/dist/vue.esm'
import ShiftSubmissionsNew from 'components/admins/shift_submissions/new.vue'
import ElementUI from 'element-ui'
import locale from 'element-ui/lib/locale/lang/ja'
import 'element-ui/lib/theme-chalk/index.css'

Vue.use(ElementUI, { locale })

document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    el: '#shift_submissions_new',
    template: '<ShiftSubmissionsNew/>',
    components: { ShiftSubmissionsNew }
  })
})
