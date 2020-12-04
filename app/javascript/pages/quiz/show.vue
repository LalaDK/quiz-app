<template lang="html">
  <div>
    <input type="text" class="form-control" v-model="quiz.name" />
    <category v-for="category in quiz.categories" :key="category.id" :quiz_id="quiz.id" :id="category.id" />
  </div>
</template>

<script>
import { Quiz } from '../../services'
import Category from '../../components/category'

export default {
  components: { Category },
  data() {
    return {
      hello: '',
      quiz: {
        name: ''
      }
    }
  },
  methods: {
    query() {
      Quiz.get({id: this.$route.params.id}).then((response) => {
        this.quiz = response;
      })
    }
  },
  created() {
    this.query();
  },
  watch: {
    $route(to, from) {
      this.query();
    }
  }
}
</script>

<style lang="css" scoped>
</style>
