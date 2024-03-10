#init.sql version: 1.2
#date: 10-03-2024
#authors: zeh sobrinho & tutorC

CREATE TABLE IF NOT EXISTS clientes
(
id integer PRIMARY KEY,
nome text NOT NULL,
limite integer NOT NULL,
saldo integer NOT NULL DEFAULT 0,
ultimas_transacoes json DEFAULT '[]',

CONSTRAINT saldo_maior_que_o_limite 
CHECK (saldo >= (limite * -1))
);

INSERT INTO clientes
VALUES
(1, 'Fulano', 1000, 0),
(2, 'Ciclano', 800, 0),
(3, 'Beltrano', 10000, 0),
(4, 'Cicrano', 100000, 0),
(5, 'Belano', 5000, 0);

CREATE TABLE IF NOT EXISTS transacoes
(
id integer PRIMARY KEY,
cliente_id integer NOT NULL,
valor real NOT NULL,
tipo text NOT NULL,
descricao text NOT NULL,
data datetime NOT NULL DEFAULT (datetime('now'))
);

ALTER TABLE transacoes
ADD CONSTRAINT tipo_valido
CHECK (tipo IN ('c', 'd'));

ALTER TABLE transacoes
ADD CONSTRAINT valor_positivo
CHECK (valor > 0);

CREATE INDEX transacoes_cliente_id ON transacoes(cliente_id);
CREATE INDEX transacoes_data ON transacoes(data);

CREATE TRIGGER atualiza_saldo AFTER INSERT ON transacoes
BEGIN
-- lógica de atualização do saldo
END;

INSERT INTO transacoes VALUES
(1, 1, 10, 'c', 'Compra'),
(2, 2, 5, 'd', 'Saque');

INSERT INTO ids DEFAULT VALUES;
SELECT last_insert_rowid() AS novo_id; 