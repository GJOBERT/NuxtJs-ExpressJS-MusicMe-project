const express = require("express");
const router = express.Router();
const userCtrl = require("../controllers/user");
const auth = require('../middleware/auth');
const authAdmin = require('../middleware/authAdmin');

// // GET
router.get('/', authAdmin, userCtrl.getUsers);
router.get('/all', authAdmin, userCtrl.getUsersId);
router.get('/:id', auth, userCtrl.getUser);

// // USER ORDERS
router.get('/getorders/:id', auth, userCtrl.getUserOrders);

// SEARCH / UPDATE / DELETE
// router.post('/search', auth, userCtrl.searchUser);
router.put('/:id', auth, userCtrl.updateUser);
router.delete('/:id', auth, userCtrl.deleteUser);

//login
router.post('/login', userCtrl.login);
router.post('/signup', userCtrl.createUser);
router.post('/signupadmin', authAdmin, userCtrl.createUserAdmin);

module.exports = router;