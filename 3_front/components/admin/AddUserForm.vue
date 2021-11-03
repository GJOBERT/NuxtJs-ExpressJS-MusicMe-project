<template>
  <v-form>
    <v-container>
      <v-row>
        <v-col cols="2" md="2">
          <v-text-field
            v-model="firstname"
            :rules="firstNameRule"
            :counter="255"
            label="Prénom"
            required
          ></v-text-field>
        </v-col>

        <v-col cols="1" md="2">
          <v-text-field
            v-model="lastname"
            :rules="lastnameRule"
            :counter="255"
            label="Nom"
            required
          ></v-text-field>
        </v-col>

        <v-col cols="1" md="2">
          <v-text-field
            v-model="password"
            :rules="passwordRule"
            :counter="255"
            label="Mot de passe"
            type="password"
            required
          ></v-text-field>
        </v-col>

        <v-col cols="4" md="3">
          <v-text-field
            :rules="emailRule"
            :counter="255"
            v-model="email"
            label="Email"
            type="email"
            required
          ></v-text-field>
        </v-col>

        <v-col cols="1" md="2">
          <v-text-field
            :rules="birtdayRule"
            v-model="birthday"
            label="Date de naissance"
            type="date"
            required
          ></v-text-field>
        </v-col>

        <v-col cols="1" md="3">
          <v-file-input
            @change="onFileChange"
            accept="image/png, image/jpeg, image/bmp"
            placeholder="Avatar : choisissez un fichier"
            prepend-icon="mdi-camera"
          ></v-file-input>
        </v-col>

        <v-col cols="1" md="4">
          <v-checkbox
            @click="setAdminRole"
            label="Définir l'utilisateur en tant qu'administrateur"
          ></v-checkbox>
        </v-col>
      </v-row>
    </v-container>
    <v-btn
      v-if="!isUpdated"
      color="green"
      class="btn_add"
      :key="isUpdated"
      @click="addUser"
      :disabled="!firstname || !lastname || !password || !email || !birthday"
    >
      Ajouter l'utilisateur
    </v-btn>
    <v-btn
      v-else
      color="green"
      class="btn_modify"
      @click="updateUser(token_id)"
      :disabled="!firstname || !lastname || !password || !email || !birthday"
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
      firstname: "",
      lastname: "",
      password: "",
      email: "",
      birthday: null,
      avatar: null,
      isUpdated: false,
      token_id: "",
      isAdmin: 0,
      userToUpdate: [],
      image_preview_url: "",
      firstNameRule: [
        (v) => !!v || "Champ requis",
        (v) =>
          v.length <= 255 || "Le prénom ne doit pas dépasser 255 caractères.",
      ],
      lastnameRule: [
        (v) => !!v || "Champ requis",
        (v) => v.length <= 255 || "Le nom ne doit pas dépasser 255 caractères.",
      ],
      passwordRule: [
        (v) => !!v || "Champ requis",
        (v) =>
          v.length <= 255 ||
          "Le mot de passe ne doit pas dépasser 255 caractères.",
      ],
      emailRule: [
        (v) => !!v || "Champ requis",
        (v) =>
          v.length <= 255 || "L'email ne doit pas dépasser 255 caractères.",
      ],
      birtdayRule: [(v) => !!v || "Champ requis"],
    };
  },

  props: {
    idToUpdate: String,
  },

  methods: {
    setAdminRole() {
      if (this.isAdmin === 0) {
        this.isAdmin = 1;
      } else {
        this.isAdmin = 0;
      }
    },

    addUser() {
      if (this.avatar !== null) {
        var newUser = {
          firstname: this.firstname,
          lastname: this.lastname,
          password: this.password,
          email: this.email,
          birthday: this.birthday,
          avatar: this.avatar,
          isAdmin: this.isAdmin,
        };
      } else {
      }

      console.log(newUser);

      newUser = JSON.stringify(newUser);

      fetch("http://" + server + ":3333/api/user/signupadmin", {
        method: "POST",
        mode: "cors",
        headers: {
          "Content-Type": "application/json",
          Authorization: "Bearer " + this.token,
        },
        body: newUser,
      })
        .then((response) => response.json())
        .then(() => {
          this.$nuxt.$emit("triggerUsersDisplay");
          this.$nuxt.$emit("hideAddUserForm");
          this.$store.commit("setIsAdmin", 0);
        })
        .catch((error) => {
          console.log(error);
        });
    },

    updateUser(token_id) {
      this.isUpdated = false;

      var updatedUser = {
        firstname: this.firstname,
        lastname: this.lastname,
        birthday: this.birthday,
        email: this.email,
        password: this.password,
        avatar: this.avatar,
        isAdmin: this.isAdmin,
      };

      console.log(updatedUser);

      updatedUser = JSON.stringify(updatedUser);

      fetch("http://" + server + ":3333/api/user/" + token_id, {
        method: "PUT",
        mode: "cors",
        headers: {
          "Content-Type": "application/json",
          Authorization: "Bearer " + this.token,
        },
        body: updatedUser,
      })
        .then((response) => response.json())
        .then(() => {
          this.$nuxt.$emit("hideAddUserForm");
          this.$nuxt.$emit("triggerUsersDisplay");
          this.$nuxt.$emit("btnEditUserDisplay");
          this.$store.commit("setIsAdmin", 0);
        })
        .catch((error) => {
          console.log(error);
        });
    },

    getUser(token_id) {
      this.userToUpdate = [];
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
          this.userToUpdate = data.result[0];
          this.firstname = this.userToUpdate.firstname;
          this.lastname = this.userToUpdate.lastname;
          this.email = this.userToUpdate.email;
          this.password = this.userToUpdate.password;
          this.birthday = moment(this.userToUpdate.birthday).format(
            "yyyy-MM-DD"
          );
        })
        .catch((error) => {
          console.log(error);
        });
    },

    async onFileChange(e) {
      const file = e;
      const reader = new FileReader();
      if (file instanceof Object) {
        reader.readAsDataURL(file);
        reader.onload = () => (this.avatar = reader.result);
        this.image_preview_url = URL.createObjectURL(file);
        this.avatar = await this.image_replacer();
      } else {
        console.log("Image issue");
      }
    },

    async image_replacer() {
      const response = await fetch(this.image_preview_url);
      const blob = await response.blob();
      const reader = new FileReader();
      await new Promise((resolve, reject) => {
        reader.onload = resolve;
        reader.onerror = reject;
        reader.readAsDataURL(blob);
      });
      return reader.result.toString();
    },
  },

  mounted() {
    this.$nuxt.$on("hideUpdateUserBtn", () => {
      this.isUpdated = false;
      console.log(this.isUpdated);
    });
    if (isNaN(this.$props.idToUpdate) || this.$props.idToUpdate === null) {
      this.isUpdated = false;
    } else {
      this.isUpdated = true;
      this.token_id = this.$props.idToUpdate;
      this.getUser(this.$props.idToUpdate);
    }
  },

  computed: {
    ...mapState(["token"]),
  },
};
</script>

<style scoped>
</style>