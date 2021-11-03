<template>
  <tbody>
    <tr>
      <td>{{ user.firstname }}</td>
      <td>{{ user.lastname }}</td>
      <td>{{ user.email }}</td>
      <td>{{ birthday }}</td>
      <td>
        <v-avatar v-if="image_url !== null"><img :src="image_url" /></v-avatar>
        <v-avatar v-else
          ><svg style="width: 45px; height: 45px" viewBox="0 0 24 24">
            <path
              fill="currentColor"
              d="M12,19.2C9.5,19.2 7.29,17.92 6,16C6.03,14 10,12.9 12,12.9C14,12.9 17.97,14 18,16C16.71,17.92 14.5,19.2 12,19.2M12,5A3,3 0 0,1 15,8A3,3 0 0,1 12,11A3,3 0 0,1 9,8A3,3 0 0,1 12,5M12,2A10,10 0 0,0 2,12A10,10 0 0,0 12,22A10,10 0 0,0 22,12C22,6.47 17.5,2 12,2Z"
            /></svg
        ></v-avatar>
      </td>
      <td v-if="user.isAdmin === 1">Oui</td>
      <td v-else>Non</td>
      <td @click="updateUser(user.token_id, user.firstname, user.lastname)">
        <svg style="width: 24px; height: 24px" viewBox="0 0 24 24">
          <path
            fill="currentColor"
            d="M20.71,7.04C21.1,6.65 21.1,6 20.71,5.63L18.37,3.29C18,2.9 17.35,2.9 16.96,3.29L15.12,5.12L18.87,8.87M3,17.25V21H6.75L17.81,9.93L14.06,6.18L3,17.25Z"
          />
        </svg>
      </td>
      <td @click="deleteUser(user.token_id, user.firstname, user.lastname)">
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
      user: [],
      image_url: "",
      birthday: "",
    };
  },

  props: {
    userId: String,
  },

  methods: {
    getUserById(token_id) {
      this.image_url = "";
      fetch("http://" + server + ":3333/api/user/" + token_id, {
        method: "GET",
        mode: "cors",
        headers: {
          "Content-Type": "application/json",
          Authorization: "Bearer " + this.token,
        },
      })
        .then((response) => response.json())
        .then((data) => {
          this.user = data.result[0];
          this.birthday = moment(this.user.birthday).format("DD/MM/YYYY");
          if (this.user.avatar !== null && this.user.avatar !== undefined) {
			  if (this.user.avatar.data.length !== 4) {
            	this.image_url = Buffer.from(this.user.avatar);
			  }
          } else {
            this.image_url = null;
          }
        })
        .catch((error) => {
          console.log(error);
        });
    },

    deleteUser(id, firstname, lastname) {
      let confirmation = confirm(
        "Êtes-vous sûr de vouloir supprimer l'" +
          "utilisateur " +
          firstname +
          " " +
          lastname +
          " ?"
      );
      if (confirmation) {
        fetch("http://" + server + ":3333/api/user/" + id, {
          method: "DELETE",
          mode: "cors",
          headers: {
            "Content-Type": "application/json;",
            Authorization: "Bearer " + this.$store.state.token,
          },
        })
          .then(() => {
            this.$nuxt.$emit("triggerUsersDisplay");
          })
          .catch((error) => {
            console.log(error);
          });
      }
    },

    updateUser(token_id, firstname, lastname) {
      let confirmation = confirm(
        "Êtes-vous sûr de vouloir modifier l'" +
          "utilisateur " +
          firstname +
          " " +
          lastname +
          " ?"
      );
      if (confirmation) {
        this.$nuxt.$emit("emitIdForUpdating", token_id);
        this.$nuxt.$emit("displayUserEditForm");
      }
    },
  },

  mounted() {
    moment.locale("fr");
    this.getUserById(this.$props.userId, this.$store.state.token);
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
</style>