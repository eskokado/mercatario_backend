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
end
