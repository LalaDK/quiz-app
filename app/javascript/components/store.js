import Vuex from 'vuex'
import Vue from 'vue/dist/vue.esm'
import consumer from "channels/consumer"

Vue.use(Vuex)

const myPlugin = (store) => {
  const quizChannel = consumer.subscriptions.create(
    {channel: 'ApplicationCable::QuizChannel' },
    {
      received(data) {
        console.log(store.count)
        if(data && data.count && data.count != store.count) {
          store.commit('set', data.count);
        }
        //console.log("Data received:", data);
        //store.commit('increment');
      }
    }
  )

  store.subscribe((mutation, state) => {
    //console.log(state)
    quizChannel.send({ count: state.count })
  });
}

export default new Vuex.Store({
  state: {
    count: 5
  },
  mutations: {
    increment(state) {
      state.count++;
    },
    decrement(state) {
      state.count--;
    },
    set(state, count) {
      state.count = count;
    }
  },
  getters: {
    getCount(state) {
      return state.count;
    }
  },
  plugins: [myPlugin]
});
