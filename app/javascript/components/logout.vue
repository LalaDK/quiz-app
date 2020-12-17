<template lang="html">
  <button id="logout-btn" class="btn btn-lg btn-secondary pull-right" type="button" @click="logout">
    <b-icon-person-circle/> Log ud
  </button>
</template>

<script>
import Axios from 'axios'

export default {
  methods: {
    logout() {
      window.location = '/users/sign_out'
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
