require 'rails_helper'

RSpec.describe DocumentosPessoaisController, type: :controller do
  let(:credor) { create(:credor) }
  let(:valid_attributes) { { tipo: 'rg', arquivo: fixture_file_upload('spec/fixtures/rg.pdf', 'application/pdf') } }
  let(:invalid_file_attributes) { { tipo: 'rg', arquivo: fixture_file_upload('spec/fixtures/test.txt', 'text/plain') } }
  let(:invalid_attributes) { { tipo: 'rg', arquivo: nil } }

  describe 'POST #upload' do
    context 'com credor válido' do
      before do
        allow(controller).to receive(:set_credor) do
          controller.instance_variable_set(:@credor, credor)
        end
      end

      context 'com arquivo PDF válido' do
        it 'cria um novo documento' do
          expect {
            post :upload, params: { id: credor.id, **valid_attributes }
          }.to change(DocumentoPessoal, :count).by(1)
        end

        it 'retorna URL do arquivo' do
          post :upload, params: { id: credor.id, **valid_attributes }
          documento = DocumentoPessoal.last
          expect(documento.arquivo_url).to include(documento.arquivo.filename.to_s)
        end
      end

      context 'com arquivo não PDF' do
        it 'não cria o documento e retorna erro' do
          expect {
            post :upload, params: { id: credor.id, **invalid_file_attributes }
          }.not_to change(DocumentoPessoal, :count)
        end

        it 'retorna mensagem de erro específica' do
          post :upload, params: { id: credor.id, **invalid_file_attributes }
          expect(response).to have_http_status(:unprocessable_entity)
          expect(JSON.parse(response.body)['errors']['arquivo']).to include('deve ser um PDF')
        end
      end

      context 'sem arquivo' do
        it 'retorna erro de arquivo ausente' do
          post :upload, params: { id: credor.id, **invalid_attributes }
          expect(response).to have_http_status(:unprocessable_entity)
          expect(JSON.parse(response.body)['errors']['arquivo']).to include('não pode ficar em branco')
        end
      end
    end

    context 'com credor inválido' do
      it 'retorna 404' do
        post :upload, params: { id: 999 }
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
