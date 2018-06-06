import App from 'components/owners/shift_tables/App.vue'
import store from '../../../store/owners/shift_tables/'

Vue.use(ElementUI, { locale })

document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    el: '#shift_tables',
    template: '<App/>',
    components: { App },
    store
  })
})
