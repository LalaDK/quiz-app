<template lang="html">
  <div>
    <button type="button" class="btn btn-dark left-corner-btn" @click="goBack">
      <b-icon-arrow-return-left /> Tilbage
    </button>
    <div class="center">
      <div class="category" :style="{backgroundColor: category.background_color, color: category.font_color}">
        <p class="title" v-if="!editName">{{category.name}}</p>
        <div class="input-group" v-if="editName">
          <input type="text" class="form-control" v-model="category.name" />
          <div class="input-group-append">
            <button class="btn btn-dark" type="button" @click="save">Gem</button>
          </div>
        </div>
      </div>
    </div>

    <div class="center">
      <button slot="trigger" type="button" name="button" class="btn btn-dark" @click="editName = true">
        <b-icon-pencil /> Omdøb
      </button>
      <v-swatches v-model="category.background_color" @input="save">
        <button slot="trigger" type="button" name="button" class="btn btn-dark">
          <b-icon-brush /> Farve
        </button>
      </v-swatches>
      <button type="button" name="button" class="btn btn-danger" @click="deleteCategory">
        <b-icon-trash /> Slet kategori
      </button>
    </div>

    <div v-for="question in questionsSorted" :key="question.id" class="card bg-dark text-white">
      <div class="card-header" :style="{backgroundColor: category.background_color, color: category.font_color, fontWeight: 'bold'}">
        {{question.reward}} points
      </div>
      <div class="card-body">
        <h5 class="card-title">{{question.question}}</h5>
        <h6 class="card-subtitle mb-2 text-muted">{{question.answer}}</h6>
        <p class="card-text" v-for="link in question.links">
          <a :href="link.link">{{link.name}}</a>
        </p>
        <button type="button" name="button" class="btn btn-dark" @click="editQuestion(question.id)">
          <b-icon-pencil /> Rediger
        </button>
        <button type="button" name="button" class="btn btn-danger" @click="deleteQuestion(question.id)">
          <b-icon-trash /> Slet spørgsmål
        </button>
      </div>
    </div>
    <div class="center">
      <button type="button" name="button" class="btn btn-primary" @click="createQuestion">
        Tilføj spørgsmål
      </button>
    </div>
  </div>
</template>

<script>
import { Category, Question } from '../../services'
import VSwatches from 'vue-swatches'
import 'vue-swatches/dist/vue-swatches.css'

export default {
  components: { VSwatches },
  computed: {
    questionsSorted() {
      return (this.category.questions || []).sortBy((question) => {
        return question.reward || 9999;
      });
    }
  },
  data() {
    return {
      editName: false,
      category: {
        name: ''
      }
    }
  },
  methods: {
    goBack() {
      this.$router.push('/quiz/' + this.$route.params.quiz_id);
    },
    editQuestion(question_id) {
      this.$router.push('/quiz/' + this.$route.params.quiz_id + '/category/' + this.$route.params.id + '/question/' + question_id);
    },
    deleteQuestion(question_id) {
      if(window.confirm('Er du sikker på at du vil slette spørgsmålet?')) {
        Question.destroy({quiz_id: this.$route.params.quiz_id, category_id: this.$route.params.id, id: question_id}).then(() => {
          this.get();
        });
      }
    },
    createQuestion() {
      Question.save({quiz_id: this.$route.params.quiz_id, category_id: this.$route.params.id}).then(() => {
        this.get();
      });
    },
    deleteCategory() {
      if(window.confirm('Er du sikker på at du vil slette kategorien?')) {
        Category.destroy({quiz_id: this.$route.params.quiz_id, id: this.$route.params.id}).then(() => {
          this.$router.push('/quiz/' + this.$route.params.quiz_id);
        });
      }
    },
    save() {
      this.editName = false;
      Category.update({quiz_id: this.$route.params.quiz_id, id: this.$route.params.id}, this.category).then(() => {
        this.get();
      })
    },
    get() {
      Category.get({quiz_id: this.$route.params.quiz_id, id: this.$route.params.id}).then((response) => {
        this.category = response;
      }, () => {
        this.$router.push('/quiz/' + this.$route.params.quiz_id);
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

div.card {
  margin: 50px;
}

p#color-pick-message {
  font-family: 'Cherry Swash', cursive;

  display: inline;
}

div.center {
  text-align: center;
}

div.category {
  margin: 20px;
  border-radius: 10px;
  padding: 20px;
  box-shadow: 5px 10px 18px black;
}

p.title {
  text-align: center;
  font-family: 'Cherry Swash', cursive;
  font-weight: bold;
  font-size: 22pt;
}
</style>
