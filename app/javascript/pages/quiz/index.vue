<template lang="html">
  <div>
    <h1>Quizzes</h1>
    <table class="table table-bordered table-striped">
      <thead class="thead-dark">
        <tr>
          <th>Navn</th>
          <th></th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="quiz in quizzes" :key="quiz.id">
          <td>{{ quiz.name || '(Unavngivet)' }}</td>
          <td>
            <button type="button" class="btn btn-outline-primary" @click="edit(quiz.id)">
              <b-icon-pencil /> Rediger
            </button>
            <button type="button" class="btn btn-outline-danger" @click="destroy(quiz.id)">
              <b-icon-trash /> Slet
            </button>
          </td>
        </tr>
      </tbody>
    </table>

    <button type="button" class="btn btn-outline-primary" @click="create">
      <b-icon-plus/> Tilføj quiz
  </button>
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
      Quiz.delete({id: quiz_id}).then(() => {
        this.query();
      })
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
