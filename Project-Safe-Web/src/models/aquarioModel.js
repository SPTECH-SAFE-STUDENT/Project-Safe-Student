var database = require("../database/config");

function buscarVansPorEmpresa(IdUsuario) {
  // console.log(usuario.idUsuario)
  var instrucaoSql = `SELECT * FROM Veiculo where fkEmpresa = '${IdUsuario}'`;

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
  cadastrar
}
