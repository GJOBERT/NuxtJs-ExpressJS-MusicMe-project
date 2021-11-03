<template>
  <v-row>
    <v-col cols="8" class="mx-auto">
      <v-btn
        @click="$router.push({ name: 'orderhistory' })"
        class="mt-7 back_button"
        color="primary darken-2"
        dark
      >
        <v-icon dark left> mdi-arrow-left </v-icon>Retour
      </v-btn>

      <v-card max-width="450" class="mx-auto my-12">
        <v-toolbar color="cyan" dark @click="getOrder">
          <v-toolbar-title>
            Commande du {{ orders.length ? orderDate : "Date non définie" }}
            <br />
            <span class="text-subtitle-1"
              >(Ref: {{ $route.params.orderid }})</span
            >
          </v-toolbar-title>
        </v-toolbar>
        <v-list two-line>
          <template v-for="(order, index) in orders">
            <v-list-item :key="index">
              <v-list-item-avatar>
                <v-img :src="order.image"></v-img>
              </v-list-item-avatar>

              <v-list-item-content>
                <v-list-item-title
                  v-text="order.quantity + 'x ' + order.title"
                ></v-list-item-title>
                <v-list-item-subtitle
                  v-text="order.artist"
                ></v-list-item-subtitle>
              </v-list-item-content>

              <v-list-item-action>
                <v-list-item-action-text class="text-body-2">
                  {{ order.price * order.quantity }}€
                </v-list-item-action-text>
              </v-list-item-action>
            </v-list-item>
            <v-divider :key="order.title"></v-divider>
          </template>
        </v-list>
        <div class="text-center py-2">
          {{ orderSize }} Articles pour {{ orderCost }} €
        </div>
      </v-card>
    </v-col>
  </v-row>
</template>

<script>
import server from "@/api/host";

export default {
  data() {
    return {
      orders: [],
      monthFr: [
        "Janvier",
        "Février",
        "Mars",
        "Avril",
        "Mai",
        "Juin",
        "Juillet",
        "Août",
        "Septmenbre",
        "Octobre",
        "Novembre",
        "Décembre",
      ],
    };
  },

  computed: {
    orderDate() {
      let date = new Date(this.orders[0].order_date);
      return (
        date.getDate() +
        " " +
        this.monthFr[date.getMonth()] +
        " " +
        date.getFullYear()
      );
    },

    orderSize() {
      let size = 0;
      for (const order of this.orders) {
        size += order.quantity;
      }
      return size;
    },

    orderCost() {
      let cost = 0;
      for (const order of this.orders) {
        cost += order.quantity * order.price;
      }
      return cost;
    },
  },

  methods: {
    async getOrder() {
      const token = this.$store.state.token;

      let response = await fetch(
        "http://" + server + ":3333/api/orders/" + this.$route.params.orderid,
        {
          method: "GET",
          mode: "cors",
          headers: {
            Authorization: "Bearer " + token,
          },
        }
      );

      let result = await response.json();

      if (response.ok) {
        if (result.result[0].client_id == this.$store.state.userId) {
          this.orders = result.result;
        } else {
          const snackMessage =
            "Cette commande n'est pas la votre " + String.fromCodePoint(129300);
          this.$nuxt.$emit("display-snack", {
            color: "error",
            message: snackMessage,
          });
          this.$router.push({ name: "orderhistory" });
        }
      } else {
        const snackMessage =
          "Cette commande n'existe pas " + String.fromCodePoint(129300);
        this.$nuxt.$emit("display-snack", {
          color: "error",
          message: snackMessage,
        });
        this.$router.push({ name: "orderhistory" });
      }
    },
  },

  async beforeMount() {
    this.getOrder();
  },
};
</script>

<style>
</style>