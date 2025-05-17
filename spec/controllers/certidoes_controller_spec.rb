require 'rails_helper'

RSpec.describe CertidoesController, type: :controller do
  let(:credor) { create(:credor) }
  let(:valid_attributes) do
    {
      tipo: 'federal',
      origem: 'manual',
      status: 'pendente',
      arquivo: fixture_file_upload('spec/fixtures/arquivo.pdf', 'application/pdf')
    }
  end
  let(:invalid_attributes) { { tipo: nil, arquivo: nil } }
  let(:invalid_file_attributes) do
    {
      tipo: 'federal',
      origem: 'manual',
      status: 'pendente',
      arquivo: fixture_file_upload('spec/fixtures/test.txt', 'text/plain')
    }
  end

  describe 'POST #upload_manual' do
    context 'com credor válido' do
      before do
        allow(controller).to receive(:set_credor) do
          controller.instance_variable_set(:@credor, credor)
        end
      end

      context 'com parâmetros válidos' do
        it 'cria uma nova certidão' do
          expect {
            post :upload_manual, params: { id: credor.id, **valid_attributes }
          }.to change(Certidao, :count).by(1)
        end

        it 'retorna sucesso e URL do arquivo' do
          post :upload_manual, params: { id: credor.id, **valid_attributes }
          expect(response).to have_http_status(:ok)
          expect(JSON.parse(response.body)).to include('success' => true)
        end
      end

      context 'com arquivo ausente' do
        it 'não cria a certidão e retorna erro' do
          post :upload_manual, params: { id: credor.id, **invalid_attributes }
          expect(response).to have_http_status(:unprocessable_entity)
          expect(JSON.parse(response.body)['errors']).to have_key('arquivo')
        end
      end

      context 'com arquivo não PDF' do
        it 'rejeita o arquivo e retorna erro' do
          post :upload_manual, params: { id: credor.id, **invalid_file_attributes }
          expect(response).to have_http_status(:unprocessable_entity)
          expect(JSON.parse(response.body)['errors']['arquivo']).to include('deve ser um PDF')
        end

        it 'não cria uma nova certidão' do
          expect {
            post :upload_manual, params: { id: credor.id, **invalid_file_attributes }
          }.not_to change(Certidao, :count)
        end
      end
    end

    context 'com credor inválido' do
      it 'retorna 404' do
        post :upload_manual, params: { id: 999 }
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe 'GET #buscar_api' do
    let!(:certidao1) { create(:certidao, credor: credor, recebida_em: 2.days.ago) }
    let!(:certidao2) { create(:certidao, credor: credor, recebida_em: 1.day.ago) }

    it 'retorna certidões em ordem decrescente' do
      get :buscar_api, params: { id: credor.id }
      expect(JSON.parse(response.body).pluck('id')).to eq([ certidao2.id, certidao1.id ])
    end
  end
end
