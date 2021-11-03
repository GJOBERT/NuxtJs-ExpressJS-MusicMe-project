<template>
  <v-main>
    <Connect />
  </v-main>
</template>

<script>
import Connect from "../components/Connect.vue";
export default {
  components: { Connect },

  beforeCreate() {
    if (this.$store.state.isLoggedIn) {
      const snackMessage = "Vous êtes déjà connecté"
      this.$nuxt.$emit('display-snack', { color: "primary", message: snackMessage})
      this.$router.push({ name: "index" });
    }
  },
};
</script>

<style>
</style>