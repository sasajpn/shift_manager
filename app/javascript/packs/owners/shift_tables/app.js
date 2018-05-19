import App from 'components/owners/shift_tables/App.vue'

Vue.use(ElementUI, { locale })

document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    el: '#shift_tables',
    template: '<App/>',
    components: { App }
  })
})
