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
  it { is_expected.to belong_to(:credor) }
  it { is_expected.to validate_presence_of(:tipo) }
  it { is_expected.to validate_presence_of(:arquivo) }

  it 'validates inclusion of tipo' do
    expect(subject).to validate_inclusion_of(:tipo).in_array(%w[rg cnh comprovante_residencia cpf certidao_nascimento certidao_casamento passaporte outro])
  end
end
