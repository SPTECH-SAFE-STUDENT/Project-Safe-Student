var express = require("express");
var router = express.Router();

var aquarioController = require("../controllers/aquarioController");

router.get("/:empresaId", function (req, res) {
  aquarioController.buscarVansPorEmpresa(req, res);
});

router.post("/cadastrar", function (req, res) {
  aquarioController.cadastrar(req, res);
})

router.post("/kpiAlertas", function (req, res) {
  aquarioController.kpiAlertas(req, res);
})

router.post("/kpiCriticos", function (req, res) {
  aquarioController.kpiCriticos(req, res);
})

router.post("/kpiVansServico", function (req, res) {
  aquarioController.kpiVansServico(req, res);
})

module.exports = router;