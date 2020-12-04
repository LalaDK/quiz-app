<template lang="html">
  <div class="">

  <button type="button" class="btn btn-outline-primary" @click="goBack">
    <b-icon-arrow-left /> Tilbage
  </button>
  <div class="center">
    <h1 v-if="!editName">{{quiz.name || '(Unavngivet)'}}</h1>

    <div class="input-group" v-if="editName">
      <input type="text" class="form-control" v-model="quiz.name" />
      <div class="input-group-append">
        <button class="btn btn-primary" type="button" @click="save">Gem</button>
      </div>
    </div>

    <div class="center" v-if="!editName">
      <button slot="trigger" type="button" name="button" class="btn btn-outline-primary" @click="editName = true">
        <b-icon-pencil /> Omdøb
      </button>
    </div>

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
      editName: false,
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
        this.get();
      });
    },
    save() {
      Quiz.update({id: this.$route.params.id}, this.quiz).then(() => {
        this.editName = false;
        this.get()
      });
    },
    get() {
      Quiz.get({id: this.$route.params.id}).then((response) => {
        this.quiz = response;
      });
    }
  },
  created() {
    this.get();
  },
  watch: {
    $route(to, from) {
      this.get();
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
</style>
