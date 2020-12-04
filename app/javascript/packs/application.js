require("@rails/ujs").start()
require("channels")

import Vue from 'vue/dist/vue.esm'
import VueRouter from 'vue-router'
import Vuex from 'vuex'
import Sugar from 'sugar';
Sugar.extend();
import { BootstrapVue, BootstrapVueIcons } from 'bootstrap-vue'

import 'bootstrap/dist/css/bootstrap.css';
import 'bootstrap-vue/dist/bootstrap-vue.css';


import Game from '../components/game.vue'

Vue.use(Vuex)
Vue.use(VueRouter)
Vue.use(BootstrapVue)
Vue.use(BootstrapVueIcons)

import JoinGamePage from '../pages/join_game.vue'
import QuizIndex from '../pages/quiz/index.vue'
import QuizShow from '../pages/quiz/show.vue'

const router = new VueRouter(
  {
    routes: [
      { path: '/join', component: JoinGamePage },
      { path: '/quiz', component: QuizIndex },
      { path: '/quiz/:id', component: QuizShow }
    ]
  }
);

import store from '../components/store'

document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    router,
    store,
    el: '#app',
    data: {},
    components: { }
  })
})
