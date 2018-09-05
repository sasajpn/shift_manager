import App from 'components/users/shift_coordinators/shift_tables/App.vue'
import store from '../../../../store/users/shift_tables/index'

Vue.use(ElementUI, { locale })

document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    el: '#shift_tables',
    template: '<App/>',
    components: { App },
    store
  })
})
