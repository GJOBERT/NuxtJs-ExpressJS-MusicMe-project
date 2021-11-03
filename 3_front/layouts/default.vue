<template>
  <v-app>
    <HeaderAnon v-if="!isLoggedIn" />
    <HeaderUser v-if="isLoggedIn" />
    <v-snackbar
      v-model="snackbar"
      top
      right
      :timeout="snackTimeout"
      :color="snackColor"
      transition="scroll-y-transition"
    >
      {{ snackMessage }}
      <template v-slot:action="{ attrs }">
        <v-btn dark text v-bind="attrs" @click="snackbar = false">Close</v-btn>
      </template>
    </v-snackbar>

    <Nuxt />
    <Footer />
  </v-app>
</template>

<script>
import { mapState } from "vuex";
export default {
  data() {
    return {
      snackbar: false,
      snackMessage: "",
      snackColor: "",
      snackTimeout: "4000",
    };
  },
  computed: {
    ...mapState(["isLoggedIn"]),
  },

  created() {
    this.$nuxt.$on("display-snack", (snackParams) => {
      this.snackTimeout = "1"
      this.snackbar = false
      this.snackMessage = snackParams.message;
      this.snackColor = snackParams.color;
      this.snackTimeout = "4000"
      this.snackbar = true;
    });
  },
};
</script>

<style scoped>
</style>
