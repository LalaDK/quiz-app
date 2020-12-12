<template lang="html">
  <div>
    <button type="button" class="btn btn-primary" @click="goBack">
      <b-icon-arrow-left /> Tilbage
    </button>
    <div class="center">
      <div class="category" :style="{backgroundColor: category.background_color, color: category.font_color}">
        <p class="title" v-if="!editName">{{category.name}}</p>
        <div class="input-group" v-if="editName">
          <input type="text" class="form-control" v-model="category.name" />
          <div class="input-group-append">
            <button class="btn btn-primary" type="button" @click="save">Gem</button>
          </div>
        </div>
      </div>
    </div>

    <div class="center">
      <button slot="trigger" type="button" name="button" class="btn btn-primary" @click="editName = true">
        <b-icon-pencil /> Omdøb
      </button>
      <v-swatches v-model="category.background_color" @input="save">
        <button slot="trigger" type="button" name="button" class="btn btn-primary">
          <b-icon-brush /> Farve
        </button>
      </v-swatches>
      <button slot="trigger" type="button" name="button" class="btn btn-danger" @click="deleteCategory">
        <b-icon-trash /> Slet
      </button>
    </div>

    <div v-for="question in category.questions" :key="question.id" class="card">
      <div class="card-header" :style="{backgroundColor: category.background_color, color: category.font_color, fontWeight: 'bold'}">
        {{question.reward}} points
      </div>
      <div class="card-body">
        <h5 class="card-title">{{question.question}}</h5>
        <h6 class="card-subtitle mb-2 text-muted">{{question.answer}}</h6>
        <p class="card-text">
          <a :href="question.spotify_uri">Spotify</a>
        </p>

        <button type="button" name="button" class="btn btn-primary" @click="editQuestion(question.id)">
          <b-icon-pencil /> Rediger

        </button>
        <button type="button" name="button" class="btn btn-danger" @click="deleteQuestion(question.id)">
          <b-icon-trash /> Slet
        </button>
      </div>
    </div>
    <div class="center">
      <button slot="trigger" type="button" name="button" class="btn btn-primary" @click="createQuestion">
        <b-icon-plus /> Nyt spørgsmål
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
      Question.destroy({quiz_id: this.$route.params.quiz_id, category_id: this.$route.params.id, id: question_id}).then(() => {
        this.get();
      });
    },
    createQuestion() {
      Question.save({quiz_id: this.$route.params.quiz_id, category_id: this.$route.params.id}).then(() => {
        this.get();
      });
    },
    deleteCategory() {
      Category.destroy({quiz_id: this.$route.params.quiz_id, id: this.$route.params.id}).then(() => {
        this.$router.push('/quiz/' + this.$route.params.quiz_id);
      })
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
  box-shadow: 5px 10px 18px #888888;
}

p.title {
  text-align: center;
  font-family: 'Cherry Swash', cursive;
  font-weight: bold;
  font-size: 22pt;
}
</style>
