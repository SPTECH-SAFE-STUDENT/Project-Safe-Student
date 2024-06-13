// Importa os módulos necessários
// não altere!
const serialport = require('serialport'); // Módulo para comunicação serial
const express = require('express'); // Módulo para criar um servidor web
const mysql = require('mysql2'); // Módulo para conectar ao MySQL

// Constantes para configurações
// não altere!
const SERIAL_BAUD_RATE = 9600;
const SERVIDOR_PORTA = 3300;

// Habilita ou desabilita a inserção de dados no banco de dados
// false -> nao insere
// true -> insere
const HABILITAR_OPERACAO_INSERIR = true;

// Função para comunicação serial
const serial = async (
    valoresLm35Temperatura,
    valoresChave
) => {
    let poolBancoDados = ''

    // Conexão com o banco de dados MySQL
    poolBancoDados = mysql.createPool(
        {
            // altere!
            // Credenciais do banco de dados
            host: '10.18.36.95',
            user: 'Safe_Student',
            password: 'Safe@Student123',
            database: 'safe_student',
            port: 3307
        }
    ).promise();

    // Lista as portas seriais disponíveis e procura pelo Arduino
    const portas = await serialport.SerialPort.list();
    const portaArduino = portas.find((porta) => porta.vendorId == 2341 && porta.productId == 43);
    if (!portaArduino) {
        throw new Error('O arduino não foi encontrado em nenhuma porta serial');
    }

    // Configura a porta serial com o baud rate especificado
    const arduino = new serialport.SerialPort(
        {
            path: portaArduino.path,
            baudRate: SERIAL_BAUD_RATE
        }
    );

    // Evento quando a porta serial é aberta
    arduino.on('open', () => {
        console.log(`A leitura do arduino foi iniciada na porta ${portaArduino.path} utilizando Baud Rate de ${SERIAL_BAUD_RATE}`);
    });

    // Processa os dados recebidos do Arduino
    arduino.pipe(new serialport.ReadlineParser({ delimiter: '\r\n' })).on('data', async (data) => {
        const valores = data.split(';');
        const chave = parseInt(valores[0]);
        let lm35Temperatura = parseFloat(valores[1]);


        // Armazena os valores dos sensores nos arrays correspondentes
        valoresLm35Temperatura.push(lm35Temperatura);
        valoresChave.push(chave);

        // Insere os dados no banco de dados (se habilitado)
        if (HABILITAR_OPERACAO_INSERIR) {

            // altere!
            // Este insert irá inserir os dados na tabela "medida"
            // VAN 1
        // for(let fkTemperatura = 1; fkTemperatura <= 2; fkTemperatura ++){
            // VAN 2
        for(let fkTemperatura = 17; fkTemperatura <= 18; fkTemperatura ++){
            // VAN 3  
        // for(let fkTemperatura = 35; fkTemperatura <= 36; fkTemperatura ++){
             if(fkTemperatura == 18 || fkTemperatura == 36 || fkTemperatura == 2){
                lm35Temperatura = lm35Temperatura*1.05
             }else{
                lm35Temperatura = lm35Temperatura*1
             }

            await poolBancoDados.execute(
                'INSERT INTO LeituraTemp (temperatura, fksensorTemp) VALUES (? , ?)',
                [lm35Temperatura, fkTemperatura]
                
            );
            console.log("valores inseridos no banco Temperatura: " + lm35Temperatura)
        }
            //VAN 1
        // for(let fkChave = 3; fkChave <= 16; fkChave ++){
            //VAN 2
        for(let fkChave = 19; fkChave <= 34; fkChave ++){
            //VAN 3
        // for(let fkChave = 37; fkChave <= 56; fkChave ++){
            await poolBancoDados.execute(
                'INSERT INTO LeituraProx (chave, fksensorProx) VALUES (?, ?)',
                [chave, fkChave]
                
                );
            console.log("valores inseridos no banco Proximidade: " + chave)
        }
            
           
        
        }
        
    });

    // Evento para lidar com erros na comunicação serial
    arduino.on('error', (mensagem) => {
        console.error(`Erro no arduino (Mensagem: ${mensagem}`)
    });
}


// não altere!
// Função para criar e configurar o servidor web
const servidor = (
    valoresLm35Temperatura,
    valoresChave
) => {
    const app = express();

    // Configurações de CORS
    app.use((request, response, next) => {
        response.header('Access-Control-Allow-Origin', '*');
        response.header('Access-Control-Allow-Headers', 'Origin, Content-Type, Accept');
        next();
    });

    // Inicia o servidor na porta especificada
    app.listen(SERVIDOR_PORTA, () => {
        console.log(`API executada com sucesso na porta ${SERVIDOR_PORTA}`);
    });

    // Define os endpoints da API para cada tipo de sensor
    app.get('/sensores/lm35/temperatura', (_, response) => {
        return response.json(valoresLm35Temperatura);
    });
    app.get('/sensores/chave', (_, response) => {
        return response.json(valoresChave);
    });
}

// Função principal assíncrona para iniciar a comunicação serial e o servidor web
(async () => {
    const valoresLm35Temperatura = [];
    const valoresChave = [];

    // Inicia a comunicação serialm
    await serial(
        valoresLm35Temperatura,
        valoresChave
    );

    // Inicia o servidor web
    servidor(
        valoresLm35Temperatura,
        valoresChave
    );
})();
