<template lang="html">
  <div style="height: 100%;" class="gradiant">
    <login v-if="!connected" v-on:pin-entered="joinGame" />

    <button class="btn btn-lg btn-dark pull-right top-right-corner" v-if="!connected" @click="goToAdmin"> <b-icon-person-circle/> Min side </button>
    <div class="flexbox" v-if="connected">
      <div class="score-container">
        <div v-for="score in game.score_board" class="team">
          <div class="name" :class="{underline: score.turn}" :style="{backgroundColor: score.team.background_color, color: score.team.font_color}">
            {{score.team.name}}
          </div>
          <div class="score">{{score.points}} point</div>
        </div>
      </div>
      <div class="category-container">
        <div v-for="category in game.categories" :key="category.id" class="question-container" >
          <div class="category" :style="{backgroundColor: category.background_color, color: category.font_color}"> {{category.name}} </div>
          <div v-for="question in category.questions" class="question" :style="questionStyle(question)">
            <div>
              {{question.reward}} point
            </div>
          </div>
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
import Login from "../../components/login"
import Modal from "../../components/modal"

window.quizChannel;

export default {
  components: { Background, Modal, Login },
  data() {
    return {
      game: {},
      connected: false,
      channel: {}
    }
  },
  methods: {
    goToAdmin() {
      window.location.href = '/admin';
    },
    questionStyle(question) {
      let team = ((this.game || {}).teams || []).filter((team) => {
        return team.id == question.team_id;
      })[0]
      if(team) {
        return "background-color: " + team.background_color + ";";
      }
      else if (question.skipped) {
        return "background-color: #111;";
      } else {
        return ""
      }
    },
    disconnect() {
      consumer.disconnect();
      this.game = {};
    },
    joinGame(pin_code) {
      let self = this;
      this.channel = consumer.subscriptions.create(
        {channel: 'ApplicationCable::GameChannel', pin_code: pin_code},
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
            window.location.reload();
          },
          received(data) {
            if(data.categories) {
              data.categories = data.categories.map((category) => {
                category.questions = (category.questions || []).sort((a, b) => {
                  return a.reward > b.reward ? 1 : -1;
                })
                return category;
              })
            }
            self.game = data;
          }
        }
      );
    }
  },
  watch: {
    game: function(newValue, oldValue) {
      if(newValue.show_answer || newValue.questions_left == 0) {
        this.$confetti.start({
          particles: [ { type: 'rect', size: 15, dropRate: 15 } ]
        });
      } else {
        this.$confetti.stop()
      }
    }
  }
}
</script>

<style lang="css">
.flexbox {
  height: 100%;
  display: flex;
  flex-direction: column;
  font-family: 'Cherry Swash', cursive;
  padding: 2vmin;
}

div.score-container {
  display: flex;
  flex-direction: row;
  justify-content: center;
}

div.team div.name {
  margin: 0px 1vmin;
  padding: 0px 1.5vmin;
  border-radius: 2vmin;
  font-size: 4vmin;
}

div.team div.score {
  color: white;
  font-size: 3vmin;
}

div.category-container {
  font-size: 4vmin;
  width: 100%;
  display: flex;
  flex-direction: row;
  flex-wrap: nowrap;
  height: 100%;
}

div.question-container {
  width: 100%;
  display: flex;
  flex-direction: column;
  flex-wrap: nowrap;
  justify-content: space-between;
}

div.category {
  padding: 2vmin;
  text-align: center;
  border-radius: 10px;
  box-shadow: 5px 10px 18px black;
  margin-left: 2vmin;
  margin-right: 2vmin;
}

div.question {
  display: flex;
  align-items: center;
  justify-content: center;
  background-color: white;
  border-radius: 10px;
  border: 4px solid #ccc;
  box-shadow: 5px 10px 18px black;
  margin-left: 5vmin;
  margin-right: 5vmin;
}
</style>
