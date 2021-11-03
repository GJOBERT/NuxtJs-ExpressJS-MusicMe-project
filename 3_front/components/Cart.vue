<template>
  <v-row>
    <v-col cols="8" class="mx-auto">
      <v-btn
        @click="$router.go(-1)"
        class="mt-7 back_button"
        color="primary darken-2"
        dark
      >
        <v-icon dark left> mdi-arrow-left </v-icon>Retour
      </v-btn>

      <v-card max-width="450" class="mx-auto">
        <v-toolbar color="cyan" dark>
          <v-toolbar-title>Mon Panier</v-toolbar-title>
          <v-spacer></v-spacer>
          <v-btn icon @click="unsetCart">
            <v-icon>mdi-delete</v-icon>
          </v-btn>
        </v-toolbar>

        <v-list two-line>
          <template v-for="(product, index) in cart">
            <v-list-item :key="index">
              <v-list-item-avatar>
                <v-img :src="require('@/assets/example.png')"></v-img>
              </v-list-item-avatar>

              <v-list-item-content>
                <v-list-item-title v-text="product.title"> </v-list-item-title>
                <v-list-item-subtitle v-text="product.artist">
                </v-list-item-subtitle>
              </v-list-item-content>

              <v-list-item-action>
                <v-list-item-action-text
                  v-text="
                    product.quantity +
                    ' x ' +
                    product.price +
                    '€= ' +
                    product.price * product.quantity +
                    '€'
                  "
                ></v-list-item-action-text>
                <v-list-item-action-text>
                  <v-btn
                    v-if="product.quantity > 1"
                    icon
                    x-small
                    @click="decrementProduct(product.id)"
                  >
                    <v-icon>mdi-minus</v-icon>
                  </v-btn>
                  <v-btn icon x-small @click="removeProduct(product.id)">
                    <v-icon>mdi-delete</v-icon>
                  </v-btn>
                  <v-btn icon x-small @click="incrementProduct(product.id)">
                    <v-icon>mdi-plus</v-icon>
                  </v-btn>
                </v-list-item-action-text>
              </v-list-item-action>
            </v-list-item>
            <v-divider :key="'div ' + index"></v-divider>
          </template>
          <v-list-item>
            <v-list-item-avatar></v-list-item-avatar>
            <v-list-item-content>
              <v-list-item-title inset v-text="'Total'"></v-list-item-title>
            </v-list-item-content>

            <v-list-item-action>
              <v-list-item-action-text
                v-text="cartSize + ' Articles'"
              ></v-list-item-action-text>
              <v-list-item-action-text
                v-text="cartCost + ' €'"
              ></v-list-item-action-text>
            </v-list-item-action>
          </v-list-item>
        </v-list>
        <v-row justify="center">
          <v-col cols="11">
            <v-btn :disabled="!!!cart.length" color="success" x-large block @click="confirmOrder"> Confirmer </v-btn>
          </v-col>
        </v-row>
      </v-card>
    </v-col>
  </v-row>
</template>

<script>
import server from "@/api/host";
import { mapState } from 'vuex';

export default {
  data() {
    return {
      
    };
  },

  computed: {
    ...mapState(["cart"]),

    cartSize() {
      let size = 0;
      for (const product of this.cart) {
        size += product.quantity;
      }
      return size;
    },

    cartCost() {
      let cost = 0;
      for (const product of this.cart) {
        cost += product.quantity * product.price;
      }
      return cost;
    },
  },

  methods: {

    incrementProduct(productId) {
      this.$store.commit("incrementProduct", productId);
    },

    decrementProduct(productId) {
      this.$store.commit("decrementProduct", productId);
    },

    removeProduct(productId) {
      this.$store.commit("removeProduct", productId);
    },

    unsetCart() {
      this.$store.commit("unsetCart");
    },

    async confirmOrder() {

      if (!this.$store.state.isLoggedIn) {
        const snackMessage = "Connectez-vous pour valider votre panier"
        this.$nuxt.$emit('display-snack', { color: "error", message: snackMessage})
        this.$router.push({ name: 'connect'})
        return
      }

      if (!this.cart.length) {
        const snackMessage = "Votre panier est vide ... "
        this.$nuxt.$emit('display-snack', { color: "primary", message: snackMessage})
        return
      }

      const uuidv4 = require("uuid");
      const uniq_id = uuidv4.v4().substr(0, 18);
      const token = this.$store.state.token;
      const client_id = this.$store.state.userId;
      const order_date = new Date().toISOString().slice(0, 10);
      let deliver_date = new Date(order_date);
      deliver_date.setDate(deliver_date.getDate() + 14);
      deliver_date = deliver_date.toISOString().slice(0, 10);

      let newOrder = {
        uniq_id,
        client_id,
        order_date,
        deliver_date,
      };

      for (const product of this.cart) {
        newOrder.product_id = product.id;
        newOrder.quantity = product.quantity;
        let response = await fetch("http://" + server + ":3333/api/orders", {
          method: "POST",
          mode: "cors",
          headers: {
            Authorization: "Bearer " + token,
            "Content-Type": "application/json",
          },
          body: JSON.stringify(newOrder),
        });

        let result = await response.json();
      }

      this.$router.push({ name: "confirmed" });
    },
  },

  beforeMount() {
  },
};
</script>

<style>
</style>