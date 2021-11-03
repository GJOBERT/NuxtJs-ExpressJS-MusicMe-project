<template>
  <div v-if="isLoggedIn && target_user !== ''">
      <v-avatar size="50px" color="#385391" class="avatar">
        <img
          v-if="image_url"
          alt="Avatar"
          :src="image_url"
        />
        <v-icon v-if="!image_url" dark> mdi-account-circle </v-icon>
      </v-avatar>
      <v-row>
        <div class="firstname">{{ target_user.firstname }}</div>
        <div class="Lastname">{{ target_user.lastname }}</div>
      </v-row>
  </div>
</template>

<script>
import { mapState } from 'vuex';
import gabrielServices from '../api/gabrielServices';

export default {
	data() {
		return {
			target_user: '',
			image_url:''
		};
	},
	computed: {
			...mapState([
				'token',
				'isLoggedIn',
				'userId',
				'user'
			])
		},

	mounted(){
		this.fetchAvatar();
	},
	methods: {
		fetchAvatar(){
				if (this.isLoggedIn) {
					gabrielServices.getUser(this.userId, this.token)
						.then((response) => {
							this.target_user = response[0];
							this.$store.commit('setUser', this.target_user);
							if (this.target_user.avatar !== null) {
								this.image_url = Buffer.from(this.target_user.avatar);
							}
						})
				}
			},
	}
};
</script>

<style scoped>
.row {
  margin: 5px auto;
  align-items: center;
}
.avatar {
  margin-right: auto;
  margin-left: auto;
}
.firstname {
  color: black;
}
.Lastname {
  color: black;
  margin-left: 4px;
}
</style>