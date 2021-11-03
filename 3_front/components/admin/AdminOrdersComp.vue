<template>
  <div class="main_div">
    <h3 class="title">Liste des commandes</h3>
    <EditOrderForm v-if="displayForm" :idToUpdate='uniq_id'/>
    <v-simple-table>
      <!-- <thead> -->
      <thead>
        <tr>
          <th v-for="(column, index) in columns" :key="index" scope="col">
            {{ column }}
          </th>
        </tr>
      </thead>
      <!-- <thead> -->

      <!-- <tbody> -->
      <OrderLign
        v-for="(order, index) in orders"
        :key="index"
        class="table-line"
        :orderId="order.uniq_id"
      />
      <!-- </tbody> -->
    </v-simple-table>
  </div>
</template>

<script>
import server from '@/api/host';

export default {
  data() {
    return {
      orders: [],
      columns: [
        "ID de la commande",
        "ID du client",
        "Quantité",
        "Etat",
        "Date de commande",
        "Date de récupération prévue",
        "Modifier",
        "Supprimer",
      ],
      displayForm: false,
      uniq_id: ''
    };
  },

  methods: {
    getAllOrders() {
      this.orders = [];
      fetch("http://" + server + ":3333/api/orders/", {
        headers: {
          "Content-Type": "application/json",
          Authorization: "Bearer " + this.$store.state.token,
        },
      })
        .then((response) => response.json())
        .then((data) => {
          this.orders = data.result;
        })
        .catch((error) => {
          console.log(error);
        });
    },

    filterInt(value) {
      if (/^(-|\+)?(\d+|Infinity)$/.test(value)) {
        return Number(value);
      } else {
        return NaN;
      }
    },

    displayEditForm() {
      this.displayForm = !this.displayForm;
    },

    hideEditForm() {
      this.displayForm = false;
    },

    passIdToUpdate(id) {
      this.uniq_id = id;
    }
  },

  mounted() {
    this.getAllOrders();
    this.$nuxt.$on('triggerOrdersDisplay', () => {
      this.getAllOrders();
    })
    this.$nuxt.$on('hideUpdateOrderForm', () => {
      this.hideEditForm();
    })
    this.$nuxt.$on('triggerUpdating', (id) => {
      this.passIdToUpdate(id);
    })
    this.$nuxt.$on('displayEditForm', () => {
      this.displayEditForm();
    });
  },
};
</script>

<style scoped>