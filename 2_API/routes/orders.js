const express = require("express");
const router = express.Router();
const orderCtrl = require("../controllers/orders");
const auth = require('../middleware/auth');
const authAdmin = require('../middleware/authAdmin');


router.get('/', authAdmin, orderCtrl.getOrders);
router.get('/:id', auth, orderCtrl.getOrder);
router.post('/', auth, orderCtrl.createOrder);
router.put('/:id', authAdmin, orderCtrl.editOrder);
router.delete('/:id', authAdmin, orderCtrl.deleteOrder);

module.exports = router;