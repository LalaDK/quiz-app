<template lang="html">
  <div class="">
    <button type="button" class="btn btn-secondary left-corner-btn" @click="goBack">
      <b-icon-arrow-return-left /> Tilbage
    </button>
    <div class="card bg-dark text-white">
      <div class="card-header">
        <h1>Spørgsmål</h1>
      </div>
      <div class="card-body">
        <form>
          <div class="form-group row">
            <label class="col-sm-4 col-form-label" for="question">Spørgsmål</label>
            <div class="col-sm-8">
              <input type="text" class="form-control" v-model="question.question">
              <small class="form-text text-muted"></small>
            </div>
          </div>
          <div class="form-group row">
            <label class="col-sm-4 col-form-label" for="question">Svar</label>
            <div class="col-sm-8">
              <input type="text" class="form-control" v-model="question.answer">
              <small class="form-text text-muted"></small>
            </div>
          </div>
          <div class="form-group row">
            <label class="col-sm-4 col-form-label" for="question">Point</label>
            <div class="col-sm-8">
              <input type="number" class="form-control" v-model="question.reward">
              <small class="form-text text-muted">Point ved rigtigt svar.</small>
            </div>
          </div>

          <div class="form-group row" v-if="question.links.length">
            <label class="col-sm-4 col-form-label" for="question">Links</label>
            <div class="col-sm-8">
              <div class="form-row" v-for="link in question.links">
                <div class="form-group col-md-6">
                  <label for="links">Linkbeskrivelse</label>
                  <input type="text" class="form-control" v-model="link.name" placeholder="Linkbeskrivelse">
                </div>
                <div class="form-group col-md-6">
                  <label for="links">Adresse</label>
                  <div class="input-group">
                    <input type="text" class="form-control" v-model="link.link" placeholder="Adresse">
                    <button type="button" class="btn btn-danger" name="button" @click="removeLink($index)">
                      <b-icon-x />
                    </button>
                  </div>
                </div>
              </div>
            </div>
          </div>
          <div class="form-group row">
            <label class="col-sm-4 col-form-label" for="question"></label>
            <div class="col-sm-8">
              <button type="button" class="btn btn-secondary" @click="addLink">Tilføj link</button>
              <button type="button" class="btn btn-primary" @click="save">Gem</button>
              <button type="button" class="btn btn-danger" @click="destroy">
                <b-icon-trash /> Slet spørgsmål
              </button>
            </div>
          </div>


        </form>
      </div>
    </div>
  </div>
</template>
<script>
import { Question } from '../../services'

export default {
  data() {
    return {
      question: {
        links: []
      }
    }
  },
  methods: {
    removeLink(index) {
      this.question.links.splice(index, 1);
    },
    addLink() {
      this.question.links = this.question.links || [];
      this.question.links.push({name: '', link: ''})
    },
    goBack() {
      this.$router.push('/quiz/' + this.$route.params.quiz_id + '/category/' + this.$route.params.category_id);
    },
    destroy() {
      if(window.confirm('Er du sikker på at du vil slette spørgsmålet?')) {
        Question.delete({quiz_id: this.$route.params.quiz_id, category_id: this.$route.params.category_id, id: this.$route.params.id}).then(() => {
          this.$router.push('/quiz/' + this.$route.params.quiz_id + '/category/' + this.$route.params.category_id);
        });
      }
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
