const connect = require('../config/db.config');
const SQL = require('sql-template-strings');
const mysql = require('mysql');

exports.getProducts = (req, res, next) => {

	connect.query(`SELECT id FROM products`, (err, result) => {
		if (err) {
			return res.status(500).json({
				'Error': err
			});
		} else {
			if (result.length > 0) {
				return res.status(200).json({
					result
				});
			} else {
				return res.status(404).json({
					'Error': 'Products not found'
				});
			}

		}
	});
}

exports.getAllProducts = (req, res, next) => {

	connect.query(`SELECT * FROM products`, (err, result) => {
		if (err) {
			return res.status(500).json({
				'Error': err
			});
		} else {
			if (result.length > 0) {
				return res.status(200).json({
					result
				});
			} else {
				return res.status(404).json({
					'Error': 'Products not found'
				});
			}

		}
	});
}

exports.getProduct = (req, res, next) => {

	const id = req.params.id;

	connect.query(SQL`SELECT id FROM products
                    WHERE id = ${id}`, (err, result) => {
		if (err) {
			return res.status(500).json({
				'Error': err
			});
		} else {

			if (result.length > 0) {

				connect.query(SQL`SELECT products.id, title, description, artist, year, price, image, num_available, num_reserved, num_total, category_id, categories.name AS 'category'
								FROM products
								INNER JOIN categories ON products.category_id = categories.id
								WHERE products.id = ${id}`, (err, result) => {
					if (err) {
						return res.status(500).json({
							'Error': err
						});
					} else {
						if (result.length > 0) {
							return res.status(200).json({
								result
							});
						} else {
							return res.status(404).json({
								'Error': 'Product not found'
							});
						}
					}
				});
			} else {
				return res.status(404).json({
					'Error': 'Product not found'
				});
			}
		}
	});
}

exports.searchProduct = (req, res, next) => {

	const search = req.body;

	// const query = `SELECT id FROM products
	// WHERE (title LIKE "%`+mysql.escape(search.main)+`%"
	// OR description LIKE "%`+mysql.escape(search.main)+`%"
	// OR artist LIKE "%`+mysql.escape(search.main)+`%"
	// OR year LIKE "%`+mysql.escape(search.main)+`%")
	// AND price <= `+mysql.escape(search.price)+`
	// AND category_id LIKE "%%" 
	// ORDER BY ${search.col} DESC`;
	const inserts = [search.main, search.main, search.main, search.main, search.price, search.category_id];

	connect.query(`SELECT id FROM products
				WHERE (title LIKE ?
				OR description LIKE ?
				OR artist LIKE ?
				OR year LIKE ?)
				AND price <= ?
				AND category_id LIKE ? 
				ORDER BY ${search.col} ${search.order}
				`, inserts, (err, result) => {
		if (err) {
			return res.status(500).json({
				'Error': err
			});
		} else {

			if (result.length > 0) {
				return res.status(200).json({
					result
				});
			} else {
				return res.status(404).json({
					'Error': 'Search products not found'
				});
			}
		}
	});
	
}

exports.deleteProduct = (req, res, next) => {
	let id = req.params.id;

	connect.query(SQL`SELECT id FROM products
                    WHERE id = ${id}`, (err, result) => {
		if (err) {
			return res.status(500).json({
				'Error': err
			});
		} else {
			if (result.length > 0) {

				connect.query(SQL`DELETE FROM products WHERE id = ${id}`, (err, result) => {
					if (err) {
						return res.status(500).json({
							'Error': err
						});
					} else {
						return res.status(200).json({ 'QueryOK': `Product deleted successfully` });
					}
				});
			} else {
				return res.status(404).json({
					'Error': 'Product not found'
				});
			}
		}
	});
}

exports.getRecommandationsByCategory = (req, res, next) => {

	const id = req.params.id;

	connect.query(SQL`SELECT products.id, categories.name AS 'category' 
					FROM products 
					INNER JOIN categories ON products.category_id = categories.id 
					WHERE category_id = ${id} LIMIT 12`, (err, result) => {
		if (err) {
			return res.status(500).json({
				'Error': err
			});
		} else {
			if (result.length > 0) {
				return res.status(200).json({
					result
				});
			} else {
				return res.status(404).json({
					'Error': 'Recommendation products not found'
				});
			}
		}
	});
}


exports.addProduct = (req, res, next) => {
	let product = req.body;

	connect.query(SQL`INSERT INTO products (title, description, artist, year, price, image, num_available, num_total, num_reserved, category_id)
                    VALUES (${product.title}, ${product.description}, ${product.artist}, ${product.year}, ${product.price}, ${product.image}, ${product.quantity}, ${product.quantity}, 0, ${product.category_id})`, (err, result) => {

		if (err) {
			return res.status(500).json({
				'Error': err
			});
		} else {
			return res.status(201).json({
				'QueryOK': 'Product created successfully',
			});
		}

	});
}

exports.editProduct = (req, res, next) => {
	let id = req.params.id;
	let reqBody = req.body;

	connect.query(SQL`SELECT * FROM products WHERE id = ${id}`, (err, result) => {
		if (err) {
			return res.status(500).json({
				'Error': err
			});
		} else {

			if (result.length > 0) {

				if (reqBody.image !== null && reqBody.image !== "" && reqBody.image !== undefined) {

					const inserts = [reqBody.title, reqBody.description, reqBody.artist, reqBody.year, reqBody.num_available, reqBody.num_reserved, reqBody.num_total, reqBody.category_id, id]

					connect.query(`UPDATE products 
								SET title = ?, 
								description = ?, 
								artist = ?, 
								year =  ?, 
								image = "${reqBody.image}", 
								num_available = ?, 
								num_reserved = ?, 
								num_total = ?, 
								category_id = ? 
								WHERE id = ?`, inserts, (err, result) => {

						if (err) {
							return res.status(500).json({
								'Error': err
							});
						} else {

							return res.status(201).json({
								'QueryOK': 'Product edited successfully'
							});
						}

					});
				} else {
					const inserts = [reqBody.title, reqBody.description, reqBody.artist, reqBody.year, reqBody.num_available, reqBody.num_reserved, reqBody.num_total, reqBody.category_id, id]

					connect.query(`UPDATE products 
								SET title = ?, 
								description = ?, 
								artist = ?, 
								year =  ?, 
								num_available = ?, 
								num_reserved = ?, 
								num_total = ?, 
								category_id = ? 
								WHERE id = ?`, inserts, (err, result) => {

						if (err) {
							return res.status(500).json({
								'Error': err
							});
						} else {

							return res.status(201).json({
								'QueryOK': 'Product edited successfully'
							});
						}

					});
				}
			} else {
				return res.status(404).json({
					'Error': 'Cannot find this product'
				});
			}
		}
	})		
}