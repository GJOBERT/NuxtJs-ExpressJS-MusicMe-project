<template>
  <div class="main_index_div">
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

        <div class="card_container_grid" id="grid">
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
import gabrielServices from "../api/gabrielServices";
import { mapState } from "vuex";

export default {
  data() {
    return {
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

      //INFINITE SCROLL OK
      mini_list_of_products: [],
      LCP: -1,
      is_started: false,
      is_finished: false,
      step: 7,
      initial_step: 18,
	  scroll_index: 0
    };
  },

  components: {
    Filters,
    ProductCard,
  },

  methods: {
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

    // INFINITE SCROLL WORKING
    handleInfiniteScroll() {
		let element = document.getElementById("grid");
		if (element.scrollTop > this.scroll_index + 350) {
			if (this.is_started === true && this.is_finished === false) {
				this.scroll_index = element.scrollTop;
				this.get_cycler();
			}
		}
    },
    retrieveCatalogue() {
		this.list_of_products = [];
		this.mini_list_of_products = [];
		this.scroll_index = 0;
		this.search_body.category_id = "%" + this.search_body.category_id + "%";
		this.search_body.main = "%" + this.search_body.main + "%";
		let search = JSON.stringify(this.search_body);
      	gabrielServices.searchProducts(search)
        .then((response) => {
			if (response !== undefined && response.length > 0) {
				this.list_of_products = response;

				this.is_started = true;
				this.is_finished = false;

				let borne_inferieure = 0;
				let borne_superieure = Math.min(borne_inferieure + this.initial_step, this.list_of_products.length);
				this.mini_list_of_products = this.list_of_products.slice(borne_inferieure, borne_superieure);
				this.LCP = borne_superieure;
				if (this.mini_list_of_products.length === this.list_of_products.length) {
					this.is_finished = true;
				}
			} else {
				this.list_of_products = [];
				this.mini_list_of_products = []
			}
        })
    },
    get_cycler() {
      	if (this.is_started === true && this.is_finished === false) {
			if (this.list_of_products.length !== 0) {
				let borne_inferieure = this.LCP;
				let borne_superieure = Math.min(borne_inferieure + this.step, this.list_of_products.length);
				let intron = this.list_of_products.slice(borne_inferieure, borne_superieure);

				intron.forEach((element) => {
					this.mini_list_of_products.push(element);
				});


				if (borne_superieure < this.list_of_products.length) {
					this.is_finished = false;
					this.LCP = borne_superieure;

				} else {
					this.is_finished = true;
					this.LCP = this.list_of_products.length - 1;
				}
			}
      	}
    },
  },

	destroyed () {
		document.getElementById("grid").removeEventListener('scroll',  this.handleInfiniteScroll);
	},

  mounted() {
	document.querySelector("#grid").addEventListener('scroll', this.handleInfiniteScroll);
    // this.search_body = this.$store.state.search_object;
    this.list_of_products = [];
	this.mini_list_of_products = [];
    this.retrieveCatalogue();
    this.handleInfiniteScroll();
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
	  // this.$store.commit('setSearchObject', this.search_body);
      this.retrieveCatalogue();
    },
    price_search: function () {
      this.search_body.price = this.price_search;
	  // this.$store.commit('setSearchObject', this.search_body);
      this.retrieveCatalogue();
    },
    order: function () {
      if (this.search_body.category_id !== "") {
        this.search_body.order = this.order;
		// this.$store.commit('setSearchObject', this.search_body);
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
	/* margin: 0 auto; */
	max-width: 1838px;
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
  max-width: 1400px;
  height: 72vh;
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
