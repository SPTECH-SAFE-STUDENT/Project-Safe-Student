var database = require("../database/config");

function buscarVansPorEmpresa(fkcnpj) {
  // console.log(usuario.idUsuario)
  var instrucaoSql = `SELECT 
    v.placa, 
    v.marca, 
    v.categoria,
    s.nome AS sensor_nome,
    s.localizacao,
    s.tipo,
    lt.temperatura AS ultima_temperatura,
    lt.id AS leitura_id
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
 v.fkCnpj = '${fkcnpj}'
-- fkEmpresa = 1
and s.tipo = 'temperatura'
ORDER BY 
    ultima_temperatura desc;
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



function cadastrar(empresaId, descricao) {

  var instrucaoSql = `INSERT INTO (descricao, fk_empresa) aquario VALUES (${descricao}, ${empresaId})`;

  console.log("Executando a instrução SQL: \n" + instrucaoSql);
  return database.executar(instrucaoSql);
}


module.exports = {
  buscarVansPorEmpresa,
  buscarVanPorMotorista,
  cadastrar
}
