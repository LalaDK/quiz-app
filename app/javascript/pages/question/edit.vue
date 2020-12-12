<template lang="html">
  <div class="">
    <button type="button" class="btn btn-primary" @click="goBack">
      <b-icon-arrow-left /> Tilbage
    </button>
    <form>
      <div class="form-group">
        <label for="question">Spørgsmål</label>
        <input type="text" class="form-control" v-model="question.question">
        <small class="form-text text-muted"></small>
      </div>
      <div class="form-group">
        <label for="question">Svar</label>
        <input type="text" class="form-control" v-model="question.answer">
        <small class="form-text text-muted"></small>
      </div>
      <div class="form-group">
        <label for="question">Point</label>
        <input type="number" class="form-control" v-model="question.reward">
        <small class="form-text text-muted">Point ved rigtigt svar.</small>
      </div>
      <div class="form-group">
        <label for="question">Spotify URI</label>
        <input type="text" class="form-control" v-model="question.spotify_uri">
        <small class="form-text text-muted">Højreklik på en sang i Spotfy: <i>Share -> Copy Spotify URI</i></small>
      </div>
      <button type="button" class="btn btn-primary" @click="save">Gem</button>
      <button type="button" class="btn btn-danger" @click="destroy">
        <b-icon-trash /> Slet
      </button>
    </form>
  </div>
</template>
<script>
import { Question } from '../../services'

export default {
  data() {
    return {
      question: {}
    }
  },
  methods: {
    goBack() {
      this.$router.push('/quiz/' + this.$route.params.quiz_id + '/category/' + this.$route.params.category_id);
    },
    destroy() {
      Question.delete({quiz_id: this.$route.params.quiz_id, category_id: this.$route.params.category_id, id: this.$route.params.id}).then(() => {
        this.$router.push('/quiz/' + this.$route.params.quiz_id + '/category/' + this.$route.params.category_id);
      })
    },
    save() {
      this.editName = false;
      Question.update({quiz_id: this.$route.params.quiz_id, category_id: this.$route.params.category_id, id: this.$route.params.id}, this.question).then(() => {
        this.$router.push('/quiz/' + this.$route.params.quiz_id + '/category/' + this.$route.params.category_id);
      })
    },
    get() {
      Question.get({quiz_id: this.$route.params.quiz_id, category_id: this.$route.params.category_id, id: this.$route.params.id}).then((response) => {
        this.question = response;
      }, () => {
        this.$router.push('/quiz/' + this.$route.params.quiz_id + '/category/' + this.$route.params.category_id);
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
</style>
