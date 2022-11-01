CREATE DATABASE exercicio_SQL_locadora

GO 
USE exercicio_SQL_locadora

--Criação de tabela filme
GO
CREATE TABLE filme(
id                    INT                                                                 NOT NULL,
titulo                VARCHAR(40)                                                         NOT NULL,
ano                   INT             CHECK(ano<=2021)                                    NULL
PRIMARY KEY(id) 
)

--Criação de tabela estrela
GO
CREATE TABLE estrela(
id                    INT                                                                 NOT NULL,
nome                  VARCHAR(50)                                                         NOT NULL
PRIMARY KEY(id)
)

--Criação de tabela filme_estrela
GO
CREATE TABLE filme_estrela(
filme_id              INT                                                                 NOT NULL,
estrela_id            INT                                                                 NOT NULL
PRIMARY KEY (filme_id, estrela_id)
FOREIGN KEY (filme_id) 
        REFERENCES filme(id),
FOREIGN KEY (estrela_id) 
        REFERENCES estrela(id)
)
--Criação de tabela dvd
GO
CREATE TABLE dvd(
num                   INT                                                                 NOT NULL,
data_fabricacao       DATE            CHECK(data_fabricacao < GETDATE())                  NOT NULL,
filme_id              INT                                                                 NOT NULL
PRIMARY KEY (num)
FOREIGN KEY (filme_id) 
        REFERENCES filme(id)
)

--Criação de tabela cliente
GO
CREATE TABLE cliente(
num_cadastro          INT                                                                 NOT NULL,
nome                  VARCHAR(70)                                                         NOT NULL,
logradouro            VARCHAR(150)                                                        NOT NULL,
num                   INT             CHECK(num > 0)                                      NOT NULL,
cep                   CHAR(8)         CHECK(LEN(cep) = 8)                                 NULL
PRIMARY KEY (num_cadastro)
)

--Criação de tabela locacao
GO
CREATE TABLE locacao(
dvd_num               INT                                                                 NOT NULL,
cliente_num_cadastro  INT                                                                 NOT NULL,
data_locacao          DATE            DEFAULT(GETDATE())                                  NOT NULL,
data_devolucao        DATE                                                                NOT NULL,
valor                 DECIMAL(7,2)    CHECK(valor > 0.00)                                 NOT NULL
PRIMARY KEY (dvd_num, cliente_num_cadastro, data_locacao)
FOREIGN KEY (dvd_num) 
        REFERENCES dvd(num),
FOREIGN KEY (cliente_num_cadastro) REFERENCES cliente(num_cadastro),
CONSTRAINT check_data CHECK(data_devolucao > data_locacao)
)

--Esquema:
--Modificar tipo de coluna nome_real na estrela
ALTER TABLE estrela
ADD nome_real         VARCHAR(50)                                                         NULL

--Modificar tipo de coluna titulo no filme
ALTER TABLE filme
ALTER COLUMN  titulo  VARCHAR(80)                                                         NOT NULL

--Inserção de Dados filme
INSERT INTO filme(id, titulo, ano)
VALUES            (1001, 'Whiplash', 2015)

GO
INSERT INTO filme(id, titulo, ano)
VALUES            (1002, 'Birdman', 2015)

GO
INSERT INTO filme(id, titulo, ano)
VALUES            (1003, 'Interestelar', 2014)

GO
INSERT INTO filme(id, titulo, ano)
VALUES            (1004, 'A Culpa é das Estrelas', 2014)

GO
INSERT INTO filme(id, titulo, ano)
VALUES            (1005, 'Alexandre e o Dia Terrível, Horrível, Espantoso e Horroroso', 2014)

GO
INSERT INTO filme(id, titulo, ano)
VALUES            (1006, 'Sing', 2016)

--Inserção de Dados estrela
INSERT INTO estrela(id, nome, nome_real)
VALUES              (9901, 'Michael Keaton', 'Michael John Douglas')

GO
INSERT INTO estrela(id, nome, nome_real)
VALUES              (9902, 'Emma Stone', 'Emily Jean Stone')

GO
INSERT INTO estrela(id, nome, nome_real)
VALUES              (9903, 'Miles Teller', NULL)

GO
INSERT INTO estrela(id, nome, nome_real)
VALUES              (9904, 'Steve Carell', 'Steven John Carell')

GO
INSERT INTO estrela(id, nome, nome_real)
VALUES              (9905, 'Jennifer Garner', 'Jennifer Anne Garner')

--Inserção de Dados filme_estrela
INSERT INTO filme_estrela(filme_id, estrela_id)
VALUES                    (1002, 9901)

GO
INSERT INTO filme_estrela(filme_id, estrela_id)
VALUES                    (1002, 9902)

GO
INSERT INTO filme_estrela(filme_id, estrela_id)
VALUES                    (1001, 9903)

GO
INSERT INTO filme_estrela(filme_id, estrela_id)
VALUES                    (1005, 9904)

GO
INSERT INTO filme_estrela(filme_id, estrela_id)
VALUES                    (1005, 9905)

--Inserção de Dados dvd
INSERT INTO dvd(num, data_fabricacao, filme_id)
VALUES          (10001, '2020-12-02', 1001)

GO
INSERT INTO dvd(num, data_fabricacao, filme_id)
VALUES          (10002, '2019-10-18', 1002)

GO
INSERT INTO dvd(num, data_fabricacao, filme_id)
VALUES          (10003, '2020-04-03', 1003)

GO
INSERT INTO dvd(num, data_fabricacao, filme_id)
VALUES          (10004, '2020-12-02', 1001)

GO
INSERT INTO dvd(num, data_fabricacao, filme_id)
VALUES          (10005, '2019-10-18', 1004)

GO
INSERT INTO dvd(num, data_fabricacao, filme_id)
VALUES          (10006, '2020-04-03', 1002)

GO
INSERT INTO dvd(num, data_fabricacao, filme_id)
VALUES          (10007, '2020-12-02', 1005)

GO
INSERT INTO dvd(num, data_fabricacao, filme_id)
VALUES          (10008, '2019-10-18', 1002)

GO
INSERT INTO dvd(num, data_fabricacao, filme_id)
VALUES          (10009, '2020-04-03', 1003)

--Inserção de Dados cliente
INSERT INTO cliente(num_cadastro, nome, logradouro, num, cep)
VALUES              (5501, 'Matilde Luz', 'Rua Síria', 150, '03086040')

GO
INSERT INTO cliente(num_cadastro, nome, logradouro, num, cep)
VALUES              (5502, 'Carlos Carreiro', 'Rua Bartolomeu Aires', 1250, '04419110')

GO
INSERT INTO cliente(num_cadastro, nome, logradouro, num, cep)
VALUES              (5503, 'Daniel Ramalho', 'Rua Itajutiba', 169, NULL)

GO
INSERT INTO cliente(num_cadastro, nome, logradouro, num, cep)
VALUES              (5504, 'Roberta Bento', 'Rua Jayme Von Rosenburg', 36, NULL)

GO
INSERT INTO cliente(num_cadastro, nome, logradouro, num, cep)
VALUES              (5505, 'Rosa Cerqueira', 'Rua Arnaldo Simões Pinto', 235, '02917110')

--Inserção de Dados locacao
INSERT INTO locacao (dvd_num, cliente_num_cadastro, data_locacao, data_devolucao, valor)
VALUES               (10001, 5502, '2021-02-18', '2021-02-21', 3.50)

GO
INSERT INTO locacao (dvd_num, cliente_num_cadastro, data_locacao, data_devolucao, valor)
VALUES               (10009, 5502, '2021-02-18', '2021-02-21', 3.50)

GO
INSERT INTO locacao (dvd_num, cliente_num_cadastro, data_locacao, data_devolucao, valor)
VALUES               (10002, 5503, '2021-02-18', '2021-02-19', 3.50)

GO
INSERT INTO locacao (dvd_num, cliente_num_cadastro, data_locacao, data_devolucao, valor)
VALUES               (10002, 5505, '2021-02-20', '2021-02-23', 3.00)

GO
INSERT INTO locacao (dvd_num, cliente_num_cadastro, data_locacao, data_devolucao, valor)
VALUES               (10004, 5505, '2021-02-20', '2021-02-23', 3.00)

GO
INSERT INTO locacao (dvd_num, cliente_num_cadastro, data_locacao, data_devolucao, valor)
VALUES               (10005, 5505, '2021-02-20', '2021-02-23', 3.00)

GO
INSERT INTO locacao (dvd_num, cliente_num_cadastro, data_locacao, data_devolucao, valor)
VALUES               (10001, 5501, '2021-02-24', '2021-02-26', 3.50)

GO
INSERT INTO locacao (dvd_num, cliente_num_cadastro, data_locacao, data_devolucao, valor)
VALUES               (10008, 5501, '2021-02-24', '2021-02-26', 3.50)

--Atualizar Dados cliente 5503
UPDATE cliente
SET cep = '08411150' 
WHERE num_cadastro = 5503

--Atualizar Dados cliente 5504
UPDATE cliente
SET cep = '02918190'
WHERE num_cadastro = 5504

--Atualizar Dados locacao e cliente
UPDATE locacao
SET valor = 3.25
WHERE data_locacao = '2021-02-18' AND cliente_num_cadastro = 5502 

--Atualizar Dados locacao e cliente
UPDATE locacao
SET valor = 3.10
WHERE data_locacao = '2021-02-24' AND cliente_num_cadastro = 5501

--Atualizar Dados dvd 10005
UPDATE dvd
SET data_fabricacao = '2019-07-14'
WHERE num = 10005

--Atualizar Dados estrela Miles
UPDATE estrela
SET nome_real = 'Miles Alexander Teller'
WHERE nome = 'Miles Teller'

--Excluir filme Sing
DELETE filme
WHERE titulo = 'Sing'

--Consultar:
/*
1) Fazer uma consulta que retorne ID, Ano, nome do Filme (Caso o nome do filme tenha mais de 
10 caracteres, para caber no campo da tela, mostrar os 10 primeiros caracteres, seguidos de
reticências ...) dos filmes cujos DVDs foram fabricados depois de 01/01/2020
*/
SELECT id, 
       ano, 
	   CASE WHEN LEN(titulo) > 10
       THEN 
	       RTRIM(SUBSTRING(titulo, 1, 10)) + '...' 
	   
	   ELSE 
	       titulo
	   END AS titulo
	    
FROM filme
WHERE id IN 
(
      SELECT  filme_id
      FROM dvd
      WHERE data_fabricacao > '2020-01-01'
)

/*
2) Fazer uma consulta que retorne num, data_fabricacao, qtd_meses_desde_fabricacao 
(Quantos meses desde que o dvd foi fabricado até hoje) do filme Interestelar
*/
SELECT DISTINCT num, 
                data_fabricacao,
                DATEDIFF(MONTH, data_fabricacao, GETDATE()) AS qtd_meses_desde_fabricacao

FROM dvd
WHERE filme_id IN 
(
      SELECT id
      FROM filme
      WHERE titulo = 'Interestelar'
)

/*
3) Fazer uma consulta que retorne num_dvd, data_locacao, data_devolucao, dias_alugado
(Total de dias que o dvd ficou alugado) e valor das locações da cliente que tem, no nome, o termo Rosa
*/
SELECT dvd_num, 
       data_locacao,
	   data_devolucao,
	   DATEDIFF(DAY, data_locacao, data_devolucao) AS dias_alugado,
	   valor

FROM locacao
WHERE cliente_num_cadastro IN
(
      SELECT num_cadastro 
      FROM cliente
      WHERE nome LIKE 'Rosa%'
)

/*
4) Nome, endereço_completo (logradouro e número concatenados), cep (formato XXXXX-XXX) dos 
clientes que alugaram DVD de num 10002.
*/
SELECT nome,
       logradouro +','+ CAST(num AS VARCHAR(5)) AS endereço_completo,
	   RTRIM(SUBSTRING(cep, 1, 6)) + '-' + RTRIM(SUBSTRING(cep, 6, 9)) AS cep
 
FROM cliente
WHERE num_cadastro IN 
(
      SELECT cliente_num_cadastro 
      FROM locacao
      WHERE dvd_num IN 
      (
	        SELECT num 
            FROM dvd
            WHERE num = 10002
      )
)

--Consulta todas as linhas e todas as colunas cliente, estrela, dvd, filme, filme_estrela, locacao
SELECT * FROM cliente 
SELECT * FROM estrela
SELECT * FROM dvd
SELECT * FROM filme
SELECT * FROM filme_estrela
SELECT * FROM locacao