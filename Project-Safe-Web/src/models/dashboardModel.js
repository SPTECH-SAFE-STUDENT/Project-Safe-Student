var database = require("../database/config");



function buscarTemperatura(idVan) {
    var buscarTemperaturaID = `SELECT lt.fksensorTemp, lt.temperatura FROM LeituraTemp as lt 
    inner join Sensores as sn
    on lt.fksensorTemp = sn.id
    where sn.fkveiculo= '${idVan}' order by lt.fksensorTemp;
    `;

    console.log("Executando a instrução SQL: \n" + buscarTemperaturaID);
    return database.executar(buscarTemperaturaID);
}

function buscarProximidade() {

}




module.exports = {
    buscarTemperatura,
    buscarProximidade
}