const express = require("express");
const router = express.Router();
const prodCtrl = require("../controllers/products");
const auth = require('../middleware/auth');
const authAdmin = require('../middleware/authAdmin');

// GET / SEARCH
router.get('/', prodCtrl.getProducts);
router.get('/all', prodCtrl.getAllProducts);
router.get('/:id', prodCtrl.getProduct);
router.post('/search', prodCtrl.searchProduct);

// CREATE / UPDATE / DELETE
router.post('/', authAdmin, prodCtrl.addProduct);
router.put('/:id', authAdmin, prodCtrl.editProduct);
router.delete('/:id', authAdmin, prodCtrl.deleteProduct);

// Recommandations
// router.get('/recommandations/:id', prodCtrl.getProductsRecommandationsByCategory);

module.exports = router;