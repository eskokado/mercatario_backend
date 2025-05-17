require 'rails_helper'

RSpec.describe CredoresController, type: :controller do
  describe 'POST #create' do
    context 'com parâmetros válidos' do
      let(:valid_params) do
        {
          nome: 'João Silva',
          cpf_cnpj: '12345678900',
          email: 'joao.silva@email.com',
          telefone: '119123451234',
          precatorio: {
            numero_precatorio: '123',
            valor_nominal: 1000.0,
            foro: 'Foro local',
            data_publicacao: '2025/05/17'
          }
        }
      end

      it 'cria um novo credor' do
        expect {
          post :create, params: valid_params
        }.to change(Credor, :count).by(1)
      end

      it 'associa o precatório corretamente' do
        post :create, params: valid_params
        credor = Credor.last
        expect(credor.precatorios.first.numero_precatorio).to eq('123')
      end
    end

    context 'com parâmetros inválidos' do
      it 'retorna erros' do
        post :create, params: { nome: nil }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'GET #show' do
    let(:credor) { create(:credor) }

    it 'retorna o credor com associações' do
      get :show, params: { id: credor.id }
      expect(JSON.parse(response.body)).to include('id' => credor.id)
    end

    it 'retorna 404 para credor inexistente' do
      get :show, params: { id: 999 }
      expect(response).to have_http_status(:not_found)
    end
  end
end
