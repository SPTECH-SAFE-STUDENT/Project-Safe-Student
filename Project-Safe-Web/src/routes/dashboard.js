var express = require("express");
var router = express.Router();

router.get("/buscarTemperatura/:idVan", function (req, res) {
    formularioController.buscarTemperatura(req, res);
});

router.get("/buscarProximidade/:idVan", function (req, res) {
    formularioController.buscarProximidade(req, res);
});

module.exports = router;