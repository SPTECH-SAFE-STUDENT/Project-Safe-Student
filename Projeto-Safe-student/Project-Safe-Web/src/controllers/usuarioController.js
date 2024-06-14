var usuarioModel = require("../models/usuarioModel");
var aquarioModel = require("../models/aquarioModel");

function autenticar(req, res) {
    var email = req.body.emailServer;
    var senha = req.body.senhaServer;

    if (email == undefined) {
        return res.status(400).send("Seu email está undefined!");
    } else if (senha == undefined) {
        return res.status(400).send("Sua senha está indefinida!");
    }

    usuarioModel.autenticar(email, senha)
        .then(
            function (resultadoAutenticar) {
                console.log(`\nResultados encontrados: ${resultadoAutenticar.length}`);
                console.log(`Resultados: ${JSON.stringify(resultadoAutenticar)}`); // transforma JSON em String

                if (resultadoAutenticar.length == 1) {
                    const usuario = resultadoAutenticar[0];

                    console.log(usuario.fkcnpj + " teste idUsuario");

                   if(usuario.cargo == ('dono' || 'suporte')){
                        //usuario for um dono faça outro select
                        console.log("login com dono")

                        aquarioModel.buscarVansPorEmpresa(resultadoAutenticar[0].fkcnpj)
                        .then((resultadoVans) => {

                            // if para guardar os dados pego tanto no select do usuario quanto no select das vans
                            if (resultadoVans.length > 0) {
                                res.json({
                                    idUsuario: usuario.idUsuario,
                                    email: usuario.email,
                                    nome: usuario.nome,
                                    cargo: usuario.cargo,
                                    fkcnpj: usuario.fkcnpj,
                                    fkempresa: usuario.fkempresa,
                                    senha: usuario.senha,   
                                    vans: resultadoVans
                                });
                            } else {
                                res.status(204).json({ aquarios: [] });
                            }
                        })
                        .catch((erro) => {
                            console.log(erro);
                            console.log("\nHouve um erro ao buscar vans! Erro: ", erro.sqlMessage);
                            res.status(500).json(erro.sqlMessage);
                        });
                    }else {

                        aquarioModel.buscarVanPorMotorista(resultadoAutenticar[0].idUsuario)
                        .then((resultadoVans) => {
                            let placaVan;
                            let qtdBancosVan;
                            resultadoVans.forEach(element => {
                                placaVan = element.placa
                                qtdBancosVan = element.qtdBancos
                                
                            });
                            // if para guardar os dados pego tanto no select do usuario quanto no select das vans
                            if (resultadoVans.length > 0) {
                                res.json({
                                    placa:placaVan,
                                    qtdBancos:qtdBancosVan,
                                    fkCnpj:usuario.fkCnpj,
                                    fkUsuario:usuario.fkUsuario,
                                    idUsuario: usuario.idUsuario,
                                    email: usuario.email,
                                    nome: usuario.nome,
                                    cargo: usuario.cargo,
                                    fkcnpj: usuario.fkcnpj,
                                    fkempresa: usuario.fkempresa,
                                    senha: usuario.senha
                                });
                            } else {
                                res.status(204).json({ van: [] });
                            }
                        })
                        .catch((erro) => {
                            console.log(erro);
                            console.log("\nHouve um erro ao buscar vans! Erro: ", erro.sqlMessage);
                            res.status(500).json(erro.sqlMessage);
                        });

                        //usuario for um moto faça outro select
                        console.log("login com Motorista")
                    }
                    
                } else if (resultadoAutenticar.length == 0) {
                    res.status(403).send("Email e/ou senha inválido(s)");
                } else{
                    res.status(403).send("Mais de um usuário com o mesmo login e senha!");
                }
            }
        )
        .catch(
            function (erro) {
                console.log(erro);
                console.log("\nHouve um erro ao realizar o login! Erro: ", erro.sqlMessage);
                res.status(500).json(erro.sqlMessage);
            }
        );
}


function cadastrar(req, res) {
    // Crie uma variável que vá recuperar os valores do arquivo cadastro.html
    var nome = req.body.nomeServer;
    var email = req.body.emailServer;
    var senha = req.body.senhaServer;
    var cnpj = req.body.cnpjServer;
    var crmc = req.body.crmcServer;
    // var cpf = req.body.cpfServer;
    // var empresaId = req.body.empresaServer;

    // Faça as validações dos valores
    if (nome == undefined) {
        res.status(400).send("Seu nome está indefinido!");
    } else if (email == undefined) {
        res.status(400).send("Seu email está indefinido!");
    } else if (senha == undefined) {
        res.status(400).send("Sua senha está indefinido!");
    } else if(cnpj == undefined){
        res.status(400).send("Sua senha está indefinido!");
    } else if(crmc == undefined){
        res.status(400).send("Seu crmc está indefinido!");
    }
    else {

        // Passe os valores como parâmetro e vá para o arquivo usuarioModel.js
        usuarioModel.cadastrar(nome, email, crmc, cnpj, senha)
            .then(
                function (resultado) {
                    console.log("Erro Aqui")
                    res.json(resultado);
                }
            ).catch(
                function (erro) {
                    console.log(erro);
                    console.log(
                        "\nHouve um erro ao realizar o cadastro! Erro: ",
                        erro.sqlMessage
                    );
                    res.status(500).json(erro.sqlMessage);
                }
            );
    }
}

module.exports = {
    autenticar,
    cadastrar
}