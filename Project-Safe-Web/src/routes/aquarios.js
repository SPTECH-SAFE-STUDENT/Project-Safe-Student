var express = require("express");
var router = express.Router();

var vanController = require("../controllers/aquarioController");

router.get("/:empresaId", function (req, res) {
  vanController.buscarVansPorEmpresa(req, res);
});

router.post("/cadastrar", function (req, res) {
  vanController.cadastrar(req, res);
})

router.post("/kpiAlertas", function (req, res) {
  vanController.kpiAlertas(req, res);
})

router.post("/kpiCriticos", function (req, res) {
  vanController.kpiCriticos(req, res);
})

router.post("/kpiVansServico", function (req, res) {
  vanController.kpiVansServico(req, res);
})


module.exports = router;