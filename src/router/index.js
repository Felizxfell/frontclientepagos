import { createRouter, createWebHashHistory } from 'vue-router'
import Clientes from "@/components/Clientes/index";

const routes = [
  {
    path: '/',
    name: 'clientes',
    component: Clientes
  },
  {
    path: '/pagos',
    name: 'pagos',
    // route level code-splitting
    // this generates a separate chunk (about.[hash].js) for this route
    // which is lazy-loaded when the route is visited.
    component: () => import(/* webpackChunkName: "about" */ '../components/Pagos.vue')
  }
]

const router = createRouter({
  history: createWebHashHistory(),
  routes
})

export default router
