var database = require("../database/config");

function buscarVansPorEmpresa(fkcnpj) {
  // console.log(usuario.idUsuario)
  var instrucaoSql = `SELECT 
    v.placa,
    v.marca,
    v.categoria,
    v.qtdBancos,
    v.statusVan,
    MAX(lt.temperatura) AS ultima_temperatura
FROM 
    veiculo v
JOIN 
    sensores s ON v.placa = s.fkveiculo
JOIN 
    LeituraTemp lt ON s.id = lt.fksensorTemp
WHERE 
    v.fkCnpj = '${fkcnpj}' AND
    s.nome IN ('SensorA', 'SensorB') AND
    lt.id IN (
        SELECT id
        FROM (
            SELECT lt.id
            FROM LeituraTemp lt
            JOIN sensores s ON lt.fksensorTemp = s.id
            WHERE s.fkveiculo = v.placa AND s.nome IN ('SensorA', 'SensorB')
            ORDER BY lt.id DESC
            LIMIT 2
        ) subquery
    )
GROUP BY 
    v.placa, v.marca, v.categoria, v.qtdBancos
    order by ultima_temperatura desc;
    `;
  // var instrucaoSql = `SELECT * FROM Veiculo where fkEmpresa = '${idUsuario}'`;

  console.log("Executando a instrução SQL: \n" + instrucaoSql);
  return database.executar(instrucaoSql);
}

function buscarVanPorMotorista(idUsuario) {

  var instrucaoSql = `select idUsuario, email, cargo, v.placa, qtdBancos, v.fkCnpj , fkUsuario
    from veiculo v
    join usuario on idUsuario = fkUsuario
    where fkUsuario = ${idUsuario};
    `;

  console.log("Executando a instrução SQL: \n" + instrucaoSql);
  return database.executar(instrucaoSql);

}

function kpiAlertas(fkCnpj){

  var instrucaoSql = `select 
count(temperatura) as qtdAlertas
from veiculo 
join sensores on fkveiculo = placa
join leituratemp on fksensorTemp = sensores.id
where temperatura > 25 
and fkCnpj = '${fkCnpj}';
  `;

console.log("Executando a instrução SQL: \n" + instrucaoSql);
return database.executar(instrucaoSql);

}

function kpiCriticos(fkCnpj){

  var instrucaoSql = `    SELECT 
          count(lt.temperatura) AS ultima_temperatura
      FROM 
          Veiculo v
      JOIN 
          Sensores s ON v.placa = s.fkveiculo
      LEFT JOIN 
          (SELECT 
              id, temperatura, fksensorTemp
          FROM 
              LeituraTemp
          WHERE 
              id IN (SELECT MAX(id) FROM LeituraTemp GROUP BY fksensorTemp)
              ) lt ON s.id = lt.fksensorTemp
      where 
      v.fkCnpj = '${fkCnpj}'
      -- fkEmpresa = 1
      and s.tipo = 'temperatura'
      and lt.temperatura > 28
      ORDER BY 
          ultima_temperatura desc;
  `;

console.log("Executando a instrução SQL: \n" + instrucaoSql);
return database.executar(instrucaoSql);

}

function kpiVansServico(fkCnpj){

  var instrucaoSql = `
    select count(statusVan) as VansServico from veiculo
    where statusVan = 'rodando'
    and fkCnpj = '${fkCnpj}';
  `;

console.log("Executando a instrução SQL: \n" + instrucaoSql);
return database.executar(instrucaoSql);

}

function cadastrar(empresaId, descricao) {

  var instrucaoSql = `INSERT INTO (descricao, fk_empresa) aquario VALUES (${descricao}, ${empresaId})`;

  console.log("Executando a instrução SQL: \n" + instrucaoSql);
  return database.executar(instrucaoSql);
}


module.exports = {
  buscarVansPorEmpresa,
  buscarVanPorMotorista,
  cadastrar,
  kpiCriticos,
  kpiAlertas,
  kpiVansServico

}
