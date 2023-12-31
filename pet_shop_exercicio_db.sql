-->Item 1
-->Item 2
CREATE TABLE CLIENTES (
	ID_CLIENTE INT PRIMARY KEY,
	NM_CLIENTE VARCHAR(50) NOT NULL,
	CPF VARCHAR(11) UNIQUE NOT NULL,
	LOGRADOURO VARCHAR(50) NOT NULL,
	NR_RESIDENCIA VARCHAR(6) NOT NULL,
	COMPLEMENTO VARCHAR(6),
	BAIRRO VARCHAR(30) NOT NULL,
	MUNICIPIO VARCHAR(30) NOT NULL,
	CEP CHAR(8) NOT NULL,
	UF CHAR(2) NOT NULL
);

CREATE TABLE PETS (
	ID_PET INT NOT NULL,
	NM_PET VARCHAR(30) NOT NULL,
	SEXO CHAR(1) NOT NULL CHECK (SEXO = 'F' OR SEXO = 'M'),
	DT_NASC DATE NOT NULL,
	TIPO VARCHAR(20) NOT NULL,
	RACA VARCHAR(30) NOT NULL,
	COR VARCHAR(20) NOT NULL DEFAULT 'NÃO INFORMADA',
	ID_CLIENTE INT NOT NULL,
	PRIMARY KEY (ID_PET, ID_CLIENTE),
	CONSTRAINT FK_PETS_CLIENTE FOREIGN KEY (ID_CLIENTE) REFERENCES CLIENTES (ID_CLIENTE) ON DELETE CASCADE
);

CREATE TABLE TELEFONES (
	ID_TELEFONE SERIAL NOT NULL,
	NR_TELEFONE VARCHAR(11) NOT NULL,
	ID_CLIENTE INT NOT NULL,
	PRIMARY KEY (ID_TELEFONE, ID_CLIENTE),
	CONSTRAINT FK_TELEFONES_CLIENTE FOREIGN KEY (ID_TELEFONE) REFERENCES CLIENTES (ID_CLIENTE) ON DELETE CASCADE
);

-->Item 3
-->Item 3(a)
INSERT INTO CLIENTES (ID_CLIENTE, NM_CLIENTE, CPF, LOGRADOURO, NR_RESIDENCIA, COMPLEMENTO, BAIRRO, MUNICIPIO, CEP, UF)
				VALUES (1, 'Carla Dias', '12345678910', 'Av. Borges de Medeiros', '111', 'Casa', 'Centro', 'Porto Alegre', '12345678', 'RS'),
						(2, 'Marcio Gonçalves', '12345678920', 'Rua Monte Claro', '222', 'Apto', 'Fragata', 'Pelotas', '12345679', 'RS'),
						(3, 'Antônio Carlos Belchior', '12345678930', 'Rua Jaçanã', '333', 'Casa', 'Centro', 'Sobral', '12345610', 'CE'),
						(4, 'Isabelle Silva', '12345678940', 'Av. Atlântica', '444', 'Casa' ,'Copacabana', 'Rio de Janeiro', '12345620', 'RJ'),
						(5, 'Carmem Miranda', '12345678950', 'Av. Farrapos', '555', 'Apto', 'Centro', 'Salvador', '12345630', 'BA');

-->Item 3(b)
INSERT INTO PETS (ID_PET, NM_PET, SEXO, DT_NASC, TIPO, RACA, COR, ID_CLIENTE)
			VALUES (1, 'Nick', 'F', '12/17/2006', 'Cachorro', 'Poodle', 'Branco', 1),
					(2, 'Jack', 'M', '08/14/2011', 'Gato', 'Pastor-alemão', 'Preto', 2),
					(3, 'Sonic', 'M', '03/11/2018', 'Cachorro', 'Buldogue', 'Cinza', 3),
					(4, 'Anakin', 'M', '09/04/2019', 'Gato', 'Maine Coon', 'Amarelo', 4),
					(5, 'Rey', 'F', '02/26/2023', 'Gato', 'Siamês', 'Cinza e branco', 4),
					(6, 'Obi Wan', 'M', '01/07/2022', 'Gato', 'Siamês', 'Preto e branco', 5),
					(7, 'Yoda', 'M', '10/06/2020', 'Cachorro', 'Poodle', 'Preto', 5),
					(8, 'Leia', 'F', '07/08/2016', 'Cachorro', 'Chihuahua', 'Cinza', 5);

-->Item 3(c)
INSERT INTO TELEFONES (NR_TELEFONE, ID_CLIENTE) 
				VALUES ('12345678999', 1),
						('12334678977', 2),
						('12345678944', 3),
						('12345678966', 4),
						('12345678933', 4);

-->Item 4
SELECT * FROM CLIENTES;

-->Item 5
SELECT NM_PET
FROM PETS
WHERE SEXO = 'M'
ORDER BY NM_PET ASC;

-->Item 6
SELECT NM_PET, DT_NASC
FROM PETS
ORDER BY DT_NASC DESC;

-->Item 7
SELECT NM_PET
FROM PETS
WHERE DT_NASC BETWEEN '09/04/2019' AND '02/26/2023';

-->Item 8
SELECT NM_CLIENTE, LOGRADOURO
FROM CLIENTES
WHERE COMPLEMENTO IS NULL;

-->Item 9
SELECT NM_PET
FROM PETS
WHERE NM_PET LIKE 'N%';

-->Item 10
SELECT DISTINCT MUNICIPIO
FROM CLIENTES;

-->Item 11
SELECT UPPER (NM_PET), UPPER (SEXO), UPPER (TIPO)
FROM PETS
WHERE SEXO = 'M' AND NM_PET LIKE '%n';