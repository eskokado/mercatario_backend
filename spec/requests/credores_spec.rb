require 'swagger_helper'

RSpec.describe 'Credores', type: :request do
  path '/credores' do
    post 'Cria um credor' do
      tags 'Credores'
      consumes 'application/json'
      parameter name: :credor, in: :body, schema: {
        type: :object,
        properties: {
          nome: { type: :string },
          cpf_cnpj: { type: :string },
          email: { type: :string },
          telefone: { type: :string },
          precatorio: {
            type: :object,
            properties: {
              numero_precatorio: { type: :string },
              valor_nominal: { type: :number },
              foro: { type: :string },
              data_publicacao: { type: :string, format: 'date' }
            }
          }
        },
        required: %w[nome cpf_cnpj]
      }

      response '201', 'Credor criado' do
        example 'application/json', :success, {
          id: 1,
          nome: 'João Silva',
          cpf_cnpj: '123.456.789-09',
          email: 'example@email.com',
          telefone: '12345678901',
          created_at: '2025-05-15T20:24:24.773Z',
          updated_at: '2025-05-15T20:24:24.773Z',
          precatorios: [
            {
              id: 2,
              numero_precatorio: 'numero002',
              valor_nominal: '200.0',
              foro: 'foro tal',
              data_publicacao: '2025-05-15'
            }
          ]
        }
        run_test!
      end

      response '422', 'Dados inválidos' do
        let(:credor) { { nome: 'Sem CPF' } }
        run_test!
      end
    end
  end

  path '/credores/{id}' do
    get 'Exibe um credor' do
      tags 'Credores'
      produces 'application/json'
      parameter name: :id, in: :path, type: :integer

      response '200', 'Credor encontrado' do
        schema type: :object,
          properties: {
            id: { type: :integer },
            nome: { type: :string },
            precatorios: { type: :array },
            documentos_pessoais: { type: :array },
            certidoes: { type: :array }
          }

        let(:id) { Credor.create(nome: 'Teste', cpf_cnpj: '123').id }
        run_test!
      end
    end
  end
end
