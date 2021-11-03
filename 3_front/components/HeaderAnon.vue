<template>
  <v-app-bar app :elevation="5" color="white">
    <nuxt-link to="/">
      <img
        class="mr-3 image"
        :src="require('../assets/Logo_MusicMe_sans_texte.png')"
        height="40"
      />
    </nuxt-link>

    <v-toolbar-title class="ml-2"
      ><span class="title_M1">M</span>usic<span class="title_M2">M</span>e
    </v-toolbar-title>

    <v-spacer></v-spacer>

    <div>
      <template v-if="cart.length && $route.name != 'connect' && $route.name != 'register' && $route.name != 'cart'">
        <v-badge
          overlap
          color="red"
          :value="cart.length"
          :content="cart.length"
        >
          <v-btn
            class="ma-2"
            outlined
            v-on:click="$router.push({ name: 'cart' })"
          >
            Panier
            <v-icon>mdi-cart-outline</v-icon>
          </v-btn>
        </v-badge>
      </template>
      <nuxt-link to="/Register" class="btn_signup">
        <v-btn outlined text>
          <span class="btn_signup_i">I</span>nscription
        </v-btn>
      </nuxt-link>
      <nuxt-link to="/connect" class="btn_login">
        <v-btn outlined text>
          <span class="btn_login_c">C</span>onnexion
        </v-btn>
      </nuxt-link>
    </div>
  </v-app-bar>
</template>

<script>
import { mapState } from "vuex";

export default {
  name: "HeaderAnon",
  data() {
    return {};
  },

  computed: {
    ...mapState(["cart"]),
  },

  mounted() {},

  methods: {},
};
</script>

<style scoped>
.image {
  margin-right: 10px;
}
.title_M1,
.title_M2,
.btn_signup_i,
.btn_login_c,
.btn_admin_a,
.btn_account_mon {
  color: #0285e7;
}
.btn_admin {
  background-color: rgb(248, 190, 190);
}
.btn_signup,
.btn_login,
.btn_account,
.btn_admin {
  text-decoration: none;
}
</style>