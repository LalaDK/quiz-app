import Vue from 'vue/dist/vue.esm'
import { BootstrapVue, BootstrapVueIcons } from 'bootstrap-vue'
import 'bootstrap/dist/css/bootstrap.css';

Vue.use(BootstrapVue)
Vue.use(BootstrapVueIcons)
import ViewerApp from '../pages/viewer/show.vue'

document.addEventListener('DOMContentLoaded', () => {
  new Vue({
    render: h => h(ViewerApp),
  }).$mount('#app')
});
