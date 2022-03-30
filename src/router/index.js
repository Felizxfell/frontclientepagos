import { createRouter, createWebHashHistory } from 'vue-router'
import ClienteView from '../views/Clientes.vue'

const routes = [
  {
    path: '/',
    name: 'clientes',
    component: ClienteView
  },
  {
    path: '/pagos',
    name: 'pagos',
    // route level code-splitting
    // this generates a separate chunk (about.[hash].js) for this route
    // which is lazy-loaded when the route is visited.
    component: () => import(/* webpackChunkName: "about" */ '../views/Pagos.vue')
  }
]

const router = createRouter({
  history: createWebHashHistory(),
  routes
})

export default router
