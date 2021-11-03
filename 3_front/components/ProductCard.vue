<template>
  <div v-if="product_object !== undefined">
    <v-card :loading="loading" class="card">
      <div class="image_container">
        <img
          @click="
            $router.push({
              name: 'ProductDetails',
              params: { id: productId.id },
            })
          "
          v-if="!is_image_loading"
          v-bind:src="current_image_src"
          style="height: 229px"
          class="img"
        />

        <!-- <v-progress-circular
			v-if="is_image_loading"
			indeterminate
			size="150"
			color="primary"
			></v-progress-circular> -->

        <!-- <img v-if="is_image_loading"
			src="https://media.giphy.com/media/MDrmyLuEV8XFOe7lU6/giphy.gif"
			style="height: 229px"
			class="img"
			> -->

        <v-img
          v-if="is_image_loading"
          @click="
            $router.push({
              name: 'ProductDetails',
              params: { id: productId.id },
            })
          "
          :src="require('@/assets/example.png')"
          class="img"
        >
        </v-img>
      </div>

      <v-card-title
        class="card_title d-inline-block text-truncate"
        style="max-width: 100%"
        >{{ product_object.title }}</v-card-title
      >

      <v-card-text class="card_text">
        <div><span>Artiste : </span>{{ product_object.artist }}</div>
        <div><span>Année de sortie : </span>{{ product_object.year }}</div>
        <v-row class="text_row">
          <div>{{ product_object.category }}</div>
          <div class="price">
            {{ product_object.price }} <span class="device"> €</span>
          </div>
        </v-row>
      </v-card-text>

      <div>
        <v-card-actions class="card_action">
          <v-btn icon @click.prevent="addCart">
            <v-icon>mdi-cart-arrow-down</v-icon>
          </v-btn>
        </v-card-actions>
      </div>
    </v-card>
  </div>
</template>

<script>
import gabrielServices from "../api/gabrielServices";

export default {
  name: "ProductCard",

  data() {
    return {
      snackbar: false,
      loading: false,
      selection: 1,
      product_object: {},
      category: [],
      current_image_src: null,
      is_image_loading: true,
    };
  },

  props: {
    productId: {
      type: Object,
      required: true,
    },
  },

  methods: {
    reserve() {
      this.loading = true;
      setTimeout(() => (this.loading = false), 2000);
    },

    getProductById() {
      this.is_image_loading = true;
      gabrielServices.getProduct(this.productId.id).then((response) => {
		 	if(response !== undefined) {
				this.product_object = response[0];
				console.log(this.product_object);
				if(this.product_object.image !== null && this.product_object.image !== undefined) {
					this.current_image_src = Buffer.from(this.product_object.image);
					this.is_image_loading = false;
				}
		  	} else {
				  this.product_object = undefined;
			  }
      });
    },

    addCart() {
      this.$store.commit("addCart", this.product_object);
      let snackMessage = String.fromCodePoint(128192) + ' ' + this.product_object.title + " a été ajouté au panier ";
      this.$store.state.cart.forEach((product) => {
        if (product.title == this.product_object.title) {
          if (product.quantity != 1) {
            snackMessage += "(" + product.quantity + ")";
          }
        }
      });
      this.$nuxt.$emit("display-snack", { color: "success", message: snackMessage});
    },
  },

  mounted() {
    this.product_object = {};
    this.getProductById();
  },
};
</script>

<style scoped>
.img {
	border-bottom: 1px solid rgb(236, 241, 245);
	width: 100%;
	height: 226px;
	border-radius: 5px;
}

.image_container {
	height:226px;
	width: 100%;
}
.card {
  margin-top: 20px;
  margin-right: 10px;
  margin-bottom: 10px;
  height: 420px;
  width: 350px;
}
.card_title {
  padding-bottom: 2px;
}
.card_text {
  margin-top: 0;
}
.text_row {
  margin: auto;
  justify-content: space-between;
}
.card_action {
  background-color: rgb(236, 241, 245);
  justify-content: center;
  border-bottom-left-radius: 5px;
  border-bottom-right-radius: 5px;
}
.price {
  color: rgb(0, 183, 255);
}
.device {
  color: rgb(0, 183, 255);
}
</style>