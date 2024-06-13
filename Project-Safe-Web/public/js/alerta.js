var alertas = [];

function obterdados(idVan) {
    fetch(`/medidas/tempo-real/${idVan}`)
        .then(resposta => {
            if (resposta.status == 200) {
                resposta.json().then(resposta => {

                    console.log(`Dados recebidos: ${JSON.stringify(resposta)}`);

                    alertar(resposta, idVan);
                });
            } else {
                console.error(`Nenhum dado encontrado para o id ${idVan} ou erro na API`);
            }
        })
        .catch(function (error) {
            console.error(`Erro na obtenção dos dados do aquario p/ gráfico: ${error.message}`);
        });

}

function alertar(resposta, idVan) {
    resposta.forEach(element => {

        if (SensorA != null) {
            var temp = element.SensorTempA;
        } else if (SensorB != null) {
            var temp = element.SensorTempB;
        }
        var grauDeAviso = '';

        var limites = {
            muito_quente: 23,
            quente: 22,
            ideal: 20,
            frio: 10,
            muito_frio: 5
        };

        var classe_temperatura = 'cor-alerta';

        if (temp >= limites.muito_quente) {
            classe_temperatura = 'cor-alerta perigo-quente';
            grauDeAviso = 'perigo quente'
            grauDeAvisoCor = 'cor-alerta perigo-quente'
            exibirAlerta(temp, idVan, grauDeAviso, grauDeAvisoCor)
        }
        else if (temp < limites.muito_quente && temp >= limites.quente) {
            classe_temperatura = 'cor-alerta alerta-quente';
            grauDeAviso = 'alerta quente'
            grauDeAvisoCor = 'cor-alerta alerta-quente'
            exibirAlerta(temp, idVan, grauDeAviso, grauDeAvisoCor)
        }
        else if (temp < limites.quente && temp > limites.frio) {
            classe_temperatura = 'cor-alerta ideal';
            removerAlerta(idVan);
        }
        else if (temp <= limites.frio && temp > limites.muito_frio) {
            classe_temperatura = 'cor-alerta alerta-frio';
            grauDeAviso = 'alerta frio'
            grauDeAvisoCor = 'cor-alerta alerta-frio'
            exibirAlerta(temp, idVan, grauDeAviso, grauDeAvisoCor)
        }
        else if (temp <= limites.muito_frio) {
            classe_temperatura = 'cor-alerta perigo-frio';
            grauDeAviso = 'perigo frio'
            grauDeAvisoCor = 'cor-alerta perigo-frio'
            exibirAlerta(temp, idVan, grauDeAviso, grauDeAvisoCor)
        }

        var card;

        if (document.getElementById(`temp_aquario_${idVan}`) != null) {
            document.getElementById(`temp_aquario_${idVan}`).innerHTML = temp + "°C";
        }

        if (document.getElementById(`card_${idVan}`)) {
            card = document.getElementById(`card_${idVan}`)
            card.className = classe_temperatura;
        }
    });
}

function exibirAlerta(temp, idVan, grauDeAviso, grauDeAvisoCor) {
    var indice = alertas.findIndex(item => item.idVan == idVan);

    if (indice >= 0) {
        alertas[indice] = { idVan, temp, grauDeAviso, grauDeAvisoCor }
    } else {
        alertas.push({ idVan, temp, grauDeAviso, grauDeAvisoCor });
    }

    exibirCards();
}

function removerAlerta(idVan) {
    alertas = alertas.filter(item => item.idVan != idVan);
    exibirCards();
}

function exibirCards() {
    alerta.innerHTML = '';

    for (var i = 0; i < alertas.length; i++) {
        var mensagem = alertas[i];
        alerta.innerHTML += transformarEmDiv(mensagem);
    }
}

function transformarEmDiv({ idVan, temp, grauDeAviso, grauDeAvisoCor }) {

    var descricao = JSON.parse(sessionStorage.AQUARIOS).find(item => item.id == idVan).descricao;
    return `
    <div class="mensagem-alarme">
        <div class="informacao">
            <div class="${grauDeAvisoCor}">&#12644;</div> 
            <h3>${descricao} está em estado de ${grauDeAviso}!</h3>
            <small>Temperatura capturada: ${temp}°C.</small>   
        </div>
        <div class="alarme-sino"></div>
    </div>
    `;
}

function atualizacaoPeriodica() {
    JSON.parse(sessionStorage.PLACA_VAN).forEach(item => {
        obterdados(item.id)
    });
    setTimeout(atualizacaoPeriodica, 5000);
}
