var dashboardModel = require("../models/dashboardModel");

function buscarTemperatura(req, res) {

    var idVan = req.params.idVan;

    console.log(`Buscando a temperatura da van pelo id`);

    dashboardModel.buscarTemperatura(idVan).then(function (resultado) {
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

function buscarProximidade(req, res) {

    var idVan = req.params.idVan;

    console.log(`Buscando dados de proximidade da van pelo id`);

    dashboardModel.buscarProximidade(idVan).then(function (resultado) {
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
    buscarTemperatura,
    buscarProximidade
}
