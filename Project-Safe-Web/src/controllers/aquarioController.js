var aquarioModel = require("../models/aquarioModel");

function buscarVansPorEmpresa(req, res) {
  var idUsuario = req.params.idUsuario;

  aquarioModel.buscarVansPorEmpresa(idUsuario).then((resultado) => {
    if (resultado.length > 0) {
      res.status(200).json(resultado);
    } else {
      res.status(204).json([]);
    }
  }).catch(function (erro) {
    console.log(erro);
    console.log("Houve um erro ao buscar os aquarios: ", erro.sqlMessage);
    res.status(500).json(erro.sqlMessage);
  });
}


function cadastrar(req, res) {
  var descricao = req.body.descricao;
  var idUsuario = req.body.idUsuario;

  if (descricao == undefined) {
    res.status(400).send("descricao está undefined!");
  } else if (idUsuario == undefined) {
    res.status(400).send("idUsuario está undefined!");
  } else {


    aquarioModel.cadastrar(descricao, idUsuario)
      .then((resultado) => {
        res.status(201).json(resultado);
      }
      ).catch((erro) => {
        console.log(erro);
        console.log(
          "\nHouve um erro ao realizar o cadastro! Erro: ",
          erro.sqlMessage
        );
        res.status(500).json(erro.sqlMessage);
      });
  }
}

function kpiAlertas(req, res) {

  var fkCnpj = req.body.fkCnpj;

  console.log(`Buscando dados  da Kpi alertas`);

  aquarioModel.kpiAlertas(fkCnpj).then(function (resultado) {
      if (resultado.length > 0) {
          res.status(200).json(resultado); /*resposta que o bd traz*/
      } else {
          res.status(204).send("Nenhum resultado encontrado!")
      }
  }).catch(function (erro) {
      console.log(erro);
      console.log("Houve um erro ao buscar as ultimos resultados.", erro.sqlMessage);
      res.status(500).json(erro.sqlMessage);
  });
}

function kpiCriticos(req, res) {

  var fkCnpj = req.body.fkCnpj;

  console.log(`Buscando dados da Kpi alertas Criticos`);

  aquarioModel.kpiCriticos(fkCnpj).then(function (resultado) {
      if (resultado.length > 0) {
          res.status(200).json(resultado); /*resposta que o bd traz*/
      } else {
          res.status(204).send("Nenhum resultado encontrado!")
      }
  }).catch(function (erro) {
      console.log(erro);
      console.log("Houve um erro ao buscar as ultimos resultados.", erro.sqlMessage);
      res.status(500).json(erro.sqlMessage);
  });
}

function kpiVansServico(req, res) {

  var fkCnpj = req.body.fkCnpj;

  console.log(`Buscando dados de proximidade da van pelo id`);

  aquarioModel.kpiVansServico(fkCnpj).then(function (resultado) {
      if (resultado.length > 0) {
          res.status(200).json(resultado); /*resposta que o bd traz*/
      } else {
          res.status(204).send("Nenhum resultado encontrado!")
      }
  }).catch(function (erro) {
      console.log(erro);
      console.log("Houve um erro ao buscar as ultimos resultados.", erro.sqlMessage);
      res.status(500).json(erro.sqlMessage);
  });
}

module.exports = {
  buscarVansPorEmpresa,
  cadastrar,
  kpiAlertas,
  kpiCriticos,
  kpiVansServico
}