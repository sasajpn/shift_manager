import Vue from 'vue'

import ElementUI from 'element-ui'
import 'element-ui/lib/theme-chalk/index.css'
Vue.use(ElementUI)

import App from './app'

new Vue({
  components: { App },
  template: '<App/>'
}).$mount('#app')
