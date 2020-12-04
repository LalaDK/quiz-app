<template lang="html">
  <div>
    Question: {{question}}
  </div>
</template>

<script>
import { Question } from '../services'


export default {
  data() {
    return {
      question: {}
    }
  },
  props: {
    id: {
      required: true,
      type: String
    },
    category_id: {
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
      Question.get({quiz_id: this.quiz_id, category_id: this.category_id, id: this.id}).then((response) => {
        this.question = response;
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
