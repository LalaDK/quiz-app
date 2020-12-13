<template lang="html">
  <button id="logout-btn" class="btn btn-secondary pull-right" @click="logout">
    <b-icon-person-circle/> Log ud
  </button>
</template>

<script>
export default {
  methods: {
    logout() {

    }
  }
}
</script>

<style lang="css" scoped>
#logout-btn {
  position: absolute;
  top: 0;
  right: 0;
  border-radius: 0px 0px 0px 0.25em;
}
</style>
