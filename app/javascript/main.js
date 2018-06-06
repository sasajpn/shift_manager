import Vue from 'vue'
import store from './store'

import App from './app'

new Vue({
  components: { App },
  template: '<App/>',
  store
}).$mount('#app')
