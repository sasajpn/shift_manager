import Vue from 'vue/dist/vue.esm'
import ShiftAdjustmentsEdit from 'components/users/shift_adjustments/edit.vue'
import ElementUI from 'element-ui'
import locale from 'element-ui/lib/locale/lang/ja'
import 'element-ui/lib/theme-chalk/index.css'

Vue.use(ElementUI, { locale })

document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    el: '#shift_adjustments_edit',
    template: '<ShiftAdjustmentsEdit/>',
    components: { ShiftAdjustmentsEdit }
  })
})
