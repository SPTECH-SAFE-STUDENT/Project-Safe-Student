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
    MAX(CASE WHEN lt.fkSensorTemp = ${sensorA} THEN lt.temperatura ELSE NULL END) AS SensorTempA,
    MAX(CASE WHEN lt.fkSensorTemp = ${sensorB} THEN lt.temperatura ELSE NULL END) AS SensorTempB,
    lt.horario
FROM leituraTemp as lt
INNER JOIN sensores as sn
    ON lt.fkSensorTemp = sn.id
WHERE sn.fkVeiculo = '${idVan}'
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
    p.fkSensorProx,
    p.id AS leitura_id,
    p.chave
FROM
    leituraProx p
JOIN
    (SELECT 
        fksensorProx,
        MAX(id) AS max_id
     FROM 
        leituraProx
     WHERE
        fkSensorProx BETWEEN ${sensor1} AND ${sensorUltimo}
     GROUP BY 
        fkSensorProx) latest
ON
    p.fkSensorProx = latest.fkSensorProx
    AND p.id = latest.max_id
WHERE
    p.fkSensorProx IN (
        SELECT id
        FROM sensores
        WHERE fkVeiculo = '${idVan}' 
    );`

    console.log("Executando a instrução SQL: \n" + instrucaoSQL);
    return database.executar(instrucaoSQL);
}


function KpiBancosOcupados(idVan){

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
    leituraProx p
JOIN
    (SELECT
        fkSensorProx,
        MAX(id) AS max_id
     FROM
        leituraProx
     WHERE
        fkSensorProx BETWEEN ${sensor1} AND ${sensorUltimo}
     GROUP BY
        fkSensorProx) latest
ON
    p.fkSensorProx = latest.fkSensorProx
    AND p.id = latest.max_id
WHERE
    p.fksensorProx IN (
        SELECT id
        FROM sensores
        WHERE fkVeiculo = '${idVan}'
    )
    AND p.chave = 1;`;

    console.log("Executando a instrução SQL: \n" + instrucaoSQL);
    return database.executar(instrucaoSQL);

}

function iniciarFinalizarServiço(idVan,status) {
    console.log("ACESSEI O DASHBOARD MODEL : onde status pode ser parado ou rodando", status, idVan);

    var instrucaoSql = `
        UPDATE veiculo SET statusVan = '${status}' WHERE placa = '${idVan}';
    `;
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function temperaturaMaxMin(idVan){

    var instrucaoSQL = `select max(temp.temperatura) as MaxTemp,
		min(temp.temperatura) as MinTemp 
    from leituraTemp temp
    join sensores on sensores.id = fkSensortemp
    where fkVeiculo = '${idVan}';
` 
       console.log("Executando a instrução SQL: \n" + instrucaoSQL);
       return database.executar(instrucaoSQL);
    }


module.exports = {
    buscarTemperatura,
    buscarProximidade,
    KpiBancosOcupados,
    iniciarFinalizarServiço,
    temperaturaMaxMin
}