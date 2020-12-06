<template>
  <div>

    <h1>Igangværende spil</h1>
    <table class="table table-bordered table-striped">
      <thead class="thead-dark">
        <tr>
          <th>Navn</th>
          <th></th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="game in games" :key="game.id">
          <td>
            {{ game.quiz_name }}
          </td>
          <td>
            <button type="button" class="btn btn-outline-primary" @click="open(game.id)">
              <b-icon-controller /> Vis
            </button>
            <button type="button" class="btn btn-outline-danger" @click="destroy(game.id)">
              <b-icon-trash /> Slet
            </button>
          </td>
        </tr>
      </tbody>
    </table>

    <div class="input-group mb-3">
  <select class="form-control" v-model="quiz_id">
    <option v-for="quiz in quizzes" v-bind:value="quiz.id">
      {{ quiz.name }}
    </option>
  </select>
  <div class="input-group-append">
    <button type="button" class="btn btn-outline-primary" @click="create" :disabled="!quiz_id">
      <b-icon-controller/> Start spil
    </button>
  </div>
</div>


  </div>
</template>


<script type="text/javascript">
import { Game, Quiz } from '../../services'

export default {
  data() {
    return {
      quiz_id: null,
      games: [],
      quizzes: []
    }
  },
  methods: {
    open(game_id) {
      this.$router.push('/game/' + game_id)
    },
    destroy(game_id) {
      Game.delete({id: game_id}).then(() => {
        this.query();
      })
    },
    create() {
      Game.save({quiz_id: this.quiz_id}).then(() => {
        this.query();
      })
    },
    query() {
      Game.query({}).then((response) => {
        this.games = response;
      });
      Quiz.query({}).then((response) => {
        this.quizzes = response;
      });
    }
  },
  created() {
    this.query()
  },
  watch: {
    $route(to, from) {
      this.query();
    }
  }
}
</script>
