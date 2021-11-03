<template>
  <v-card
    max-width="450"
    min-height="400"
    class="connect-form rounded-lg elevation-4 my-12 mx-auto"
  >
    <v-card-title primary-title> CONNEXION </v-card-title>
		<v-card-subtitle class="red--text" v-if="errorMessage"> {{ errorMessage }} </v-card-subtitle>
    <v-form v-model="valid">
      <v-row justify="center">
        <v-col cols="10">
          <v-text-field
            v-model="email"
            :rules="emailRules"
            label="Adresse Email"
            required
            outlined
            light
          ></v-text-field>
        </v-col>
        <v-col cols="10">
          <v-text-field
            type="password"
            v-model="password"
            :rules="passworRules"
            label="Mot de Passe"
            required
            light
            outlined
						@keyup.enter="valid ? connectUser(): errorMessage = 'Vérifiez votre saisie' "
          ></v-text-field>
        </v-col>
      </v-row>

      <v-row justify="space-around">
        <v-spacer></v-spacer>
        <v-col cols="5">
          <router-link to="/"> Mot de passe oublié ? </router-link>
          <br />
          <router-link to="/register"> S'inscrire </router-link>
        </v-col>
        <v-spacer></v-spacer>
        <v-col>
          <v-btn
            :disabled="!valid"
            large
            color="primary"
            elevation="4"
            @click="connectUser"
          >
            Se connecter
          </v-btn>
        </v-col>
        <v-spacer></v-spacer>
      </v-row>
    </v-form>
  </v-card>
</template>

<script>
import server from '@/api/host';

export default {
  name: "Connect",
  data: () => ({
    valid: false,
    email: "",
    password: "",
    emailRules: [
      (v) => !!v || "Veuillez entrez votre adresse Email",
      (v) => /[^@ \t\r\n]+@[^@ \t\r\n]+\.[^@ \t\r\n]+/.test(v) || "L'adresse Email doit être valide",
    ],
    passworRules: [(v) => !!v || "Veuillez entrez votre Mot de passe"],
		errorMessage: ""
  }),
  methods: {
    async connectUser() {
      const userInfos = {
        email: this.email,
        password: this.password,
      };

      let response = await fetch("http://" + server + ":3333/api/user/login", {
        method: "POST",
        mode: "cors",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify(userInfos),
      });

      let result = await response.json();


      if (response.ok) {
        this.$store.commit("connect");
        this.$store.commit("setToken", result.token);
        this.$store.commit("setUserId", result.userId);
        this.$store.commit("setIsAdmin", result.isAdmin);

        this.$router.push({ name: "index" });
      } else if (response.status == 401) {
				this.errorMessage = "L'adresse Email et le Mot de passe ne correspondent pas"
      }
    },
  },
};
</script>

<style>
.margin_0 {
  height: 89vh;
  display: flex;
  flex-direction: column;
  justify-content: space-evenly;
  margin: 0 auto;
  width: 450px;
}
</style>