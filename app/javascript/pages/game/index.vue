<template>
  <div>
    <table class="table table-sm table-dark table-bordered table-striped">
      <thead class="thead-dark">
        <tr>
          <th>Quiznavn</th>
          <th>PIN-kode</th>
          <th></th>
        </tr>
      </thead>
      <tbody>
        <tr v-if="!games.length">
          <td colspan="4" class="norows">Du har endnu ikke startet nogen spil.</td>
        </tr>
        <tr v-for="game in games" :key="game.id">
          <td> {{ game.quiz_name }} </td>
          <td> <b>{{ game.pin_code }}</b> </td>
          <td class="td-toolbar">
            <button type="button" class="btn btn-primary" @click="open(game.id)">
              <b-icon-controller /> Administrér
            </button>
            <button type="button" class="btn btn-danger" @click="destroy(game.id)">
              <b-icon-trash /> Slet
            </button>
          </td>
        </tr>
      </tbody>
      <tfoot>
        <tr>
          <td colspan="4">
            <div class="input-group">
              <select class="form-control" v-model="quiz_id">
                <option v-for="quiz in quizzes" v-bind:value="quiz.id">
                  {{ quiz.name }}
                </option>
              </select>
              <div class="input-group-append">
                <button type="button" class="btn btn-primary" @click="create" :disabled="!quiz_id">
                  <b-icon-controller/> Start spil
                </button>
              </div>
            </div>
          </td>
        </tr>
      </tfoot>
    </table>
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
