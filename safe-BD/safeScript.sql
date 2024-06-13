drop database if exists safe_student;
create database safe_student;

use safe_student;

create table empresa(
idEmpresa INT PRIMARY KEY AUTO_INCREMENT,
nome varchar(55),
cnpj VARCHAR(18) UNIQUE KEY,
rua VARCHAR(255),
cidade VARCHAR(100),
estado VARCHAR(50),
cep VARCHAR(10)
);


CREATE TABLE Usuario (
	idUsuario  INT AUTO_INCREMENT PRIMARY KEY,
	crmc CHAR (10),
    nome VARCHAR(100),
    cpf VARCHAR(14),
    email VARCHAR(100) UNIQUE KEY,
    celular VARCHAR(20),
    senha VARCHAR(50),
    fkCnpj VARCHAR(18),
    cargo VARCHAR(15),
    constraint ck_cargo check (cargo in ('dono', 'motorista', 'suporte')),
    constraint fk_usuario_empresa FOREIGN KEY (fkCnpj) references empresa(cnpj)
);



CREATE TABLE Veiculo (
    placa CHAR(7) PRIMARY KEY,
    chassi CHAR(17),
    ano INT,
    marca VARCHAR(100),
    categoria VARCHAR(50),  
    qtdBancos INT,
    fkUsuario INT UNIQUE KEY,
    fkEmpresa INT,
    fkCnpj varchar(18),
    statusVan varchar(15),
    FOREIGN KEY (fkCnpj) references empresa(cnpj),
    FOREIGN KEY (fkEmpresa) references empresa(idEmpresa),
    FOREIGN KEY (fkUsuario) REFERENCES Usuario(idUsuario)
);


CREATE TABLE Sensores (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100),
    localizacao VARCHAR(100),
    tipo VARCHAR(50),
    fkveiculo CHAR(7),
    FOREIGN KEY (fkveiculo) REFERENCES Veiculo(placa)
);

CREATE TABLE LeituraTemp (
    id INT AUTO_INCREMENT PRIMARY KEY,
    temperatura DECIMAL (4,2),
    fksensorTemp INT,
    horario time,
    FOREIGN KEY (fksensorTemp) REFERENCES Sensores(id) 
);


CREATE TABLE LeituraProx (
id int auto_increment primary key , 
chave int,
fksensorProx int,
FOREIGN KEY (fksensorProx) references Sensores(id)
);

-- Inserindo dados na tabela cadastro

-- inserts para teste da api

INSERT INTO empresa (nome , cnpj, rua, cidade, estado, cep) VALUES 
('FrizzaVans', '12.345.678/0001-00', 'Av. consolação', 'São Paulo', 'SP', '12345-678'),
('Bryantur', '87.654.321/0001-00', 'Av. Paulista', 'São Paulo', 'SP', '87654-321');

/*
select idUsuario, nome, email, fkcnpj, cargo , fkEmpresa from empresa
inner join usuario on fkCnpj = cnpj
join veiculo on fkEmpresa = idEmpresa
where email = 'motoristaa1@empresaA.com' AND senha = 'senhaC';*/

INSERT INTO Usuario (crmc, nome, cpf, email, celular, senha, fkCnpj, cargo) VALUES 
('051.302-00', 'Claudio Frizza', '111.111.111-11', 'frizaClaudio@frizzaVans.com', '(11) 11111-1111', 'Frizza@123', '12.345.678/0001-00', 'dono'),
('0000000001','Bruna Karen', '222.222.222-22', 'support@safestudent.atlassian.net', '(11) 22222-2222', 'Bruna@123', '12.345.678/0001-00', 'suporte'),
('987.654-32', 'Luiz Moraes', '333.333.333-33', 'luiz@frizzaVans.com', '(11) 33333-3333', 'Luiz@123', '12.345.678/0001-00', 'motorista'),
('001.234-56', 'maykon Nogueira', '444.444.444-44', 'maykon@frizzaVans.com', '(11) 44444-4444', 'Maykon@123', '12.345.678/0001-00', 'motorista'),
('876.543-21', 'Bryan Ferro', '555.555.555-55', 'bryan@bryantur.com', '(11) 55555-5555', 'Bryan@123', '87.654.321/0001-00', 'dono');

/*
update usuario 
set fkCnpj = '87.654.321/0001-00'
where idUsuario = 2;
*/

-- Empresa Frizza
INSERT INTO Veiculo (placa, chassi, ano, marca, categoria, fkUsuario, fkEmpresa, fkCnpj, qtdBancos, statusVan) VALUES 
('ABC1111', '1HGBH41JXMN109186', 2020, 'Mercedes', 'Mini Van', 3, 1, '12.345.678/0001-00' , 14, 'parado'),  -- Motorista A1
('BAB2222', '1HGBH41JXMN109187', 2021, 'Fiat', 'Van', 4, 1, '12.345.678/0001-00' , 16, 'parado');  -- Motorista A2

-- Empresa Bryan
INSERT INTO Veiculo (placa, chassi, ano, marca, categoria, fkUsuario, fkEmpresa, fkCnpj, qtdBancos, statusVan) VALUES 
('AXC1111', '1HGBH41JXMN109186', 2020, 'Volkswagen', 'Ônibus', 5, 1, '87.654.321/0001-00' , 20 , 'parado');

/*

update veiculo
set fkCnpj = '12.345.678/0001-00'
where fkEmpresa = 1;

update veiculo 
set qtdBancos = 16
where fkEmpresa = 1;

*/

-- Sensores de temperatura ABC1111
INSERT INTO Sensores (nome, localizacao, tipo, fkveiculo)
VALUES ('SensorA', 'Frente', 'Temperatura', 'ABC1111'),
       ('SensorB', 'Fundo', 'Temperatura', 'ABC1111');

-- Sensores de proximidade ABC1111
INSERT INTO Sensores (nome, localizacao, tipo, fkveiculo)
VALUES ('SensorP1', 'Banco 1', 'Proximidade', 'ABC1111'),
       ('SensorP2', 'Banco 2', 'Proximidade', 'ABC1111'),
       ('SensorP3', 'Banco 3', 'Proximidade', 'ABC1111'),
       ('SensorP4', 'Banco 4', 'Proximidade', 'ABC1111'),
       ('SensorP5', 'Banco 5', 'Proximidade', 'ABC1111'),
       ('SensorP6', 'Banco 6', 'Proximidade', 'ABC1111'),
       ('SensorP7', 'Banco 7', 'Proximidade', 'ABC1111'),
       ('SensorP8', 'Banco 8', 'Proximidade', 'ABC1111'),
       ('SensorP9', 'Banco 9', 'Proximidade', 'ABC1111'),
       ('SensorP10', 'Banco 10', 'Proximidade', 'ABC1111'),
       ('SensorP11', 'Banco 11', 'Proximidade', 'ABC1111'),
       ('SensorP12', 'Banco 12', 'Proximidade', 'ABC1111'),
       ('SensorP13', 'Banco 13', 'Proximidade', 'ABC1111'),
       ('SensorP14', 'Banco 14', 'Proximidade', 'ABC1111');
       
       
-- Sensores de temperatura para BAB2222
INSERT INTO Sensores (nome, localizacao, tipo, fkveiculo)
VALUES ('SensorA', 'Frente', 'Temperatura', 'BAB2222'),
       ('SensorB', 'Fundo', 'Temperatura', 'BAB2222');

-- Sensores de proximidade para BAB2222
INSERT INTO Sensores (nome, localizacao, tipo, fkveiculo)
VALUES ('SensorP1', 'Banco 1', 'Proximidade', 'BAB2222'),
       ('SensorP2', 'Banco 2', 'Proximidade', 'BAB2222'),
       ('SensorP3', 'Banco 3', 'Proximidade', 'BAB2222'),
       ('SensorP4', 'Banco 4', 'Proximidade', 'BAB2222'),
       ('SensorP5', 'Banco 5', 'Proximidade', 'BAB2222'),
       ('SensorP6', 'Banco 6', 'Proximidade', 'BAB2222'),
       ('SensorP7', 'Banco 7', 'Proximidade', 'BAB2222'),
       ('SensorP8', 'Banco 8', 'Proximidade', 'BAB2222'),
       ('SensorP9', 'Banco 9', 'Proximidade', 'BAB2222'),
       ('SensorP10', 'Banco 10', 'Proximidade', 'BAB2222'),
       ('SensorP11', 'Banco 11', 'Proximidade', 'BAB2222'),
       ('SensorP12', 'Banco 12', 'Proximidade', 'BAB2222'),
       ('SensorP13', 'Banco 13', 'Proximidade', 'BAB2222'),
       ('SensorP14', 'Banco 14', 'Proximidade', 'BAB2222'),
       ('SensorP15', 'Banco 15', 'Proximidade', 'BAB2222'),
       ('SensorP16', 'Banco 16', 'Proximidade', 'BAB2222');


-- Sensores de temperatura para AXC1111
INSERT INTO Sensores (nome, localizacao, tipo, fkveiculo)
VALUES ('SensorA', 'Frente', 'Temperatura', 'AXC1111'),
       ('SensorB', 'Fundo', 'Temperatura', 'AXC1111');

-- Sensores de proximidade para AXC1111
INSERT INTO Sensores (nome, localizacao, tipo, fkveiculo)
VALUES ('SensorP1', 'Banco 1', 'Proximidade', 'AXC1111'),
       ('SensorP2', 'Banco 2', 'Proximidade', 'AXC1111'),
       ('SensorP3', 'Banco 3', 'Proximidade', 'AXC1111'),
       ('SensorP4', 'Banco 4', 'Proximidade', 'AXC1111'),
       ('SensorP5', 'Banco 5', 'Proximidade', 'AXC1111'),
       ('SensorP6', 'Banco 6', 'Proximidade', 'AXC1111'),
       ('SensorP7', 'Banco 7', 'Proximidade', 'AXC1111'),
       ('SensorP8', 'Banco 8', 'Proximidade', 'AXC1111'),
       ('SensorP9', 'Banco 9', 'Proximidade', 'AXC1111'),
       ('SensorP10', 'Banco 10', 'Proximidade', 'AXC1111'),
       ('SensorP11', 'Banco 11', 'Proximidade', 'AXC1111'),
       ('SensorP12', 'Banco 12', 'Proximidade', 'AXC1111'),
       ('SensorP13', 'Banco 13', 'Proximidade', 'AXC1111'),
       ('SensorP14', 'Banco 14', 'Proximidade', 'AXC1111'),
       ('SensorP15', 'Banco 15', 'Proximidade', 'AXC1111'),
       ('SensorP16', 'Banco 16', 'Proximidade', 'AXC1111'),
       ('SensorP17', 'Banco 17', 'Proximidade', 'AXC1111'),
       ('SensorP18', 'Banco 18', 'Proximidade', 'AXC1111'),
       ('SensorP19', 'Banco 19', 'Proximidade', 'AXC1111'),
       ('SensorP20', 'Banco 20', 'Proximidade', 'AXC1111');


INSERT INTO LeituraTemp (temperatura, fksensorTemp, horario) VALUES 
(22.5 , 1, now()),
(22 , 2, now()),
(21.5 , 17, now()),
(24.5 , 18, now()),
(30 , 35, now()),
(28 , 36 , now());

INSERT INTO LeituraProx (chave, fksensorProx) VALUES 
(1, 3),
(0, 4),
(0, 5),
(1, 6),
(1, 7),
(0, 8),
(0, 9),
(0, 10),
(0, 11),
(0, 12),
(0, 13),
(0, 14),
(0, 15),
(1, 16);	







/*

truncate table leituraTemp;
truncate table leituraProx;

select * from usuario;


select * from veiculo;

SELECT 
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
 v.fkCnpj = '12.345.678/0001-00'
-- fkEmpresa = 1
and s.tipo = 'temperatura'
ORDER BY 
    ultima_temperatura desc;
    */
    
-- testes para API 

/*
SELECT idUsuario, nome, email, Veiculo.fkcnpj, fkempresa FROM usuario 
join Veiculo 
WHERE email = 'bryan@gmail.com' AND senha = '12345678';
*/

-- Selecionar todos os cadastros
SELECT * FROM Usuario;


-- Selecionar todos os veículos
SELECT * FROM Veiculo;

-- Selecionar todas as empresas
select * from empresa;

-- Selecionar todos os sensores
SELECT * FROM Sensores;

-- Selecionar leitura da temperatura
SELECT * FROM LeituraTemp ;

-- Selecionar a leitura proximidade 
SELECT * FROM LeituraProx;

-- selecionar a tabela cadastro mostrando o veiculo que ela está ligada 
select *
from Usuario 
join veiculo on veiculo.fkUsuario = Usuario.idUsuario;

select idUsuario, email, cargo, placa, qtdBancos, v.fkCnpj , fkUsuario
from veiculo v
join usuario 
where fkUsuario = 9;
    

-- selcionar a tabela sensores e veiculo mostrando a fk 
select *
from sensores
join veiculo on sensores.fkveiculo = veiculo.placa;
-- selecionar a tabela leitura mostrando sua ligação 
select *
from LeituraProx as leitura
join sensores on leitura.fksensorProx = sensores.id;

select *
from LeituraTemp as leitura
join sensores on leitura.fksensorTemp = sensores.id;


-- selecionar a tabela alertas e suas fks

-- Select com case para verificar se a temperatura está ou não em alerta
create view alertaMaximo as
select sens.id, sens.nome, sens.tipo, sens.fkveiculo, temp.temperatura,
	case when (temp.temperatura) >= 25 then 'Temperatura Acima da média'
    end 'Alerta'
from sensores as sens
join leituratemp as temp on temp.fksensorTemp = sens.id
where temp.temperatura >= 25;

create view alertaMinimo as
select sens.id, sens.nome, sens.tipo, sens.fkveiculo, temp.temperatura,
	case when (temp.temperatura) <= 18 then 'Temperatura Abaixo da média'
	end 'Alerta'
from sensores as sens
join leituratemp as temp on temp.fksensorTemp = sens.id
where temp.temperatura <= 18;

select * from alertaMinimo;
select * from alertaMaximo;

-- os dois tipos de alertas

select * from alertaMinimo
join alertaMaximo;

select *
from LeituraProx as leitura
join sensores on leitura.fksensorProx = sensores.id;

-- Select para qtd de bancos ocupados
select count(prox.chave) as bancosOcupados from LeituraProx as prox
where prox.chave = 1;

SELECT
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
        fksensorProx BETWEEN 3 AND 16
     GROUP BY
        fksensorProx) latest
ON
    p.fksensorProx = latest.fksensorProx
    AND p.id = latest.max_id
WHERE
    p.fksensorProx IN (
        SELECT id
        FROM Sensores
        WHERE fkveiculo = 'ABC1111'
        );
        
        SELECT
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
        fksensorProx BETWEEN 3 AND 16
     GROUP BY
        fksensorProx) latest
ON
    p.fksensorProx = latest.fksensorProx
    AND p.id = latest.max_id
WHERE
    p.fksensorProx IN (
        SELECT id
        FROM Sensores
        WHERE fkveiculo = 'ABC1111'
    )
    AND p.chave = 1;

-- Select de temperatura mínima do dia
select min(temp.temperatura) from leituratemp as temp;

-- Select para temperatura máxima e minima do dia de certa VAN BRYAN
    
    
select * from leituratemp;
-- select das temperaturas de uma van especifica
select sens.id, sens.nome, sens.tipo, sens.fkveiculo, temp.temperatura
from sensores as sens
join leituratemp as temp on temp.fksensorTemp = sens.id
where fkveiculo = 'ABC1111';

update sensores 
set nome = 'sensorB'
where id = 11;
	
-- Select para quantidade de alertas do dia
-- alertas maximos de uma van especifica
select sens.id, sens.nome, sens.tipo, sens.fkveiculo, temp.temperatura
from sensores as sens
join leituratemp as temp on temp.fksensorTemp = sens.id
where temp.temperatura > 24 and temp.temperatura <= 28 and fkveiculo = 'ABC1111';


-- select dos dados de proximidade de uma van especifica
select sens.id, sens.nome, sens.tipo, sens.fkveiculo, prox.chave
from sensores as sens
join leituraprox as prox on prox.fksensorProx = sens.id
where fkveiculo = 'ABC1111';

-- alertas minimos
select sens.id, sens.nome, sens.tipo, sens.fkveiculo, temp.temperatura
from sensores as sens
join leituratemp as temp on temp.fksensorTemp = sens.id
where temp.temperatura <= 18;

-- Select para vans em estado crítico
select sens.id, sens.nome, sens.tipo, sens.fkveiculo, temp.temperatura
from sensores as sens
join leituratemp as temp on temp.fksensorTemp = sens.id
where temp.temperatura > 28;	

-- Select para vans em serviço 
select vei.placa, vei.fkUsuario as motorista, vei.statusVan from veiculo as vei;

-- qtd de vans em serviço
select count(vei.statusVan) from veiculo as vei
where vei.statusVan = 1;

-- Select para verificar quantas vans estão em serviço
select count(statusVan) as VansServico from veiculo
where statusVan = 'rodando'
and fkCnpj = '12.345.678/0001-00';

-- update para fazer com que a van esteja rodando ou não
update Veiculo
set statusVan = 'rodando'
where placa = 'ABC1111';


-- Quantidade de alertas
select count(temperatura) as qtdAlertas
from veiculo 
join sensores on fkveiculo = placa
join leituratemp on fksensorTemp = sensores.id
where temperatura > 25 
and fkCnpj = '12.345.678/0001-00';

-- Quantidade de vans em estado crítico
select count(temperatura) as qtdAlertasCriticos 
from veiculo 
join sensores on fkveiculo = placa
join leituratemp on fksensorTemp = sensores.id
where temperatura > 28 
and fkCnpj = '12.345.678/0001-00'
order by leituratemp.id desc;

/*

update veiculo
set fkCnpj = '12.345.678/0001-00'
where fkEmpresa = 1;

update veiculo 
set qtdBancos = 16
where fkEmpresa = 1;

*/


SELECT 
    v.placa,
    v.marca,
    v.categoria,
    v.qtdBancos,
    MAX(lt.temperatura) AS max_temperatura
FROM 
    veiculo v
JOIN 
    sensores s ON v.placa = s.fkveiculo
JOIN 
    LeituraTemp lt ON s.id = lt.fksensorTemp
WHERE 
    v.fkCnpj = '12.345.678/0001-00' AND
    s.nome IN ('SensorA', 'SensorB')
GROUP BY 
    v.placa, v.marca, v.categoria, v.qtdBancos;
    
    
    
SELECT 
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
    v.fkCnpj = '12.345.678/0001-00' AND
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


-- select para pegar as últimas temperaturas
    SELECT 
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
 v.fkCnpj = '12.345.678/0001-00'
-- fkEmpresa = 1
and s.tipo = 'temperatura'
and lt.temperatura > 28
ORDER BY 
    ultima_temperatura desc;
    
       
    SELECT 
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
 v.fkCnpj = '12.345.678/0001-00'
-- fkEmpresa = 1
and s.tipo = 'temperatura'
ORDER BY 
    ultima_temperatura desc;

SELECT MAX(id) FROM LeituraTemp GROUP BY fksensorTemp;


    
    select count(statusVan) as VansServico, count(placa) as qtdVans from veiculo
    where statusVan = 'rodando'
    and fkCnpj = '12.345.678/0001-00';