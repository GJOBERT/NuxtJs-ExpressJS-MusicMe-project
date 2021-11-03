<template>
  <v-main>
    <OrderHistory />
  </v-main>
</template>

<script>
import OrderHistory from "../components/OrderHistory";

export default {
  components: { OrderHistory },
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