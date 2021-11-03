<template lang="html">

    <v-app-bar
    app
    color="white"
    :elevation="5"
		class="pb-2 pt-1"
    >
		<nuxt-link to="/">
			<img
			class="mr-3 image"
			:src="require('../assets/Logo_MusicMe_sans_texte.png')"
			height="40"
			/>
		</nuxt-link>

		<v-toolbar-title class="ml-2"
			><span class="title_M1">M</span>usic<span class="title_M2">M</span>e
		</v-toolbar-title>
		
		<v-spacer></v-spacer>

		<v-avatar
		size="40px"
		v-if="image_preview_url !== ''"
		>
			<img
			v-bind:src="image_preview_url"
			alt="Avatar"
			>

		</v-avatar>

		<div class="persona_cartouche" v-if="user !== null">
			<span class="font-weight-bold ml-4 mr-4" v-if="user !== null"> Bienvenue {{user.firstname}} {{user.lastname}}</span>
		</div>

		<v-avatar
		size="36px"
		v-if="image_preview_url === ''"
		color="#385391"
		>
			<v-icon dark> mdi-account-circle </v-icon>
		</v-avatar>

		<div v-if="isLoggedIn" class="mx-2">
			<nuxt-link to="/userDetails" class="btn_account">
			<v-btn text>
				<span class="btn_account_mon">Mon</span>&nbsp;compte
			</v-btn>
			</nuxt-link>
		</div>

		<div v-if="user !== null && user.isAdmin">
			<nuxt-link to="/admin" class="btn_admin">
			<v-btn text class="btn_admin">
				<span class="btn_admin_a">A</span>dmin
			</v-btn>
			</nuxt-link>
		</div>

		<template v-if="$route.name != 'cart'">
			<v-badge overlap color="red" :value="cart.length" :content="cart.length">
				<v-btn class="ma-2" outlined v-on:click="$router.push({ name: 'cart' })">
				Panier
				<v-icon>mdi-cart-outline</v-icon>
				</v-btn>
			</v-badge>
		</template>

		<v-btn class="ma-2 logout_button"
		outlined
		v-on:click="logout">
			Déconnexion
		</v-btn>

    </v-app-bar>

</template>

<script>
import gabrielServices from "../api/gabrielServices.js";
import { mapState } from "vuex";

export default {
  name: "HeaderUser",
  data() {
    return {
      image_preview_url: "",
      target_user: "",
      nbCartProducts: 4,
    };
  },
  computed: {
    ...mapState(["token", "isLoggedIn", "userId", "user", "cart", "avatar"]),
  },

  mounted() {
    this.fetchAvatar();
  },

  methods: {
    logout() {
      this.$store.dispatch("LogOut");
			const snackMessage = "Vous avez été déconnecté " + String.fromCodePoint(128075)
			this.$nuxt.$emit('display-snack', { color: "primary", message: snackMessage})
      this.$router.push({ name: "connect" });
    },

    fetchAvatar() {
      gabrielServices.getUser(this.userId, this.token).then((response) => {
        this.target_user = response[0];
        this.$store.commit("setUser", this.target_user);
        if (this.target_user.avatar !== null) {
          this.image_preview_url = Buffer.from(this.target_user.avatar);
        }
      });
    },
  },
  watch: {
    avatar: function () {
      this.fetchAvatar();
    },
  }
};
</script>

<style scoped>
.logout_button {
  color: #0285e7;
}
.image {
  margin-right: 10px;
}
.title_M1,
.title_M2,
.btn_signup_i,
.btn_login_c,
.btn_admin_a,
.btn_account_mon {
  color: #0285e7;
}
.btn_admin {
  background-color: rgb(248, 190, 190);
}
.btn_signup,
.btn_login,
.btn_account,
.btn_admin {
  text-decoration: none;
}

.nav_button {
  font-family: "Roboto", sans-serif;
  font-weight: 500;
  font-size: 1rem;
}

.cartouchesubtitle {
  font-size: 0.5em;
}
.cartouche {
  display: flex;
  flex-direction: column;
}

.avatarpic {
  object-fit: cover;
}

.persona_cartouche {
  display: flex;
  flex-direction: column;
}

.persona_cartouche {
  display: flex;
  flex-direction: column;
}
</style>
