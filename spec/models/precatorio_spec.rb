# == Schema Information
#
# Table name: precatorios
#
#  id                :integer          not null, primary key
#  credor_id         :integer
#  numero_precatorio :string
#  valor_nominal     :decimal(, )
#  foro              :string
#  data_publicacao   :date
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

require 'rails_helper'

RSpec.describe Precatorio, type: :model do
  it { is_expected.to belong_to(:credor) }
  it { is_expected.to validate_presence_of(:numero_precatorio) }
  it { is_expected.to validate_uniqueness_of(:numero_precatorio) }
  it { is_expected.to validate_presence_of(:valor_nominal) }
  it { is_expected.to validate_numericality_of(:valor_nominal).is_greater_than(0) }

  describe 'callbacks' do
    let(:credor) { create(:credor) }

    it 'sets credor_id before validation' do
      precatorio = build(:precatorio, credor: credor)
      precatorio.valid?
      expect(precatorio.credor_id).to eq(credor.id)
    end
  end
end
