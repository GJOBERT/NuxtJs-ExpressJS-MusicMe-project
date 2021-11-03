const connect = require('../config/db.config');
const SQL = require('sql-template-strings');

exports.getFavorites = (req, res, next) => {

    connect.query(SQL`SELECT * FROM favorites`, (err, result) => {
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
					'Error': 'Favorites query : nothing found'
				});
			}
        }
    });
}

exports.getUserFavorites = (req, res, next) => {

	const client_id = req.params.id;

	connect.query(SQL`SELECT product_id FROM favorites
					WHERE client_id = ${client_id}`, (err, result) => {
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
					'Error': 'User favorites query : nothing found'
				});
			}
		}
	});
}


exports.createFavorite = (req, res, next) => {

    const reqBody = req.body;

	connect.query(SQL`SELECT id FROM favorites
					WHERE client_id = ${reqBody.client_id}
					AND product_id = ${reqBody.product_id}`, (err, result) => {
        if (err) {
            return res.status(500).json({
                'Error': err
            });
        } else {
			if (result.length > 0) {
				return res.status(401).json({
					'Unauthorized': 'This favorite already exists'
				});
			} else {
				connect.query(SQL`INSERT INTO favorites (product_id, client_id) 
								VALUES (${reqBody.product_id}, ${reqBody.client_id})`, (err, result) => { 
					if (err) {
						return res.status(500).json({
							'Error': err
						});
					} else {
						return res.status(201).json({
							'QueryOk': 'New favorite created successfully'
						});
					}
				});
			}
		}
	});
}

// exports.editFavorite = (req, res, next) => {

//     const uniq_id = req.params.id;
//     const reqBody = req.body;

//     connect.query(SQL`SELECT * FROM favorites WHERE uniq_id = "${uniq_id}"`, (err, result) => {
//         if (err) {
//             return res.status(404).json({
//                 'Error': err
//             });
//         } else {

//             if (result.length > 0) {

//                 connect.query(SQL`UPDATE favorites 
//                                 SET uniq_id = "${reqBody.name}"
//                                 WHERE uniq_id = "${uniq_id}"`, (err, result) => { 
//                     if (err) {
//                         return res.status(404).json({
//                             'Error': err
//                         });
//                     } else {
//                         return res.status(201).json({
//                             'QueryOk': 'Favorite edited successfully'
//                         });
//                     }
//                 });


//             } else {
//                 return res.status(404).json({
//                     'Error': 'Cannot find this category'
//                 });
//             }
//         }
//     });
// }

exports.deleteFavorite = (req, res, next) => {

    const body = req.body;

	connect.query(SQL`SELECT id FROM favorites
					WHERE client_id = ${body.client_id}
					AND product_id = ${body.product_id}`, (err, result) => {
        if (err) {
            return res.status(500).json({
                'Error': err
            });
        } else {
			if (result.length > 0) {
				connect.query(SQL`DELETE FROM favorites 
								WHERE product_id = ${body.product_id}
								AND client_id = ${body.client_id}`, (err, result) => { 
					if (err) {
						return res.status(500).json({
							'Error': err
						});
					} else {
						return res.status(200).json({
							'QueryOk': 'Favorite deleted successfully'
						});
					}
				});
			} else {
				return res.status(404).json({
					'Error': 'Favorite not found'
				});
			}
		}
	});
}