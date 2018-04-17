import Vue from 'vue/dist/vue.esm'
import App from '../app.vue'
import ElementUI from 'element-ui'

Vue.use(ElementUI)
console.log(ElementUI)

document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    el: '#hello',
    data: {
      message: "Can you say hello?"
    },
    components: { App }
  })
})
