<template>
  <v-main>
    <OrderDetails />
  </v-main>
</template>

<script>
import OrderDetails from "@/components/OrderDetails";

export default {
  components: { OrderDetails },
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