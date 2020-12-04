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
            <router-link  :to="'/quiz/' + quiz.id">Vis</router-link>
          </td>
        </tr>
      </tbody>
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
