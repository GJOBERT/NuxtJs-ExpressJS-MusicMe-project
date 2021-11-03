const connect = require('../config/db.config');
const SQL = require('sql-template-strings');

exports.getCategories = (req, res, next) => {

    connect.query(`SELECT * FROM categories`, (err, result) => {
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
					'Error': 'Categories not found'
				});
			}
        }
    });
}

exports.getCategory = (req, res, next) => {

    const id = req.params.id;

    connect.query(SQL`SELECT * FROM categories WHERE id = ${id}`, (err, result) => {
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
					'Error': 'Category not found'
				});
			}
        }
    });
}


exports.createCategory = (req, res, next) => {

    const reqBody = req.body;

    connect.query(SQL`INSERT INTO categories (name) 
                    VALUES (${reqBody.name})`, (err, result) => { 
        if (err) {
            return res.status(500).json({
                'Error': err
            });
        } else {
            return res.status(201).json({
                'QueryOk': 'New category created successfully'
            });
        }
    });
}

exports.editCategory = (req, res, next) => {

    const id = req.params.id;
    const reqBody = req.body;

    connect.query(SQL`SELECT * FROM categories WHERE id = ${id}`, (err, result) => {
        if (err) {
            return res.status(500).json({
                'Error': err
            });
        } else {
            if (result.length > 0) {

                connect.query(SQL`UPDATE categories 
                                SET name = ${reqBody.name}
                                WHERE id = ${id}`, (err, result) => { 
                    if (err) {
                        return res.status(404).json({
                            'Error': err
                        });
                    } else {
                        return res.status(201).json({
                            'QueryOk': 'Category edited successfully'
                        });
                    }
                });
            } else {
                return res.status(404).json({
                    'Error': 'Cannot find this category'
                });
            }
        }
    });    
}

exports.deleteCategory = (req, res, next) => {

    const id = req.params.id;

	connect.query(SQL`SELECT * FROM categories WHERE id = ${id}`, (err, result) => {
        if (err) {
            return res.status(500).json({
                'Error': err
            });
        } else {
            if (result.length > 0) {

				connect.query(SQL`DELETE FROM categories 
								WHERE id = ${id}`, (err, result) => { 
					if (err) {
						return res.status(500).json({
							'Error': err
						});
					} else {
						return res.status(200).json({
							'QueryOk': 'Category deleted successfully'
						});
					}
				});
			} else {
				return res.status(404).json({
                    'Error': 'Cannot find this category'
                });
			}
		}
	});
}