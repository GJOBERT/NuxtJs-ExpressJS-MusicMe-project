<template>
  <v-main>
    <Register />
  </v-main>
</template>

<script>
import Register from "../components/Register.vue";
export default {
  components: { Register },

  beforeCreate() {
    if (this.$store.state.isLoggedIn) {
      const snackMessage = "Vous êtes déjà membre " + String.fromCodePoint(129321);
      this.$nuxt.$emit("display-snack", {
        color: "primary",
        message: snackMessage,
      });
      this.$router.push({ name: "index" });
    }
  },
};
</script>

<style>
</style>