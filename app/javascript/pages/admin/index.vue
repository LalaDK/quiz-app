<template lang="html">
<div>
  <logout />
  <br><br>
  <div class="row">
    <div class="col-12">
      <h1 class="center">Velkommen til Quizzy</h1>
    </div>
  </div>
  <div class="row" id="container">
    <div class="col-lg-6 col-md-12">
      <div class="center">
        For at komme i gang med at quizze med venner og familie, skal du først og fremmest oprette en quiz, som du gør ved at trykke på "Opret quiz". Herefter kan du trykke "Rediger", for at oprette quizkategorier og spørgsmål som dine deltagere skal dyste i !
      </div>
      <div class="center">
        Når din quiz er oprettet, kan du starte et spil med din quiz, hvor du har mulighed for at angive holdnavne, holdfarve mv. Når du har startet spillet, vil der blive vist en PIN-kode, som du skal indtaste på <a href="https://www.quizzy.dk/" target="_blank">www.quizzy.dk.</a> Her vil spillets gang blive vist, og du kan nu styre spillet ved at trykke på knappen "Administrer".
        God fornøjelse!
      </div>
    </div>
    <div class="col-lg-6 col-md-12">
      <h3>Mine quizzer</h3>
      <quiz-index />
      <h3>Mine spil</h3>
      <game-index />
    </div>


  </div>
</div>
</template>

<script>
import GameIndex from '../game/index.vue'
import QuizIndex from '../quiz/index.vue'
import Logout from '../../components/logout.vue'

export default {
  components: { GameIndex, QuizIndex, Logout }
}
</script>

<style lang="css">
@import url('https://fonts.googleapis.com/css2?family=Cherry+Swash:wght@700&display=swap');

#container {
  background-color: rgb(0,0,0,0.6);
  padding: 10px;
  border-radius: 20px;
}

div {
  color: white;

}

.center {
  text-align: center;
}

div.center {
  padding: 10px;
}
</style>
