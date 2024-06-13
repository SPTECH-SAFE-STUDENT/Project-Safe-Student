var express = require("express");
var router = express.Router();

var dashboardController = require("../controllers/dashboardController");

router.get("/buscarTemperatura/:idVan", function (req, res) {
    dashboardController.buscarTemperatura(req, res);
});

router.get("/buscarProximidade/:idVan", function (req, res) {
    dashboardController.buscarProximidade(req, res);
});

router.get("/bancosOcupados/:idVan", function (req, res) {
    dashboardController.kpiBancos(req, res);
});

router.get("/temperaturaMaxMin/:idVan", function (req, res) {
    dashboardController.kpiTemperatura(req, res);
});

router.put("/iniciarFinalizar", function (req, res) {
    dashboardController.iniciarFinalizarViagem(req, res);
});


module.exports = router;