require 'rails_helper'

RSpec.describe Api::CertidoesController, type: :controller do
  describe 'GET #consultar' do
    it 'retorna mock de certidões com CPF/CNPJ' do
      get :consultar, params: { cpf_cnpj: '12345678900' }
      expect(response).to have_http_status(:ok)

      response_body = JSON.parse(response.body)

      expect(response_body).to include(
        'cpf_cnpj' => '12345678900',
        'certidoes' => be_an(Array)
      )

      expect(response_body['certidoes']).to include(
        { 'tipo' => 'federal', 'status' => 'negativa', 'conteudo_base64' => '...' },
        { 'tipo' => 'trabalhista', 'status' => 'positiva', 'conteudo_base64' => '...' }
      )
    end
  end
end
