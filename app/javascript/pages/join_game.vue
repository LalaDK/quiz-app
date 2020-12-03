<template lang="html">
<div>
  <h1>Join game</h1>
  <input type="number" v-model="pin" min="0" max="9999" class="form-horizontal">
</div>
</template>

<script>

export default {
  created() {
  },
  data() {
    return {
      pin: ''
    }
  }
}
</script>

<style lang="css" scoped>
</style>
