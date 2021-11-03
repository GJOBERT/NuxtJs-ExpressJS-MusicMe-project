<template>
  <v-sheet rounded="lg">
    <div class="dashboard_title">Tableau de bord</div>

    <v-divider class="my-1"></v-divider>

    <v-list-item
      id="ordersComp"
      class="menu"
      @click="emitAdminCompToDisplay('orders')"
      link
    >
      <v-list-item-title class="title">Statut des commandes</v-list-item-title>
    </v-list-item>
    <v-list-item
      id="usersComp"
      class="menu"
      @click="emitAdminCompToDisplay('users')"
      link
    >
      <v-list-item-title class="title"
        >Gestion des utilisateurs</v-list-item-title
      >
    </v-list-item>

    <v-list-item
      id="productsComp"
      class="menu"
      @click="emitAdminCompToDisplay('products')"
      link
    >
      <v-list-item-title class="title">Gestion des produits</v-list-item-title>
    </v-list-item>

    <v-list-item
      id="categoriesComp"
      class="menu"
      @click="emitAdminCompToDisplay('categories')"
      link
    >
      <v-list-item-title class="title"
        >Gestion des catégories</v-list-item-title
      >
    </v-list-item>
  </v-sheet>
</template>

<script>
export default {
  name: "AdminDashboardMenu",
  methods: {
    emitAdminCompToDisplay(componentToDisplay) {
      this.$nuxt.$emit("selectAdminComp", componentToDisplay);
    },
  },
};
</script>

<style scoped>
.menu,
.dashboard_title {
  text-align: center;
}
.dashboard_title {
  color: white;
  font-size: 22px;
  margin-top: 10px;
}
.title {
  color: white !important;
  font-size: 18px !important;
}
.v-sheet {
  background-color: #00479b;
  padding-top: 1px;
  padding-bottom: 5px;
}
</style>