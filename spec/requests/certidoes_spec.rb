require 'swagger_helper'

RSpec.describe 'API::Certidoes', type: :request do
  path '/api/certidoes' do
    get 'Consulta certidões' do
      tags 'Certidões'
      produces 'application/json'
      parameter name: :cpf_cnpj, in: :query, type: :string, required: true

      response '200', 'Certidões encontradas' do
        schema type: :object,
          properties: {
            cpf_cnpj: { type: :string },
            certidoes: {
              type: :array,
              items: {
                type: :object,
                properties: {
                  tipo: { type: :string },
                  status: { type: :string },
                  conteudo_base64: { type: :string }
                }
              }
            }
          }

        let(:cpf_cnpj) { '123.456.789-09' }
        run_test!
      end
    end
  end
end
