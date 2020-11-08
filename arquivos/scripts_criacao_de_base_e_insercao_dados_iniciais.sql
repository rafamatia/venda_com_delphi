/* CRIA A BASE DE DADOS */
create database dbwktechnoloygy;

/* USA A BASE DE DADOS CRIADA */
use dbwktechnoloygy;

/* CRIA A TABELA DE CLIENTES, E SEUS INDICES */
create table clientes (
 cli_codigo int not null auto_increment,
 cli_nome varchar(60) not null,
 cli_cidade varchar(40), 
 cli_uf char(2), 
 primary key(cli_codigo),
 KEY `idx_cli_nome` (`cli_nome`)
);

/* CRIA A TABELA DE PRODUTOS, E SEUS INDICES */
create table produtos (
 pro_codigo int not null auto_increment,
 pro_descricao varchar(60) not null,
 pro_preco_venda decimal(12,2) NOT NULL,
 primary key(pro_codigo),
 KEY `idx_pro_descricao` (`pro_descricao`)
);

/* CRIA A TABELA DE PEDIDOS, E SEUS INDICES */
create table pedidos (
 ped_numero bigint(20) not null auto_increment,
 ped_dataemissao datetime not null default current_timestamp,
 ped_fkcliente int NOT NULL,
 ped_vlrtotal decimal(12,2) NOT NULL default 0,
 primary key(ped_numero),
 KEY `idx_ped_fkcliente` (`ped_fkcliente`),
 KEY `idx_ped_dataemissao` (`ped_dataemissao`),
 CONSTRAINT `fk_pedidocliente` FOREIGN KEY (`ped_fkcliente`) REFERENCES `clientes` (`cli_codigo`) ON DELETE CASCADE
);

/* CRIA A TABELA DE PRODUTOS DO PEDIDO, E SEUS INDICES - ITENS DO PEDIDO */
create table itens_pedido (
 itp_id bigint(20) not null auto_increment,
 itp_fkpedido bigint(20) not null,
 itp_fkproduto int NOT NULL,
 itp_quantidade decimal(12,2) NOT NULL default 0,
 itp_vlrunitario decimal(12,2) NOT NULL default 0,
 itp_vlrtotal decimal(12,2) NOT NULL default 0,
 primary key(itp_id),
 KEY `idx_itp_fkpedido` (`itp_fkpedido`),
 KEY `idx_itp_fkproduto` (`itp_fkproduto`),
 CONSTRAINT `fk_itempedido_pedido` FOREIGN KEY (`itp_fkpedido`) REFERENCES `pedidos` (`ped_numero`) ON DELETE CASCADE,
 CONSTRAINT `fk_itempedido_produto` FOREIGN KEY (`itp_fkproduto`) REFERENCES `produtos` (`pro_codigo`)
);

/* INSERE OS CLIENTES - 25 CLIENTES */
INSERT INTO clientes(cli_nome, cli_cidade, cli_uf) 
VALUES ('CONSUMIDOR','FLORIANÓPOLIS','SC');
INSERT INTO clientes(cli_nome, cli_cidade, cli_uf) 
VALUES ('RAFAEL','MANDAGUARI','PR');
INSERT INTO clientes(cli_nome, cli_cidade, cli_uf) 
VALUES ('MARIA DA SILVA','DOURADOS','MS');
INSERT INTO clientes(cli_nome, cli_cidade, cli_uf) 
VALUES ('CARLOS ROBERTO JUNIOR DA COSTA','MANDAGUARI','PR');
INSERT INTO clientes(cli_nome, cli_cidade, cli_uf) 
VALUES ('JOSÉ DOS SANTOS','MANDAGUARI','PR');
INSERT INTO clientes(cli_nome, cli_cidade, cli_uf) 
VALUES ('AGNESS MATIA','MANDAGUARI','PR');
INSERT INTO clientes(cli_nome, cli_cidade, cli_uf) 
VALUES ('JOÃO PEDRO','MANDAGUARI','PR');
INSERT INTO clientes(cli_nome, cli_cidade, cli_uf) 
VALUES ('BIANCA SILVA SANTOS','MANDAGUARI','PR');
INSERT INTO clientes(cli_nome, cli_cidade, cli_uf) 
VALUES ('OSVALDO DE OLIVEIRA','MANDAGUARI','PR');
INSERT INTO clientes(cli_nome, cli_cidade, cli_uf) 
VALUES ('FÉLIX MATIA','MANDAGUARI','PR');
INSERT INTO clientes(cli_nome, cli_cidade, cli_uf) 
VALUES ('MARIA TEREZA','MANDAGUARI','PR');
INSERT INTO clientes(cli_nome, cli_cidade, cli_uf) 
VALUES ('CASSIANO','MARINGÁ','PR');
INSERT INTO clientes(cli_nome, cli_cidade, cli_uf) 
VALUES ('CAROLINE','MARINGÁ','PR');
INSERT INTO clientes(cli_nome, cli_cidade, cli_uf) 
VALUES ('LUIS CARLOS DE OLIVEIRA DA SILVA','MANDAGUARI','PR');
INSERT INTO clientes(cli_nome, cli_cidade, cli_uf) 
VALUES ('MARIANA','MANDAGUARI','PR');
INSERT INTO clientes(cli_nome, cli_cidade, cli_uf) 
VALUES ('VANDERSON','MARINGÁ','PR');
INSERT INTO clientes(cli_nome, cli_cidade, cli_uf) 
VALUES ('MIRIAN','ARACAJU','SE');
INSERT INTO clientes(cli_nome, cli_cidade, cli_uf) 
VALUES ('MARCELA DA COSTA','SÃO LUIZ DO MARANHÃO','MA');
INSERT INTO clientes(cli_nome, cli_cidade, cli_uf) 
VALUES ('FERNADA DE SÁ','CAMPINAS','SP');
INSERT INTO clientes(cli_nome, cli_cidade, cli_uf) 
VALUES ('LULU SANTOS','SÃO PAULO','SP');
INSERT INTO clientes(cli_nome, cli_cidade, cli_uf) 
VALUES ('LEONARDO','FLORIANÓPOLIS','SC');
INSERT INTO clientes(cli_nome, cli_cidade, cli_uf) 
VALUES ('JOSEFA DOS SANTOS PINHEIRO','FLORIANÓPOLIS','SC');
INSERT INTO clientes(cli_nome, cli_cidade, cli_uf) 
VALUES ('LUCAS DE ALMEIDA','MANDAGUARI','PR');
INSERT INTO clientes(cli_nome, cli_cidade, cli_uf) 
VALUES ('RAFAEL JOSÉ MATIA DE SÁ TELES','MANDAGUARI','PR');
INSERT INTO clientes(cli_nome, cli_cidade, cli_uf) 
VALUES ('GUILHERME','MARINGÁ','PR');

/* INSERE OS PRODUTOS - 33 PRODUTOS */
INSERT INTO produtos(pro_codigo, pro_descricao, pro_preco_venda) 
VALUES (0,'ARROZ ZAELI 5KG','27.50');
INSERT INTO produtos()
VALUES (0,'MACARRÃO ZAELI 500G','7.29');
INSERT INTO produtos(pro_descricao, pro_preco_venda) 
VALUES ('MAIONESE HELLMANNS 500G',8);
INSERT INTO produtos(pro_descricao, pro_preco_venda) 
VALUES ('ÁLCOOL FLOPS 70º 1L',6.23);
INSERT INTO produtos(pro_descricao, pro_preco_venda) 
VALUES ('MORTEM PRO 400ML',12.99);
INSERT INTO produtos(pro_descricao, pro_preco_venda) 
VALUES ('FEIJÃO PRETO ZAELI 1KG',7.55);
INSERT INTO produtos(pro_descricao, pro_preco_venda) 
VALUES ('AÇUCAR CRISTAL 5KG',15);
INSERT INTO produtos(pro_descricao, pro_preco_venda) 
VALUES ('AÇUCAR CRISTAL 2KG',7.08);
INSERT INTO produtos(pro_descricao, pro_preco_venda) 
VALUES ('CERVEJA SKOL LATA 350ML',2.95);
INSERT INTO produtos(pro_descricao, pro_preco_venda) 
VALUES ('REFRIG. COCA-COLA 2L',6.85);
INSERT INTO produtos(pro_descricao, pro_preco_venda) 
VALUES ('COCA-COLA LATA 350ML',3.67);
INSERT INTO produtos(pro_descricao, pro_preco_venda) 
VALUES ('COCA COLA 150ML',1);
INSERT INTO produtos(pro_descricao, pro_preco_venda) 
VALUES ('REFRI GAROTO COCA-COLA 2L',2.35);
INSERT INTO produtos(pro_descricao, pro_preco_venda) 
VALUES ('CERVEJA SKOL 1L',10);
INSERT INTO produtos(pro_descricao, pro_preco_venda) 
VALUES ('SKOL 473ML',4.75);
INSERT INTO produtos(pro_descricao, pro_preco_venda) 
VALUES ('BATATA EXTRA KG',4);
INSERT INTO produtos(pro_descricao, pro_preco_venda) 
VALUES ('PÃO DE ALHO SANTA MASSA',9.10);
INSERT INTO produtos(pro_descricao, pro_preco_venda) 
VALUES ('CAFÉ JANDAIA 500G',7);
INSERT INTO produtos(pro_descricao, pro_preco_venda) 
VALUES ('CAFÉ',8);
INSERT INTO produtos(pro_descricao, pro_preco_venda) 
VALUES ('MARGARINA QUALY 1K',8.60);
INSERT INTO produtos(pro_descricao, pro_preco_venda) 
VALUES ('QUALY 500G',3.95);
INSERT INTO produtos(pro_descricao, pro_preco_venda) 
VALUES ('MARG. QUALY 250G',1.99);
INSERT INTO produtos(pro_descricao, pro_preco_venda) 
VALUES ('HELLMANNS 1KG',15.96);
INSERT INTO produtos(pro_descricao, pro_preco_venda) 
VALUES ('VINHO ROSE RESERVADO 750ML',33.50);
INSERT INTO produtos(pro_descricao, pro_preco_venda) 
VALUES ('CADERNO 10 MATÉRIAS CREDEAL',16.65);
INSERT INTO produtos(pro_descricao, pro_preco_venda) 
VALUES ('NOTEBOOK ACER I5',2500.78);
INSERT INTO produtos(pro_descricao, pro_preco_venda) 
VALUES ('MOUSE',5);
INSERT INTO produtos(pro_descricao, pro_preco_venda) 
VALUES ('TECLADO',8);
INSERT INTO produtos(pro_descricao, pro_preco_venda) 
VALUES ('CANETA AZUL BIC',0.95);
INSERT INTO produtos(pro_descricao, pro_preco_venda) 
VALUES ('CANETA',8);
INSERT INTO produtos(pro_descricao, pro_preco_venda) 
VALUES ('TV SAMSUNG',45871.12);
INSERT INTO produtos(pro_descricao, pro_preco_venda) 
VALUES ('SMARTPHONE SAMSUNG S10',3947.88);
INSERT INTO produtos(pro_descricao, pro_preco_venda) 
VALUES ('ALEXIA',453.24);