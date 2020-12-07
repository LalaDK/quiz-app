<template lang="html">
  <div>
    <div class="input-group mb-3" v-if="!connected">
      <h1>Join game</h1>
      <input type="text" v-model="pin_code" class="form-horizontal">
      <div class="input-group-append">
        <button class="btn btn-outline-primary" type="button" @click="joinGame">Button</button>
      </div>
    </div>
    <button type="button" class="btn btn-outline-danger" v-if="connected" @click="disconnect">Afbrud</button>
    {{game}}
  </div>


</template>

<script>
import consumer from "channels/consumer"
window.quizChannel;

export default {
  data() {
    return {
      game: {},
      connected: false,
      channel: {},
      pin_code: ''
    }
  },
  methods: {
    disconnect() {
      consumer.disconnect();
      this.game = {};
    },
    joinGame() {
      let self = this;
      this.channel = consumer.subscriptions.create(
        {channel: 'ApplicationCable::GameChannel', pin_code: this.pin_code},
        {
          initialized() {
            self.connected = true
          },
          disconnected() {
            self.connected = false
          },
          rejected() {
            alert('Ugyldig PIN');
            self.connected = false

          },
          received(data) {
            self.game = data;
          }
        }
      );
    }
  }
}
</script>

<style lang="css" scoped>
</style>
