import Vue from 'vue/dist/vue.esm.js'
import Router from 'vue-router'

Vue.use(Router)

const router = new Router({
  routes: [
    {
      path: '/',
      name: 'main-page',
      component: require('@/components/MainPage').default,
      meta: {
        requiresAuth: true
      }
    },
    {
      path: '/login',
      name: 'login-page',
      component: require('@/components/Login').default
    },
    {
      path: '*',
      redirect: '/'
    }
  ]
})
