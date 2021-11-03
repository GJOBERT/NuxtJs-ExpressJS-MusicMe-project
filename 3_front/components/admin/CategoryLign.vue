<template>
  <tbody>
    <tr>
      <td>{{ category.id }}</td>
      <td>{{ category.name }}</td>
      <td @click="updateCategory(category.id, category.name)">
        <svg style="width: 24px; height: 24px" viewBox="0 0 24 24">
          <path
            fill="currentColor"
            d="M20.71,7.04C21.1,6.65 21.1,6 20.71,5.63L18.37,3.29C18,2.9 17.35,2.9 16.96,3.29L15.12,5.12L18.87,8.87M3,17.25V21H6.75L17.81,9.93L14.06,6.18L3,17.25Z"
          />
        </svg>
      </td>
      <td @click="deleteCategory(category.id, category.name)">
        <svg style="width: 24px; height: 24px" viewBox="0 0 24 24">
          <path
            fill="currentColor"
            d="M6,19A2,2 0 0,0 8,21H16A2,2 0 0,0 18,19V7H6V19M8.46,11.88L9.87,10.47L12,12.59L14.12,10.47L15.53,11.88L13.41,14L15.53,16.12L14.12,17.53L12,15.41L9.88,17.53L8.47,16.12L10.59,14L8.46,11.88M15.5,4L14.5,3H9.5L8.5,4H5V6H19V4H15.5Z"
          />
        </svg>
      </td>
    </tr>
  </tbody>
</template>

<script>
import server from '@/api/host';
import { mapState } from "vuex";

export default {
  data() {
    return {
      category: [],
    };
  },

  props: {
    categoryId: Number,
  },

  computed: {
    ...mapState(["token"]),
  },

  methods: {
    getCategoryById(id) {
      fetch("http://" + server + ":3333/api/category/" + id, {
        method: "GET",
        mode: "cors",
        headers: {
          "Content-Type": "application/json",
          Authorization: "Bearer " + this.token,
        },
      })
        .then((response) => response.json())
        .then((data) => {
          this.category = data.result[0];
        })
        .catch((error) => {
          console.log(error);
        });
    },

    deleteCategory(id, name) {
      let confirmation = confirm(
        'Êtes-vous sûr de vouloir supprimer la catégorie "' + name + '" ?'
      );
      if (confirmation) {
        fetch("http://" + server + ":3333/api/category/" + id, {
          method: "DELETE",
          mode: "cors",
          headers: {
            "Content-Type": "application/json;",
            Authorization: "Bearer " + this.$store.state.token,
          },
        })
          .then((res) => {
            this.$nuxt.$emit("triggerCategoriesDisplay");
          })
          .catch((error) => {
            console.log(error);
          });
      }
    },

    updateCategory(category_id, name) {
      let confirmation = confirm(
        'Êtes-vous sûr de vouloir modifier la catégorie "' + name + '" ?'
      );
      if (confirmation) {
        this.$nuxt.$emit("emitIdForUpdating", category_id);
        this.$nuxt.$emit("displayCategoryEditForm");
      }
    },
  },

  mounted() {
    this.getCategoryById(this.$props.categoryId);
  },
};
</script>

<style scoped>
td {
  text-align: left;
}
</style>