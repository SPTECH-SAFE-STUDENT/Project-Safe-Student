var database = require("../database/config");



function buscarTemperatura(idVan) {
    let sensorA = 1
    let sensorB = 2

    if(idVan == 'BAB2222'){
        sensorA = 17
        sensorB = 18
    }else 
    if(idVan == 'AXC1111'){
        sensorA = 35
        sensorB = 36
    }

    var buscarTemperaturaID = `SELECT
	lt.id,
    MAX(CASE WHEN lt.fksensorTemp = ${sensorA} THEN lt.temperatura ELSE NULL END) AS SensorTempA,
    MAX(CASE WHEN lt.fksensorTemp = ${sensorB} THEN lt.temperatura ELSE NULL END) AS SensorTempB,
    lt.horario
FROM LeituraTemp as lt
INNER JOIN Sensores as sn
    ON lt.fksensorTemp = sn.id
WHERE sn.fkveiculo = '${idVan}'
GROUP BY lt.id 
order by lt.id desc
limit 28;
    `;

    console.log("Executando a instrução SQL: \n" + buscarTemperaturaID);
    return database.executar(buscarTemperaturaID);
}

function buscarProximidade(idVan) {

    let sensor1 = 3
    let sensorUltimo = 16

    if(idVan == 'BAB2222'){
        sensor1 = 19
        sensorUltimo = 34
    }else 
    if(idVan == 'AXC1111'){
        sensor1 = 37
        sensorUltimo = 56
    }

    var instrucaoSQL = `SELECT
    p.fksensorProx,
    p.id AS leitura_id,
    p.chave
FROM
    LeituraProx p
JOIN
    (SELECT 
        fksensorProx,
        MAX(id) AS max_id
     FROM 
        LeituraProx
     WHERE
        fksensorProx BETWEEN ${sensor1} AND ${sensorUltimo}}
     GROUP BY 
        fksensorProx) latest
ON
    p.fksensorProx = latest.fksensorProx
    AND p.id = latest.max_id
WHERE
    p.fksensorProx IN (
        SELECT id
        FROM Sensores
        WHERE fkveiculo = '${idVan}' 
    );`

    console.log("Executando a instrução SQL: \n" + instrucaoSQL);
    return database.executar(instrucaoSQL);
}


function KpiBancosOcupados(){

    let sensor1 = 3
    let sensorUltimo = 16

    if(idVan == 'BAB2222'){
        sensor1 = 19
        sensorUltimo = 34
    }else 
    if(idVan == 'AXC1111'){
        sensor1 = 37
        sensorUltimo = 56
    }


var instrucaoSQL = ` SELECT
    COUNT(p.id) AS bancos_ocupados
FROM
    LeituraProx p
JOIN
    (SELECT
        fksensorProx,
        MAX(id) AS max_id
     FROM
        LeituraProx
     WHERE
        fksensorProx BETWEEN ${sensor1} AND ${sensorUltimo}}
     GROUP BY
        fksensorProx) latest
ON
    p.fksensorProx = latest.fksensorProx
    AND p.id = latest.max_id
WHERE
    p.fksensorProx IN (
        SELECT id
        FROM Sensores
        WHERE fkveiculo = '${idVan}'
    )
    AND p.chave = 1;`;

    console.log("Executando a instrução SQL: \n" + instrucaoSQL);
    return database.executar(instrucaoSQL);

}

function iniciarFinalizarServiço(status, placaVeiculo) {
    console.log("ACESSEI O DASHBOARD MODEL : onde status pode ser parado ou rodando", status, placaVeiculo);

    var instrucaoSql = `
        UPDATE veiculo SET statusVan = '${status}' WHERE id = ${placaVeiculo};
    `;
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}




module.exports = {
    buscarTemperatura,
    buscarProximidade,
    KpiBancosOcupados,
    iniciarFinalizarServiço
}