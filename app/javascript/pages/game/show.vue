<template>
  <div>
    <button type="button" class="btn btn-secondary left-corner-btn" @click="goBack">
      <b-icon-arrow-return-left /> Tilbage
    </button>
    <div class="center">
      <h3 class="score" v-for="score in game.score_board">
        <span class="badge badge-primary" :style="{ backgroundColor: score.team.background_color }">
          <b-icon-arrow-right v-if="score.team.id == game.current_team_id" />
          {{score.team.name}} - {{score.points}} points
          <b-icon-arrow-left v-if="score.team.id == game.current_team_id" />
        </span>
      </h3>
      <br>
      <span class="badge badge-primary">Pinkode: {{game.pin_code}} </span>
      <span class="badge badge-secondary">{{game.questions_left}} spørgsmål tilbage </span>
    </div>

    <div v-if="game.id && !game.lock_game">
      <teams-component :game_id="game.id" @input="get" />
    <button type="button" class="center btn btn-lg btn-secondary" :disabled="(game.teams || []).length < 2" @click="startGame">Start spil</button>
    <br><br>
    <div class="alert alert-primary" role="alert">
      Tilføj minimum 2 hold for at starte spillet ...
    </div>
  </div>


    <div v-if="game.current_question_id">
      <div class="card bg-dark text-white" v-if="game.current_question">
        <div class="card-header center">
          {{game.current_question.question}}
        </div>
        <div class="card-body center">
          <h5 class="card-title">
            <span v-if="game.show_answer">
              {{game.current_question.answer}}
            </span>
          </h5>
          <button type="button" class="btn btn-lg btn-secondary" @click="showAnswer" v-if="!game.show_answer">Vis svar</button>
          <button type="button" class="btn btn-lg btn-danger" @click="closeQuestion">Luk</button>
          <div v-for="link in game.current_question.links">
            <button type="button" class="btn btn-lg btn-link" @click="openLink(link)">{{link.name}}</button>
          </div>
          <br><b>Giv {{game.current_question.reward}} point til:</b><br>
          <div class="btn-group center btn-group-lg" role="group" aria-label="...">
            <button type="button" class="btn btn-secondary" @click="assignPointsTo(team.id)" v-for="team in game.teams" :style="{ backgroundColor: team.background_color }"> {{team.name}} </button>
            <button type="button" class="btn btn-secondary" @click="assignPointsTo(null)">Ingen</button>
          </div>
        </div>
      </div>
    </div>

    <div v-if="game.lock_game && !game.current_question_id">
      <div class="card bg-dark text-white" v-for="category in game.categories" style="margin-bottom: 20px;">
        <div class="card-header" :style="{backgroundColor: category.background_color, color: category.font_color}">
          <h2 class="center">{{category.name}}</h2>
        </div>
        <div class="card-body">
          <div class="list-group">
            <a href="#" class="list-group-item list-group-item-action center" :style="{backgroundColor: category.background_color, color: category.font_color}" @click="openQuestion(question.id)" v-for="question in category.questions">
              <h3>
                <b-icon-square v-if="!question.team_id && !question.skipped" />
                <b-icon-check-square v-if="question.team_id" />
                <b-icon-dash-square v-if="question.skipped" />
                {{question.reward}} points
              </h3>
            </a>
          </div>
        </div>
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
    goBack() {
      this.$router.push('/');
    },
    openLink(link) {
      window.open(link.link);
    },
    showAnswer() {
      Axios({
        method: 'put',
        url: '/game/' + this.game.id + '/show_answer',
        headers: {
          "X-CSRF-Token": document.querySelector('meta[name=csrf-token]').content
        }
      }).then(() => {
        this.get()
      });
    },
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

h3 {
  text-align: center;
}

div.card-header {
  font-family: 'Cherry Swash', cursive;
  text-align: center;
}

h2.score {
  display: inline-block;
  margin: 5px;
}

div.center, span.center {
  text-align: center;
}
</style>
