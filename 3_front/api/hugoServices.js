const DEFAULT_HEADERS = {
    "Content-Type": "application/json",
}

import server from './host';

export default {

    // Products

    getAllproducts() {
        return new Promise((resolve, reject) => {
            fetch("http://"+server+":3333/api/products")
                .then((response) => response.json())
                .then((data) => {
                    resolve(data.result[0]);
                })
                .catch(reject)
        })
    },

    getProductById(id) {
        return new Promise((resolve, reject) => {
            fetch("http://"+server+":3333/api/products/" + id)
                .then((response) => response.json())
                .then((data) => {
					if (data.result !== undefined) {
                    	resolve(data.result[0]);
					} else {
						let myresult = undefined;
						resolve(myresult);
					}
                })
                .catch(reject)
        })
    },

    addProduct(newProduct, token) {
        return new Promise((resolve, reject) => {
            fetch("http://"+server+":3333/api/products", {
                method: "POST",
                mode: "cors",
                headers: {
                    "Content-Type": "application/json",
                    Authorization: "Bearer " + token
                },
                body: newProduct,
            })
                .then((response) => response.json())
                .then((data) => {
                    resolve(data.result[0]);
                })
                .catch(reject);
        })
    },

    updateProduct(id, product, token) {
        return new Promise((resolve, reject) => {
            fetch(`http://`+server+`:3333/api/products/update/${id}`, {
                method: 'PUT',
                mode: 'cors',
                headers: {
                    "Content-Type": "application/json",
                    Authorization: "Bearer " + token
                },
                body: product
            })
                .then(response => response.json())
                .then((data) => {
                    resolve(data.result[0]);
                })
                .catch(reject)
        })
    },

    deleteProduct(id, title, token) {
        // Commit à supprimer après implémentation dans le login
        this.$store.commit(
            "setToken",
            "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI4MDIzODU5NCIsImlzQWRtaW4iOjEsImlhdCI6MTYxMjUxOTE3NH0.BVlOsgCb2CQLCuXnm1NvZ2I0iY7i6Y5iByoIQ1gE-vc"
        )
        //

        let confirmation = confirm(
            'Êtes-vous sûr de vouloir supprimer le produit "' + title + '" ?'
        );
        if (confirmation) {
            return new Promise((resolve, reject) => {
                fetch("http://"+server+":3333/api/products/" + id, {
                    method: "DELETE",
                    mode: "cors",
                    headers: {
                        "Content-Type": "application/json",
                        Authorization: "Bearer " + token
                    },
                })
                    .then((data) => {
                        resolve(data.result[0]);
                    })
                    .catch(reject);
            })
        }

    },

    // Users

    addUser(newUser, token) {
        return new Promise((resolve, reject) => {
            fetch("http://"+server+":3333/api/user/signupadmin", {
                method: "POST",
                mode: "cors",
                headers: {
                    "Content-Type": "application/json",
                    Authorization: "Bearer " + token,
                },
                body: newUser,
            })
                .then((response) => response.json())
                .then((data) => {
                    resolve(data);
                })
                .catch(reject);
        })
    },

    getUsers(token) {
        return new Promise((resolve, reject) => {
            fetch("http://"+server+":3333/api/users", {
                method: "GET",
                mode: "cors",
                headers: {
                    "Content-Type": "application/json",
                    Authorization: "Bearer " + token
                },
            })
                .then((response) => response.json())
                .then((data) => {
                    resolve(data);
                })
                .catch(reject);
        })
    },

    getUserById(token_id, token) {
        return new Promise((resolve, reject) => {
            fetch("http://"+server+":3333/api/user/" + token_id, {
                method: "GET",
                mode: "cors",
                headers: {
                    "Content-Type": "application/json",
                    Authorization: "Bearer " + token
                },
            })
                .then((response) => response.json())
                .then((data) => {
                    resolve(data.result[0]);
                })
                .catch(reject)
        })
    },
}