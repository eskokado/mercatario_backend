# == Schema Information
#
# Table name: certidoes
#
#  id              :integer          not null, primary key
#  credor_id       :integer
#  tipo            :string
#  origem          :string
#  status          :string
#  arquivo_url     :string
#  conteudo_base64 :text
#  recebida_em     :datetime
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

# == Schema Information
#
# Table name: certidoes
#
#  id              :integer          not null, primary key
#  credor_id       :integer
#  tipo            :string
#  origem          :string
#  status          :string
#  arquivo_url     :string
#  conteudo_base64 :text
#  recebida_em     :datetime
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

require 'rails_helper'

RSpec.describe Certidao, type: :model do
  let(:credor) { Credor.create } # Adjust according to your Credor model requirements
  subject do
    described_class.new(
      credor: credor,
      tipo: 'federal',
      origem: 'manual',
      status: 'pendente'
    )
  end

  it { is_expected.to belong_to(:credor) }
  it { is_expected.to validate_presence_of(:tipo) }
  it { is_expected.to validate_presence_of(:origem) }
  it { is_expected.to validate_presence_of(:status) }

  it 'validates inclusion of tipo' do
    expect(subject).to validate_inclusion_of(:tipo).in_array(%w[federal estadual municipal trabalhista])
  end

  it 'has one attached arquivo' do
    expect(subject.arquivo).to be_an_instance_of(ActiveStorage::Attached::One)
  end

  describe 'arquivo attachment validation' do
    context 'when a PDF file is attached' do
      before do
        subject.arquivo.attach(
          io: File.open(Rails.root.join('spec/fixtures/rg.pdf')),
          filename: 'rg.pdf',
          content_type: 'application/pdf'
        )
      end

      it 'is valid' do
        expect(subject).to be_valid
      end
    end

    context 'when a non-PDF file is attached' do
      before do
        subject.arquivo.attach(
          io: File.open(Rails.root.join('spec/fixtures/test.png')),
          filename: 'dummy.txt',
          content_type: 'text/plain'
        )
      end

      it 'is invalid and adds an error message' do
        expect(subject).not_to be_valid
        expect(subject.errors[:arquivo]).to include('deve ser um PDF')
      end
    end
  end
end
