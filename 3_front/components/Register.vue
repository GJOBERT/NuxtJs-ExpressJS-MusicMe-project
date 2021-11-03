<template>
  <v-card max-width="450" class="rounded-lg elevation-4 my-12 mx-auto">
    <v-card-title> INSCRIPTION </v-card-title>
    <v-card-subtitle class="red--text" v-if="errorMessage">
      {{ errorMessage }}
    </v-card-subtitle>

    <v-form v-model="valid" ref="form">
      <v-row justify="center" dense>
        <v-col cols="10">
          <v-text-field
            v-model="firstname"
            :rules="[notEmptyRules]"
            label="Prénom"
            required
            outlined
          ></v-text-field>
        </v-col>

        <v-col cols="10">
          <v-text-field
            v-model="lastname"
            :rules="[notEmptyRules]"
            label="Nom"
            required
            outlined
          ></v-text-field>
        </v-col>

        <v-col cols="10">
          <v-text-field
            v-model="email"
            :rules="[notEmptyRules, validEmailRules]"
            label="Adresse email"
            required
            outlined
          ></v-text-field>
        </v-col>
        <v-col cols="10">
          <v-text-field
            v-model="password"
            :rules="[notEmptyRules, minLengthRules]" 
            @input='checkValidation'
            type="password"
            label="Mot de passe"
            required
            counter
            outlined
          ></v-text-field>
        </v-col>
        <v-col cols="10">
          <v-text-field
            v-model="passwordConfirm"
            :rules="[notEmptyRules, samePasswordRules]"
            type="password"
            label="Confirmation mot de passe"
            required
            outlined
          ></v-text-field>
        </v-col>

        <v-col cols="10">
          <v-menu
            ref="menu"
            v-model="menu"
            :close-on-content-click="false"
            transition="scale-transition"
            offset-y
            min-width="auto"
          >
            <template v-slot:activator="{ on, attrs }">
              <v-text-field
                v-model="date"
                label="Date d'anniversaire"
                prepend-icon="mdi-calendar"
                readonly
                required
                outlined
                v-bind="attrs"
                v-on="on"
              ></v-text-field>
            </template>
            <v-date-picker
              ref="picker"
              locale="fr"
              first-day-of-week="1"
              v-model="date"
              :max="new Date().toISOString().substr(0, 10)"
              min="1950-01-01"
              @change="save"
            ></v-date-picker>
          </v-menu>
        </v-col>
        <v-col cols="10" class="mb-4">
          <v-btn
            :disabled="!valid"
            block
            x-large
            color="primary"
            elevation="4"
            @click="createAccount"
          >
            Créer mon compte
          </v-btn>
        </v-col>
      </v-row>
    </v-form>
  </v-card>
</template>

<script>
import server from "@/api/host";

export default {
  data: () => ({
    valid: false,
    errorMessage: "",
    firstname: "",
    lastname: "",
    email: "",
    password: "",
    passwordConfirm: "",
    date: new Date().toISOString().slice(0, 10),
    menu: false,
  }),

  watch: {
    menu(v) {
      v && setTimeout(() => (this.$refs.picker.activePicker = "YEAR"));
    },
  },

  methods: {
    save(date) {
      this.$refs.menu.save(date);
    },

    notEmptyRules(v) {
      return !!v || "Ce champ est obligatoire";
    },

    validEmailRules(v) {
      return (
        /[^@ \t\r\n]+@[^@ \t\r\n]+\.[^@ \t\r\n]+/.test(v) ||
        "L'adresse email doit être valide"
      );
    },

    minLengthRules(v) {
      return v.length >= 8 || 'Le mot de passe doit contenir au moins 8 caractères'
    },

    samePasswordRules(v) {
      return v == this.password || "Les mots de passe doivent être similaires";
    },

    checkValidation() {
      this.$refs.form.validate()
    },

    async createAccount() {
      const newUser = {
        firstname: this.firstname,
        lastname: this.lastname,
        birthday: this.date,
        email: this.email,
        password: this.password,
      };

      let response = await fetch("http://" + server + ":3333/api/user/signup", {
        method: "POST",
        mode: "cors",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify(newUser),
      });

      const result = await response.json();

      if (response.ok) {
        const snackMessage = "Félicitations! Veuillez vous connectez";
        this.$nuxt.$emit("display-snack", {
          color: "success",
          message: snackMessage,
        });
        this.$router.push({ name: "connect" });
      } else if (result.Unauthorized == "This user already exists") {
        this.errorMessage = "Cette adresse email est déjà utilisée";
      } else {
        this.errorMessage = "Il y a eu une erreur, vérifiez votre saisie";
      }
    },
  },
};
</script>

<style>
</style>