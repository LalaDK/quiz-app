<template lang="html">
  <div class="question-modal">
    <div class="question-modal-content">
      <span class="question">{{game.current_question.question}}</span>
      <div class="answer" v-if="game.show_answer">{{game.current_question.answer}}</div>
    </div>
  </div>
</template>

<script>
export default {
  props: {
    game: {
      required: true,
      type: Object
    }
  }
}
</script>

<style lang="css" scoped>
p.question {
  font-size: 18pt;
}

.question-modal {
  position: fixed;
  z-index: 1000;
  padding-top: calc(50vh - 150px);
  left: 0;
  top: 0;
  width: 100%;
  height: 100%;
  overflow: auto;
  background-color: rgb(0,0,0);
  background-color: rgba(0,0,0,0.6);
}

/* Modal Content */
.question-modal-content {
  text-align: center;
  color: white;
  background-color: black;
  margin: auto;
  padding: 50px;
  box-shadow: 0px 0px 30px 30px black;
}

div.question-modal-content span.question {
  font-size: 3vw;
  font-family: 'Cherry Swash', cursive;
}

div.question-modal-content div.answer {
  font-family: 'Cherry Swash', cursive;
  font-size: 4vw;
  text-decoration: underline;
}
</style>
