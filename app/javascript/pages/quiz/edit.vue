<template lang="html">
  <div>
    <button type="button" class="btn btn-dark left-corner-btn" @click="goBack">
      <b-icon-arrow-return-left /> Tilbage
    </button>
    <div class="center">
      <h1 v-if="!editName">{{quiz.name || '(Unavngivet)'}}</h1>

      <div class="input-group" v-if="editName">
        <input type="text" class="form-control form-control-lg" v-model="quiz.name" />
        <div class="input-group-append">
          <button class="btn btn-lg btn-dark" type="button" @click="save">Gem</button>
        </div>
      </div>

      <div class="center" v-if="!editName">
        <button slot="trigger" type="button" name="button" class="btn btn-dark" @click="editName = true">
          <b-icon-pencil /> Omdøb
        </button>
      </div>

      <div class="flex-container">
        <category-component v-for="category in quiz.categories" :key="category.id" :quiz_id="quiz.id" :id="category.id" />
      </div>

      <button type="button" @click="addCategory" class="btn btn-dark">Tilføj kategori</button>
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
      this.$router.push('/');
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
@import url('https://fonts.googleapis.com/css2?family=Cherry+Swash:wght@700&display=swap');

div.center {
  text-align: center;
}

div.flex-container {
  display: flex;
  flex-wrap: wrap;
  flex-direction: row;
  justify-content: center;
}

h1 {
  font-family: 'Cherry Swash', cursive;
  text-align: center;
}
</style>
