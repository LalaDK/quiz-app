<template lang="html">
  <div>
    <div class="logo" v-if="!connected"></div>
    <div class="row" v-if="!connected">
      <div class="offset-lg-4 col-lg-4 offset-md-4 col-md-4" id="join-game-container">
        <form @submit.prevent="joinGame">
          <div class="form-group">
            <div class="input-group">
              <input type="text" id="pin-code" inputmode="numeric" pattern="\d*" v-model="pin_code" placeholder="PIN-kode" class="form-control form-control-lg" autofocus>
              <div class="input-group-append">
                <button class="btn btn-lg btn-primary" type="button" @click="joinGame">Go!</button>
              </div>
            </div>
          </div>
        </form>
      </div>
    </div>

      <button id="disconnect-btn" class="btn btn-lg btn-dark pull-right" v-if="connected" @click="disconnect">
        <b-icon-x />
      </button>

      <button id="disconnect-btn" class="btn btn-lg btn-dark pull-right" v-if="!connected" @click="goToAdmin">
        <b-icon-person-circle/> Min side
      </button>

    <div class="score-container">
      <div v-for="score in game.score_board">
        <h1><span class="badge badge-primary" :style="{backgroundColor: score.team.background_color, color: score.team.font_color}">{{score.team.name}}</span></h1>
        <div class="score">{{score.points}} point</div>
      </div>
    </div>

    <div class="category-container">
      <div v-for="category in game.categories" :key="category.id" class="question-container" >
        <div class="category" :style="{backgroundColor: category.background_color, color: category.font_color}">
          <p class="title">{{category.name}}</p>
        </div>
        <div v-for="question in category.questions" class="question" :style="questionStyle(question)">
          <p class="question">{{question.reward}} point</p>
        </div>
      </div>
    </div>



    <modal v-if="game.current_question_id" :game="game" />
    <background />
  </div>
</template>

<script>
require("@rails/ujs").start()
require("channels")

import consumer from "channels/consumer"
import Background from "../../components/background"
import Modal from "../../components/modal"

window.quizChannel;

export default {
  components: { Background, Modal },
  data() {
    return {
      game: {},
      connected: false,
      channel: {},
      pin_code: ''
    }
  },
  methods: {
    goToAdmin() {
      window.location.href = '/admin';
    },
    questionStyle(question) {
      let team = this.game.teams.filter((team) => {
        return team.id == question.team_id;
      })[0]
      if(team) {
        return "background-color: " + team.background_color + ";";
      } else {
        return ""
      }
    },
    disconnect() {
      consumer.disconnect();
      this.game = {};
    },
    joinGame() {
      let self = this;
      this.channel = consumer.subscriptions.create(
        {channel: 'ApplicationCable::GameChannel', pin_code: this.pin_code},
        {
          initialized() {
            self.connected = true
          },
          disconnected() {
            self.connected = false
          },
          rejected() {
            alert('Ugyldig PIN');
            self.connected = false

          },
          received(data) {
            self.game = data;
          }
        }
      );
    }
  },
  watch: {
    game: function(newValue, oldValue) {
      if(newValue.show_answer) {
        this.$confetti.start({ particles: [ { type: 'rect' } ] });
      } else {
        this.$confetti.stop()
      }
    }
  }
}
</script>

<style lang="css">
#join-game-container {
  top: 40vmin;
}

button, #pin-code {
  font-family: 'Montserrat', sans-serif;
  text-align: center;
  font-weight: bold !important;
}

div.score-container {
  display: flex;
  flex-direction: row;
  justify-content: center;
}

#disconnect-btn {
  position: fixed;
  top: 0;
  right: 0;
  border-radius: 0px 0px 0px 0.25em;

}

div.score {
  text-align: center;
  font-size: 16pt;
  font-weight: bold;
  color: white;
}

div.category {
  text-align: center;
  margin: 20px;
  border-radius: 10px;
  padding: 20px;
  box-shadow: 5px 10px 18px #484848;
}

div.question {
  background-color: white;
  text-align: center;
  margin: 20px 40px 20px 40px;
  border-radius: 10px;
  border: 4px solid #ccc;
  box-shadow: 5px 10px 18px #484848;
}

p {
  margin: 10px;
  text-align: center;
  font-family: 'Cherry Swash', cursive;
}

p.question {
  font-size: 18pt;
}

p.title {
  font-weight: bold;
  font-size: 22pt;
}

div.category-container {
  width: 100%;
  display: flex;
  flex-direction: row;
  flex-wrap: nowrap;
  align-items: strech;
}

div.question-container {
  width: 100%;
  display: flex;
  flex-direction: column;
  flex-wrap: nowrap;
  justify-content: flex-start;
}
</style>
