<template lang="html">

  <div id="main">
    <div class="center">
      <div class="input-group" v-if="!connected">
        <input type="text" v-model="pin_code" placeholder="PIN-kode" class="form-horizontal">
        <div class="input-group-append">
          <button class="btn btn-lg btn-primary" type="button" @click="joinGame">Deltag</button>
        </div>
      </div>
    </div>

    <div class="pull-right" style="z-index: 1000;">
      <button id="disconnect-btn" class="btn btn-lg btn-dark pull-right" v-if="connected" @click="disconnect">
        <b-icon-x />
      </button>
    </div>

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

    <div v-if="game.current_question_id" class="question-modal">
      <div class="modal-content">
        <span class="question">{{game.current_question.question}}</span>
        <span class="answer" v-if="game.show_answer">{{game.current_question.answer}}</span>
      </div>
    </div>

    <ul class="circles">
      <li></li>
      <li></li>
      <li></li>
      <li></li>
      <li></li>
      <li></li>
      <li></li>
      <li></li>
      <li></li>
      <li></li>
    </ul>
  </div>
</template>

<script>
require("@rails/ujs").start()
require("channels")

import consumer from "channels/consumer"

window.quizChannel;

export default {
  data() {
    return {
      game: {},
      connected: false,
      channel: {},
      pin_code: ''
    }
  },
  methods: {
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

<style lang="css" scoped>
@import url('https://fonts.googleapis.com/css2?family=Cherry+Swash:wght@700&display=swap');

div.score-container {
  display: flex;
  flex-direction: row;
  justify-content: center;
}

h1 {
  display: inline-block;
  margin: 10px;
}

#disconnect-btn {
  border-radius: 0px 0px 0px 0.25em;
}

.pull-right {
  position: relative;
  text-align: right;
}

div.score {
  text-align: center;
  font-size: 16pt;
  font-weight: bold;
  color: white;
}

div.category {
  z-index: 100;
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

p.title {
  font-weight: bold;
  font-size: 22pt;
}

p.question {
  font-size: 18pt;
}

.question-modal {
  position: fixed; /* Stay in place */
  z-index: 1000; /* Sit on top */
  padding-top: 100px; /* Location of the box */
  left: 0;
  top: 0;
  width: 100%; /* Full width */
  height: 100%; /* Full height */
  overflow: auto; /* Enable scroll if needed */
  background-color: rgb(0,0,0); /* Fallback color */
  background-color: rgba(0,0,0,0.4); /* Black w/ opacity */
}

/* Modal Content */
.modal-content {
  text-align: center;
  color: white;
  background-color: #737373;
  margin: auto;
  padding: 50px;
  border: 1px solid #888;
  width: 80%;
  height: 80%;
}

div.modal-content span.question {
  font-size: 3vw;
  font-family: 'Cherry Swash', cursive;
}

div.modal-content span.answer {
  font-family: 'Cherry Swash', cursive;
  font-size: 4vw;
  text-decoration: underline;
}

div.category-container {
  z-index: 100;
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

div#main {
  background: #6f6f6f;
  background: -webkit-linear-gradient(to left, #8f94fb, #4e54c8);
  width: 100%;
  height:100vh;
}

.circles{
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  overflow: hidden;
}

.circles li{
  position: absolute;
  display: block;
  list-style: none;
  width: 20px;
  height: 20px;
  background: rgba(255, 255, 255, 0.2);
  animation: animate 25s linear infinite;
  bottom: -150px;

}

.circles li:nth-child(1){
  left: 25%;
  width: 80px;
  height: 80px;
  animation-delay: 0s;
}


.circles li:nth-child(2){
  left: 10%;
  width: 20px;
  height: 20px;
  animation-delay: 2s;
  animation-duration: 12s;
}

.circles li:nth-child(3){
  left: 70%;
  width: 20px;
  height: 20px;
  animation-delay: 4s;
}

.circles li:nth-child(4){
  left: 40%;
  width: 60px;
  height: 60px;
  animation-delay: 0s;
  animation-duration: 18s;
}

.circles li:nth-child(5){
  left: 65%;
  width: 20px;
  height: 20px;
  animation-delay: 0s;
}

.circles li:nth-child(6){
  left: 75%;
  width: 110px;
  height: 110px;
  animation-delay: 3s;
}

.circles li:nth-child(7){
  left: 35%;
  width: 150px;
  height: 150px;
  animation-delay: 7s;
}

.circles li:nth-child(8){
  left: 50%;
  width: 25px;
  height: 25px;
  animation-delay: 15s;
  animation-duration: 45s;
}

.circles li:nth-child(9){
  left: 20%;
  width: 15px;
  height: 15px;
  animation-delay: 2s;
  animation-duration: 35s;
}

.circles li:nth-child(10){
  left: 85%;
  width: 150px;
  height: 150px;
  animation-delay: 0s;
  animation-duration: 11s;
}



@keyframes animate {
  0%{
    transform: translateY(0) rotate(0deg);
    opacity: 1;
    border-radius: 0;
  }
  100%{
    transform: translateY(-1000px) rotate(720deg);
    opacity: 0;
    border-radius: 50%;
  }
}
</style>
