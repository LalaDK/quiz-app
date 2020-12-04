<template lang="html">
  <div class="category" v-if="category.id" :style="{backgroundColor: category.background_color, color: category.font_color}" @click="open">
    <p class="title">{{category.name}}</p>
    <p class="question-count">{{category.questions.length}} spørgsmål</p>
  </div>
</template>

<script>
import { Category } from '../services'
//import Question from './question'


export default {
  //components: { Question },
  data() {
    return {
      category: {
        questions: []
      }
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
    open() {
      this.$router.push('/quiz/' + this.quiz_id + '/category/' + this.id)
    },
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

p.question-question-count {
  font-size: 10pt;
}
</style>
