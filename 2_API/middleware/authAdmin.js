const jwt = require('jsonwebtoken');

module.exports = (req, res, next) => {
    try {
        const token = req.headers.authorization.split(' ')[1];
        const decodedToken = jwt.verify(token, process.env.SECRET_TOKEN);
		const userId = decodedToken.userId;
		const isAdmin = decodedToken.isAdmin;

        if ((req.body.id && req.body.id != userId) || (isAdmin != 1) ) {
            throw 'Incorrect userID or User not admin';
        } else {
            next();
        }

    } catch (error) {
        res.status(401).json({ error });
    }
}