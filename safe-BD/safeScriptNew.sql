drop database if exists safe_student;
create database safe_student;

use safe_student;

create table empresa(
idEmpresa INT PRIMARY KEY AUTO_INCREMENT,
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
    fkUsuario INT UNIQUE KEY,
    fkEmpresa INT,
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
    FOREIGN KEY (fksensorTemp) REFERENCES Sensores(id) 
);

CREATE TABLE LeituraProx (
id int auto_increment primary key , 
chave int,
fksensorProx int,
FOREIGN KEY (fksensorProx) references Sensores(id)
);


/*
CREATE TABLE Alertas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    tipo VARCHAR(100), -- tipo ou indicar bloqueio ou temperatura
    descricao TEXT, -- descrever qual o problema exibido no alert
    data_hora DATETIME, -- data e hora do ocorrido
    fksensores INT,
	FOREIGN KEY (fksensores) REFERENCES Sensores(id) 
);
*/

-- Inserindo dados na tabela cadastro
/*
 INSERT INTO  Usuario (crmc, nome, cpf, email, celular)
VALUES 
('12345', 'João Silva', '123.456.789-00', 'joao@gmail.com', '(99) 97912-0972'),
('54321', 'Maria Oliveira', '987.654.321-00', 'maria@gmail.com', '(88) 92146-8128'),
('67890', 'Carlos Souza', '456.789.123-00', 'carlos@gmail.com', '(77) 98721-9856'),
('24680', 'Ana Santos', '789.123.456-00', 'ana@gmail.com', '(66) 91823-7654'),
('13579', 'Pedro Pereira', '654.321.987-00', 'pedro@gmail.com', '(55) 91224-9712'),
('97531', 'Juliana Costa', '321.654.987-00', 'juliana@gmail.com', '(44) 91243-1272'),
('86420', 'Lucas Oliveira', '987.321.654-00', 'lucas@gmail.com', '(33) 98715-9123'),
('78901', 'Fernanda Santos', '654.987.321-00', 'fernanda@gmail.com', '(22) 98564-0122'),
('75319', 'Gabriel Costa', '321.987.654-00', 'gabriel@gmail.com', '(11) 91541-0121'),
('01234', 'Aline Pereira', '987.123.456-00', 'aline@gmail.com', '(21) 98214-0923');
*/
insert into empresa(cnpj, rua, cidade, estado, cep)
values ('12.345.678-0001-00', 'Haddock lobo', 'São Paulo', 'SP','1414001');

-- Inserindo dados na tabela Veiculo
INSERT INTO Veiculo (placa, chassi, ano,  marca, categoria, fkUsuario, fkEmpresa)
VALUES 
('ABC1234', '9BM111060T5002146', 2020, 'Mercedes', 'VAN', 1, 1);
/*
('DEF4567', '9BF112060T5002136', 2019, 'Fiat', 'VAN', 2, 1),
('GHI7890', '9BP113060T5002126', 2018, 'Peugeot', 'VAN', 3, 1),
('JKL0123', '9BF114060T5002166', 2017, 'Ford', 'VAN', 4, 1),
('MNO3456', '9BR115060T5002157', 2016,  'Renault', 'VAN', 5, 1),
('PQR6789', '9BC116060T5002158', 2021,  'Citroën', 'VAN', 6, 1),
('STU9012', '9BV117060T5002159', 2020, 'Volkswagen', 'VAN', 7, 1),
('VWX2345', '9BI118060T5002150', 2019,  'Iveco', 'VAN', 8, 1),
('YZA5678', '9BD119060T5002156', 2018, 'Hyundai', 'VAN', 9, 1),
('BCD8901', '9BF110060T5002156', 2017, 'Fiat',  'VAN', 10, 1);
*/
-- inserindo dados na tabela sensores 
INSERT INTO Sensores (nome, localizacao, tipo, fkveiculo) VALUES
('Sensor1', 'Frente', 'temperatura', 'ABC1234'),
('Sensor2', 'Fundo', 'temperatura', 'ABC1234'),
('Sensor3', 'Banco 1 ', 'bloqueio', 'ABC1234'),
('Sensor4', 'Banco 2', 'bloqueio', 'ABC1234'),
('Sensor5', 'Banco 3', 'bloqueio', 'ABC1234'),
('Sensor6', 'Banco 4', 'bloqueio', 'ABC1234'),
('Sensor7', 'Banco 5', 'bloqueio', 'ABC1234'),
('Sensor8', 'Banco 6', 'bloqueio', 'ABC1234'),
('Sensor9', 'Banco 7', 'bloqueio', 'ABC1234'),
('Sensor10', 'Banco 8', 'bloqueio', 'ABC1234');

-- Inserindo dados na tabel leitura 
-- 0 e 1 representam se o lugar está ocupado ou não 
INSERT INTO LeituraTemp (fksensorTemp, temperatura) 
VALUES 
    (11, 25.50),
    (12, 26.75),
    (12, 24.80),
    (11, 27.30),
    (11, 25.00),
    (12, 26.20),
    (12, 24.90),
    (11, 17.80),
    (11, 15.75),
    (12, 18.40);

-- Inserindo dados na tabela leitura 
INSERT INTO LeituraProx (fksensorProx, chave) 
VALUES 
    (13, 1),
    (14, 0),
    (15, 1),
    (16, 0),
    (17, 1),
    (18, 0),
    (19, 1),
    (20, 0),
    (13, 1),
    (14, 0);


-- inserindo dados na tabela alertas 
-- Inserir dados de exemplo na tabela Alertas com números de 1 a 10 nas FKs
-- Inserir 10 linhas na tabela Alertas
/*
INSERT INTO Alertas (tipo, descricao, data_hora, fksensores) VALUES
('bloqueio', 'Alerta de bloqueio no Sensor 1.', NOW(), 1),
('temperatura', 'Alerta de temperatura alta no Sensor 2.', NOW(), 2),
('bloqueio', 'Alerta de bloqueio no Sensor 3.', NOW(), 3),
('temperatura', 'Alerta de temperatura baixa no Sensor 4.', NOW(), 4),
('bloqueio', 'Alerta de bloqueio no Sensor 5.', NOW(), 5),
('temperatura', 'Alerta de temperatura alta no Sensor 6.', NOW(), 6),
('bloqueio', 'Alerta de bloqueio no Sensor 7.', NOW(), 7),
('temperatura', 'Alerta de temperatura baixa no Sensor 8.', NOW(), 8),
('bloqueio', 'Alerta de bloqueio no Sensor 9.', NOW(), 9),
('temperatura', 'Alerta de temperatura alta no Sensor 10.', NOW(), 10);
*/
-- testes para API 

SELECT idUsuario, nome, email, fkcnpj, fkempresa FROM usuario 
join Veiculo 
WHERE email = 'bryan@gmail.com' AND senha = '12345678';


-- Selecionar todos os cadastros
SELECT * FROM Usuario;

-- Selecionar todos os veículos
SELECT * FROM Veiculo;



-- Selecionar todos os alertas
SELECT * FROM Alertas;

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
select *
from alertas as alert
join sensores on alert.fksensores = sensores.id;

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
