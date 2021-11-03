<template>
 	<v-main>
	  	<div class="main_container">

			<nuxt-link
			class="btn_back_link"
			to="./"
			@click="this.$store.commit('unsetIsSaved', '')"
			>
			<v-btn class="btn_back" text> Retour </v-btn>
			</nuxt-link>

			<h1 class="display-4">Disque</h1>
			<h2 class="display-2 font-weight-thin">Page de détail</h2>

			
			<div class="info_block">

				<div class="left_side">
					<img
					src="../assets/example.png"
					alt="album_image"
					v-if="is_image_loading"
					class="illustration"
					/>
					<img
					:src="current_image_src"
					alt="album_image"
					v-if="!is_image_loading"
					class="illustration"
					/>

					<div class="mt-4">
						<p class="stock">Stock disponible</p>
						<span class="stock_num">{{product.num_available}}</span>
					</div>

				</div>

				<div class="right_side">

					<p class="album_title">{{ product.title }}</p>

					<p class="Property">Artiste</p>
					<p class="property_text">{{ product.artist }}</p>

					<p class="Property">Genre</p>
					<p class="property_text">{{ product.category }}</p>

					<p class="Property">Année de sortie</p>
					<p class="property_text">{{ product.year }}</p>

					<p class="Property" v-if="product.description !== ''">L'album en quelques mots </p>
					<p class="property_text" v-if="product.description !== ''">{{ product.description }}</p>

					<div class="flex_div">
						<div>
							<p class="Property">Prix</p>
							<p class="property_price">{{ product.price }} €</p>
						</div>

						<span class="div_cart_icon">
							<span class="ajout">Ajouter au panier</span>
							<div class="cart_icon">
								<v-btn icon @click="addCart">
								<v-icon color="black" size="40"
									>mdi-cart-arrow-down
								</v-icon>
								</v-btn>
							</div>
						</span>
					</div>
				</div>
			</div>
		</div>
    
    <!-- <v-container class="d-flex">
      <div class="prodImg">
        <img
          src="../assets/example.png"
          alt="album_image"
          v-if="is_image_loading"
        />
        <img
          :src="current_image_src"
          alt="album_image"
          v-if="!is_image_loading"
        />
      </div>
      <div>
        <div class="prodTitle">
          
        </div>
        <div class="prodDetails">
          sorti en {{ product.year }} par {{ product.artist }}
        </div>
        <div class="prodDescription">
          L'album en quelques mots : <br />
          {{ product.description }}
        </div>
        <div class="prodPrice">{{ product.price }} €</div>
        <div class="div_cart_icon">
          <v-card-actions class="card_action">
            <v-btn icon @click="addCart">
              <v-icon class="cart_icon" color="black" size="40"
                >mdi-cart-arrow-down
              </v-icon>
            </v-btn>
          </v-card-actions>
        </div>
      </div>
    </v-container> -->
  	</v-main>
</template>

<script>
import server from '@/api/host';

export default {
  name: "ProductDetails",

  data() {
    return {
      product: [],
      idSaved: null,
      addInCart: false,
      current_image_src: null,
      is_image_loading: true,
    };
  },

  methods: {
    displayProduct(id) {
      fetch("http://" + server + ":3333/api/products/" + id)
        .then((response) => response.json())
        .then((data) => {
          this.product = data.result[0];
          if(this.product.image !== null && this.product.image !== undefined) {
          	this.current_image_src = Buffer.from(this.product.image);
          	this.is_image_loading = false;
          }
        })
        .catch((error) => {
          console.log(error);
        });
    },

    addCart() {
      this.$store.commit("addCart", this.product);
      let snackMessage = this.product.title + "a été ajouté au panier ";
      this.$store.state.cart.forEach((product) => {
        if (product.title == this.product.title) {
          if (product.quantity != 1) {
            snackMessage += "(" + product.quantity + ")";
          }
        }
      });
      this.$nuxt.$emit("display-snack", {
        color: "success",
        message: snackMessage,
      });
      this.$nuxt.$emit("add-cart", this.product.title);
    },
  },

  mounted() {
    if (this.$route.params.id) {
      this.$store.commit("setIsSaved", this.$route.params.id);
      this.displayProduct(this.$store.state.idSaved);
    } else {
      this.displayProduct(this.$store.state.idSaved);
    }
  },
};
</script>

<style scoped>
.stock {
	font-family: "Roboto", sans-serif;
	font-weight: 400;
	font-size: 1rem;
	color: black;
	margin: 0 !important;
}

.stock_num {
	font-family: "Roboto", sans-serif;
	font-weight: 500;
	font-size: 1.5rem;
	color: black;
}

.loan_status{
  display:grid;
  grid-template-columns: 1fr 1fr;
  grid-template-rows: 1fr 1fr 1fr;
  column-gap: 20px;
}

.Property {
  font-family: "Raleway", sans-serif;
  font-weight: 550;
  font-size: 1.5rem;
  padding-top: 1vh;
  margin: 0;
  word-break: break-word;
  color: #0285e7;
}

.property_text {
  font-family: "Roboto", sans-serif;
  font-weight: 400;
  font-size: 1.2rem;
  word-break: break-word;
}

.album_title {
	font-family: "Roboto", sans-serif;
	font-weight: 500;
	font-size: 3rem;
	word-break: break-word;
	color: #0D47A1;
	padding-bottom: 2vh;
}

.property_price {
	padding: 15px;
	font-family: "Roboto", sans-serif;
	font-weight: 500;
	font-size: 1.7rem;
	color: black;
}

.main_container{
  width:80%;
  margin-left:auto;
  margin-right:auto;
  display:flex;
  flex-direction: column;
}

.info_block{
  margin-top: 20px;
  display:flex;
  flex-direction: row;
  justify-content: space-between;
}

.left_side{
  flex-basis:30%;
  display:flex;
  flex-direction: column;
  justify-content: flex-start;
}

.right_side{
  flex-basis:60%;
  display: flex;
  flex-direction: column;
  justify-content: space-between;
  height:60%;
}

.illustration{
  width:100%;
  height:500px;
  background-color:black;
  object-fit:contain;
}

.div_cart_icon {
	padding-top: 20px;
	padding-bottom: 15px;
	padding-right: 5px;
	padding-left: 5px;
	border: solid 5px #0284e7b2;
	border-radius: 15px;
}

.cart_icon {
	margin-top: 10px;
	margin-left: 85px;
}

.flex_div {
	display: flex;
	flex-direction: row;
	width: 40%;
	justify-content: space-between;
}

.ajout {
	font-family: "Roboto", sans-serif;
	font-weight: 500;
	font-size: 1.7rem;
	color: black;
	padding-bottom: 15px !important;
}

.back_button {
  width: 150px;
}

.btn_back_link {
  text-decoration: none;
  margin-left: 20px;
  margin-top: 10px;
}
.btn_back {
  background-color: #0285e7;
}
.container {
  align-items: center;
}
.prodTitle {
  margin-top: 20px;
  font-size: 1.5em;
  color: #0285e7;
}
.prodDetails {
  color: black;
}
.prodDescription {
  margin-top: 40px;
  color: black;
}
.prodPrice {
  color: #0285e7;
  text-align: right;
  font-size: 1.5em;
  margin-top: 2em;
}


@font-face {
  font-family: "Raleway", "sans-serif";
  src: url("https://fonts.googleapis.com/css2?family=Raleway:wght@300;400;500;600&display=swap")
    format("truetype");
}

@font-face {
  font-family: "Raleway", "sans-serif";
  src: url("https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500&display=swap")
    format("truetype");
}
</style>