
CREATE TABLE tb_consumo (
    id              INTEGER NOT NULL,
    energia         NUMBER NOT NULL,
    agua            NUMBER NOT NULL,
    materia_prima   VARCHAR2(60) NOT NULL,
    periodo_medicao DATE NOT NULL,
    tb_empresa_id   INTEGER NOT NULL
);

ALTER TABLE tb_consumo ADD CONSTRAINT tb_consumo_pk PRIMARY KEY ( id,
                                                                  tb_empresa_id );

CREATE TABLE tb_empresa (
    id       INTEGER NOT NULL,
    nome     VARCHAR2(60) NOT NULL,
    endereco VARCHAR2(60) NOT NULL,
    setor    VARCHAR2(60) NOT NULL
);

ALTER TABLE tb_empresa ADD CONSTRAINT tb_empresa_pk PRIMARY KEY ( id );

CREATE TABLE tb_metas (
    id                       INTEGER NOT NULL,
    nome                     VARCHAR2(60) NOT NULL,
    descricao                VARCHAR2(266),
    num_alvo                 INTEGER NOT NULL,
    dt_limite                DATE NOT NULL,
    responsavel              VARCHAR2(60) NOT NULL,
    tb_consumo_id            INTEGER NOT NULL,
    tb_empresa_id            INTEGER NOT NULL,
    tb_consumo_tb_empresa_id INTEGER NOT NULL
);

ALTER TABLE tb_metas
    ADD CONSTRAINT tb_metas_pk PRIMARY KEY ( id,
                                             tb_consumo_id,
                                             tb_consumo_tb_empresa_id,
                                             tb_empresa_id );

CREATE TABLE tb_prod_rec (
    tb_produto_id             INTEGER NOT NULL,
    tb_recursos_id            INTEGER NOT NULL,
    tb_produto_tb_empresa_id  INTEGER NOT NULL,
    tb_recursos_tb_empresa_id INTEGER NOT NULL
);

ALTER TABLE tb_prod_rec
    ADD CONSTRAINT tb_prod_rec_pk PRIMARY KEY ( tb_produto_id,
                                                tb_produto_tb_empresa_id,
                                                tb_recursos_id,
                                                tb_recursos_tb_empresa_id );

CREATE TABLE tb_produto (
    id               INTEGER NOT NULL,
    nome             VARCHAR2(60) NOT NULL,
    descricao        VARCHAR2(60),
    cd_identificacao VARCHAR2(60) NOT NULL,
    tb_empresa_id    INTEGER NOT NULL
);

ALTER TABLE tb_produto ADD CONSTRAINT tb_produto_pk PRIMARY KEY ( id,
                                                                  tb_empresa_id );

CREATE TABLE tb_recursos (
    id              INTEGER NOT NULL,
    nome            VARCHAR2(60) NOT NULL,
    descricao       VARCHAR2(60) NOT NULL,
    origem          VARCHAR2(60) NOT NULL,
    certificacao    VARCHAR2(60),
    disponibilidade VARCHAR2(60) NOT NULL,
    tb_empresa_id   INTEGER NOT NULL
);

ALTER TABLE tb_recursos ADD CONSTRAINT tb_recursos_pk PRIMARY KEY ( id,
                                                                    tb_empresa_id );

ALTER TABLE tb_consumo
    ADD CONSTRAINT tb_consumo_tb_empresa_fk FOREIGN KEY ( tb_empresa_id )
        REFERENCES tb_empresa ( id );

ALTER TABLE tb_metas
    ADD CONSTRAINT tb_metas_tb_consumo_fk FOREIGN KEY ( tb_consumo_id,
                                                        tb_consumo_tb_empresa_id )
        REFERENCES tb_consumo ( id,
                                tb_empresa_id );

ALTER TABLE tb_metas
    ADD CONSTRAINT tb_metas_tb_empresa_fk FOREIGN KEY ( tb_empresa_id )
        REFERENCES tb_empresa ( id );

ALTER TABLE tb_prod_rec
    ADD CONSTRAINT tb_prod_rec_tb_produto_fk FOREIGN KEY ( tb_produto_id,
                                                           tb_produto_tb_empresa_id )
        REFERENCES tb_produto ( id,
                                tb_empresa_id );

ALTER TABLE tb_prod_rec
    ADD CONSTRAINT tb_prod_rec_tb_recursos_fk FOREIGN KEY ( tb_recursos_id,
                                                            tb_recursos_tb_empresa_id )
        REFERENCES tb_recursos ( id,
                                 tb_empresa_id );

ALTER TABLE tb_produto
    ADD CONSTRAINT tb_produto_tb_empresa_fk FOREIGN KEY ( tb_empresa_id )
        REFERENCES tb_empresa ( id );

ALTER TABLE tb_recursos
    ADD CONSTRAINT tb_recursos_tb_empresa_fk FOREIGN KEY ( tb_empresa_id )
        REFERENCES tb_empresa ( id );



-- Relatório de Resumo do Oracle: 
-- 
-- CREATE TABLE                             6
-- CREATE INDEX                             0
-- ALTER TABLE                             13
-- 
-- ERRORS                                   0
-- WARNINGS                                 0
