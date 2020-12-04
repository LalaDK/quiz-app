<template lang="html">
  <div>
    {{category}}
    <question v-for="question in category.questions" :key="question.id" :quiz_id="quiz_id" :category_id="id" :id="question.id" />
  </div>
</template>

<script>
import { Category } from '../services'
import Question from './question'


export default {
  components: { Question },
  data() {
    return {
      category: {}
    }
  },
  props: {
    id: {
      required: true,
      type: String
    },
    quiz_id: {
      required: true,
      type: String
    },
  },
  methods: {
    get() {
      Category.get({quiz_id: this.quiz_id, id: this.id}).then((response) => {
        this.category = response;
      })
    }
  },
  created() {
    this.get();
  }
}
</script>

<style lang="css" scoped>
</style>
