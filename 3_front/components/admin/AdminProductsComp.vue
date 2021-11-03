<template>
  <div class="main_div" id="grid">
    <h3 class="title">Liste des produits</h3>
    <v-btn class="add_button" @click="addProductForm"
      >+ Ajouter un produit</v-btn
    >
    <AddProductForm v-if="isAddProductForm" :idToUpdate="product_id" />
    <v-simple-table>
      <!-- <thead> -->
      <thead>
        <tr>
          <th v-for="(column, index) in columns" :key="index" scope="col">
            {{ column }}
          </th>
        </tr>
      </thead>
      <!-- <thead> -->

      <!-- <tbody> -->
      <ProductLign
        v-for="(product, index) in mini_list_of_products"
        :key="index"
        class="table-line"
        :prodId="product.id"
      />
      <!-- <infinite-loading
        spinner="spiral"
        @infinite="infiniteScroll"
      ></infinite-loading> -->
      <!-- </tbody> -->
    </v-simple-table>
  </div>
</template>

<script>
import server from "@/api/host";

export default {
  data() {
    return {
      list_of_products: [],
      columns: [
        "Titre",
        "Artiste",
        "Année",
        "Categorie",
        "Image",
        "Réservations",
        "Stock",
        "Prix",
        "Modifier",
        "Supprimer",
      ],
      isAddProductForm: false,
      product_id: null,

      //INFINITE SCROLL
      mini_list_of_products: [],
      LCP: -1,
      is_started: false,
      is_finished: false,
      step: 7,
      initial_step: 50,
      scroll_index: 0,
    };
  },

  methods: {
    addProductForm() {
      this.isAddProductForm = !this.isAddProductForm;
    },

    closeAddProductForm() {
      this.isAddProductForm = false;
    },

    // INFINITE SCROLL WORKING
    handleInfiniteScroll() {
      // if ((window.innerHeight + window.scrollY) >= document.body.offsetHeight * 0.50) {
      //         if (this.is_started === true && this.is_finished === false) {
      //             this.getMovie_cycler();
      //         }
      //     }
      let element = document.getElementById("grid");
      if (element.scrollTop > this.scroll_index + 300) {
        if (this.is_started === true && this.is_finished === false) {
          this.scroll_index = element.scrollTop;
          this.get_cycler();
        }
      }
    },
    retrieveCatalogue() {
      this.scroll_index = 0;
      this.list_of_products = [];
      this.mini_list_of_products = [];
      fetch(`http://` + server + `:3333/api/products/`, {
        method: "GET",
        headers: {
          "Content-Type": "application/json",
        },
      })
        .then((response) => response.json())
        .then((data) => {
          if (data.result !== undefined && data.result.length > 0) {
            this.list_of_products = data.result;

            this.is_started = true;
            this.is_finished = false;

            let borne_inferieure = 0;
            let borne_superieure = Math.min(
              borne_inferieure + this.initial_step,
              this.list_of_products.length
            );
            this.mini_list_of_products = this.list_of_products.slice(
              borne_inferieure,
              borne_superieure
            );
            this.LCP = borne_superieure;
            if (
              this.mini_list_of_products.length === this.list_of_products.length
            ) {
              this.is_finished = true;
            }
          } else {
            this.list_of_products = [];
            this.mini_list_of_products = [];
          }
        });
    },
    get_cycler() {
      if (this.is_started === true && this.is_finished === false) {
        if (this.list_of_products.length !== 0) {
          let borne_inferieure = this.LCP;
          let borne_superieure = Math.min(
            borne_inferieure + this.step,
            this.list_of_products.length
          );
          let intron = this.list_of_products.slice(
            borne_inferieure,
            borne_superieure
          );

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

    passIdForUpdate(product_id) {
      this.product_id = product_id;
    },
  },

  created() {
    this.$nuxt.$on("btnProductsDisplay", () => {
      this.product_id = null;
    });
  },

  mounted() {
    document
      .getElementById("grid")
      .removeEventListener("scroll", this.handleInfiniteScroll);
    document
      .getElementById("grid")
      .addEventListener("scroll", this.handleInfiniteScroll);
    this.list_of_products = [];
    this.mini_list_of_products = [];
    this.retrieveCatalogue();
    this.handleInfiniteScroll();

    this.$nuxt.$on("triggerProductsDisplay", () => {
      this.retrieveCatalogue();
    });
    this.$nuxt.$on("hideAddProductForm", () => {
      this.closeAddProductForm();
    });
    this.$nuxt.$on("displayProductEditForm", () => {
      this.addProductForm();
    });
    this.$nuxt.$on("emitIdForUpdating", (product_id) => {
      this.passIdForUpdate(product_id);
    });
  },
};
</script>

<style scoped>
.add_button {
  margin: 10px 0;
}

.main_div {
  height: 80vh;
  overflow: auto;
}
</style>