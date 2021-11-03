<template>
  <v-form v-model="valid">
    <v-container>
      <v-row>
        <v-col cols="2" md="2">
          <v-text-field
            v-model="title"
            :rules="titleRule"
            :counter="255"
            label="Titre"
            required
          ></v-text-field>
        </v-col>

        <v-col cols="1" md="2">
          <v-text-field
            v-model="artist"
            :rules="artistRule"
            :counter="255"
            label="Artiste"
            required
          ></v-text-field>
        </v-col>

        <v-col cols="4" md="4">
          <v-text-field
            :rules="descriptionRule"
            :counter="255"
            v-model="description"
            label="Description"
            required
          ></v-text-field>
        </v-col>

        <v-col cols="1" md="1">
          <v-text-field
            :rules="yearRule"
            v-model="year"
            label="Année"
            type="number"
            required
          ></v-text-field>
        </v-col>

        <v-col cols="1" md="1">
          <v-text-field
            :rules="catRule"
            v-model="category_id"
            label="Cat. ID"
            type="number"
            required
          ></v-text-field>
        </v-col>

        <v-col cols="1" md="1">
          <v-text-field
            :rules="priceRule"
            v-model="price"
            label="Prix"
            type="number"
            required
          ></v-text-field>
        </v-col>

        <v-col cols="1" md="1">
          <v-text-field
            :rules="stockRule"
            v-model="num_total"
            label="Stock total"
            type="number"
            required
          ></v-text-field>
        </v-col>

        <v-col cols="1" md="2" v-if="isUpdated">
          <v-text-field
            :rules="stockAvailableRule"
            v-model="num_available"
            label="Stock disponible"
            type="number"
            required
          ></v-text-field>
        </v-col>

        <v-col cols="1" md="3">
          <v-file-input
            @change="onFileChange"
            accept="image/png, image/jpeg, image/bmp"
            placeholder="Choisissez une image"
            prepend-icon="mdi-camera"
          ></v-file-input>
        </v-col>
      </v-row>
    </v-container>
    <v-btn
      v-if="isUpdated !== true"
      color="green"
      class="mr-4"
      @click="addProduct"
      :disabled="
        !num_total ||
        !price ||
        !year ||
        !category_id ||
        !description ||
        !artist ||
        !title
      "
    >
      Ajouter le produit
    </v-btn>
    <v-btn
      v-else
      color="green"
      class="mr-4"
      @click="updateProduct(productId)"
      :disabled="
        !num_available ||
        !num_total ||
        !price ||
        !year ||
        !category_id ||
        !description ||
        !artist ||
        !title
      "
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
      title: "",
      artist: "",
      price: null,
      description: "",
      category_id: null,
      year: null,
      num_total: null,
      num_available: null,
      num_reserved: 0,
      image: null,
      isUpdated: false,
      productId: null,
      productToUpdate: [],
      image_preview_url: "",
      titleRule: [
        (v) => !!v || "Champ requis",
        (v) =>
          v.length <= 255 || "Le titre ne doit pas dépasser 255 caractères.",
      ],
      artistRule: [
        (v) => !!v || "Champ requis",
        (v) =>
          v.length <= 255 ||
          "Le nom de l'artiste ne doit pas dépasser 255 caractères.",
      ],
      descriptionRule: [
        (v) => !!v || "Champ requis",
        (v) =>
          v.length <= 255 ||
          "La description ne doit pas dépasser 255 caractères.",
      ],
      priceRule: [(v) => !!v || "Champ requis"],
      yearRule: [(v) => !!v || "Champ requis"],
      catRule: [(v) => !!v || "Champ requis"],
      stockRule: [(v) => !!v || "Champ requis"],
      stockAvailableRule: [(v) => !!v || "Champ requis"],
    };
  },

  props: {
    idToUpdate: Number,
  },

  methods: {
    addProduct() {
      var newProduct = {
        title: this.title,
        description: this.description,
        artist: this.artist,
        year: this.year,
        price: this.price,
        image: this.image,
        quantity: this.num_total,
        category_id: this.category_id,
      };

      console.log(newProduct);

      newProduct = JSON.stringify(newProduct);

      fetch("http://" + server + ":3333/api/products", {
        method: "POST",
        mode: "cors",
        headers: {
          "Content-Type": "application/json",
          Authorization: "Bearer " + this.token,
        },
        body: newProduct,
      })
        .then((response) => response.json())
        .then((data) => {
          this.$nuxt.$emit("triggerProductsDisplay");
          this.$nuxt.$emit("hideAddProductForm");
        })
        .catch((error) => {
          console.log(error);
        });
    },

    updateProduct(product_id) {
      console.log(this.image);

      var updatedProduct = {
        title: this.title,
        description: this.description,
        artist: this.artist,
        year: this.year,
        price: this.price,
        image: this.image,
        num_available: this.num_available,
        num_reserved: this.num_reserved,
        num_total: this.num_total,
        category_id: this.category_id,
      };

      console.log(updatedProduct);

      updatedProduct = JSON.stringify(updatedProduct);

      fetch("http://" + server + ":3333/api/products/" + product_id, {
        method: "PUT",
        mode: "cors",
        headers: {
          "Content-Type": "application/json",
          Authorization: "Bearer " + this.token,
        },
        body: updatedProduct,
      })
        .then((response) => response.json())
        .then(() => {
          this.$nuxt.$emit("hideAddProductForm");
          this.$nuxt.$emit("triggerProductsDisplay");
          this.$nuxt.$emit('btnProductsDisplay');
          this.isUpdated = false;
        })
        .catch((error) => {
          console.log(error);
        });
    },

    getProduct(product_id) {
      this.productToUpdate = [];
      fetch("http://" + server + ":3333/api/products/" + product_id, {
        method: "GET",
        mode: "cors",
        headers: {
          "Content-Type": "application/json",
          Authorization: "Bearer " + this.token,
        },
      })
        .then((response) => response.json())
        .then((data) => {
          this.productToUpdate = data.result[0];
          this.title = this.productToUpdate.title;
          this.artist = this.productToUpdate.artist;
          this.description = this.productToUpdate.description;
          this.year = this.productToUpdate.year;
          this.price = this.productToUpdate.price;
          this.num_total = this.productToUpdate.num_total;
          this.num_available = this.productToUpdate.num_available;
          this.num_reserved = this.productToUpdate.num_reserved;
          this.category_id = this.productToUpdate.category_id;
        })
        .catch((error) => {
          console.log(error);
        });
    },

    async onFileChange(e) {
      const file = e;
      const reader = new FileReader();
      if (file instanceof Object) {
        reader.readAsDataURL(file);
        reader.onload = () => (this.image = reader.result);
        this.image_preview_url = URL.createObjectURL(file);
        this.image = await this.image_replacer();
      } else {
        console.log("Image issue");
      }
    },

    async image_replacer() {
      const response = await fetch(this.image_preview_url);
      const blob = await response.blob();
      const reader = new FileReader();
      await new Promise((resolve, reject) => {
        reader.onload = resolve;
        reader.onerror = reject;
        reader.readAsDataURL(blob);
      });
      return reader.result.toString();
    },

    async image_replacer_inverse() {
      const response = await fetch(this.image_preview_url);
      const blob = await response.blob();
      const reader = new FileReader();
      await new Promise((resolve, reject) => {
        reader.onload = resolve;
        reader.onerror = reject;
        reader.readAsDataURL(blob);
      });
      return reader.result.toString();
    },
  },

  mounted() {
    if (!this.$props.idToUpdate || this.$props.idToUpdate === null) {
      this.isUpdated = false;
    } else {
      this.isUpdated = true;
      this.productId = this.$props.idToUpdate;
      this.getProduct(this.$props.idToUpdate);
    }
  },

  computed: {
    ...mapState(["token"]),
  },
};
</script>