import { createStore } from 'vuex'
import { UrlsApi } from '@/utils/';
import plugin from 'tailwindcss/plugin';

const { URLAPI_CLIENTES } = UrlsApi()

export default createStore({
  state: {
    clientes: []
  },
  getters: {
    clientes(state) {
      return state.clientes
    },
  },
  mutations: {
    setClientes(state, payload) {
      state.clientes = payload
    }
  },
  actions: {
    async listarClientesAsync({ commit }) {      
      try {
        const reqs = await fetch(URLAPI_CLIENTES);
        const resp = await reqs.json();
        commit('setClientes', resp)
      } catch (error) {
        throw new Error(error);
      }
    }    
  },
  modules: {
  }
})
