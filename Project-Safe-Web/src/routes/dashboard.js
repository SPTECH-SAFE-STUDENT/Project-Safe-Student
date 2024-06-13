var express = require("express");
var router = express.Router();

var dashboardController = require("../controllers/dashboardController");

router.get("/buscarTemperatura/:idVan", function (req, res) {
    dashboardController.buscarTemperatura(req, res);
});

router.get("/buscarProximidade/:idVan", function (req, res) {
    dashboardController.buscarProximidade(req, res);
});

module.exports = router;