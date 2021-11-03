import createPersistedState from "vuex-persistedstate";

export const plugins = [createPersistedState()]

export const state = () => ({

	//Status
	isLoggedIn: false,

	//Admin
	userIsAdmin: 0,

	//Token
	token: '',

	//User
	user: null,
	userId: '',
	cart: [],

	// Search body User side
	search_object: {
		main: '',
		price: 1000,
		category_id: '',
		orderby: 'ORDER BY',
		col: 'id',
		order: 'DESC',
	},
	category_id_search: "",
	price_search: 1000,

	idSaved: '',

	avatar: null


})

export const mutations = {

	// SEARCH

	setSearchObject(state, searchObject) {
		state.search_object = searchObject;
	},

	unsetSearchObject(state) {
		state.search_object = {
			main: '',
			price: 1000,
			category_id: '',
			orderby: 'ORDER BY',
			col: 'id',
			order: 'DESC',
		}
	},

	setCategorySearch(state, category) {
		state.category_id_search = category;
	},

	setPriceSearch(state, price) {
		state.price_search = price;
	},

	unsetCategorySearch(state) {
		state.category_id_search = "";
	},

	unsetPriceSearch(state) {
		state.price_search = 10000;
	},

	// USER

	setAvatar(state, avatar) {
		state.avatar = avatar;
	},

	setUser(state, user) {
		state.user = user;
	},
	unsetUser(state) {
		state.user = null;
	},

	setIsSaved(state, id) {
		state.idSaved = id;
	},
	unsetIsSaved(state) {
		state.idSaved = '';
	},

	setUserId(state, id) {
		state.userId = id
	},
	unsetUserId(state) {
		state.userId = '';
	},

	connect(state) {
		state.isLoggedIn = true
	},
	unsetIsLoggedIn(state) {
		state.isLoggedIn = false;
	},

	setToken(state, token) {
		state.token = token;
	},
	unsetToken(state) {
		state.token = '';
	},

	addCart(state, newProduct) {

		if (!state.cart.length) {
			newProduct.quantity = 1
			state.cart.push(newProduct)
		} else {

			const index = state.cart.findIndex((product) => {
				if (product.id == newProduct.id) {
					product.quantity += 1
					return true
				}
			})

			if (index == -1) {
				newProduct.quantity = 1
				state.cart.push(newProduct)
			}
		}
	},

	incrementProduct(state, productId) {
		state.cart = state.cart.map((product) => {
			if (product.id == productId) {
				product.quantity += 1
			}
			return product
		})
	},

	decrementProduct(state, productId) {
		state.cart = state.cart.map((product) => {
			if (product.id == productId) {
				product.quantity -= 1
			}
			return product
		})
	},

	removeProduct(state, productId) {
		state.cart = state.cart.filter((product) => {
			if (product.id == productId) {
				return false
			} else { return true }
		})
	},

	unsetCart(state) {
		state.cart = []
	},

	setIsAdmin(state, value) {
		state.userIsAdmin = value;
	},
	unsetIsAdmin(state) {
		state.userIsAdmin = 0;
	},

	logOut(state) {
		state.userIsAdmin = '';
		state.token = '';
		state.isLoggedIn = false;
		state.userId = '';
		state.idSaved = '';
		state.user = null;
	}
}

export const actions = {

	LogOut({ commit }) {
		commit('unsetUser');
		commit('unsetUserId');
		commit('unsetIsSaved');
		commit('unsetIsAdmin');
		commit('unsetIsLoggedIn');
		commit('unsetToken');
		commit('unsetSearchObject');
	},
}

export const modules = {

}