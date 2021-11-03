const connect = require('../config/db.config');
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
const uuidv4 = require('uuid');
const SQL = require('sql-template-strings');

exports.getUsers = (req, res, next) => {
	
    connect.query(SQL`SELECT * FROM users`, (err, result) => {
        if (err) {
            return res.status(500).json({
                'Error': err
            });
        } else {
            if (result.length > 0) {
                const { password, ...user} = result[0];
                const users= [];
                result.forEach( r => {
                    const { password, ...user} = r;
                    users.push(user);
                });
                return res.status(200).json({
                    users
                });
            } else {
                return res.status(404).json({
                    'Error': "Users not found"
                });
            }
        }
    });
}

exports.login = (req, res, next) => {
    let email = req.body.email;
    let password = req.body.password;

    connect.query(SQL`SELECT * FROM users WHERE email = ${email}`, (err, result) => {
        if (err) {
            return res.status(500).json({
                'Error': err
            });
        } else {
            if (result.length > 0) {
                let user = result[0];

                bcrypt.compare(password, user.password)
                .then( same => {
                    if (!same) {
                        return res.status(401).json({
                            'Unauthorized': "Passwords don't match"
                        });
                    }
                    return res.status(200).json({

                        userId: user.token_id,
                        isAdmin: user.isAdmin,
                        token: jwt.sign({
                                userId: user.token_id,
                                isAdmin: user.isAdmin
                            },
                            process.env.SECRET_TOKEN,
                            {} // expiresIn: '1h'
                        ),
                    });
                })

            } else {
                return res.status(404).json({
                    'Error': 'Cannot find this user'
                });
            }
        }
	});
}

exports.createUser = (req, res, next) => {
    let user = req.body;

    connect.query(SQL`SELECT * FROM users WHERE email = ${user.email}`, (err, result) => {
        if (err) {
            return res.status(500).json({
                'Error': err
            });
        } else {

            if (result.length > 0) {
                return res.status(401).json({
                    'Unauthorized': 'This user already exists'
                })
            } else {

                bcrypt.hash(user.password, 10)
                .then(hash => {

					let token_id = uuidv4.v4().replace(/\D/g,'').substring(0,8);
                    user.password = hash

                    connect.query(SQL`INSERT INTO users (token_id, firstname, lastname, birthday, email, password, isAdmin)
                                    VALUES (${token_id}, ${user.firstname}, ${user.lastname}, ${user.birthday}, ${user.email}, ${user.password}, 0)`, (err, result) => {

                        if (err) {
                            return res.status(500).json({
                                'Error': err
                            });
                        } else {
                            return res.status(201).json({
                                'QueryOK': 'User created successfully'
                            });
                        }

                    });
                })

            }

        }
    });

}

exports.createUserAdmin = (req, res, next) => {
    let user = req.body;

    connect.query(SQL`SELECT * FROM users WHERE email = ${user.email}`, (err, result) => {
        if (err) {
            return res.status(500).json({
                'Error': err
            });
        } else {

            if (result.length > 0) {
                return res.status(401).json({
                    'Unauthorized': 'This user already exists'
                })
            } else {

                bcrypt.hash(user.password, 10)
                .then(hash => {

					let token_id = uuidv4.v4().replace(/\D/g,'').substring(0,12);
                    user.password = hash

                    connect.query(SQL`INSERT INTO users (token_id, firstname, lastname, birthday, email, password, isAdmin)
                                    VALUES (${token_id}, ${user.firstname}, ${user.lastname}, ${user.birthday}, ${user.email}, ${user.password}, ${user.isAdmin})`, (err, result) => {

                        if (err) {
                            return res.status(500).json({
                                'Error': err
                            });
                        } else {
                            return res.status(201).json({
                                'QueryOK': 'User created successfully'
                            });
                        }

                    });
                })

            }

        }
    });

}

exports.getUser = (req, res, next) => {
	let id = req.params.id;
	
	connect.query(SQL`SELECT id FROM users WHERE token_id = ${id}`, (err, result) => {
        if (err) {
            return res.status(500).json({
                'Error': err
            });
        } else {
			if (result.length > 0) {

                connect.query(SQL`SELECT * FROM users WHERE token_id = ${id}`, (err, result) => {
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
                    'Error': 'User not found'
				})
			}
		}
	});
}

exports.getUsersId = (req, res, next) => {

	connect.query(SQL`SELECT token_id FROM users`, (err, result) => {
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
					'Error': "Users not found"
				});
			}
		}
	});
}

exports.getUserOrders = (req, res, next) => {
	let id = req.params.id;
	
	connect.query(SQL`SELECT id FROM users WHERE token_id = ${id}`, (err, result) => {
        if (err) {
            return res.status(500).json({
                'Error': err
            });
        } else {
			if (result.length > 0) {

				connect.query(SQL`SELECT orders.uniq_id, orders.quantity, orders.order_date, orders.is_delivered, orders.client_id, users.firstname, users.lastname, products.artist, products.title, products.price, products.year, products.category_id, categories.name AS 'category'
								FROM orders
								INNER JOIN products ON orders.product_id = products.id
								INNER JOIN categories ON products.category_id = categories.id
								INNER JOIN users ON orders.client_id = users.token_id
								WHERE client_id = ${id}`, (err, result) => {
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
								'Error': "User's order not found"
							});
						}
					}
				});
			} else {
				return res.status(404).json({
					'Error': "User not found"
				});
			}
		}
	});
}

exports.updateUser = (req, res, next) => {
    let id = req.params.id;
    const reqBody = req.body;

    connect.query(SQL`SELECT * FROM users WHERE token_id = ${id}`, (err, result) => {
        if (err) {
            return res.status(500).json({
                'Error': err
            });
        } else {

            if (result.length > 0) {

                let user = result[0];

                if (reqBody.password === user.password) {

                    if (user.email != reqBody.email) {
                        checkEmail(reqBody);
                    } else {
                        update(reqBody);
                    }

                } else {

                    bcrypt.hash(reqBody.password, 10)
                    .then(hash => {
                        reqBody.password = hash;
                        if (user.email != reqBody.email) {
                            checkEmail(reqBody);
                        } else {
                            update(reqBody);
                        }
                    })
                }

            } else {
                return res.status(404).json({
                    'Error': "This user doesn't exist"
                });
            }

        }
    });

    function checkEmail(reqBody) {
        connect.query(SQL`SELECT * FROM users WHERE email = ${reqBody.email}`, (err, result) => {
            if (err) {
                return res.status(500).json({
                    'Error': err
                });
            } else {

                if (result.length > 0) {
                    return res.status(401).json({
                        'Unauthorized': 'This user already exists'
                    });
                } else {
                    update(reqBody);
                }
            }

        });
    }

    function update(reqBody) {

		const inserts = [reqBody.firstname, reqBody.lastname, reqBody.birthday, reqBody.email, reqBody.isAdmin, id];

		if (reqBody.avatar !== null && reqBody.avatar !== "" && reqBody.avatar !== undefined) {

			connect.query(`UPDATE users
							SET firstname = ?,
							lastname = ?,
							birthday =  ?,
							email = ?,
							password = "${reqBody.password}",
							avatar = '${reqBody.avatar}',
							isAdmin = ?
							WHERE token_id = ?`, inserts, (err, result) => {

				if (err) {
					return res.status(500).json({
						'Error': err
					});
				} else {
					return res.status(201).json({
						'QueryOK': 'User updated successfully'
					});
				}
			});
		} else {
			connect.query(`UPDATE users
							SET firstname = ?,
							lastname = ?,
							birthday =  ?,
							email = ?,
							password = "${reqBody.password}",
							isAdmin = ?
							WHERE token_id = ?`, inserts, (err, result) => {

				if (err) {
					return res.status(500).json({
						'Error': err
					});
				} else {
					return res.status(201).json({
						'QueryOK': 'User updated successfully'
					});
				}
			});
		}
    }
}

exports.deleteUser = (req, res, next) => {
    const id = req.params.id;

	connect.query(SQL`SELECT id FROM users WHERE token_id = ${id}`, (err, result) => {
        if (err) {
            return res.status(500).json({
                'Error': err
            });
        } else {
			if (result.length > 0) {

				connect.query(`DELETE FROM users WHERE token_id = ${id}`, (err, result) => {
					if (err) {
						return res.status(500).json({
							'Error': err
						});
					} else {
						return res.status(200).json({ 'QueryOK': `User deleted successfully`});
					}
				});
			} else {
				return res.status(404).json({
                    'Error': "This user doesn't exist"
                });
			}
		}
	});
}