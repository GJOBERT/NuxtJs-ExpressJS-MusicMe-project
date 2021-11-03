<template>
  <div class="main_div">
    <h3 class="title">Liste des catégories</h3>
    <v-btn class="add_button" @click="addCategoryForm"
      >+ Ajouter une catégorie</v-btn
    >
    <AddCategoryForm v-if="isAddCategoryForm" :idToUpdate="category_id" />
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
      <CategoryLign
        v-for="(category, index) in categories"
        :key="index"
        class="table-line"
        :categoryId="category.id"
      />
      <!-- </tbody> -->
    </v-simple-table>
  </div>
</template>

<script>
import server from '@/api/host';
import { mapState } from "vuex";

export default {
  name: "AdminCategoryComp",
  data() {
    return {
      categories: [],
      columns: ["id", "Name", "Modifier", "Supprimer"],
      isAddCategoryForm: false,
      category_id: null,
    };
  },

  computed: {
    ...mapState(["token"]),
  },

  methods: {
    addCategoryForm() {
      this.isAddCategoryForm = !this.isAddCategoryForm;
      this.$nuxt.$emit("hideUpdateCatBtn");
    },

    closeAddCategoryForm() {
      this.isAddCategoryForm = false;
    },

    getAllCategories() {
      this.categories = [];
      fetch("http://" + server + ":3333/api/category/", {
        headers: {
          "Content-Type": "application/JSON",
          Authorization: "Bearer " + this.token,
        },
      })
        .then((response) => response.json())
        .then((data) => {
          this.categories = data.result;
        })
        .catch((error) => {
          console.log(error);
        });
    },

    passIdForUpdate(category_id) {
      this.category_id = category_id;
    },
  },

  created() {
    this.$nuxt.$on("triggerCategoriesDisplay", () => {
		this.getAllCategories();
      this.category_id = null;
    });
  },

  mounted() {
    this.getAllCategories();
    this.$nuxt.$on("resetIdToUpdate", () => {
      this.getAllCategories();
    });
    this.$nuxt.$on("hideAddCategoryForm", () => {
      this.closeAddCategoryForm();
    });
    this.$nuxt.$on("displayCategoryEditForm", () => {
      this.addCategoryForm();
    });
    this.$nuxt.$on("emitIdForUpdating", (category_id) => {
      this.passIdForUpdate(category_id);
    });
  },
};
</script>

<style scoped>
.add_button {
  margin: 10px 0;
}
</style>