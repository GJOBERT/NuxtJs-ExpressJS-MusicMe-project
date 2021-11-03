const DEFAULT_HEADERS = {
	'Content-Type': 'application/json'
}

import server from './host';

export default {

	login () {
		return new Promise((resolve, reject) => {
			fetch(`http://`+server+`:3333/api/user/login`, {

				method: 'POST',
				mode: "cors",
				headers: DEFAULT_HEADERS
			})
			.then(response => response.json())
			.then((data) => resolve(data.result))
			.catch(reject)
		})
	},

	getAllproducts () {
		return new Promise((resolve, reject) => {
			fetch(`http://`+server+`:3333/api/products/`, {

				method: 'GET',
				headers: DEFAULT_HEADERS
			})
			.then(response => response.json())
			.then((data) => resolve(data.result))
			.catch(reject)
		})
	},

	async newSearch(search){
		const response = await fetch(`http://`+server+`:3333/api/products/search/`, {
		method: 'POST',
		mode: 'cors',
		headers: DEFAULT_HEADERS,
		body: search
		});
		return response.json();
	},

	getProduct(id) {
		return new Promise((resolve, reject) => {
			fetch(`http://`+server+`:3333/api/products/${id}`, {

				method: 'GET',
				headers: DEFAULT_HEADERS
			})
			.then(response => response.json())
			.then((data) => resolve(data.result))
			.catch(reject)
		})
	},

	addProduct(product, token) {
		return new Promise((resolve, reject) => {
			fetch(`http://`+server+`:3333/api/products/`, {

			method: 'POST',
			mode: 'cors',
			headers: {
				'Authorization': 'Bearer '+token,
				'Content-Type': 'application/json'
			},
			body: product
			})
			.then(response => {
				response.json()
				console.log(token)
			})
			.then(data => resolve(data))
			.catch(reject)
		})
	},

	// getProductsByCategoryRecommandations (category_id) {
	// 	return new Promise((resolve, reject) => {
	// 		fetch(`http://`+server+`:3333/api/products/recommandations/${category_id}`, {

	// 		method: 'GET',
	// 		headers: DEFAULT_HEADERS
	// 		})
	// 		.then(response => response.json())
	// 		.then(data => resolve(data.result))
	// 		.catch(reject);
	// 	})
	// },

	updateProducts (id, product, token) {
		return new Promise((resolve, reject) => {
			fetch(`http://`+server+`:3333/api/products/update/${id}`, {

			method: 'PUT',
			mode: 'cors',
			headers: {
				'Authorization': 'Bearer '+token,
				'Content-Type': 'application/json'
			},
			body: product
			})
			.then(response => response.json())
			.then(data => resolve(data.result))
			.catch(reject)
		})
	},

	searchProducts (search) {
		return new Promise((resolve, reject) => {
			fetch(`http://139.162.164.39:3333/api/products/search`, {

				method: 'POST',
				headers: {
					'Content-Type': 'application/json'
				},
				body: search
			})
			.then(response => response.json())
			.then(data => resolve(data.result))
			.catch(reject)
		})
	},

	getCategories() {
		return new Promise((resolve, reject) => {
			fetch(`http://`+server+`:3333/api/category/`, {

				method: 'GET',
				headers: DEFAULT_HEADERS,
			})
			.then(response => response.json())
			.then(data => resolve(data.result))
			.catch(reject)
		})
	},



	// USER

	getUserproducts (id, token) {
		return new Promise((resolve, reject) => {
			fetch(`http://`+server+`:3333/api/user/getorders/${id}`, {

			method: 'GET',
			mode: 'cors',
			headers: {
				'Authorization': 'Bearer '+token,
				'Content-Type': 'application/json'
			}
			})
			.then(response => response.json())
			.then((data) => resolve(data.result))
			.catch(reject)
		})
	},

	updateUser (id, user, token) {
		return new Promise((resolve, reject) => {
			fetch(`http://`+server+`:3333/api/user/${id}`, {

				method: 'PUT',
				mode: 'cors',
				headers: {
				'Authorization': 'Bearer '+token,
				'Content-Type': 'application/json'
				},
				body: user
			})
			.then(response => response.json())
			.then(data => resolve(data.result))
			.catch(reject)
		})
	},

	getUser (id, token) {
		return new Promise((resolve, reject) => {
			fetch(`http://`+server+`:3333/api/user/${id}`, {

			method: 'GET',
			mode: 'cors',
			headers: {
				'Authorization': 'Bearer '+token,
				'Content-Type': 'application/json'
			}
			})
			.then(response => response.json())
			.then(data => resolve(data.result))
			.catch(reject);
		})
	},

}