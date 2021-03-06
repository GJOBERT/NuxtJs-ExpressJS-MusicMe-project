const jwt = require('jsonwebtoken');

module.exports = (req, res, next) => {
    try {
        const token = req.headers.authorization.split(' ')[1];
        const decodedToken = jwt.verify(token, process.env.SECRET_TOKEN);
        const userId = decodedToken.userId;

        if (req.body.id && req.body.id != userId) {
            throw 'Incorrect userID';
        } else {
            next();
        }

    } catch (error) {
        res.status(401).json({ error });
    }
}