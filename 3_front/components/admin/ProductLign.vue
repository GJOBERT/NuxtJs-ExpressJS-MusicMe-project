<template>
  <tbody v-if="product !== undefined">
    <tr>
      <td>{{ product.title }}</td>
      <td>{{ product.artist }}</td>
      <td>{{ product.year }}</td>
      <td>{{ product.category }}</td>
      <td>
        <v-avatar v-if="image_url !== '' || image_url === null"
          ><img :src="image_url"
        /></v-avatar>
        <v-avatar v-else
          ><svg style="width: 45px; height: 45px" viewBox="0 0 24 24">
            <path
              fill="currentColor"
              d="M12,19.2C9.5,19.2 7.29,17.92 6,16C6.03,14 10,12.9 12,12.9C14,12.9 17.97,14 18,16C16.71,17.92 14.5,19.2 12,19.2M12,5A3,3 0 0,1 15,8A3,3 0 0,1 12,11A3,3 0 0,1 9,8A3,3 0 0,1 12,5M12,2A10,10 0 0,0 2,12A10,10 0 0,0 12,22A10,10 0 0,0 22,12C22,6.47 17.5,2 12,2Z"
            /></svg
        ></v-avatar>
      </td>
      <td>{{ product.num_reserved }}</td>
      <td>{{ product.num_total }}</td>
      <td>{{ product.price }}</td>
      <td @click="updateProduct(product.id, product.title)">
        <svg style="width: 24px; height: 24px" viewBox="0 0 24 24">
          <path
            fill="currentColor"
            d="M20.71,7.04C21.1,6.65 21.1,6 20.71,5.63L18.37,3.29C18,2.9 17.35,2.9 16.96,3.29L15.12,5.12L18.87,8.87M3,17.25V21H6.75L17.81,9.93L14.06,6.18L3,17.25Z"
          />
        </svg>
      </td>
      <td @click="deleteProduct(product.id, product.title)">
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
import hugoServices from "@/api/hugoServices";
import server from '@/api/host';

export default {
  data() {
    return {
      product: [],
      category: [],
      image_url: "",
    };
  },

  props: {
    prodId: Number,
  },

  methods: {
    getProductById(id) {
      hugoServices
        .getProductById(id)
        .then((response) => {
			this.product = response;
			console.log(this.product)
			if (this.product.image !== null && this.product.image !== undefined && this.product.image !== "") {
				this.image_url = Buffer.from(this.product.image);
			}
			
        })
        .catch((error) => {
          console.log(error);
        });
    },

    deleteProduct(id, title) {
      console.log(id, title);
      let confirmation = confirm(
        'Êtes-vous sûr de vouloir supprimer le produit "' + title + '" ?'
      );
      if (confirmation) {
        fetch("http://" + server + ":3333/api/products/" + id, {
          method: "DELETE",
          mode: "cors",
          headers: {
            "Content-Type": "application/json;",
            Authorization: "Bearer " + this.$store.state.token,
          },
        })
          .then(() => {
            this.$nuxt.$emit("triggerProductsDisplay");
            console.log(id);
          })
          .catch((error) => {
            console.log(error);
          });
      }
    },

    updateProduct(product_id, title) {
      let confirmation = confirm(
        'Êtes-vous sûr de vouloir modifier le produit "' + title + '" ?'
      );
      if (confirmation) {
        this.$nuxt.$emit("emitIdForUpdating", product_id);
        this.$nuxt.$emit("displayProductEditForm");
      }
    },
  },

  mounted() {
    this.getProductById(this.$props.prodId);
  },
};
</script>

<style scoped>
td {
  text-align: left;
}
</style>