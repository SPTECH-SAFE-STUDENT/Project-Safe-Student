var database = require("../database/config");

function buscarUltimasMedidas(idAquario, limite_linhas) {

    var instrucaoSql = `SELECT 
        dht11_temperatura as temperatura, 
        dht11_umidade as umidade,
                        momento,
                        DATE_FORMAT(momento,'%H:%i:%s') as momento_grafico
                    FROM medida
                    WHERE fk_aquario = ${idAquario}
                    ORDER BY id DESC LIMIT ${limite_linhas}`;

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function buscarMedidasEmTempoReal(idVan) {
    let sensorA = 1
    let sensorB = 2

    if (idVan == 'BAB2222') {
        sensorA = 17
        sensorB = 18
    } else
        if (idVan == 'AXC1111') {
            sensorA = 35
            sensorB = 36
        }

    var instrucaoSql = `SELECT
	lt.id,
    MAX(CASE WHEN lt.fkSensorTemp = ${sensorA} THEN lt.temperatura ELSE NULL END) AS SensorTempA,
    MAX(CASE WHEN lt.fkSensorTemp = ${sensorB} THEN lt.temperatura ELSE NULL END) AS SensorTempB,
    lt.horario
FROM leituraTemp as lt
INNER JOIN sensores as sn
    ON lt.fkSensorTemp = sn.id
WHERE sn.fkVeiculo = '${idVan}'
GROUP BY lt.id 
order by lt.id desc
limit 2;
    `;

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function buscarTemperatura(idVan) {
    let sensorA = 1
    let sensorB = 2

    if (idVan == 'BAB2222') {
        sensorA = 17
        sensorB = 18
    } else
        if (idVan == 'AXC1111') {
            sensorA = 35
            sensorB = 36
        }

    var buscarTemperaturaID = `SELECT
	lt.id,
    MAX(CASE WHEN lt.fkSensorTemp = ${sensorA} THEN lt.temperatura ELSE NULL END) AS SensorTempA,
    MAX(CASE WHEN lt.fkSensorTemp = ${sensorB} THEN lt.temperatura ELSE NULL END) AS SensorTempB,
    lt.horario
FROM leituraTemp as lt
INNER JOIN sensores as sn
    ON lt.fkSensorTemp = sn.id
WHERE sn.fkVeiculo = '${idVan}'
GROUP BY lt.id 
order by lt.id desc
limit 2;
    `;

    console.log("Executando a instrução SQL: \n" + buscarTemperaturaID);
    return database.executar(buscarTemperaturaID);
}

module.exports = {
    buscarUltimasMedidas,
    buscarMedidasEmTempoReal
}
