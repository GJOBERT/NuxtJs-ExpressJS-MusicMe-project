<template>
  <v-row>
    <v-col cols="8" class="mx-auto">
      <v-btn
        @click="$router.push({ name: 'userdetails' })"
        class="mt-7 back_button"
        color="primary darken-2"
        dark
      >
        <v-icon dark left> mdi-arrow-left </v-icon>Retour
      </v-btn>

      <v-card max-width="450" class="mx-auto mt-12">
        <v-toolbar color="cyan" dark>
          <v-toolbar-title>Historiques des commandes</v-toolbar-title>
        </v-toolbar>
        <v-list two-line>
          <v-list-item v-if="orders.length == 0">
            <v-list-item-avatar>
              <v-icon>mdi-emoticon-sad-outline</v-icon>
            </v-list-item-avatar>
            <v-list-item-title
              v-text="'Vous n\'avez pas encore commandé chez nous ...'"
            ></v-list-item-title>
          </v-list-item>
          <template v-for="(order, index) in orders">
            <v-list-item
              :key="index"
              @click="$router.push('orderdetails/' + order.uniq_id)"
            >
              <v-list-item-content>
                <v-list-item-title
                  v-text="
                    'Commande n°' +
                    order.uniq_id +
                    ' (' +
                    order.order_date +
                    ')'
                  "
                ></v-list-item-title>
                <v-list-item-subtitle
                  v-text="order.size + ' articles pour ' + order.cost + '€'"
                ></v-list-item-subtitle>
              </v-list-item-content>
            </v-list-item>
            <v-divider :key="order.uniq_id"></v-divider>
          </template>
        </v-list>
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
    };
  },

  methods: {
    async getOrders() {
      if (!this.$store.state.isLoggedIn) {return}
      const userId = this.$store.state.userId;
      const token = this.$store.state.token;

      let response = await fetch(
        "http://" + server + ":3333/api/user/getorders/" + userId,
        {
          method: "GET",
          mode: "cors",
          headers: {
            Authorization: "Bearer " + token,
          },
        }
      );
    
      if (!response.ok) {return}

      let results = await response.json();

      for (const result of results.result) {
        if (this.orders.length == 0) {
          this.orders.push({
            uniq_id: result.uniq_id,
            size: result.quantity,
            cost: result.quantity * result.price,
            is_delivered: result.is_delivered,
            order_date: result.order_date.slice(0, 10),
          });
        } else {
          let index = this.orders.findIndex((order, index, self) => {
            if (result.uniq_id == order.uniq_id) {
              order.size += result.quantity;
              order.cost += result.quantity * result.price;
              return true;
            }
          });

          if (index == -1) {
            this.orders.push({
              uniq_id: result.uniq_id,
              size: result.quantity,
              cost: result.quantity * result.price,
              is_delivered: result.is_delivered,
              order_date: result.order_date.slice(0, 10),
            });
          }
        }
      }
    },
  },
  async beforeMount() {
    this.getOrders();
  },
};
</script>

<style>
</style>