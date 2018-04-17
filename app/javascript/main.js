import Vue from 'vue'

import ElementUI from 'element-ui'
Vue.use(ElementUI)

import App from './app'

new Vue({
  components: { App },
  template: '<App/>'
}).$mount('#app')
