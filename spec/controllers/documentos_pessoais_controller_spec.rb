require 'rails_helper'

RSpec.describe DocumentosPessoaisController, type: :controller do
  let(:credor) { create(:credor) }
  let(:valid_attributes) { { tipo: 'rg', arquivo: fixture_file_upload('spec/fixtures/rg.pdf', 'application/pdf') } }

  describe 'POST #upload' do
    context 'com credor válido' do
      before do
        allow(controller).to receive(:set_credor) do
          controller.instance_variable_set(:@credor, credor)
        end
      end

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

    context 'sem arquivo' do
      it 'retorna erro' do
        post :upload, params: { id: credor.id, tipo: 'RG', arquivo: nil }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
