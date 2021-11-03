<template>
  <tbody>
    <tr>
      <td>{{ order.uniq_id }}</td>
      <td>{{ order.client_id }}</td>
      <td>{{ order.quantity }}</td>
      <td v-if="order.is_delivered === 1">
        <div class="isDelivered">Récupérée</div>
      </td>
      <td v-else><div class="isNotDelivered">En attente</div></td>
      <td>{{ this.order_date }}</td>
      <td>{{ this.deliver_date }}</td>
      <td @click="updateOrder(order.uniq_id, order.firstname, order.lastname)">
        <svg style="width: 24px; height: 24px" viewBox="0 0 24 24">
          <path
            fill="currentColor"
            d="M20.71,7.04C21.1,6.65 21.1,6 20.71,5.63L18.37,3.29C18,2.9 17.35,2.9 16.96,3.29L15.12,5.12L18.87,8.87M3,17.25V21H6.75L17.81,9.93L14.06,6.18L3,17.25Z"
          />
        </svg>
      </td>
      <td @click="deleteOrder(order.uniq_id, order.client_id)">
        <svg style="width: 24px; height: 24px" viewBox="0 0 24 24">
          <path
            fill="currentColor"
            d="M6,19A2,2 0 0,0 8,21H16A2,2 0 0,0 18,19V7H6V19M8.46,11.88L9.87,10.47L12,12.59L14.12,10.47L15.53,11.88L13.41,14L15.53,16.12L14.12,17.53L12,15.41L9.88,17.53L8.47,16.12L10.59,14L8.46,11.88M15.5,4L14.5,3H9.5L8.5,4H5V6H19V4H15.5Z"
          />
        </svg>
      </td>
    </tr>
  </tbody>
</template>

<script>
import hugoServices from "@/api/hugoServices";
import { mapState } from "vuex";
import * as moment from "moment";
import "moment/locale/pt-br";
import server from '@/api/host';

export default {
  data() {
    return {
      firstname: "",
      lastname: "",
      order: [],
      order_date: "",
      deliver_date: "",
    };
  },

  props: {
    orderId: String,
  },

  methods: {
    getOrdertById(uniq_id) {
      fetch("http://"+ server + ":3333/api/orders/" + uniq_id, {
        method: "GET",
        mode: "cors",
        headers: {
          "Content-Type": "application/json",
          Authorization: "Bearer " + this.token,
        },
      })
        .then((response) => response.json())
        .then((data) => {
          this.order = data.result[0];
          this.order_date = moment(this.order.order_date).format(
            "DD/MM/yyyy à hh:mm"
          );
          this.deliver_date = moment(this.order.deliver_date).format(
            "DD/MM/yyyy"
          );
        })
        .catch((error) => {
          console.log(error);
        });
    },

    deleteOrder(id, client_id) {
      let confirmation = confirm(
        'Êtes-vous sûr de vouloir supprimer la commande de "' +
          client_id +
          '" ?'
      );
      if (confirmation) {
        fetch("http://" + server + ":3333/api/orders/" + id, {
          method: "DELETE",
          mode: "cors",
          headers: {
            "Content-Type": "application/json;",
            Authorization: "Bearer " + this.token,
          },
        })
          .then(() => {
            this.$nuxt.$emit("triggerOrdersDisplay");
          })
          .catch((error) => {
            console.log(error);
          });
      }
    },

    openEditForm() {
      this.displayEditForm = true;
    },

    updateOrder(uniq_id, userFirstname, userLastname) {
      let confirmation = confirm(
        "Êtes-vous sûr de vouloir modifier la commande " +
          uniq_id +
          " " +
          'de "' +
          userFirstname +
          " " +
          userLastname +
          '" ?'
      );
      if (confirmation) {
        this.$nuxt.$emit("triggerUpdating", uniq_id);
        this.$nuxt.$emit("displayEditForm");
      }
    },
  },

  mounted() {
    moment.locale("fr");
    this.getOrdertById(this.$props.orderId, this.$store.state.token);
  },

  computed: {
    ...mapState(["token"]),
  },
};
</script>

<style scoped>
td {
  text-align: left;
}
.isDelivered {
  background-color: rgb(159, 241, 159);
}
.isNotDelivered {
  background-color: rgb(241, 159, 159);
}
</style>