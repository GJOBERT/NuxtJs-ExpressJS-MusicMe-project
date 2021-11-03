<template lang="html">
  <v-row>
    <v-col cols="8" class="mx-auto">
	<v-snackbar
	v-model="snackbar"
	top
	app
    >
      {{ text }}

      <template v-slot:action="{ attrs }">
        <v-btn
          color="indigo"
          text
          v-bind="attrs"
          @click="snackbar = false"
        >
          Close
        </v-btn>
      </template>
    </v-snackbar>
		<v-row class="my-4">
			<v-btn
			@click="$router.push({ name: 'index'})"
			class="ma-3 back_button"
			color="primary darken-2"
			dark
			>
					<v-icon
					dark
					left
					>
					mdi-arrow-left
					</v-icon>Retour
			</v-btn>

			<v-btn
			@click="$router.push({name: 'orderhistory'})"
			class="ma-3"
			dark
			>
					<v-icon
					dark
					left
					>
					mdi-clipboard-list-outline
					</v-icon>Mes Commandes
			</v-btn>
		</v-row>

    <h1 class="display-4">Compte</h1>
    <h2 class="display-2 font-weight-light">Informations</h2>

    <div class="info_block">

      <div class="left_side">
		<!-- <img  v-if="image_preview_url" :src="image_preview_url" class="profile_image"> -->
        <img  v-if="image_preview_url" :src="image_preview_url" class="profile_image">
        <img  v-if="!image_preview_url" class="profile_image" :src="current_image_src">
        <v-file-input
          @change="onFileChange"
          accept="image/png, image/jpeg, image/bmp"
          placeholder="Choisissez un fichier"
          prepend-icon="mdi-camera"
          ></v-file-input>
          <v-btn @click="submit_image()" v-if="submit === true">Modifier l'image</v-btn>
      </div>

      <div class="right_side" v-if="modify === false">

        <v-text-field
        :value="firstname"
        label="Prénom"
        disabled
        >``</v-text-field>

        <v-text-field
        :value="lastname"
        label="Nom de famille"
        disabled
        >``</v-text-field>

        <v-text-field
        :value="email"
        label="Email"
        disabled
        >``</v-text-field>

        <v-text-field
        value="*******"
        label="Mot de passe"
        disabled
        >``</v-text-field>

        <v-text-field
        :value="date_display"
        label="Date de naissance"
        disabled
        >``</v-text-field>

        <div class="modify_buttons">
          <v-btn @click="open_modify">Modifier</v-btn>
        </div>

      </div>

      <div class="right_side" v-if="modify === true">

        <v-text-field
        v-model="firstname"
        label="Prénom"
        >``</v-text-field>

        <v-text-field
        v-model="lastname"
        label="Nom de famille"
        >``</v-text-field>

        <v-text-field
        v-model="email"
        label="Email"
        >``</v-text-field>
      
      <div v-if="modify_password === true">
        <v-text-field
        v-model="password"
        label="Mot de passe"
        type="password"
        >``</v-text-field>

        <v-text-field
        v-model="password_confirmation"
        label="Confirmation mot de passe"
        type="password"
        >``</v-text-field>

        <p class="error_message" v-if="wrong_conf === true">Le mot de passe et la confirmation doivent être identique</p>
      </div>

      <div v-if="modify_password === false">
        <v-text-field
        v-model="password"
        label="Mot de passe"
        type="password"
        disabled
        >``</v-text-field>

        <v-text-field
        v-model="password_confirmation"
        label="Confirmation mot de passe"
        type="password"
        disabled
        >``</v-text-field>

        <div class="modify_buttons">
          <v-btn @click="modify_password = true" small>Modifier le mot de passe</v-btn>
        </div>

      </div>

		<v-menu
          v-model="menu2"
          :close-on-content-click="false"
          transition="scale-transition"
          offset-y
          max-width="290px"
          min-width="auto"
        >
          <template v-slot:activator="{ on, attrs }">
            <v-text-field
              v-model="computedDateFormatted"
              label="Date de naissance"
              hint="DD/MM/YYYY format"
              persistent-hint
              prepend-icon="mdi-calendar"
              readonly
              v-bind="attrs"
              v-on="on"
            ></v-text-field>
          </template>
          <v-date-picker
            v-model="new_birthday"
            no-title
            @input="menu2 = false"
          ></v-date-picker>
        </v-menu>

        <div class="modify_buttons">
          <v-btn @click="updateUser()" color="green">Enregistrer</v-btn>
          <v-btn @click="close_modify()">Annuler</v-btn>
        </div>

      </div>
    </div>
    </v-col>
  </v-row>
</template>

<script>
import { mapState } from "vuex";
import gabrielServices from "../api/gabrielServices";
import server from "@/api/host";

export default {
  name: "UserDetails",
  data() {
    return {
      modify: false,
      password: "*******",
      password_confirmation: "*******",
      modify_password: false,
      wrong_conf: false,
      firstname: "",
      lastname: "",
      email: "",
      new_birthday: "",
      user_edit: {},
      current_image_src: "",
      image_preview_url: "",
      submit: false,
      menu2: false,
      date_display: "",
      dateFormatted: this.formatDate(new Date().toISOString().substr(0, 10)),
      snackbar: false,
      text: "Profil modifié",
      timeout: 5000,
    };
  },
  methods: {
    close_modify() {
      this.modify = false;
      this.modify_password = false;
      this.password = "*******";
      this.password_confirmation = "*******";
      this.getUser();
    },
    open_modify() {
      this.modify = true;
    },
    async updateUser() {
      if (this.password === this.password_confirmation) {
        var new_password = "";
        if (this.password === "*******") {
          new_password = this.user_edit.password;
        } else {
          new_password = this.password;
        }
        var avatar_update = await this.image_replacer();
        var update_user = {
          token_id: this.userId,
          password: new_password,
          firstname: this.firstname,
          lastname: this.lastname,
          email: this.email,
          birthday: this.new_birthday,
          avatar: avatar_update,
          isAdmin: this.user_edit.isAdmin,
        };
        update_user = JSON.stringify(update_user);

        gabrielServices
          .updateUser(this.userId, update_user, this.token)
          .then(() => {
            this.snackbar = true;
            this.close_modify();
            this.getUser();
          })
          .catch((err) => console.log("Update error:" + err));
      } else {
        this.wrong_conf = true;
      }
    },
    getUser() {
      this.new_birthday = this.new_birthday.substring(0, 10);

      gabrielServices
        .getUser(this.userId, this.token)
        .then((response) => {
          this.user_edit = response[0];
          this.firstname = this.user_edit.firstname;
          this.lastname = this.user_edit.lastname;
          this.email = this.user_edit.email;
          if (this.user_edit.avatar !== null) {
            this.image_preview_url = Buffer.from(this.user_edit.avatar);
          }
        })
        .catch((err) => console.log(err));
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

    handlePasswordChange() {
      this.target_user.password = this.new_password;
    },

    async submit_image() {
      delete this.user_edit["id"];
      this.user_edit.birthday = this.user_edit.birthday.substring(0, 10);
      this.user_edit.avatar = await this.image_replacer();
      var user_up = JSON.stringify(this.user_edit);
      gabrielServices
        .updateUser(this.userId, user_up, this.token)
        .then(() => {
          this.getUser();
		  this.$store.commit('setAvatar', this.user_edit.avatar);
          this.submit = false;
          this.snackbar = true;
        })
        .catch((err) => console.log(err));
    },

    async onFileChange(e) {
      const file = e;

      const reader = new FileReader();
      if (file instanceof Object) {
        reader.readAsDataURL(file);
        reader.onload = () => (this.user_edit.avatar = reader.result);
        this.image_preview_url = URL.createObjectURL(file);
        this.user_edit.avatar = await this.image_replacer();
        this.submit = true;
      } else {
        this.submit = false;
        this.getUser();
      }
    },

    formatDate(date) {
      if (!date) return null;

      const [year, month, day] = date.split("-");
      return `${day}/${month}/${year}`;
    },
    parseDate(date) {
      if (!date) return null;

      const [day, month, year] = date.split("/");
      return `${year}-${month.padStart(2, "0")}-${day.padStart(2, "0")}`;
    },
  },
  computed: {
    ...mapState(["token", "isLoggedIn", "userId"]),
    computedDateFormatted() {
      return this.formatDate(this.new_birthday);
    },
  },
  watch: {
    new_birthday(val) {
      this.dateFormatted = this.formatDate(this.new_birthday);
    },
  },

  async beforeMount() {
    const userId = this.$store.state.userId;
    const token = this.$store.state.token;
    const response = await fetch("http://" + server + ":3333/api/user/" + userId, {
      method: "GET",
      mode: "cors",
      headers: {
        Authorization: "Bearer " + token,
      },
    });

    const result = await response.json();
    const user = result.result[0];
    this.user_edit = result.result[0];

    this.firstname = user.firstname;
    this.lastname = user.lastname;
    this.email = user.email;
    if (this.user_edit.avatar !== null) {
      this.image_preview_url = Buffer.from(this.user_edit.avatar);
    }
    this.new_birthday = user.birthday.slice(0, 10);
    const [year, month, day] = user.birthday.slice(0, 10).split("-");
    this.date_display = `${day}/${month}/${year}`;

    console.log(user);
  },
};
</script>

<style scoped>
.error_message {
  font-family: "Raleway", sans-serif;
  font-weight: 300;
  font-size: 1rem;
  color: rgb(204, 21, 21);
}

.modify_buttons {
  display: flex;
  width: 50%;
}

.main_container {
  width: 80%;
  margin-left: auto;
  margin-right: auto;
  display: flex;
  flex-direction: column;
}

.info_block {
  margin-top: 20px;
  display: flex;
  flex-direction: row;
  justify-content: space-between;
}

.left_side {
  flex-basis: 30%;
  display: flex;
  flex-direction: column;
  justify-content: flex-start;
}

.right_side {
  flex-basis: 50%;
  display: flex;
  flex-direction: column;
  justify-content: space-between;
  height: 60%;
}

.profile_image {
  width: 400px;
  height: 400px;
  background-color: black;
  object-fit: cover;
  border-radius: 9999px;
}

@font-face {
  font-family: "Raleway", "sans-serif";
  src: url("https://fonts.googleapis.com/css2?family=Raleway:wght@300;400;500;600&display=swap")
    format("truetype");
}
</style>