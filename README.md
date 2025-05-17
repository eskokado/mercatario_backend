# Mercatório Backend Challenge

## Objetivo

Desenvolver uma API REST para simular a originação de precatórios, permitindo:
* Cadastro de credores e precatórios.
* Upload de documentos pessoais e certidões.
* Integração com uma API mock para obtenção automática de certidões.

## Funcionalidades Principais

- Cadastros
  * Credores (CPF, nome, dados pessoais).
  * Precatórios (vinculados a credores).

- Upload de Arquivos
  * Documentos pessoais (ex: RG, comprovante de residência).
  * Certidões (manual ou via API mock).

- Consulta
  * Credores com documentos e certidões associadas.

API Mock
  * Simulação de consulta de certidões (ex: endpoints /api/certidoes com respostas estáticas).

## Tecnologias e Requisitos
  * Linguagem: Ruby (Ruby on Rails).
  * Banco de Dados: PostgreSQL.
  * Armazenamento: Active Storage (upload local de arquivos).
  * Containerização: Docker e Docker Compose.
  * Documentação: Instruções claras para execução local.

## Requisitos obrigatórios

* Utilizar uma das linguagens: **Python** ou **Ruby**.
* Endpoints RESTful bem definidos
* Upload de arquivos (armazenamento local ou temporário)
* Implementar uma API mock local para simular a busca de certidões
* Documentação de como rodar o projeto localmente

## Endpoints existentes

* `POST /credores` – Cadastra credor e seu precatório
* `POST /credores/:id/documentos` – Upload de documentos pessoais
* `POST /credores/:id/certidoes` – Upload manual de certidões
* `POST /credores/:id/buscar-certidoes` – Simula consulta de certidões via API
* `GET /credores/:id` – Consulta geral do credor, precatório, documentos e certidões

## Como executar
* git clone \<repositorio>
* docker-compose up --build
* Acessar a API em: http://localhost:3000

## No insomia
* importar arquivo /insomia/Insomnia_2025-05-17.yaml

### Seguir o fluxo:
- Simular uma api de certidão
- Adicionar Credor 
- Adicionar Documento ao credor existente 
  - Seleciona um arquivo pdf
- Adicionar Certidao ao credor existente
  - Seleciona um arquivo pdf
- Consultar o credor existente
