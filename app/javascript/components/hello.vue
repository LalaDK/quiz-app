<template lang="html">
  <div>
    {{ count }}
    <button type="button" name="button" @click="increment">Increment</button>
    <button type="button" name="button" @click="decrement">Decrement</button>
  </div>
</template>

<script>
export default {
  methods: {
    increment() {
      this.$store.commit('increment', 1)
    },
    decrement() {
      this.$store.commit('decrement', 1)
    }
  },
  computed: {
    count() {
      return this.$store.getters.getCount;
    }
  }
}
</script>

<style lang="css" scoped>
</style>
