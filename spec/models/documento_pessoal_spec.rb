# == Schema Information
#
# Table name: documentos_pessoais
#
#  id          :integer          not null, primary key
#  credor_id   :integer
#  tipo        :string
#  arquivo_url :string
#  enviado_em  :datetime
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'rails_helper'

RSpec.describe DocumentoPessoal, type: :model do
  let(:credor) { create(:credor) } # Substitua por sua factory de Credor, se necessário
  subject do
    described_class.new(
      credor: credor,
      tipo: 'rg',
      arquivo: fixture_file_upload(Rails.root.join('spec/fixtures/arquivo.pdf'), 'application/pdf')
    )
  end

  it { is_expected.to belong_to(:credor) }
  it { is_expected.to validate_presence_of(:tipo) }
  it { is_expected.to validate_presence_of(:arquivo) }

  it 'validates inclusion of tipo' do
    expect(subject).to validate_inclusion_of(:tipo).in_array(%w[rg cnh comprovante_residencia cpf certidao_nascimento certidao_casamento passaporte outro])
  end

  describe 'validação do arquivo' do
    context 'quando o arquivo é um PDF' do
      it 'é válido' do
        expect(subject).to be_valid
      end
    end

    context 'quando o arquivo não é um PDF' do
      before do
        subject.arquivo.attach(
          io: File.open(Rails.root.join('spec/fixtures/test.txt')),
          filename: 'dummy.txt',
          content_type: 'text/plain'
        )
      end

      it 'é inválido e adiciona mensagem de erro' do
        expect(subject).not_to be_valid
        expect(subject.errors[:arquivo]).to include('deve ser um PDF')
      end
    end
  end
end
