import Vuex from 'vuex'
import Vue from 'vue/dist/vue.esm'
import consumer from "channels/consumer"

Vue.use(Vuex)

const myPlugin = (store) => {
  const quizChannel = consumer.subscriptions.create(
    {channel: 'ApplicationCable::QuizChannel' },
    {
      received(data) {
        if(data.id != store.getters.getGameData.id) {
          store.commit('setGameData', data);
        }
      }
    }
  )

  store.subscribe((mutation, state) => {
    quizChannel.send({ count: state.count })
  });
}

export default new Vuex.Store({
  state: {
    game: {},
  },
  mutations: {
    ping(state) {},
    setGameData(state, game) {
      state.game = game;
    }
  },
  getters: {
    getGameData(state) {
      return state.game;
    }
  },
  plugins: [myPlugin]
});
