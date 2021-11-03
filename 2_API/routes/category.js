const express = require("express");
const router = express.Router();
const categoryCtrl = require("../controllers/category");
const auth = require('../middleware/auth');

router.get('/', categoryCtrl.getCategories);
router.get('/:id', categoryCtrl.getCategory);
router.post('/', auth, categoryCtrl.createCategory);
router.put('/:id', auth, categoryCtrl.editCategory);
router.delete('/:id', auth, categoryCtrl.deleteCategory);

module.exports = router;
