<template>
  <v-main>
    <v-card max-width="450" class="mx-auto">
      <v-toolbar color="green">
        <v-toolbar-title> Thanks for your order ! </v-toolbar-title>
      </v-toolbar>
      <v-card-text>
        Congratulations we have received your order. You'll be redirect to home
        automaticaly in {{ count }} seconds...
      </v-card-text>
    </v-card>
  </v-main>
</template>

<script>
export default {
  data: () => ({
    count: 3,
  }),

  mounted() {
    this.$store.commit('unsetCart')

    setInterval(() => {
      this.count -= 1;
    }, 1000);

    setTimeout(() => {
      this.$router.push({ name: "index" });
    }, 3001);
  },
};
</script>

<style>
</style>