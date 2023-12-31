/* --> Código comentado apenas para armazenamento, sofrerá alterações nas restrições de integridade mais abaixo. <--
CREATE TABLE ALUNO (
	MATRICULA_ALUNO INT PRIMARY KEY,
	NATURALIDADE VARCHAR(15),
	FILIACAO VARCHAR(70),
	ESTADO_CIVIL VARCHAR(15),
	NR_RG INT UNIQUE NOT NULL,
	DATA_EXPEDICAO_RG DATE NOT NULL,
	NOME_ALUNO VARCHAR(70) NOT NULL,
	FOTO TXID_SNAPSHOT,
	RUA_END VARCHAR(50) NOT NULL,
	COMPLEMENTO_END VARCHAR(25),
	BAIRRO_END VARCHAR(25) NOT NULL,
	CEP_END INT NOT NULL,
	NOME_RESPONSAVEL VARCHAR(70) NOT NULL,
	EMAIL_ALUNO VARCHAR(50) NOT NULL,
	FOREIGN KEY (TELEFONE_FK) REFERENCES TELEFONE (TELEFONE_PK), -- Esta chave deve estar na tabela TELEFONE, por isso não foi aceito na tabela ALUNO.
	GRAU_PARENTESCO_RESPONSAVEL VARCHAR(15) NOT NULL,
	NACIONALIDADE VARCHAR(20), 
	DATA_NASCIMENTO DATE NOT NULL,
	TELEFONE_RESPONSAVEL VARCHAR(15) NOT NULL
	FOREIGN KEY (COD_CURSO_FK) REFERENCES CURSO (COD_CURSO) -- Esta chave deve estar na tabela CURSO, por isso não foi aceito na tabela ALUNO.
);

CREATE TABLE TELEFONE (
	TELEFONE_PK INT PRIMARY KEY,
	TELEFONE_RES VARCHAR(15),
	TELEFONE_CEL VARCHAR(15) NOT NULL,
	FOREIGN KEY (TELEFONE_PK) REFERENCES ALUNO (MATRICULA_ALUNO)
);

CREATE TABLE CURSO (
	COD_CURSO INT PRIMARY KEY,
	NOME_CURSO VARCHAR(40) NOT NULL,
	DURACAO VARCHAR(15) NOT NULL,
	TURNO CHAR(1) NOT NULL,
	DATA_CRIACAO DATE NOT NULL,
	FOREIGN KEY (COD_CURSO) REFERENCES ALUNO (MATRICULA_ALUNO)
);

CREATE TABLE PROFESSOR_DISCIPLINA (
	ID_PROFESSOR_DISCIPLINA INT PRIMARY KEY,
	CURSO_MINISTRADO VARCHAR(30) NOT NULL,
	GRAU_INSTRUCAO VARCHAR(15) NOT NULL,
	EMAIL VARCHAR(50) NOT NULL,
	DATA_NASCIMENTO_PROF DATE NOT NULL,
	TEL_RECADO VARCHAR(15),
	RUA_END VARCHAR(40) NOT NULL,
	COMPLEMENTO_END VARCHAR(25),
	CEP_END VARCHAR(8) NOT NULL,
	CIDADE_END VARCHAR(25) NOT NULL,
	BAIRRO_END VARCHAR(20) NOT NULL,
	ESTADO_CIVIL VARCHAR(15),
	NOME_PROFESSOR VARCHAR(40) NOT NULL,
	TEL_RES VARCHAR(15),
	FILHOS INT,
	NACIONALIDADE VARCHAR(20) NOT NULL,
	VALE_TRANSPORTE CHAR(3) NOT NULL,
	FOTO TXID_SNAPSHOT,
	SALARIO NUMERIC(7,2),
	DATA_ADMISSAO_PROF DATE NOT NULL,
	CARGA_HORARIA INT NOT NULL,
	TEL_CEL VARCHAR(15) NOT NULL,
	ORGAO_EMISSOR_RG VARCHAR(30) NOT NULL,
	NR_RG VARCHAR(15) NOT NULL,
	DATA_EXPEDICAO_RG DATE NOT NULL,
	NOME_PAI VARCHAR(50),
	NOME_MAE VARCHAR(50),
	FOREIGN KEY (ID_PROFESSOR_DISCIPLINA) REFERENCES CURSO (COD_CURSO),
	COD_CURSO INT NOT NULL,
	NOME_DISCIPLINA VARCHAR(30) NOT NULL,
	EMENTA VARCHAR(300) NOT NULL
);



CREATE TABLE ALUNO_POSSUI_MATRICULA_CURSO_ALUNO_PROFESSOR_DISCIPLINA (
	COD_POSSUI_MAT INT PRIMARY KEY,
	FOREIGN KEY (COD_POSSUI_MAT) REFERENCES ALUNO (MATRICULA_ALUNO),
	FOREIGN KEY (COD_POSSUI_MAT) REFERENCES CURSO (COD_CURSO),
	FOREIGN KEY (COD_POSSUI_MAT) REFERENCES PROFESSOR_DISCIPLINA (ID_PROFESSOR_DISCIPLINA)
);

CREATE TABLE CURSO_DISCIPLINA (
	COD_CURSO_DISCIPLINA INT PRIMARY KEY,
	FOREIGN KEY (COD_CURSO_DISCIPLINA) REFERENCES CURSO (COD_CURSO),
	FOREIGN KEY (COD_CURSO_DISCIPLINA) REFERENCES PROFESSOR_DISCIPLINA (ID_PROFESSOR_DISCIPLINA)
);

CREATE TABLE PRE_REQUISITO (
	ID_PRE_REQUISITO INT PRIMARY KEY,
	FOREIGN KEY (ID_PRE_REQUISITO) REFERENCES PROFESSOR_DISCIPLINA (ID_PROFESSOR_DISCIPLINA)
);

ALTER TABLE PROFESSOR_DISCIPLINA DROP COLUMN FILHOS;

CREATE TABLE DEPENDENTES_PROF (
	NOME VARCHAR(40) NOT NULL,
	CPF VARCHAR(11) NOT NULL,
	SEQUENCIA INT NOT NULL,
	MATRICULA_PROF INT NOT NULL,
	PRIMARY KEY (SEQUENCIA, MATRICULA_PROF),
	CONSTRAINT FK_DEPENDENTES_PROF FOREIGN KEY (MATRICULA_PROF) REFERENCES PROFESSOR_DISCIPLINA (ID_PROFESSOR_DISCIPLINA) ON DELETE CASCADE ON UPDATE CASCADE
);

SELECT * FROM DEPENDENTES_PROF;

ALTER TABLE DEPENDENTES_PROF ADD COLUMN PARENTESCO VARCHAR(20);

ALTER TABLE DEPENDENTES_PROF ALTER COLUMN PARENTESCO SET DEFAULT 'NÃO INFORMADO';

INSERT INTO DEPENDENTES_PROF VALUES ('Ana Maria', '12345678910', 1, 12345); 
*/

CREATE TABLE ALUNO (
	MATRICULA_ALUNO INT PRIMARY KEY,
	NOME_ALUNO VARCHAR(70) NOT NULL,
	DT_NASCIM_ALUNO DATE,
	NR_RG_ALUNO VARCHAR(10) UNIQUE NOT NULL,
	DATA_EXPEDICAO_RG DATE,
	EMAIL_ALUNO VARCHAR(50) NOT NULL,
	NATURALIDADE VARCHAR(15),
	FILIACAO_PAI VARCHAR(50),
	FILIACAO_MAE VARCHAR(50),
	ESTADO_CIVIL VARCHAR(15),
	RUA_END VARCHAR(50) NOT NULL,
	BAIRRO_END VARCHAR(25),
	CIDADE_END VARCHAR(30) NOT NULL,
	ESTADO_END CHAR(2) NOT NULL,
	COMPLEMENTO_END VARCHAR(25),
	CEP_END VARCHAR(8),
	NOME_RESPONS_ALUNO VARCHAR(70) NOT NULL,
	GRAU_PARENT_RESPONS VARCHAR(15),
	NACIONALIDADE VARCHAR(20), 
	TEL_RESPONS_ALUNO VARCHAR(15)
);

CREATE TABLE TELEFONE (
	TELEFONE_PK INT PRIMARY KEY,
	TELEFONE_RES VARCHAR(15),
	TELEFONE_CEL VARCHAR(15) NOT NULL,
	FOREIGN KEY (TELEFONE_PK) REFERENCES ALUNO (MATRICULA_ALUNO) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE CURSO (
	COD_CURSO INT PRIMARY KEY,
	NOME_CURSO VARCHAR(40) NOT NULL,
	DURACAO VARCHAR(15),
	TURNO CHAR(1) NOT NULL,
	DATA_CRIACAO DATE,
	FOREIGN KEY (COD_CURSO) REFERENCES ALUNO (MATRICULA_ALUNO) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE PROFESSOR_DISCIPLINA (
	ID_PROFESSOR_DISCIPLINA INT PRIMARY KEY,
	EMAIL_PROF VARCHAR(50) NOT NULL,
	CURSO_MINISTRADO VARCHAR(30) NOT NULL,
	GRAU_INSTRUCAO VARCHAR(15),
	DT_NASCIM_PROF DATE,
	TEL_REC_PROF VARCHAR(15),
	RUA_END VARCHAR(40) NOT NULL,
	BAIRRO_END VARCHAR(20),
	CIDADE_END VARCHAR(25) NOT NULL,
	ESTADO_END CHAR(2) NOT NULL,
	COMPLEMENTO_END VARCHAR(25),
	CEP_END VARCHAR(8),
	ESTADO_CIVIL VARCHAR(15),
	NOME_PROFESSOR VARCHAR(40) NOT NULL,
	TEL_RES VARCHAR(15),
	NACIONALIDADE_PROF VARCHAR(20),
	VALE_TRANSPORTE CHAR(3),
	SALARIO NUMERIC(7,2),
	DATA_ADMISSAO_PROF DATE,
	CARGA_HORARIA INT,
	TEL_CEL_PROF VARCHAR(15),
	NR_RG VARCHAR(15) NOT NULL,
	ORGAO_EMISSOR_RG VARCHAR(30),
	DATA_EXPEDICAO_RG DATE,
	NOME_PAI_PROF VARCHAR(50),
	NOME_MAE_PROF VARCHAR(50),
	FOREIGN KEY (ID_PROFESSOR_DISCIPLINA) REFERENCES CURSO (COD_CURSO),
	COD_CURSO INT,
	NOME_DISCIPLINA VARCHAR(30) NOT NULL,
	EMENTA VARCHAR(200)
);

CREATE TABLE ALUNO_POSSUI_MATRICULA_CURSO_ALUNO_PROFESSOR_DISCIPLINA (
	COD_POSSUI_MAT INT PRIMARY KEY,
	FOREIGN KEY (COD_POSSUI_MAT) REFERENCES ALUNO (MATRICULA_ALUNO),
	FOREIGN KEY (COD_POSSUI_MAT) REFERENCES CURSO (COD_CURSO),
	FOREIGN KEY (COD_POSSUI_MAT) REFERENCES PROFESSOR_DISCIPLINA (ID_PROFESSOR_DISCIPLINA)
);

CREATE TABLE CURSO_DISCIPLINA (
	COD_CURSO_DISCIPLINA INT PRIMARY KEY,
	FOREIGN KEY (COD_CURSO_DISCIPLINA) REFERENCES CURSO (COD_CURSO),
	FOREIGN KEY (COD_CURSO_DISCIPLINA) REFERENCES PROFESSOR_DISCIPLINA (ID_PROFESSOR_DISCIPLINA)
);

CREATE TABLE PRE_REQUISITO (
	ID_PRE_REQUISITO INT PRIMARY KEY,
	FOREIGN KEY (ID_PRE_REQUISITO) REFERENCES PROFESSOR_DISCIPLINA (ID_PROFESSOR_DISCIPLINA)
);

CREATE TABLE DEPENDENTES_PROF (
	NOME VARCHAR(40) NOT NULL,
	CPF VARCHAR(11) NOT NULL,
	SEQUENCIA INT NOT NULL,
	MATRICULA_PROF INT NOT NULL,
	PRIMARY KEY (SEQUENCIA, MATRICULA_PROF),
	CONSTRAINT FK_DEPENDENTES_PROF FOREIGN KEY (MATRICULA_PROF) REFERENCES PROFESSOR_DISCIPLINA (ID_PROFESSOR_DISCIPLINA) ON DELETE CASCADE ON UPDATE CASCADE
);

SELECT * FROM DEPENDENTES_PROF;

ALTER TABLE DEPENDENTES_PROF ADD COLUMN PARENTESCO VARCHAR(20);

ALTER TABLE DEPENDENTES_PROF ALTER COLUMN PARENTESCO SET DEFAULT 'NÃO INFORMADO';

--> Inserção de dados nas tabelas

INSERT INTO ALUNO (MATRICULA_ALUNO, NOME_ALUNO, NR_RG_ALUNO, EMAIL_ALUNO, RUA_END, BAIRRO_END, CIDADE_END, ESTADO_END, NOME_RESPONS_ALUNO)
			VALUES ('12023', 'Huandel Siqueira', '1234567891', 'huandel@gmail.com', 'Prof. Alberto', 'Fragata', 'Pelotas', 'RS', 'MAIOR DE IDADE');
			
INSERT INTO ALUNO (MATRICULA_ALUNO, NOME_ALUNO, NR_RG_ALUNO, EMAIL_ALUNO, RUA_END, BAIRRO_END, CIDADE_END, ESTADO_END, NOME_RESPONS_ALUNO)
			VALUES ('22023', 'Helen Siqueira', '1234567892', 'helen@gmail.com', 'Carlos Osório', 'Areal', 'Rio de Janeiro', 'RJ', 'MAIOR DE IDADE'),
					('32023', 'Ana Andradae', '1234567893', 'ana@gmail.com', 'Av. Paulista', 'Bela Vista', 'São Paulo', 'SP', 'Elaine Ferreira');

SELECT * FROM ALUNO;

SELECT * FROM TELEFONE;

INSERT INTO TELEFONE (TELEFONE_PK, TELEFONE_CEL)
			VALUES (12023, '98438-8538'),
					(22023, '98475-3939'),
					(32023, '99183-44-21');
					
INSERT INTO CURSO (COD_CURSO, NOME_CURSO, TURNO)
			VALUES (12023, 'Sistemas para Internet', 'N'),
					(22023, 'Edificações', 'T'),
					(32023, 'Eletrônica', 'M');
					
SELECT * FROM CURSO;

INSERT INTO PROFESSOR_DISCIPLINA (ID_PROFESSOR_DISCIPLINA, NOME_PROFESSOR, EMAIL_PROF, CURSO_MINISTRADO, RUA_END, CIDADE_END, ESTADO_END, NR_RG, NOME_DISCIPLINA)
						VALUES (12023, 'Carlos Magalhães', 'carlos@gmail.com', 'Inglês', 'Av. Bento Gonçalves', 'Pelotas', 'RS', '1234567895', 'INGLÊS');

INSERT INTO PROFESSOR_DISCIPLINA (ID_PROFESSOR_DISCIPLINA, NOME_PROFESSOR, EMAIL_PROF, CURSO_MINISTRADO, RUA_END, CIDADE_END, ESTADO_END, NR_RG, NOME_DISCIPLINA)
						VALUES (22023, 'Maria Marta Costa', 'mariam@gmail.com', 'Português', 'Av. Dom Joaquim', 'Pelotas', 'RS', '1234567894', 'PORTUGUÊS'),
								(32023, 'Joana Rodrigues', 'joana@gmail.com', 'Matemática', 'Rua dos Alfeneiros', 'São José dos Campos', 'SP', '1234567897', 'MATEMÁTICA');

INSERT INTO ALUNO_POSSUI_MATRICULA_CURSO_ALUNO_PROFESSOR_DISCIPLINA VALUES (12023);
INSERT INTO ALUNO_POSSUI_MATRICULA_CURSO_ALUNO_PROFESSOR_DISCIPLINA VALUES (22023);
INSERT INTO ALUNO_POSSUI_MATRICULA_CURSO_ALUNO_PROFESSOR_DISCIPLINA VALUES (32023);

INSERT INTO CURSO_DISCIPLINA VALUES (12023);
INSERT INTO CURSO_DISCIPLINA VALUES (22023);
INSERT INTO CURSO_DISCIPLINA VALUES (32023);

INSERT INTO PRE_REQUISITO VALUES (12023);
INSERT INTO PRE_REQUISITO VALUES (22023);
INSERT INTO PRE_REQUISITO VALUES (32023);

INSERT INTO DEPENDENTES_PROF (NOME, CPF, SEQUENCIA, MATRICULA_PROF)
					VALUES 	('Ana Maria Cardoso', '02030405061', 1, 12023),
							('João Cardoso', '25487988541', 2, 12023),
							('Bento Matos', '25444788955', 1, 22023),
							('Carlos Matos', '21145555448', 2, 22023),
							('Cláudia da Silva', '24457789614', 1, 32023);
							
SELECT * FROM DEPENDENTES_PROF;

CREATE TABLE COORDENACAO (
	MATRICULA_COORDENADOR INT PRIMARY KEY,
	FOREIGN KEY (MATRICULA_COORDENADOR) REFERENCES PROFESSOR_DISCIPLINA (ID_PROFESSOR_DISCIPLINA)
);

INSERT INTO COORDENACAO VALUES (12023);
INSERT INTO COORDENACAO VALUES (22023);

