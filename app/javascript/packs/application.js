require("@rails/ujs").start()
require("channels")

import Vue from 'vue/dist/vue.esm'
import Vuex from 'vuex'
import App from '../app.vue'

import Hello from '../components/hello.vue'

Vue.use(Vuex)


import store from '../components/store'

document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    store,
    el: '#app',
    data: {},
    components: { App, Hello }
  })
})
