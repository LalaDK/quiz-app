<template lang="html">
  <div>
    <table class="table table-sm table-dark table-bordered table-striped">
      <thead class="thead-dark">
        <tr>
          <th>Navn</th>
          <th></th>
        </tr>
      </thead>
      <tbody>
        <tr v-if="!quizzes.length">
          <td colspan="3" class="norows">Du har endnu ikke oprettet en quiz.</td>
        </tr>
        <tr v-for="quiz in quizzes" :key="quiz.id">
          <td>{{ quiz.name || '(Unavngivet)' }}</td>
          <td class="td-toolbar">
            <button type="button" class="btn btn-dark" @click="edit(quiz.id)">
              <b-icon-pencil /> Rediger
            </button>
            <button type="button" class="btn btn-danger" @click="destroy(quiz.id)">
              <b-icon-trash /> Slet quiz
            </button>
          </td>
        </tr>
      </tbody>
      <tfoot>
        <tr>
          <td colspan="2" style="text-align: right;">
            <button type="button" class="btn btn-dark" @click="create">
              Opret quiz
            </button>
          </td>
        </tr>
      </tfoot>
    </table>
  </div>
</template>

<script>
import { Quiz } from '../../services'

export default {
  data() {
    return {
      quizzes: []
    }
  },
  methods: {
    create() {
      Quiz.save({}).then(() => {
        this.query();
      })
    },
    edit(quiz_id) {
      this.$router.push('/quiz/' + quiz_id);
    },
    destroy(quiz_id) {
      if(window.confirm('Er du sikker på at du vil slette quizzen?')) {
        Quiz.delete({id: quiz_id}).then(() => {
          this.query();
        });
      }
    },
    query() {
      Quiz.query({}).then((response) => {
        this.quizzes = response;
      })
    }
  },
  created() {
    this.query()
  }
}
</script>

<style lang="css" scoped>
</style>
