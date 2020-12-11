<template lang="html">
<div>
  <h1>Mine quizzer</h1>
  <quiz-index />
  <h1>Mine spil</h1>
  <game-index />
</div>
</template>

<script>
import GameIndex from '../game/index.vue'
import QuizIndex from '../quiz/index.vue'

export default {
  components: { GameIndex, QuizIndex }
}
</script>

<style lang="css">
@import url('https://fonts.googleapis.com/css2?family=Cherry+Swash:wght@700&display=swap');

h1 {
  text-align: center;
  font-family: 'Cherry Swash', cursive;
}

</style>
