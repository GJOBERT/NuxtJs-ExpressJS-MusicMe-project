const express = require("express");
const bodyParser = require("body-parser");

const userRoutes = require("./routes/user");
const productsRoutes = require("./routes/products");
const categoryRoutes = require("./routes/category");
const ordersRoutes = require("./routes/orders");
const favoritesRoutes = require("./routes/favorites");

const app = express();

// Système de sécurité CORS : Cross Origin Resource Sharing
app.use((req, res, next) => {
    res.setHeader("Access-Control-Allow-Origin", "*");
    res.setHeader("Access-Control-Allow-Headers", "Origin, X-Requested-With, Content, Accept, Content-Type, Authorization");
    res.setHeader("Access-Control-Allow-Methods", "GET, POST, PUT, DELETE, PATCH, OPTIONS");
    next();
});


// app.use(express.static(__dirname, { dotfiles: 'allow' } ));

app.use(bodyParser.json({ limit: '50mb' }));
app.use(bodyParser.urlencoded({ limit: '50mb', extended: true, parameterLimit: 50000 }));

app.use("/api/user", userRoutes);
app.use("/api/products", productsRoutes);
app.use("/api/category", categoryRoutes);
app.use("/api/orders", ordersRoutes);
app.use("/api/favorites", favoritesRoutes);

module.exports = app;