<template>
  <div class="main_div">
    <h3 class="title">Liste des utilisateurs</h3>
    <v-btn class="add_button" @click="addUserForm"
      >+ Ajouter un utilisateur</v-btn
    >
    <AddUserForm v-if="isAddUserForm" :idToUpdate="token_id" />
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
      <UserLign
        v-for="(user, index) in users"
        :key="index"
        class="table-line"
        :userId="user.token_id"
      />
      <!-- </tbody> -->
    </v-simple-table>
  </div>
</template>

<script>
import server from '@/api/host';
import { mapState } from "vuex";

export default {
  data() {
    return {
      users: [],
      columns: [
        "Prénom",
        "Nom",
        "Email",
        "Date de naissance",
        "Avatar",
        "Admin",
        "Modifier",
        "Supprimer",
      ],
      isAddUserForm: false,
      token_id: null
    };
  },

  methods: {
    addUserForm() {
      this.isAddUserForm = !this.isAddUserForm;
    },

    closeAddUserForm() {
      this.isAddUserForm = false;
    },

    getUsers() {
      this.users = [];
      fetch("http://" + server + ":3333/api/user", {
        method: "GET",
        mode: "cors",
        headers: {
          "Content-Type": "application/json",
          Authorization: "Bearer " + this.token,
        },
      })
        .then((response) => response.json())
        .then((data) => {
          this.users = data.users;
        })
        .catch((error) => {
          console.log(error);
        });
    },

    passIdToForm(token_id) {
      this.token_id = token_id;
    },

    filterInt(value) {
      if (/^(-|\+)?(\d+|Infinity)$/.test(value)) {
        return Number(value);
      } else {
        return NaN;
      }
    },
  },

  created() {
    console.log(this.token_id)
    this.$nuxt.$on("btnEditUserDisplay", () => {
      this.token_id = null;
    });
  },

  mounted() {
    this.getUsers();
    this.$nuxt.$on("triggerUsersDisplay", () => {
      this.getUsers();
    });
    this.$nuxt.$on("hideAddUserForm", () => {
      this.closeAddUserForm();
    });
    this.$nuxt.$on("displayUserEditForm", () => {
      this.addUserForm();
    });
    this.$nuxt.$on("emitIdForUpdating", (token_id) => {
      this.passIdToForm(token_id);
    });
  },

  computed: {
    ...mapState(["token"]),
  },
};
</script>

<style scoped>
.add_button {
  margin: 10px 0;
}
</style>