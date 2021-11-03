const connect = require('../config/db.config');
const uuidv4 = require('uuid');
const SQL = require('sql-template-strings');

exports.getOrders = (req, res, next) => {

    connect.query(SQL`SELECT uniq_id FROM orders`, (err, result) => {
        if (err) {
            return res.status(500).json({
                'Error': err
            });
        } else {
			if (result.length > 0) {
				return res.status(200).json({
					result
				});
			} else  {
				return res.status(404).json({
					'Error': 'Get all orders query : nothing found'
				});
			}
        }
    });
}

exports.getOrder = (req, res, next) => {

    const uniq_id = req.params.id;

    connect.query(SQL`SELECT id FROM orders WHERE uniq_id = ${uniq_id}`, (err, result) => {
        if (err) {
            return res.status(500).json({
                'Error': err
            });
        } else {
			if (result.length > 0) {

				connect.query(SQL`SELECT orders.uniq_id, orders.client_id, orders.quantity, orders.order_date, orders.deliver_date, orders.is_delivered, users.firstname, users.lastname, products.artist, products.title, products.price, products.year, products.image, products.category_id, categories.name AS 'category'
								FROM orders
								INNER JOIN products ON orders.product_id = products.id
								INNER JOIN categories ON products.category_id = categories.id
								INNER JOIN users ON orders.client_id = users.token_id
								WHERE orders.uniq_id = ${uniq_id}`, (err, result) => {
					if (err) {
						return res.status(500).json({
							'Error': err
						});
					} else {
						return res.status(200).json({
							result
						});
					}
				});
			} else {
				return res.status(404).json({
					'Error': 'Order not found'
				});
			}
        }
    });
}

exports.createOrder = (req, res, next) => {

    const reqBody = req.body;
	if (reqBody.deliver_date === undefined) {
		reqBody.deliver_date = '1000-00-00';
	}

    connect.query(SQL`INSERT INTO orders (uniq_id, client_id, product_id, quantity, order_date, deliver_date, is_delivered) 
                    VALUES (${reqBody.uniq_id}, ${reqBody.client_id}, ${reqBody.product_id}, ${reqBody.quantity}, ${reqBody.order_date}, ${reqBody.deliver_date}, 0)`, (err, result) => { 
        if (err) {
            return res.status(500).json({
                'Error': err
            });
        } else {
            return res.status(201).json({
				'QueryOk': 'New order created successfully'
            });
        }
    });
}

exports.editOrder = (req, res, next) => {

    const uniq_id = req.params.id;
    const reqBody = req.body;

    connect.query(SQL`SELECT id FROM orders WHERE uniq_id = ${uniq_id}`, (err, result) => {
        if (err) {
            return res.status(500).json({
                'Error': err
            });
        } else {

            if (result.length > 0) {

                connect.query(SQL`UPDATE orders 
								SET is_delivered = ${reqBody.is_delivered},
                                deliver_date = ${reqBody.deliver_date},
                                quantity = ${reqBody.quantity}
                                WHERE uniq_id = ${uniq_id}`, (err, result) => { 
                    if (err) {
                        return res.status(404).json({
                            'Error': err
                        });
                    } else {
                        return res.status(201).json({
                            'QueryOk': 'Order edited successfully'
                        });
                    }
                });


            } else {
                return res.status(404).json({
                    'Error': 'Cannot find this order'
                });
            }
        }
    });
}

exports.deleteOrder = (req, res, next) => {

	const uniq_id = req.params.id;
	
	connect.query(SQL`SELECT id FROM orders WHERE uniq_id = ${uniq_id}`, (err, result) => {
        if (err) {
            return res.status(500).json({
                'Error': err
            });
        } else {

			if (result.length > 0) {

				connect.query(SQL`DELETE FROM orders 
								WHERE uniq_id = ${uniq_id}`, (err, result) => { 
					if (err) {
						return res.status(500).json({
							'Error': err
						});
					} else {
						return res.status(200).json({
							'QueryOk': 'Order deleted successfully'
						});
					}
				});
			} else {
				return res.status(404).json({
					'Error': 'Cannot find this order'
				});
			}
		}
	});
}