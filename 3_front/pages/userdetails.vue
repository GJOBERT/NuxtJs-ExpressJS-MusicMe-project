<template>
  <v-main>
    <UserDetails />
  </v-main>
</template>

<script>
import UserDetails from "../components/UserDetails";
export default {
  component: { UserDetails },
  beforeCreate() {
    if (!this.$store.state.isLoggedIn) {
      const snackMessage =
        "Vous devez être connectez pour accédez à cette page";
      this.$nuxt.$emit("display-snack", {
        color: "error",
        message: snackMessage,
      });
      this.$router.push({ name: "connect" });
    }
  },
};
</script>

<style>
</style>