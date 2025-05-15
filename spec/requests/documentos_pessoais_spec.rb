require 'swagger_helper'

RSpec.describe 'DocumentosPessoais', type: :request do
  path '/credores/{id}/documentos' do
    post 'Faz upload de documento pessoal' do
      tags 'Documentos'
      consumes 'multipart/form-data'
      parameter name: :id, in: :path, type: :integer
      parameter name: :arquivo, in: :formData, type: :file, required: true
      parameter name: :tipo, in: :formData, type: :string, required: true

      response '200', 'Documento salvo' do
        let(:id) { Credor.create(nome: 'Teste', cpf_cnpj: '123').id }
        let(:arquivo) { Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/test.txt')) }
        let(:tipo) { 'rg' }
        run_test!
      end

      response '422', 'Erro de validação' do
        let(:id) { 999 }
        run_test!
      end
    end
  end
end
