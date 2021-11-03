<template>
  <v-form>
    <v-container>
      <v-row>
        <v-col cols="1" md="4">
          <v-text-field
            v-model="quantity"
            :rules="quantityRule"
            label="Quantité"
            type="number"
            required
          ></v-text-field>
        </v-col>

        <v-col cols="1" md="4">
          <v-select
            v-model="is_delivered"
            :items="items"
            label="Statut"
          ></v-select>
        </v-col>

        <v-col cols="1" md="4">
          <v-text-field
            v-model="deliver_date"
            :rules="deliverDateRule"
            label="Date de récupération"
            type="date"
            required
          ></v-text-field>
        </v-col>
      </v-row>
    </v-container>
    <v-btn
      color="green"
      class="mr-4"
      :disabled="deliver_date === '' || is_delivered === '' || quantity === ''"
      @click="validateModifications(idToUpdate)"
    >
      Enregistrer les modifications
    </v-btn>
  </v-form>
</template>

<script>
import { mapState } from "vuex";
import * as moment from "moment";
import "moment/locale/pt-br";
import server from '@/api/host';

export default {
  data() {
    return {
      client_id: "",
      deliver_date: "",
      is_delivered: "",
      quantity: "",
      uniq_id: "",
      items: ["En attente", "Récupérée"],
      orderToUpdate: [],
      deliverDateRule: [(v) => !!v || "Champ requis"],
      quantityRule: [(v) => !!v || "Champ requis"],
      isDeliveredRule: [(v) => !!v || "Champ requis"],
    };
  },

  props: {
    idToUpdate: String,
  },

  methods: {
    validateModifications(id) {
      if (this.is_delivered === "Récupérée") {
        this.is_delivered = 1;
      } else {
        this.is_delivered = 0;
      }

      var updatedOrder = {
        deliver_date: this.deliver_date,
        is_delivered: this.is_delivered,
        quantity: this.quantity,
      };

      console.log(updatedOrder);

      updatedOrder = JSON.stringify(updatedOrder);

      fetch("http://" + server + ":3333/api/orders/" + id, {
        method: "PUT",
        mode: "cors",
        headers: {
          "Content-Type": "application/json",
          Authorization: "Bearer " + this.token,
        },
        body: updatedOrder,
      })
        .then((response) => response.json())
        .then(() => {
          this.$nuxt.$emit("hideUpdateOrderForm");
          this.$nuxt.$emit('triggerOrdersDisplay');
        })
        .catch((error) => {
          console.log(error);
        });

      this.$nuxt.$emit("triggerLignRefresh");
    },

    getOrders(uniq_id) {
      this.orderToUpdate = [];
      fetch("http://" + server + ":3333/api/orders/" + uniq_id, {
        method: "GET",
        mode: "cors",
        headers: {
          "Content-Type": "application/json",
          Authorization: "Bearer " + this.token,
        },
      })
        .then((response) => response.json())
        .then((data) => {
          this.orderToUpdate = data.result[0];
          this.quantity = this.orderToUpdate.quantity;
          this.deliver_date = moment(this.orderToUpdate.deliver_date).format(
            "yyyy-MM-DD"
          );
          if (this.orderToUpdate.is_delivered === 1) {
            this.is_delivered = "Récupérée";
          } else {
            this.is_delivered = "En attente"
          }
        })
        .catch((error) => {
          console.log(error);
        });
    },
  },

  mounted() {
    this.uniq_id = this.$props.idToUpdate;
    this.getOrders(this.uniq_id);
  },

  computed: {
    ...mapState(["token"]),
  },
};
</script>

<style scoped>
</style>