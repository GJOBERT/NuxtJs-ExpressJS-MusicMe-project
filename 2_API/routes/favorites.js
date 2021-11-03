const express = require("express");
const router = express.Router();
const favoritesCtrl = require("../controllers/favorites");
const auth = require('../middleware/auth');

router.get('/', auth, favoritesCtrl.getFavorites);
router.get('/:id', auth, favoritesCtrl.getUserFavorites);
router.post('/', auth, favoritesCtrl.createFavorite);
router.post('/delete', auth, favoritesCtrl.deleteFavorite);

module.exports = router;