<template lang="html">
  <div class="full-height">
    <div class="logo">Quizzy</div>
    <div class="pin-container">
      <div class="pin-code">
        <p class="box-text">Indtast PIN-kode</p>
        <form @submit.prevent="joinGame">
          <input type="text" inputmode="numeric" pattern="\d{4}" v-model="pin_code" placeholder="PIN-kode" autofocus>
          <button type="button" @click="joinGame" :disabled="!pin_code">OK</button>
        </form>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      pin_code: ''
    }
  },
  methods: {
    joinGame() {
      this.$emit('pin-entered', this.pin_code);
    }
  }
}
</script>

<style lang="css" scoped>

div.pin-code {
  background-color: rgb(0,0,0,0.5);
  padding: 25px;
  border-radius: 5px;
}

p.box-text {
  font-size: 16pt;
  font-weight: bold;
}

input, button, p {
  font-family: 'Montserrat', sans-serif;
}

input {
  font-weight: bold;
  border: 0;
  border-radius: 0;
  margin: 0;
  height: 50px;
}

button {
  margin-top: 5px;
  text-align: center;
  font-weight: bold;
  display: block;
  width: 100%;
  color: #fff;
  background-color: #0180ff;
  border: 0;
  padding: 5px;
  height: 50px;

}

div.pin-container {
  height: 100%;
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
}

div.logo {
  margin-top: 8vh;
  position: fixed;
  width: 100%;
  text-align: center;
  font-family: 'Montserrat', sans-serif;
  font-weight: bold;
  font-size: 15vmin;
  text-align: center;
  color: #d2d2d2;
  text-shadow: 5px 5px 30px black;
}
</style>
