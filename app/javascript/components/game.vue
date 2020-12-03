<template lang="html">
  <div>
    Gamedata: {{ gameData }}
    <button type="button" name="button" @click="sendRequest">Send request</button>
  </div>
</template>

<script>
export default {
  methods: {
    sendRequest() {
      this.$store.commit('ping', 1)
    }
  },
  computed: {
    gameData() {
      return this.$store.getters.getGameData;
    }
  }
}
</script>

<style lang="css" scoped>
</style>
