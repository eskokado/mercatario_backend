# == Schema Information
#
# Table name: credores
#
#  id         :integer          not null, primary key
#  nome       :string
#  cpf_cnpj   :string
#  email      :string
#  telefone   :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Credor, type: :model do
  let(:credor) { build(:credor) }

  it { is_expected.to have_many(:precatorios) }
  it { is_expected.to have_many(:documentos_pessoais) }
  it { is_expected.to have_many(:certidoes) }

  it { is_expected.to validate_presence_of(:nome) }
  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_presence_of(:telefone) }
  it { is_expected.to validate_uniqueness_of(:cpf_cnpj) }

  describe '#as_json' do
    let!(:credor) { create(:credor, :with_associations) }

    it 'includes nested associations' do
      credor.reload

      json = credor.as_json
      expect(json['precatorios']).to be_present
      expect(json['documentos_pessoais']).to be_present
      expect(json['certidoes']).to be_present
    end
  end
end
