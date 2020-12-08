require("@rails/ujs").start()
require("channels")

import Vue from 'vue/dist/vue.esm'
import VueRouter from 'vue-router'
import Vuex from 'vuex'
import Sugar from 'sugar';
Sugar.extend();
import { BootstrapVue, BootstrapVueIcons } from 'bootstrap-vue'

import 'bootstrap/dist/css/bootstrap.css';

import Game from '../components/game.vue'

Vue.use(Vuex)
Vue.use(VueRouter)
Vue.use(BootstrapVue)
Vue.use(BootstrapVueIcons)

import QuizIndex from '../pages/quiz/index.vue'
import QuizEdit from '../pages/quiz/edit.vue'
import CategoryEdit from '../pages/category/edit.vue'
import QuestionEdit from '../pages/question/edit.vue'
import GameIndex from '../pages/game/index.vue'
import GameShow from '../pages/game/show.vue'

const router = new VueRouter(
  {
    routes: [
      { path: '/quiz', component: QuizIndex },
      { path: '/game', component: GameIndex },
      { path: '/game/:id', component: GameShow },
      { path: '/quiz/:id', component: QuizEdit },
      { path: '/quiz/:quiz_id/category/:id', component: CategoryEdit },
      { path: '/quiz/:quiz_id/category/:category_id/question/:id', component: QuestionEdit }
    ]
  }
);

document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    router,
    el: '#app',
    data: {},
    components: { }
  })
})
