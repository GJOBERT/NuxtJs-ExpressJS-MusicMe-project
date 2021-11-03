<template>
  <div class="main_index_div">
    <v-snackbar
      :value="snackbar"
      top
      right
      timeout="4000"
      color="success"
      transition="scroll-y-transition"
    >
      {{ snackProductTitle }} a été ajouté au panier
      {{ snackProductQuantity != 1 ? "(" + snackProductQuantity + ")" : "" }}
      <template v-slot:action="{ attrs }">
        <v-btn dark text v-bind="attrs" @click="snackbar = false">Close</v-btn>
      </template>
    </v-snackbar>
    <div class="left_nav">
      <div class="navigation_drawer">
        <Filters />
      </div>
    </div>
    <v-main>
      <div class="main_flex_column">
        <div>
          <div class="SearchBar">
            <v-text-field
              v-model="search_input"
              class="SearchInput"
              label="Titre, artiste, année de sortie..."
              hint="Rechercher un vinyle, cd..."
            >
            </v-text-field>

            <div>
              <span
                class="result_number headline font-weight-bold"
                v-if="list_of_products.length === 0"
                >Aucun resultat</span
              >
              <span
                class="result_number headline font-weight-bold"
                v-if="list_of_products.length > 1"
                >{{ list_of_products.length }} resultats</span
              >
              <span
                class="result_number headline font-weight-bold"
                v-if="list_of_products.length === 1"
                >{{ list_of_products.length }} resultat</span
              >
            </div>
            <div class="filterbox">
              <v-select
                class="filter"
                :items="orders_column"
                item-text="name"
                item-value="id"
                label="Trier les résultats par"
                v-model="column"
                solo
              ></v-select>

              <v-select
                class="filter"
                :items="orders"
                item-text="name"
                item-value="id"
                v-model="order"
                solo
              ></v-select>

              <v-btn
                @click="resetSearch()"
                outlined
                color="brown darken-4"
                class="init_button"
                x-large
                text
              >
                Réinitialiser
                <!-- <v-icon right dark>autorenew</v-icon> -->
              </v-btn>
            </div>
          </div>
        </div>

        <div class="card_container_grid">
          <ProductCard
            v-for="product in mini_list_of_products"
            :key="product.id"
            :productId="product"
          />
        </div>
      </div>
    </v-main>
  </div>
</template>

<script>
import Filters from "../components/Filters";
import ProductCard from "../components/ProductCard";
import UserAvatar from "../components/UserAvatar";
import gabrielServices from "../api/gabrielServices";
import { mapState } from "vuex";

export default {
  data() {
    return {
      snackbar: false,
      snackProductTitle: "",
      snackProductQuantity: 1,
      snackTimeoutId: 0,
      list_of_products: [],
      orders_column: [
        {
          name: "Pas de filtre",
          id: "id",
        },
        {
          name: "Titre",
          id: "title",
        },
        {
          name: "Artiste",
          id: "artist",
        },
        {
          name: "Année",
          id: "year",
        },
        {
          name: "Prix",
          id: "price",
        },
      ],
      orders: [
        {
          name: "Montant",
          id: "ASC",
        },
        {
          name: "Descendant",
          id: "DESC",
        },
      ],
      search_input: "",
      search_body: {
        main: "",
        price: 200,
        category_id: "",
        orderby: "ORDER BY",
        col: "id",
        order: "ASC",
      },
      order: "ASC",
      column: "id",

      //INFINITE SCROLL IN PROGRESS
      mini_list_of_products: [],
      LCP: -1,
      is_started: false,
      is_finished: false,
      step: 4,
      initial_step: 12,
    };
  },

  components: {
    Filters,
    ProductCard,
    UserAvatar,
  },

  methods: {
    getAllProducts() {
      this.search_body.category_id = "%" + this.search_body.category_id + "%";
      this.search_body.main = "%" + this.search_body.main + "%";
      let search = JSON.stringify(this.search_body);
      gabrielServices
        .searchProducts(search)
        .then((response) => {
          if (response !== undefined && response.length > 0) {
            this.list_of_products = response;
          } else {
            this.list_of_products = [];
          }
        })
        .catch((err) => console.log(err));
    },
    resetSearch() {
      this.$store.commit("unsetSearchObject");
      this.$store.commit("unsetCategorySearch");
      this.$store.commit("unsetPriceSearch");
      this.search_input = "";
      this.column = "id";
      this.order = "ASC";
      this.search_body = {
        main: "",
        price: 200,
        category_id: "",
        orderby: "ORDER BY",
        col: "id",
        order: "ASC",
      };
    },

    // INFINITE SCROLL WORK IN PROGRESS
    handleInfiniteScroll() {
		if (window.innerHeight + window.scrollY >= document.body.offsetHeight * 0.5) {
			if (this.is_started === true && this.is_finished === false) {
				this.get_cycler();
			}
		}
    },
    retrieveCatalogue() {
		this.search_body.category_id = "%" + this.search_body.category_id + "%";
		this.search_body.main = "%" + this.search_body.main + "%";
		let search = JSON.stringify(this.search_body);
      	gabrielServices.searchProducts(search)
        .then((response) => {
			if (response !== undefined && response.length > 0) {
				this.list_of_products = response;

				this.is_started = true;
				this.is_finished = false;

				let borne_inferieure = this.LCP + 1;
				let borne_superieure = Math.min(borne_inferieure + this.initial_step, this.list_of_products.length);
				this.mini_list_of_products = this.list_of_products.slice(borne_inferieure, borne_superieure);

				if (this.mini_list_of_products.length === this.list_of_products.length) {
					this.is_finished = true;
				}
			} else {
				this.list_of_products = [];
			}
        })
        // .catch((err) => console.log(err));
    },
    get_cycler() {
      //Check that we have the right number of
      if (this.is_started === true && this.is_finished === false) {
        if (this.list_of_products.length !== 0) {
			let borne_inferieure = this.LCP + 1;
			console.log(borne_inferieure)
			let borne_superieure = Math.min(borne_inferieure + this.step, this.list_of_products.length);
          	let intron = this.list_of_products.slice(borne_inferieure, borne_superieure);

          	intron.forEach((element) => {
            	this.mini_list_of_products.push(element);
          	});

          if (borne_superieure < this.list_of_products.length) {
            this.is_finished = false;
            this.LCP = borne_superieure - 1;

          } else {
            this.is_finished = true;
            this.LCP = this.list_of_products.length - 1;
          }
        }
      }
    },
  },

  destroyed () {
  	window.removeEventListener('scroll',  this.handleInfiniteScroll);
  },

  created() {

	window.addEventListener('scroll', this.handleInfiniteScroll);

    this.$nuxt.$on("add-cart", (productTitle) => {
      if (this.snackTimeoutId) {
        console.log("Timeout en cours: " + this.snackTimeoutId);
        clearTimeout(this.snackTimeoutId);
        this.snackbar = false;
      }

      this.snackTimeoutId = setTimeout(() => {
        console.log('Nouveau Timeout: ' + this.snackTimeoutId)
        this.snackbar = false;
      }, 4500);

      this.snackProductTitle = productTitle;
      this.cart.forEach(async (product) => {
        if (product.title == productTitle) {
          this.snackProductQuantity = product.quantity + 1;
        }
      });

      	this.snackbar = true;
    });
  },

  mounted() {
    // this.search_body = this.$store.state.search_object;
    this.list_of_products = [];
    this.retrieveCatalogue();
    this.handleInfiniteScroll()
  },

  computed: {
    ...mapState([
      "token",
      "user",
      "price_search",
      "category_id_search",
      "cart",
    ]),
  },

  watch: {
    search_input: function () {
      this.search_body.main = this.search_input;
      // this.$store.commit('setSearchObject', this.search_body);

      this.retrieveCatalogue();
    },
    column: function () {
      this.search_body.main = this.search_input;
      this.search_body.col = this.column;
      // this.$store.commit('setSearchObject', this.search_body);

      this.retrieveCatalogue();
    },
    category_id_search: function () {
      this.search_body.category_id = this.category_id_search;
      this.retrieveCatalogue();
    },
    price_search: function () {
      this.search_body.price = this.price_search;
      this.retrieveCatalogue();
    },
    order: function () {
      if (this.search_body.category_id !== "") {
        this.search_body.order = this.order;
        this.retrieveCatalogue();
      }
    },
  },
};
</script>

<style>
.result_number {
  padding-bottom: 10px;
}

.SearchBar {
  display: flex;
  flex-direction: column;
  justify-content: space-between;
}

.init_button {
  width: 150px;
  height: 25px;
  margin-bottom: 7px;
  background-color: #8ac5ff;
}

.SearchInput {
  width: 99%;
  margin: 0 !important;
}
.filterbox {
  padding-top: 10px !important;
  display: flex;
  flex-direction: row;
  column-gap: 20px;
  flex-wrap: wrap;
  width: 70%;
}

.filter {
  flex-basis: 1/3;
}

.main_flex_column {
  display: flex;
  margin-left: 25px;
  margin-top: 20px;
  height: 89vh;
  flex-direction: column;
}

.left_nav {
  border-right: solid 2px #8ac4ffaf;
  /* border-radius: 3em; */
  /* background-color: #8ac5ff; */
  width: 310px;
  height: 89vh;
  margin-top: 80px;
}

.navigation_drawer {
  height: 84vh;
  width: 280px;
  display: flex;
  flex-direction: column;
  border-radius: 3em;
  margin: 15px;
  background-color: white;
}

.main_index_div {
  display: flex;
  flex-direction: row;
  justify-content: space-between;
  overflow: hidden;
}

.card_container_grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
  grid-row-gap: 20px;
  grid-column-gap: 20px;
  height: 70vh;
  overflow: auto;
}

.v-application--wrap {
  min-height: 100% !important;
  background-color: white;
}
.container {
  margin-left: 0;
  margin-right: 0;
  max-width: 100%;
  justify-content: center;
}
</style>
