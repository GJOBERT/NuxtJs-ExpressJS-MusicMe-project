<template>
  <div class="main_sheet">
    <div class="filters_list">
      <div class="genre_title">Genres</div>
      <v-radio-group class="category_sheet" v-model="category_id" column>
        <v-radio
          @click="commitCategory()"
          v-for="genre in genres"
          :key="genre.id"
          :label="genre.name"
          :value="genre.id"
        ></v-radio>
      </v-radio-group>

      <!-- <v-divider class="my-1"></v-divider> -->

      <div>
        <div class="price_title">Prix</div>

        <!-- <v-btn class="smallbtn"  elevation="2" 
				small fab color="primary" v-if="priceUnder" @click="displayHighPrices()"> <v-icon dark>
        		mdi-plus
      			</v-icon></v-btn>

				<span class="pricetext" v-if="priceUnder">Prix plus élevés</span>

				<v-btn class="smallbtn" elevation="2" 
				small fab color="primary" v-if="priceUnder === false" @click="displayLowPrices()"> <v-icon dark>
        		mdi-minus
      			</v-icon></v-btn>
				
				<span class="pricetext" v-if="priceUnder === false">Prix moins élevés</span> -->

        <v-radio-group class="price_slider" v-model="price" column>
          <v-radio
            @click="commitPrice()"
            v-for="price in prices"
            :key="price.id"
            :label="price.name"
            :value="price.id"
          ></v-radio>
        </v-radio-group>

        <!-- <v-slider
				v-if="priceUnder"
				v-model="price"
				:max="200"
				:thumb-size="35"
				thumb-label="always"
				class="price_slider"
				></v-slider>
				
				<v-slider
				v-if="priceUnder === false"
				v-model="price"
				:min="200"
				:max="1000"
				:thumb-size="35"
				thumb-label="always"
				class="price_slider"
				></v-slider>

				<v-btn class="price_filter_btn" color="primary" @click="commitPrice()" small>Filtrer le prix</v-btn> -->

        <!-- <v-list color="transparent">
					<v-list-item v-for="price in prices" :key="price" link>
					<v-list-item-content>
						<v-list-item-title class="prices_filter">
						{{ price }}
						</v-list-item-title>
					</v-list-item-content>
					</v-list-item>
				</v-list> -->
      </div>

      <!-- <v-divider class="my-1"></v-divider> -->

      <!-- <v-list-item link>
			<v-list-item-content>
				<v-list-item-title class="X_filter"> X Filtres </v-list-item-title>
			</v-list-item-content>
			</v-list-item> -->
    </div>
  </div>
</template>

<script>
import gabrielServices from "../api/gabrielServices";
import { mapState } from "vuex";

export default {
  data() {
    return {
      genres: [
        {
          name: "Tous genres",
          id: "",
        },
      ],
      category_id: "",
      price: 10000,
      priceUnder: true,
      prices: [
        { name: "< 10€", id: 10 },
        { name: "< 20€", id: 20 },
        { name: "< 30€", id: 30 },
        { name: "< 50€", id: 50 },
        { name: "< 100€", id: 100 },
        { name: "> 100€ +", id: 10000 },
      ],
    };
  },
  computed: {
    ...mapState(["token", "user", "price_search", "category_id_search"]),
  },

  methods: {
    displayHighPrices() {
      this.priceUnder = false;
    },
    displayLowPrices() {
      this.priceUnder = true;
    },
    getCategories() {
      gabrielServices.getCategories().then((response) => {
        if (response !== undefined && response.length > 0) {
          response.forEach((genre) => {
            this.genres.push(genre);
          });
        }
      });
    },
    commitCategory() {
      if (this.category_id === 0) {
        this.$store.commit("setCategorySearch", "");
      } else {
        this.$store.commit("setCategorySearch", this.category_id);
      }
    },
    commitPrice() {
      this.$store.commit("setPriceSearch", this.price);
    },
  },

  mounted() {
    this.getCategories();
  },

  watch: {
    category_id_search: function () {
      this.category_id = this.category_id_search;
    },
    price_search: function () {
      this.price = this.price_search;
    },
  },
};
</script>

<style scoped>
.smallbtn {
  margin-top: 20px;
  margin-bottom: 10px;
}
.filters_list {
  display: flex;
  flex-direction: column;
}

.price_filter_btn {
  width: 150px;
}

.pricetext {
  padding-left: 5px;
  padding-top: 10px;
}

.price_slider {
  margin-left: 10px;
  margin-top: 15px;
}

.main_sheet {
  margin-left: 0 !important;
  margin-right: 0 !important;
  border-radius: 3em;
}

.category_sheet {
  padding-left: 10px;
  padding-top: 7px;
  /* overflow: scroll; */
  max-height: 50vh;
}

.main_sheet {
  height: 90%;
  border-radius: 3em;
  width: 280px;
  margin: 0 auto;
  background-color: white;
}

.genres_filter,
.genre_title {
  text-align: center;
}

.genre_title {
  border-radius: 3em;
  background-color: #8ac5ff;
  color: black;
  margin-top: 10px;
}

.price_title {
  border-radius: 3em;
  text-align: center;
  background-color: #8ac5ff;
  color: black;
  margin-top: 10px;
}
</style>