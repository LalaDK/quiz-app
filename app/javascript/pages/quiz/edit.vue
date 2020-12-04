<template lang="html">
  <div class="">

  <button type="button" class="btn btn-outline-primary" @click="goBack">
    <b-icon-arrow-left /> Tilbage
  </button>
  <div class="center">
    <h1 @click="editTitle = true" v-if="!editTitle">{{quiz.name || '(Unavngivet)'}}</h1>
    <input v-if="editTitle" v-on:blur="editTitle = false" type="text" class="form-control" v-model="quiz.name" />

    <p class="no-title" v-if="!quiz.name && !editTitle">
      Tryk for at redigere ... <b-icon-pencil/>
    </p>


    <div class="flex-container">
      <category-component v-for="category in quiz.categories" :key="category.id" :quiz_id="quiz.id" :id="category.id" />
    </div>

    <button type="button" @click="addCategory" class="btn btn btn-outline-primary">Tilføj kategori</button>
  </div>
  </div>
</template>

<script>
import { Quiz, Category } from '../../services'
import CategoryComponent from '../../components/category'

export default {
  components: { CategoryComponent },
  data() {
    return {
      editTitle: false,
      quiz: {
        name: ''
      }
    }
  },
  methods: {
    goBack() {
      this.$router.push('/quiz');
    },
    addCategory() {
      Category.save({quiz_id: this.$route.params.id}).then(() => {
        this.query();
      });
    },
    query() {
      Quiz.get({id: this.$route.params.id}).then((response) => {
        this.quiz = response;
      });
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
div.center {
  text-align: center;
}

div.flex-container {
  display: flex;
  flex-wrap: wrap;
  flex-direction: row;
    justify-content: center;
}

@import url('https://fonts.googleapis.com/css2?family=Cherry+Swash:wght@700&display=swap');
h1 {
  font-family: 'Cherry Swash', cursive;
  text-align: center;
}

p.no-title {
  font-family: 'Cherry Swash', cursive;
  text-align: center;
  font-style: italic;
}

</style>
