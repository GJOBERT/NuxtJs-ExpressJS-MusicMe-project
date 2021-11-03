<template>
  <v-form v-model="valid">
    <v-container>
      <v-row>
        <v-col cols="1" md="12">
          <v-text-field
            v-model="name"
            :rules="nameRule"
            :counter="255"
            label="Nom de la catégorie"
            required
          ></v-text-field>
        </v-col>
      </v-row>
    </v-container>
    <v-btn
      v-if="isUpdated !== true"
      color="green"
      class="mr-4"
      @click="addCategory"
      :disabled="name === ''"
    >
      Ajouter la catégorie
    </v-btn>
    <v-btn
      v-else
      color="green"
      class="mr-4"
      @click="updateCategory(categoryToUpdate)"
      :disabled="name === ''"
    >
      Enregistrer les modifications
    </v-btn>
  </v-form>
</template>

<script>
import { mapState } from "vuex";
import server from "@/api/host";

export default {
  data() {
    return {
      valid: false,
      name: "",
      isUpdated: false,
      categoryToUpdate: null,
      idRule: [(v) => !!v || "Champ requis"],
      nameRule: [
        (v) => !!v || "Champ requis",
        (v) =>
          v.length <= 255 ||
          "Le nom de la catégorie ne doit pas dépasser 255 caractères.",
      ],
    };
  },

  props: {
    idToUpdate: Number,
  },

  methods: {
    addCategory() {
      var newCategory = {
        name: this.name,
      };

      console.log(newCategory);

      newCategory = JSON.stringify(newCategory);

      fetch("http://" + server + ":3333/api/category", {
        method: "POST",
        mode: "cors",
        headers: {
          "Content-Type": "application/json",
          Authorization: "Bearer " + this.token,
        },
        body: newCategory,
      })
        .then((response) => response.json())
        .then((data) => {
          this.$nuxt.$emit("triggerCategoriesDisplay");
          this.$nuxt.$emit("hideAddCategoryForm");
        })
        .catch((error) => {
          console.log(error);
        });
    },

    updateCategory(category_id) {
      var updatedCategory = {
        name: this.name,
      };

      console.log(updatedCategory);

      updatedCategory = JSON.stringify(updatedCategory);

      fetch("http://" + server + ":3333/api/category/" + category_id, {
        method: "PUT",
        mode: "cors",
        headers: {
          "Content-Type": "application/json",
          Authorization: "Bearer " + this.token,
        },
        body: updatedCategory,
      })
        .then((response) => response.json())
        .then(() => {
          this.$nuxt.$emit("hideAddCategoryForm");
          this.$nuxt.$emit("triggerCategoriesDisplay");
          this.$nuxt.$emit("resetIdToUpdate");
          this.isUpdated = false;
        })
        .catch((error) => {
          console.log(error);
        });
    },

    getCategory(id) {
      this.category = [];
      fetch("http://" + server + ":3333/api/category/" + id, {
        method: "GET",
        mode: "cors",
        headers: {
          "Content-Type": "application/JSON",
          Authorization: "Bearer " + this.token,
        },
      })
        .then((response) => response.json())
        .then((data) => {
          var value = data.result[0];
          this.name = value.name;
        })
        .catch((error) => {
          console.log(error);
        });
    },
  },

  mounted() {
    if (!this.$props.idToUpdate || this.$props.idToUpdate === null) {
      this.isUpdated = false;
    } else {
      this.isUpdated = true;
      this.categoryToUpdate = this.$props.idToUpdate;
      this.getCategory(this.categoryToUpdate);
    }
  },

  computed: {
    ...mapState(["token"]),
  },
};
</script>