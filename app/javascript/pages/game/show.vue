<template>
  <div>
    <h1>Score board</h1>
    {{game.score_board}}
    <h1>Pin: {{game.pin_code}}</h1>
    <teams-component v-if="game.id && !game.lock_game" :game_id="game.id" />

    <button type="button" name="button" @click="startGame">Start game</button>
    <h1>Nuværende team</h1>
    <h1 v-if="game.current_team">
      <span class="badge badge-primary" :style="{ backgroundColor: game.current_team.background_color }">{{game.current_team.name}}</span>
    </h1>

    <h1>Nuværende spørgsmål</h1>
    <div class="card" v-if="game.current_question">
      <div class="card-header">
        {{game.current_question.question}}
      </div>
      <div class="card-body">
        <h5 class="card-title">{{game.current_question.answer}}</h5>
        <a :href="game.current_question.spotify_uri" target="_blank">Spotify link</a><br>
        Points: {{game.current_question.reward}}<br>
        <b>Giv point til:</b><br>
        <button type="button" class="btn btn-primary" @click="assignPointsTo(team.id)" v-for="team in game.teams" :style="{ backgroundColor: team.background_color }"> {{team.name}} </button>
        <button type="button" class="btn btn-secondary" @click="assignPointsTo(null)">Ingen</button>
      </div>
    </div>

    <h1>Spørgsmål</h1>
    <div v-for="category in game.categories">
      {{category}}
      <div class="category" v-if="category.id" :style="{backgroundColor: category.background_color, color: category.font_color}">
        <p class="title">{{category.name}}</p>
      </div>
        <div v-for="question in category.questions">
          <button type="button" class="btn btn-primary" @click="openQuestion(question.id)">{{question.reward}} point</button>
        </div>
    </div>
    </div>
</template>

<script type="text/javascript">
import Axios from 'axios'
import { Game } from '../../services'
import TeamsComponent from '../../components/teams'

export default {
  components: { TeamsComponent },
  data() {
    return {
      game: {}
    }
  },
  methods: {
    closeQuestion(question_id) {
      Axios({
        method: 'put',
        url: '/game/' + this.game.id + '/close_question/' + question_id,
        headers: {
          "X-CSRF-Token": document.querySelector('meta[name=csrf-token]').content
        }
      }).then(() => {
        this.get()
      });
    },
    openQuestion(question_id) {
      Axios({
        method: 'put',
        url: '/game/' + this.game.id + '/open_question/' + question_id,
        headers: {
          "X-CSRF-Token": document.querySelector('meta[name=csrf-token]').content
        }
      }).then(() => {
        this.get()
      });
    },
    assignPointsTo(team_id) {
      Axios({
        method: 'put',
        url: '/game/' + this.game.id + '/assign_points_to/' + team_id,
        headers: {
          "X-CSRF-Token": document.querySelector('meta[name=csrf-token]').content
        }
      }).then(() => {
        this.get()
      });
    },
    startGame() {
      Axios({
        method: 'put',
        url: '/game/' + this.game.id + '/start_game',
        headers: {
          "X-CSRF-Token": document.querySelector('meta[name=csrf-token]').content
        }
      }).then(() => {
        this.get()
      });
    },
    get() {
      Game.get({id: this.$route.params.id}).then((response) => {
        this.game = response;
      });
    },
  },
  created() {
    this.get()
  },
  watch: {
    $route(to, from) {
      this.get();
    }
  }
}
</script>

<style lang="css" scoped>

@import url('https://fonts.googleapis.com/css2?family=Cherry+Swash:wght@700&display=swap');

div.category {
  width: 350px;
  margin: 20px;
  border-radius: 10px;
  padding: 20px;
  box-shadow: 5px 10px 18px #888888;
  transition: all ease 200ms;
}

div.category:hover {
  transform: scale(1.1);
  transition: all ease 200ms;
}

p {
  text-align: center;
  font-family: 'Cherry Swash', cursive;
}

p.title {
  font-weight: bold;
  font-size: 22pt;
}
</style>
