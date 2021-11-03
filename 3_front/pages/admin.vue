<template>
  <v-main class="white">
    <v-container>
      <v-row>
        <v-col cols="col-sm-4 col-md-3 col-lg-3 col-xl-2">
          <AdminDashBoardMenu />
        </v-col>
        <v-col cols="col-sm-8 col-md-9 col-lg-9 col-xl-10 col_data">
          <div id="ordersComp" v-if="this.compToDisplay == 'orders'">
            <AdminOrdersComp />
          </div>
          <div id="usersComp" v-if="this.compToDisplay == 'users'">
            <AdminUsersComp />
          </div>
          <div id="productsComp" v-if="this.compToDisplay == 'products'">
            <AdminProductsComp />
          </div>
          <div id="categoriesComp" v-if="this.compToDisplay == 'categories'">
            <AdminCategoriesComp />
          </div>
        </v-col>
      </v-row>
    </v-container>
  </v-main>
</template>

<script>
// import { mapState } from "vuex";

export default {

  middleware: 'authAdmin',

  data() {
    return {
      compToDisplay: "users",
    };
  },

  methods: {},

  mounted() {
    this.$nuxt.$on("selectAdminComp", (componentToDisplay) => {
      this.compToDisplay = componentToDisplay;
    });
  },
};
</script>

<style scoped>
.col_data {
  text-align: center;
  border: 2px solid #00479b;
  margin-top: 12px;
  border-radius: 8px;
}
</style>