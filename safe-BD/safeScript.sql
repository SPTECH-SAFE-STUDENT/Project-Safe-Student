
create database safe_student;

use safe_student;

CREATE TABLE Usuário (
   IdCadastro  INT AUTO_INCREMENT PRIMARY KEY,
   crmc CHAR (5) not null,
    nome VARCHAR(100),
    cpf VARCHAR(14),
    email VARCHAR(100),
    celular VARCHAR(20)
);

create table empresa(
idEmpresa INT PRIMARY KEY AUTO_INCREMENT,
cnpj VARCHAR(18),
rua VARCHAR(255),
cidade VARCHAR(100),
estado VARCHAR(50),
cep VARCHAR(10)
);



CREATE TABLE Veiculo (
    idVeiculo INT AUTO_INCREMENT PRIMARY KEY,
    chassi VARCHAR(50),
    ano INT,
    marca VARCHAR(100),
    placa VARCHAR(20),
    categoria VARCHAR(50),  
    fkUsuario INT UNIQUE KEY,
    fkEmpresa INT,
    FOREIGN KEY (fkEmpresa) references empresa(idEmpresa),
    FOREIGN KEY (fkUsuario) REFERENCES Usuário(idCadastro)
);

CREATE TABLE Sensores (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100),
    localizacao VARCHAR(100),
    tipo VARCHAR(50),
    fkveiculo INT,
    FOREIGN KEY (fkveiculo) REFERENCES Veiculo(idVeiculo)
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


CREATE TABLE Alertas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    tipo VARCHAR(100), -- tipo ou indicar bloqueio ou temperatura
    descricao TEXT, -- descrever qual o problema exibido no alert
    data_hora DATETIME, -- data e hora do ocorrido
    fksensores INT,
	FOREIGN KEY (fksensores) REFERENCES Sensores(id) 
);

-- Inserindo dados na tabela cadastro
INSERT INTO  Usuário (crmc, nome, cpf, email, celular)
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

insert into empresa(cnpj, rua, cidade, estado, cep)
values ('12.345.678-0001-00', 'Haddock lobo', 'São Paulo', 'SP','1414001');

-- Inserindo dados na tabela Veiculo
INSERT INTO Veiculo (chassi, ano,  marca, placa, categoria, fkUsuario, fkEmpresa)
VALUES 
('ABC123', 2020, 'Mercedes-Benz', 'ABC-1234', 'VAN', 1, 1),
('DEF456', 2019, 'Fiat', 'DEF-4567', 'VAN', 2, 1),
('GHI789', 2018, 'Peugeot', 'GHI-7890', 'VAN', 3, 1),
('JKL012', 2017, 'Ford', 'JKL-0123', 'VAN', 4, 1),
('MNO345', 2016,  'Renault', 'MNO-3456', 'VAN', 5, 1),
('PQR678', 2021,  'Citroën', 'PQR-6789', 'VAN', 6, 1),
('STU901', 2020, 'Volkswagen', 'STU-9012', 'VAN', 7, 1),
('VWX234', 2019,  'Iveco', 'VWX-2345', 'VAN', 8, 1),
('YZA567', 2018, 'Hyundai', 'YZA-5678', 'VAN', 9, 1),
('BCD890', 2017, 'Fiat', 'BCD-8901', 'VAN', 10, 1);

-- inserindo dados na tabela sensores 
INSERT INTO Sensores (nome, localizacao, tipo, fkveiculo) VALUES
('Sensor1', 'Banco', 'bloqueio', 1),
('Sensor2', 'Frente', 'temperatura', 2),
('Sensor3', 'Interio', 'temperatura', 3),
('Sensor4', 'Banco', 'bloqueio', 4),
('Sensor5', 'Teto', 'temperatura', 5),
('Sensor6', 'Frente', 'temperatura', 6),
('Sensor7', 'Banco', 'bloqueio', 7),
('Sensor8', 'central', 'temperatura', 8),
('Sensor9', 'interior', 'temperatura', 9),
('Sensor10', 'Banco', 'bloqueio', 10);

-- Inserindo dados na tabel leitura 
-- 0 e 1 representam se o lugar está ocupado ou não 
INSERT INTO LeituraTemp (fksensorTemp, temperatura) 
VALUES 
    (1, 25.50),
    (2, 26.75),
    (1, 24.80),
    (3, 27.30),
    (2, 25.00),
    (1, 26.20),
    (3, 24.90),
    (2, 17.80),
    (1, 15.75),
    (3, 18.40);

-- Inserindo dados na tabela leitura 
INSERT INTO LeituraProx (fksensorProx, chave) 
VALUES 
    (1, 1),
    (2, 0),
    (3, 1),
    (1, 0),
    (2, 1),
    (3, 0),
    (1, 1),
    (2, 0),
    (3, 1),
    (1, 0);


-- inserindo dados na tabela alertas 
-- Inserir dados de exemplo na tabela Alertas com números de 1 a 10 nas FKs
-- Inserir 10 linhas na tabela Alertas
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


-- Selecionar todos os cadastros
SELECT * FROM Usuário;

-- Selecionar todos os veículos
SELECT * FROM Veiculo;

-- Selecionar todos os alertas
SELECT * FROM Alertas;

-- Selecionar todos os sensores
SELECT * FROM Sensores;

-- Selecionar leitura da temperatura
SELECT * FROM LeituraTemp ;

-- Selecionar a leitura proximidade 
SELECT * FROM LeituraProx;


-- selecionar a tabela cadastro mostrando o veiculo que ela está ligada 
select *
from Usuário 
join veiculo on veiculo.fkUsuario = Usuário.idCadastro;

-- selcionar a tabela sensores e veiculo mostrando a fk 
select *
from sensores
join veiculo on sensores.fkveiculo = veiculo .idVeiculo;
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
